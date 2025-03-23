import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simpli/models/invoice_model.dart';

class InvoiceProvider with ChangeNotifier {
  List<Invoice> _invoices = [];
  final Box<Invoice> invoiceBox; // Box for storing invoices
  final Box<int> metadataBox; // Box for storing metadata (e.g., sequential number)

  InvoiceProvider(this.invoiceBox, this.metadataBox) {
    _loadInvoices(); // Load invoices from Hive when the provider is created
  }

  List<Invoice> get invoices1 => _invoices;

  // Load invoices from Hive
  void _loadInvoices() {
    _invoices = invoiceBox.values.toList();
    notifyListeners();
  }

  // Add a new invoice to Hive
  void addInvoice(Invoice invoice) {
    print('Saving invoice: $invoice');
    invoiceBox.add(invoice); // Add to Hive
    _invoices.add(invoice); // Add to local list
    notifyListeners();
    print('Invoice saved successfully!');
  }

  // Update an existing invoice in Hive
  void updateInvoice(Invoice updatedInvoice) {
    print('Updating invoice: $updatedInvoice');
    final index = _invoices.indexWhere((invoice) => invoice.id == updatedInvoice.id);
    if (index != -1) {
      invoiceBox.put(updatedInvoice.id, updatedInvoice); // Update in Hive
      _invoices[index] = updatedInvoice; // Update in local list
      notifyListeners();
      print('Invoice updated successfully!');
    } else {
      print('Invoice not found for update');
    }
  }

  // Delete an invoice from Hive
  Future<void> deleteInvoice(Invoice invoice) async {
    print('Deleting invoice: $invoice');
    await invoiceBox.delete(invoice.id); // Delete from Hive
    _invoices.removeWhere((i) => i.id == invoice.id); // Remove from local list
    notifyListeners();
    print('Invoice deleted successfully!');
  }

  // Get the next sequential invoice number
  int getNextSequentialNumber() {
    int? lastNumber = metadataBox.get('lastInvoiceNumber', defaultValue: 0);
    lastNumber = lastNumber ?? 0; // Handle null case
    lastNumber++; // Increment the number
    metadataBox.put('lastInvoiceNumber', lastNumber); // Save the updated number
    print('Next sequential number: $lastNumber'); // Debug print
    return lastNumber;
  }
}