import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simpli/models/invoice_model.dart';

class InvoiceProvider with ChangeNotifier {
  List<Invoice> _invoices = [];
  final Box<Invoice> _invoiceBox;
  final Box<int> _metadataBox;
  bool _needsMigration = false;

  InvoiceProvider(this._invoiceBox, this._metadataBox) {
    _initialize();
  }

  List<Invoice> get invoices1 => List.unmodifiable(_invoices);

  Future<void> _initialize() async {
    await _loadInvoices();
    _checkForMigration();
  }

  Future<void> _loadInvoices() async {
    try {
      if (!_invoiceBox.isOpen) {
        await Hive.openBox<Invoice>(_invoiceBox.name);
      }
      _invoices = List<Invoice>.from(_invoiceBox.values);
      notifyListeners();
    } catch (e) {
      print('Error loading invoices: $e');
      _invoices = [];
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addInvoice(Invoice invoice) async {
    try {
      // Store with UUID as key
      await _invoiceBox.put(invoice.id, invoice);
      await _invoiceBox.flush();
      await _loadInvoices();
      print('Invoice saved with key: ${invoice.id}');
    } catch (e) {
      print('Failed to save invoice: $e');
      rethrow;
    }
  }

  Future<void> updateInvoice(Invoice updatedInvoice) async {
    try {
      await _invoiceBox.put(updatedInvoice.id, updatedInvoice);
      await _invoiceBox.flush();
      await _loadInvoices();
    } catch (e) {
      print('Failed to update invoice: $e');
      rethrow;
    }
  }

  Future<void> deleteInvoice(Invoice invoice) async {
    try {
      print('[DELETE] Attempting to delete ${invoice.id}');
      print('[DELETE] Current keys: ${_invoiceBox.keys}');
      
      if (_needsMigration) {
        await _migrateExistingInvoices();
      }

      if (!_invoiceBox.containsKey(invoice.id)) {
        throw Exception('Invoice ${invoice.id} not found. Available keys: ${_invoiceBox.keys}');
      }

      await _invoiceBox.delete(invoice.id);
      await _invoiceBox.flush();
      await _loadInvoices();
      
      print('[DELETE] Successfully deleted ${invoice.id}');
    } catch (e) {
      print('[DELETE ERROR] ${e.toString()}');
      rethrow;
    }
  }

  void _checkForMigration() {
    // Check if any invoices are stored with numeric keys
    _needsMigration = _invoiceBox.keys.any((key) => key is int);
    if (_needsMigration) {
      print('[MIGRATION] Needed - Found numeric keys in box');
    }
  }

  Future<void> _migrateExistingInvoices() async {
    try {
      print('[MIGRATION] Starting migration...');
      final tempBox = await Hive.openBox<Invoice>('temp_invoices');
      final allInvoices = _invoiceBox.values.toList();
      
      await tempBox.clear();
      for (final invoice in allInvoices) {
        await tempBox.put(invoice.id, invoice);
      }

      await _invoiceBox.clear();
      for (final key in tempBox.keys) {
        final invoice = tempBox.get(key);
        if (invoice != null) {
          await _invoiceBox.put(invoice.id, invoice);
        }
      }

      await tempBox.close();
      await Hive.deleteBoxFromDisk('temp_invoices');
      _needsMigration = false;
      
      print('[MIGRATION] Completed. New keys: ${_invoiceBox.keys}');
      await _loadInvoices();
    } catch (e) {
      print('[MIGRATION ERROR] ${e.toString()}');
      rethrow;
    }
  }

  int getNextSequentialNumber() {
    try {
      int lastNumber = _metadataBox.get('lastInvoiceNumber', defaultValue: 0) ?? 0;
      lastNumber++;
      _metadataBox.put('lastInvoiceNumber', lastNumber);
      return lastNumber;
    } catch (e) {
      print('Error generating sequential number: $e');
      return 1;
    }
  }

  Future<void> close() async {
    try {
      if (_invoiceBox.isOpen) await _invoiceBox.close();
      if (_metadataBox.isOpen) await _metadataBox.close();
    } catch (e) {
      print('Error closing boxes: $e');
    }
  }
}