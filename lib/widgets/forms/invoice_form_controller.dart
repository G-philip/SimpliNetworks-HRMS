// // invoice_form_controller.dart
// import 'package:flutter/material.dart';
// import 'package:hrms_app/models/invoice_model.dart';
// import 'package:hrms_app/services/invoice_provider.dart';
// import 'package:provider/provider.dart';

// class InvoiceFormController {
//   final TextEditingController clientNameController = TextEditingController();
//   final TextEditingController clientEmailController = TextEditingController();
//   final TextEditingController clientAddressController = TextEditingController();
//   final TextEditingController itemDescriptionController = TextEditingController();
//   final TextEditingController itemQuantityController = TextEditingController();
//   final TextEditingController itemPriceController = TextEditingController();
//   final TextEditingController taxRateController = TextEditingController();
//   final TextEditingController totalAmountController = TextEditingController();

//   void onSubmit(BuildContext context) {
//     if (clientNameController.text.isNotEmpty &&
//         clientEmailController.text.isNotEmpty &&
//         clientAddressController.text.isNotEmpty) {
//           final DateTime now = DateTime.now();
//           final String invoiceNumber = 'INV-${now.year}-${now.month}-${now.day}-${DateTime.now().millisecondsSinceEpoch}';
//       final newInvoice = Invoice(
//         invoiceNumber: invoiceNumber,
//         date: now.toString().split(' ')[0],
//         customerEmail: clientEmailController.toString(),
//         amount: double.parse(totalAmountController.text),
//         status: 'Pending', 
//         customerAddress: clientAddressController.toString(), 
//         // customerPhone: '', 
//         customerName: clientNameController.text,
//       );

//       Provider.of<InvoiceProvider>(context, listen: false).addInvoice(newInvoice);
//       Navigator.of(context).pop(); // Close the dialog
//     }
//   }
// }