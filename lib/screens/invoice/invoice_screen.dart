import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpli/data/invoice_data_source.dart';
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

  void showAddInvoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ReusableModal(
          formWidget: InvoiceForm(
            onFormSubmit: () {
              // Handle any post-submission logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invoice submitted successfully!')),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    final filteredInvoices = invoiceProvider.invoices1.where((invoice) {
      final matchesSearch = invoice.invoiceNumber.contains(searchQuery) ||
          invoice.customerName.contains(searchQuery);
      final matchesFilter = selectedFilter == null ||
          (selectedFilter == 'All') ||
          (selectedFilter == invoice.status);
      return matchesSearch && matchesFilter;
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          children: [
            // Row for the Invoice Button
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HoverButton(
                  onPressed: () {
                    showAddInvoiceDialog(context); // Call the method here
                  },
                  text: 'Add Invoice', // Button text
                  icon: Icons.add, // Button icon
                  clickEffectColor: Colors.teal, // Button effect color
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Row for Search and Filter
            Row(
              children: [
                // Search Input Field with White Background, No Border, and Elevation
                Material(
                  elevation: 1.5, // Elevation value
                  borderRadius: BorderRadius.circular(0), // Optional: Add border radius if needed
                  child: Container(
                    width: 300.0, // Set the width
                    color: Colors.white, // Set background color to white
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true, // Enable filled background
                        fillColor: Colors.white, // Set background color to white
                        hintText: 'Invoice number',
                        hintStyle: TextStyle(color: Color(0xFF114F5A)),
                        border: InputBorder.none, // Remove all borders
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16), // Adjust padding
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 40), // Spacing between the search field and dropdown
                // Filter Dropdown with Elevation and Bottom Border
                Material(
                  elevation: 1, // Elevation value
                  borderRadius: BorderRadius.circular(0), // Optional: Add border radius if needed
                  child: Container(
                    width: 150.0,
                    decoration: const BoxDecoration(
                      color: Colors.white, // Set background color to white
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFF114F5A), // Bottom border color
                          width: 1.0, // Bottom border thickness
                        ),
                      ),
                    ),
                    child: DropdownButton<String>(
                      hint: const Text('Filter'),
                      value: selectedFilter,
                      icon: const Icon(Icons.tune, color: Color(0xFF114F5A)),
                      isExpanded: true,
                      style: const TextStyle(color: Color(0xFF114F5A)), // Text color
                      underline: Container(), // Remove the default underline
                      items: <String>['All', 'Paid', 'Pending', 'Overdue']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFilter = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20), // Space between button and table
            Row(
              children: [
                Expanded(
                  child: PaginatedDataTable(
                    columns: [
                      DataColumn(label: textStyleSmall('Invoice Number')),
                      DataColumn(label: textStyleSmall('Date')),
                      DataColumn(label: textStyleSmall('Customer Name')),
                      DataColumn(label: textStyleSmall('Amount')),
                      DataColumn(label: textStyleSmall('Status')),
                      DataColumn(label: textStyleSmall('Action')),
                    ],
                    source: InvoiceDataSource(
                      filteredInvoices,
                      context,
                      invoiceProvider, // Pass the InvoiceProvider here
                    ),
                    rowsPerPage: 5,
                    showCheckboxColumn: true,
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