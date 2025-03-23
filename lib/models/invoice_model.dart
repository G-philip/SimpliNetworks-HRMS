import 'package:hive_flutter/hive_flutter.dart';

part 'invoice_model.g.dart'; // Ensure this is included for Hive code generation

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
  final double amount;

  @HiveField(7)
  final String status;

  @HiveField(8)
  final String? itemDescription;

  @HiveField(9)
  final double? quantity;

  @HiveField(10)
  final double? price;

  @HiveField(11)
  final double? taxRate;

  Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.date,
    required this.customerName,
    required this.customerAddress,
    required this.customerEmail,
    required this.amount,
    required this.status,
    this.itemDescription,
    this.quantity,
    this.price,
    this.taxRate,
  });

  // Add the copyWith method
  Invoice copyWith({
    String? id,
    String? invoiceNumber,
    String? date,
    String? customerName,
    String? customerAddress,
    String? customerEmail,
    double? amount,
    String? status,
    String? itemDescription,
    double? quantity,
    double? price,
    double? taxRate,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      date: date ?? this.date,
      customerName: customerName ?? this.customerName,
      customerAddress: customerAddress ?? this.customerAddress,
      customerEmail: customerEmail ?? this.customerEmail,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      itemDescription: itemDescription ?? this.itemDescription,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      taxRate: taxRate ?? this.taxRate,
    );
  }

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceNumber': invoiceNumber,
      'date': date,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerEmail': customerEmail,
      'amount': amount,
      'status': status,
      'itemDescription': itemDescription,
      'quantity': quantity,
      'price': price,
      'taxRate': taxRate,
    };
  }
}