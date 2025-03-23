import 'package:flutter/material.dart';
import 'package:simpli/models/invoice_model.dart';
import 'package:simpli/services/invoice_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class InvoiceForm extends StatefulWidget {
  final VoidCallback onFormSubmit; // Callback for form submission
  final Invoice? invoice; // Optional invoice for editing

  const InvoiceForm({
    super.key,
    required this.onFormSubmit,
    this.invoice, // Pass the invoice to edit (null for add new)
  });

  @override
  State<InvoiceForm> createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  late final Map<String, TextEditingController> _controllers;

  bool _isClientInfoVisible = true;
  bool _isInvoiceItemsVisible = false;
  bool _isTaxesAndTotalsVisible = false;
  bool _isSubmitting = false; // Add this variable to your state

  @override
  void initState() {
    super.initState();
    // Initialize all controllers
    _controllers = _initializeControllers();

    // If an invoice is provided (edit mode), pre-fill the form
    if (widget.invoice != null) {
      _prefillForm(widget.invoice!);
    }

    // Add listeners to recalculate totals when input changes
    _controllers['itemQuantity']!.addListener(_calculateTotals);
    _controllers['itemPrice']!.addListener(_calculateTotals);
    _controllers['taxRate']!.addListener(_calculateTotals);
  }

  @override
  void dispose() {
    // Remove listeners and dispose controllers
    _controllers['itemQuantity']!.removeListener(_calculateTotals);
    _controllers['itemPrice']!.removeListener(_calculateTotals);
    _controllers['taxRate']!.removeListener(_calculateTotals);

    // Dispose all controllers
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  // Initialize all TextEditingControllers
  Map<String, TextEditingController> _initializeControllers() {
    return {
      'clientName': TextEditingController(),
      'clientEmail': TextEditingController(),
      'clientAddress': TextEditingController(),
      'itemDescription': TextEditingController(),
      'itemQuantity': TextEditingController(),
      'itemPrice': TextEditingController(),
      'taxRate': TextEditingController(),
      'totalAmount': TextEditingController(),
    };
  }

  // Pre-fill the form with existing invoice data (for edit mode)
  void _prefillForm(Invoice invoice) {
    _controllers['clientName']!.text = invoice.customerName;
    _controllers['clientEmail']!.text = invoice.customerEmail;
    _controllers['clientAddress']!.text = invoice.customerAddress;
    _controllers['itemDescription']!.text = invoice.itemDescription ?? '';
    _controllers['itemQuantity']!.text = invoice.quantity?.toString() ?? '';
    _controllers['itemPrice']!.text = invoice.price?.toString() ?? '';
    _controllers['taxRate']!.text = invoice.taxRate?.toString() ?? '';
    _controllers['totalAmount']!.text = invoice.amount.toString();
  }

  // Calculate subtotal, tax, and total amount
  void _calculateTotals() {
    final quantity = double.tryParse(_controllers['itemQuantity']!.text) ?? 0;
    final price = double.tryParse(_controllers['itemPrice']!.text) ?? 0;
    final taxRate = double.tryParse(_controllers['taxRate']!.text) ?? 0;

    final subtotal = quantity * price;
    final taxAmount = subtotal * (taxRate / 100);
    final totalAmount = subtotal + taxAmount;

    _controllers['totalAmount']!.text = totalAmount.toStringAsFixed(2);
  }

  // Handle "Next" button click
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
    if (_isSubmitting) return; // Prevent multiple submits
    _isSubmitting = true; // Set submitting state to true

    if (_formKey.currentState!.validate()) {
      final invoiceProvider = Provider.of<InvoiceProvider>(context, listen: false);

      // Generate the invoice number only once if it's a new invoice
      final String invoiceNumber;
      if (widget.invoice == null) {
        final sequentialNumber = invoiceProvider.getNextSequentialNumber();
        invoiceNumber = _generateInvoiceNumber(sequentialNumber); // Use the pre-generated sequential number
      } else {
        invoiceNumber = widget.invoice!.invoiceNumber; // Use existing invoice number
      }

      final invoice = Invoice(
        id: widget.invoice?.id ?? const Uuid().v4(), // Use existing ID for edit, generate new for add
        invoiceNumber: invoiceNumber, // Use the pre-generated invoice number
        date: widget.invoice?.date ?? DateTime.now().toString().split(' ')[0],
        customerName: _controllers['clientName']!.text,
        customerEmail: _controllers['clientEmail']!.text,
        customerAddress: _controllers['clientAddress']!.text,
        amount: double.parse(_controllers['totalAmount']!.text),
        status: widget.invoice?.status ?? 'Pending', // Use existing status for edit
        itemDescription: _controllers['itemDescription']!.text,
        quantity: double.tryParse(_controllers['itemQuantity']!.text),
        price: double.tryParse(_controllers['itemPrice']!.text),
        taxRate: double.tryParse(_controllers['taxRate']!.text),
      );

      if (widget.invoice == null) {
        invoiceProvider.addInvoice(invoice); // Add new invoice
      } else {
        invoiceProvider.updateInvoice(invoice); // Update existing invoice
      }

      // Trigger the callback to notify the parent widget
      widget.onFormSubmit();

      // Close the dialog
      Navigator.of(context).pop();
    }

    _isSubmitting = false; // Reset submitting state
  }

  String _generateInvoiceNumber(int sequentialNumber) {
    final now = DateTime.now();
    print('Generating invoice number. Sequential number: $sequentialNumber'); // Debug print
    return 'INV-${now.year}-${now.month}-${now.day}-${sequentialNumber.toString().padLeft(3, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Client Information Section
            _buildClientInfoSection(),

            // Invoice Items Section
            _buildInvoiceItemsSection(),

            // Taxes and Totals Section
            _buildTaxesAndTotalsSection(),

            const SizedBox(height: 20),

            // Navigation Buttons (Back, Next, Submit)
            _buildNavigationButtons(context),
          ],
        ),
      ),
    );
  }

  // Build Client Information Section
  Widget _buildClientInfoSection() {
    return Visibility(
      visible: _isClientInfoVisible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Client Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF114F5A),
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 10),
          _buildTextFormField(
            controller: _controllers['clientName']!,
            label: 'Client Name',
            validator: (value) => value?.isEmpty ?? true ? 'Please enter the client name' : null,
          ),
          _buildTextFormField(
            controller: _controllers['clientEmail']!,
            label: 'Client Email',
            validator: (value) => value?.isEmpty ?? true ? 'Please enter the client email' : null,
          ),
          _buildTextFormField(
            controller: _controllers['clientAddress']!,
            label: 'Client Address',
            validator: (value) => value?.isEmpty ?? true ? 'Please enter the client address' : null,
          ),
        ],
      ),
    );
  }

  // Build Invoice Items Section
  Widget _buildInvoiceItemsSection() {
    return Visibility(
      visible: _isInvoiceItemsVisible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Invoice Items',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Color(0xFF114F5A),
            ),
          ),
          const SizedBox(height: 10),
          _buildTextFormField(
            controller: _controllers['itemDescription']!,
            label: 'Item Description',
            validator: (value) => value?.isEmpty ?? true ? 'Please enter the item description' : null,
          ),
          _buildTextFormField(
            controller: _controllers['itemQuantity']!,
            label: 'Quantity',
            keyboardType: TextInputType.number,
            validator: (value) => _validateNumber(value, 'quantity'),
          ),
          _buildTextFormField(
            controller: _controllers['itemPrice']!,
            label: 'Price',
            keyboardType: TextInputType.number,
            validator: (value) => _validateNumber(value, 'price'),
          ),
        ],
      ),
    );
  }

  // Build Taxes and Totals Section
  Widget _buildTaxesAndTotalsSection() {
    return Visibility(
      visible: _isTaxesAndTotalsVisible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Taxes and Totals',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Color(0xFF114F5A),
            ),
          ),
          const SizedBox(height: 10),
          _buildTextFormField(
            controller: _controllers['taxRate']!,
            label: 'Tax Rate (%)',
            keyboardType: TextInputType.number,
            validator: (value) => _validateNumber(value, 'tax rate'),
          ),
          _buildTextFormField(
            controller: _controllers['totalAmount']!,
            label: 'Total Amount',
            keyboardType: TextInputType.number,
            readOnly: true,
            validator: (value) => _validateNumber(value, 'total amount'),
          ),
        ],
      ),
    );
  }

  // Build Navigation Buttons
  Widget _buildNavigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Back Button
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

        // Submit or Next Button
        _isTaxesAndTotalsVisible
            ? ElevatedButton(
                onPressed: () => _onSubmit(context),
                child: const Text('Submit', style: TextStyle(color: Color(0xFF114F5A))),
              )
            : ElevatedButton(
                onPressed: _onNextButtonClicked,
                child: const Row(
                  children: [
                    Text('Next', style: TextStyle(color: Color(0xFF114F5A))),
                    SizedBox(width: 6),
                    Icon(Icons.double_arrow, color: Color(0xFF114F5A), size: 20),
                  ],
                ),
              ),
      ],
    );
  }

  // Helper method to build a TextFormField
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool readOnly = false,
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
      readOnly: readOnly,
      validator: validator,
    );
  }

  // Helper method to validate numeric input
  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter the $fieldName';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }
}