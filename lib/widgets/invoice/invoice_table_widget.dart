//  // Build the invoice table
// import 'package:flutter/material.dart';
// import 'package:hrms_app/data/invoice_data_source.dart';
// import 'package:hrms_app/models/invoice_model.dart';
// import 'package:hrms_app/widgets/text_style_small.dart';

// Widget buildInvoiceTable(List<Invoice> filteredInvoices) {
//     final dataSource = InvoiceDataSource(filteredInvoices);

//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: PaginatedDataTable(
//                 // header: headerText18('Invoice List'),
//                 columns: [
//                   DataColumn(label: textStyleSmall('Invoice Number')),
//                   DataColumn(label: textStyleSmall('Date')),
//                   DataColumn(label: textStyleSmall('Customer Name')),
//                   DataColumn(label: textStyleSmall('Amount')),
//                   DataColumn(label: textStyleSmall('Status')),
//                 ],
//                 source: dataSource,
//                 rowsPerPage: 6,
//                 showCheckboxColumn: true,
//                 sortAscending: true,
//               ),
//             ),
//           ],
//         ),
//         // const SizedBox(height: 20),
//         const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Text('Designed with'),
//               SizedBox(width: 7),
//               Icon(Icons.favorite, color: Colors.blue),
//               SizedBox(width: 7),
//               Text('by SimpliNetworks'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
