import 'package:flutter/material.dart';
import 'package:simpli/models/invoice_model.dart';

// Pagination Provider
class InvoicePaginationProvider with ChangeNotifier {
  List<Invoice> _invoices = [];
  int _currentPage = 0;
  int _rowsPerPage = 5;

  // Set the invoices and notify listeners
  void setInvoices(List<Invoice> invoices1) {
    _invoices = invoices1;
    notifyListeners();
  }

  // Get the current page invoices
  List<Invoice> get currentPageInvoices {
    int startIndex = _currentPage * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;
    return _invoices.sublist(startIndex, endIndex > _invoices.length ? _invoices.length : endIndex);
  }

  // Get total number of invoices
  int get totalInvoices => _invoices.length;

  // Change the current page
  void changePage(int newPage) {
    _currentPage = newPage;
    notifyListeners();
  }

  // Set rows per page
  void setRowsPerPage(int rows) {
    _rowsPerPage = rows;
    notifyListeners();
  }
}