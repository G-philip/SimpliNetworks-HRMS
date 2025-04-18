import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpli/data/invoice_data_source.dart';
import 'package:simpli/models/invoice_model.dart';
import 'package:simpli/services/invoice_provider.dart';
import 'package:simpli/utils/hover_button.dart';
import 'package:simpli/widgets/forms/invoice_form_widget.dart';
import 'package:simpli/widgets/modal/reusable_modal.dart';
import 'package:simpli/widgets/text_style_small.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String searchQuery = '';
  String? selectedFilter;
  late InvoiceDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    _dataSource = InvoiceDataSource([], context, invoiceProvider);
  }

  void showAddInvoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ReusableModal(
          formWidget: InvoiceForm(
            onFormSubmit: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invoice created successfully!')),
              );
            },
          ),
        );
      },
    );
  }

  List<Invoice> _getFilteredInvoices(List<Invoice> invoices) {
    return invoices.where((invoice) {
      final matchesSearch = invoice.invoiceNumber
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          invoice.customerName
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      final matchesFilter = selectedFilter == null ||
          selectedFilter == 'All' ||
          (invoice.status == selectedFilter);
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    final filteredInvoices = _getFilteredInvoices(invoiceProvider.invoices1);

    _dataSource.updateInvoices(filteredInvoices);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HoverButton(
                  onPressed: () => showAddInvoiceDialog(context),
                  text: 'Add Invoice',
                  icon: Icons.add,
                  clickEffectColor: Colors.teal,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Material(
                  elevation: 1.5,
                  child: Container(
                    width: 300.0,
                    color: Colors.white,
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search invoices...',
                        hintStyle: TextStyle(color: Color(0xFF114F5A)),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      onChanged: (value) => setState(() => searchQuery = value),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Material(
                  elevation: 1,
                  child: Container(
                    width: 150.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFF114F5A),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: DropdownButton<String>(
                      hint: const Text('Filter'),
                      value: selectedFilter,
                      icon: const Icon(Icons.tune, color: Color(0xFF114F5A)),
                      isExpanded: true,
                      style: const TextStyle(color: Color(0xFF114F5A)),
                      underline: Container(),
                      items: <String>['All', 'Paid', 'Pending', 'Overdue']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() => selectedFilter = newValue);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: PaginatedDataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Invoice Number', style: smallTextStyle),
                      ),
                      // DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Client Name', style: smallTextStyle)),
                      DataColumn(label: Text('Invoice Date', style: smallTextStyle)),
                      // DataColumn(label: Text('Amount')),
                      DataColumn(label: Text('Total', style: smallTextStyle)),
                      DataColumn(label: Text('Actions', style: smallTextStyle)),
                    ],
                    source: _dataSource,
                    
                    rowsPerPage: 5,
                    showCheckboxColumn: false,
                    sortAscending: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
