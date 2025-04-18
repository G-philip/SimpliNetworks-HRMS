import 'package:flutter/material.dart';
import 'package:simpli/models/invoice_model.dart';
import 'package:simpli/services/invoice_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class InvoiceForm extends StatefulWidget {
  final VoidCallback onFormSubmit;
  final Invoice? invoice;

  const InvoiceForm({
    Key? key,
    required this.onFormSubmit,
    this.invoice,
  }) : super(key: key);

  @override
  State<InvoiceForm> createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;
  final List<InvoiceItem> _items = [];
  double _taxRate = 0.0;

  bool _isClientInfoVisible = true;
  bool _isInvoiceItemsVisible = false;
  bool _isTaxesAndTotalsVisible = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controllers = _initializeControllers();
    
    if (widget.invoice != null) {
      _prefillForm(widget.invoice!);
      _items.addAll(widget.invoice!.items);
      if (_items.isNotEmpty) {
        _taxRate = _items.first.taxRate;
        _controllers['taxRate']!.text = _taxRate.toString();
      }
    } else {
      _items.add(InvoiceItem.empty());
    }
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  Map<String, TextEditingController> _initializeControllers() {
    return {
      'clientName': TextEditingController(),
      'clientEmail': TextEditingController(),
      'clientAddress': TextEditingController(),
      'taxRate': TextEditingController(text: '0'),
    };
  }

  void _prefillForm(Invoice invoice) {
    _controllers['clientName']!.text = invoice.customerName;
    _controllers['clientEmail']!.text = invoice.customerEmail;
    _controllers['clientAddress']!.text = invoice.customerAddress;
  }

  void _calculateTotals() {
    setState(() {
      _taxRate = double.tryParse(_controllers['taxRate']!.text) ?? 0;
    });
  }

  void _addNewItem() {
    setState(() {
      _items.add(InvoiceItem.empty());
    });
  }

  void _removeItem(int index) {
    if (_items.length > 1) {
      setState(() {
        _items.removeAt(index);
      });
    }
  }

  void _updateItem(int index, InvoiceItem newItem) {
    setState(() {
      _items[index] = newItem;
    });
  }

  void _onNextButtonClicked() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (_isClientInfoVisible) {
          _isClientInfoVisible = false;
          _isInvoiceItemsVisible = true;
        } else if (_isInvoiceItemsVisible) {
          _isInvoiceItemsVisible = false;
          _isTaxesAndTotalsVisible = true;
        }
      });
    }
  }

  void _onSubmit(BuildContext context) {
    if (_isSubmitting) return;
    _isSubmitting = true;

    if (_formKey.currentState!.validate()) {
      final invoiceProvider = Provider.of<InvoiceProvider>(context, listen: false);
      
      final itemsWithTax = _items.map((item) => item.copyWith(taxRate: _taxRate)).toList();

      final invoice = Invoice(
        id: widget.invoice?.id ?? const Uuid().v4(),
        invoiceNumber: widget.invoice?.invoiceNumber ?? 
            _generateInvoiceNumber(invoiceProvider.getNextSequentialNumber()),
        date: widget.invoice?.date ?? DateTime.now().toString().split(' ')[0],
        customerName: _controllers['clientName']!.text,
        customerEmail: _controllers['clientEmail']!.text,
        customerAddress: _controllers['clientAddress']!.text,
        items: itemsWithTax,
        status: widget.invoice?.status ?? 'Pending',
      );

      if (widget.invoice == null) {
        invoiceProvider.addInvoice(invoice);
      } else {
        invoiceProvider.updateInvoice(invoice);
      }

      widget.onFormSubmit();
      Navigator.of(context).pop();
    }
    _isSubmitting = false;
  }

  String _generateInvoiceNumber(int sequentialNumber) {
    final now = DateTime.now();
    return 'INV-${now.year}-${now.month}-${now.day}-${sequentialNumber.toString().padLeft(3, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = _items.fold(0.0, (sum, item) => sum + item.total);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildClientInfoSection(),
            _buildInvoiceItemsSection(),
            _buildTaxesAndTotalsSection(totalAmount),
            const SizedBox(height: 20),
            _buildNavigationButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildClientInfoSection() {
    return Visibility(
      visible: _isClientInfoVisible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client Information',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF114F5A),
            ),
          ),
          const SizedBox(height: 10),
          _buildTextFormField(
            controller: _controllers['clientName']!,
            label: 'Client Name',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          _buildTextFormField(
            controller: _controllers['clientEmail']!,
            label: 'Client Email',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          _buildTextFormField(
            controller: _controllers['clientAddress']!,
            label: 'Client Address',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceItemsSection() {
    return Visibility(
      visible: _isInvoiceItemsVisible,
      child: Column(
        children: [
          const Text(
            'Invoice Items',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF114F5A),
            ),
          ),
          const SizedBox(height: 10),
          ..._items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return _buildItemRow(index, item);
          }).toList(),
          TextButton(
            onPressed: _addNewItem,
            child: const Text('+ Add Another Item'),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(int index, InvoiceItem item) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: item.description,
            decoration: const InputDecoration(labelText: 'Description'),
            onChanged: (value) => _updateItem(index, item.copyWith(description: value)),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 80,
          child: TextFormField(
            initialValue: item.quantity.toString(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Qty'),
            onChanged: (value) => _updateItem(
              index,
              item.copyWith(quantity: double.tryParse(value) ?? 0),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: item.price.toString(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Price'),
            onChanged: (value) => _updateItem(
              index,
              item.copyWith(price: double.tryParse(value) ?? 0),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove, color: Colors.red),
          onPressed: () => _removeItem(index),
        ),
      ],
    ),
  );
}

  Widget _buildTaxesAndTotalsSection(double totalAmount) {
    final subtotal = totalAmount / (1 + _taxRate/100);
    final taxAmount = totalAmount - subtotal;

    return Visibility(
      visible: _isTaxesAndTotalsVisible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Taxes and Totals',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF114F5A),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controllers['taxRate']!,
            decoration: const InputDecoration(labelText: 'Tax Rate (%)'),
            keyboardType: TextInputType.number,
            onChanged: (value) => _calculateTotals(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('\$${subtotal.toStringAsFixed(2)}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tax:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('\$${taxAmount.toStringAsFixed(2)}'),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total:', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
              Text('\$${totalAmount.toStringAsFixed(2)}', style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!_isClientInfoVisible)
          TextButton(
            onPressed: () {
              setState(() {
                if (_isTaxesAndTotalsVisible) {
                  _isTaxesAndTotalsVisible = false;
                  _isInvoiceItemsVisible = true;
                } else if (_isInvoiceItemsVisible) {
                  _isInvoiceItemsVisible = false;
                  _isClientInfoVisible = true;
                }
              });
            },
            child: const Row(
              children: [
                Icon(Icons.arrow_back, color: Color(0xFF114F5A)),
                SizedBox(width: 6),
                Text('Back', style: TextStyle(color: Color(0xFF114F5A))),
              ],
            ),
          ),
        const SizedBox(width: 20),
        _isTaxesAndTotalsVisible
            ? ElevatedButton(
                onPressed: () => _onSubmit(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF114F5A),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Submit'),
              )
            : ElevatedButton(
                onPressed: _onNextButtonClicked,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF114F5A),
                  foregroundColor: Colors.white,
                ),
                child: const Row(
                  children: [
                    Text('Next'),
                    SizedBox(width: 6),
                    Icon(Icons.double_arrow, size: 20),
                  ],
                ),
              ),
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF114F5A)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF114F5A)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF114F5A)),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}