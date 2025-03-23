import 'package:flutter/material.dart';
import 'package:simpli/models/invoice_model.dart';
import 'package:simpli/screens/invoice/show_invoice_item.dart';
import 'package:simpli/widgets/forms/invoice_form_widget.dart';
import 'package:simpli/widgets/modal/display_item_modal.dart';
import 'package:simpli/widgets/modal/reusable_modal.dart';
import 'package:simpli/widgets/text_style_small.dart';
import 'package:simpli/services/invoice_provider.dart'; // Import the provider

class InvoiceDataSource extends DataTableSource {
  List<Invoice> invoices1;
  final BuildContext context; // Add BuildContext to access it in the DataRow
  final InvoiceProvider
      invoiceProvider; // Use InvoiceProvider instead of Hive Box

  InvoiceDataSource(this.invoices1, this.context, this.invoiceProvider);

  // Update the list of invoices
  void updateInvoices(List<Invoice> newInvoices) {
    invoices1.clear();
    invoices1.addAll(newInvoices);
    notifyListeners(); // Notify the DataTable to update the UI
  }

  // Show the edit invoice dialog
  void showEditInvoiceDialog(BuildContext context, Invoice invoice) {
    showDialog(
      context: context,
      builder: (context) {
        return ReusableModal(
          formWidget: InvoiceForm(
            onFormSubmit: () {
              // Refresh the invoice list after editing
              invoices1 = invoiceProvider.invoices1;
              notifyListeners(); // Notify the DataTable
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invoice updated successfully!')),
              );
            },
            invoice: invoice, // Pass the invoice to edit
          ),
        );
      },
    );
  }

  // Delete an invoice
  void deleteInvoice(Invoice invoice) {
    // Show a confirmation dialog before deleting
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Invoice'),
          content: const Text('Are you sure you want to delete this invoice?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Use the provider to delete the invoice
                await invoiceProvider
                    .deleteInvoice(invoice); // Await the Future
                // Remove the invoice from the local list
                invoices1.remove(invoice);
                notifyListeners(); // Notify the DataTable to update the UI
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Invoice deleted successfully!')),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  DataRow getRow(int index) {
    if (index >= invoices1.length) {
      return const DataRow(cells: []);
    }

    final invoice = invoices1[index];

    return DataRow(
      cells: [
        DataCell(textStyleSmall(invoice.invoiceNumber)),
        DataCell(textStyleSmall(invoice.date)),
        DataCell(textStyleSmall(invoice.customerName)),
        DataCell(textStyleSmall('\$${invoice.amount.toStringAsFixed(2)}')),
        DataCell(textStyleSmall(invoice.status)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Call the edit invoice dialog function with the invoice data
                  showEditInvoiceDialog(context, invoice);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Call the delete invoice function
                  deleteInvoice(invoice);
                },
              ),
              IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    // Use showCustomModal instead of showDialog
                    showCustomModal(
                      context,
                      top: 44, // Start 100 pixels from the top
                      left: 350, // Start 100 pixels from the left
                      child:
                          const ShowInvoiceItem(), // Pass the content of the modal
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }

  double calculateTotal(List<Map<String, dynamic>> items) {
  return items.fold(0.0, (sum, item) => sum + (item['total'] as double));
}

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => invoices1.length;

  @override
  int get selectedRowCount => 0;
}
