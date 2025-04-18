import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpli/models/invoice_model.dart';
import 'package:simpli/screens/invoice/show_invoice_item.dart';
import 'package:simpli/services/layout_state.dart';
import 'package:simpli/widgets/forms/invoice_form_widget.dart';
import 'package:simpli/widgets/modal/reusable_modal.dart';
import 'package:simpli/widgets/text_style_small.dart';
import 'package:simpli/services/invoice_provider.dart';

class InvoiceDataSource extends DataTableSource {
  List<Invoice> invoices1;
  final BuildContext context;
  final InvoiceProvider invoiceProvider;

  InvoiceDataSource(this.invoices1, this.context, this.invoiceProvider);

  void updateInvoices(List<Invoice> newInvoices) {
    invoices1 = List.from(newInvoices);
    notifyListeners();
  }

  void showEditInvoiceDialog(BuildContext context, Invoice invoice) {
    showDialog(
      context: context,
      builder: (context) {
        return ReusableModal(
          formWidget: InvoiceForm(
            onFormSubmit: () {
              invoices1 = List.from(invoiceProvider.invoices1);
              notifyListeners();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invoice updated successfully!')),
              );
            },
            invoice: invoice,
          ),
        );
      },
    );
  }

  Future<void> deleteInvoice(Invoice invoice) async {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      const SnackBar(
        content: Text('Deleting invoice...'),
        duration: Duration(seconds: 2),
      ),
    );

    try {
      await invoiceProvider.deleteInvoice(invoice);
      invoices1 = List.from(invoiceProvider.invoices1);
      notifyListeners();
      
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        const SnackBar(content: Text('Invoice deleted successfully!')),
      );
    } catch (e) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to delete: ${e.toString()}'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  DataRow getRow(int index) {
    if (index >= invoices1.length) return const DataRow(cells: []);

    final invoice = invoices1[index];
    final hasItems = invoice.items.isNotEmpty;

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          }
          return index.isEven ? Colors.grey[50]! : Colors.white;
        },
      ),
      cells: [
        DataCell(textStyleSmall(invoice.invoiceNumber)),
        DataCell(textStyleSmall(invoice.customerName)),
        DataCell(textStyleSmall(invoice.date)),
        DataCell(textStyleSmall('\$${invoice.amount.toStringAsFixed(2)}')),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                message: hasItems ? 'Add items' : 'Add first item',
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: hasItems ? Colors.grey : Colors.blue,
                  ),
                  onPressed: () {
                    final newInvoice = invoice.copyWith(
                      items: [...invoice.items, InvoiceItem.empty()],
                    );
                    showEditInvoiceDialog(context, newInvoice);
                  },
                ),
              ),
              Tooltip(
                message: 'Edit invoice',
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => showEditInvoiceDialog(context, invoice),
                ),
              ),
              Tooltip(
                message: 'Delete invoice',
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteInvoice(invoice),
                ),
              ),
              Tooltip(
                message: 'View details',
                child: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Provider.of<LayoutState>(context, listen: false)
                        .setCurrentScreen(ShowInvoiceItem(invoice: invoice));
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => Dialog(
                    //     child: ShowInvoiceItem(invoice: invoice),
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => invoices1.length;

  @override
  int get selectedRowCount => 0;
}