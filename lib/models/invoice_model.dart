import 'package:hive_flutter/hive_flutter.dart';

part 'invoice_model.g.dart';

@HiveType(typeId: 1)
class InvoiceItem {
  @HiveField(0)
  final String description;
  
  @HiveField(1)
  final double quantity;
  
  @HiveField(2)
  final double price;
  
  @HiveField(3)
  final double taxRate;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.price,
    this.taxRate = 0.0,
  });

  double get total => price * quantity * (1 + taxRate/100);

  factory InvoiceItem.empty() => InvoiceItem(
    description: '',
    quantity: 0,
    price: 0,
    taxRate: 0,
  );

  InvoiceItem copyWith({
    String? description,
    double? quantity,
    double? price,
    double? taxRate,
  }) {
    return InvoiceItem(
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      taxRate: taxRate ?? this.taxRate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'quantity': quantity,
      'price': price,
      'taxRate': taxRate,
      'total': total,
    };
  }
}

@HiveType(typeId: 0)
class Invoice {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String invoiceNumber;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String customerName;

  @HiveField(4)
  final String customerAddress;

  @HiveField(5)
  final String customerEmail;

  @HiveField(6)
  final List<InvoiceItem> items;

  @HiveField(7)
  final String status;

  Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.date,
    required this.customerName,
    required this.customerAddress,
    required this.customerEmail,
    required this.items,
    this.status = 'Draft',
  });

  double get amount => items.fold(0.0, (sum, item) => sum + item.total);

  bool get hasItems => items.isNotEmpty;

  factory Invoice.empty() => Invoice(
    id: '',
    invoiceNumber: '',
    date: '',
    customerName: '',
    customerAddress: '',
    customerEmail: '',
    items: [],
  );

  Invoice copyWith({
    String? id,
    String? invoiceNumber,
    String? date,
    String? customerName,
    String? customerAddress,
    String? customerEmail,
    List<InvoiceItem>? items,
    String? status,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      date: date ?? this.date,
      customerName: customerName ?? this.customerName,
      customerAddress: customerAddress ?? this.customerAddress,
      customerEmail: customerEmail ?? this.customerEmail,
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceNumber': invoiceNumber,
      'date': date,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerEmail': customerEmail,
      'items': items.map((item) => item.toJson()).toList(),
      'status': status,
      'amount': amount,
    };
  }
}