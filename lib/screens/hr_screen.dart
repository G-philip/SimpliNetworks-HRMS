// import 'package:flutter/material.dart';
// import 'package:hrms_app/utils/hover_button.dart';
// import 'package:hrms_app/widgets/forms/hr_form_fields.dart';
// import 'package:hrms_app/widgets/forms/invoice_form_widget.dart';
// import 'package:hrms_app/widgets/header_text_widget.dart';
// import 'package:hrms_app/widgets/modal/add_new_modal.dart';
// import 'package:hrms_app/widgets/text_style_small.dart';
// import 'package:provider/provider.dart';

// // Invoice model
// class Invoice {
//   final String invoiceNumber;
//   final String date;
//   final String customerName;
//   final double amount;
//   final String status;

//   Invoice({
//     required this.invoiceNumber,
//     required this.date,
//     required this.customerName,
//     required this.amount,
//     required this.status,
//   });
// }

// // FocusNodeProvider to manage FocusNode state
// class FocusNodeProvider with ChangeNotifier {
//   final FocusNode _focusNode = FocusNode();

//   FocusNode get focusNode => _focusNode;

//   FocusNodeProvider() {
//     _focusNode.addListener(() {
//       notifyListeners();
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
// }

// // DataTableSource for managing invoice data
// class InvoiceDataSource extends DataTableSource {
//   final List<Invoice> invoices;

//   InvoiceDataSource(this.invoices);

//   @override
//   DataRow getRow(int index) {
//     if (index >= invoices.length) {
//       return const DataRow(cells: []);
//     }

//     final invoice = invoices[index];

//     return DataRow(cells: [
//       DataCell(textStyleSmall(invoice.invoiceNumber)),
//       DataCell(textStyleSmall(invoice.date)),
//       DataCell(textStyleSmall(invoice.customerName)),
//       DataCell(textStyleSmall('\$${invoice.amount.toStringAsFixed(2)}')),
//       DataCell(textStyleSmall(invoice.status)),
//     ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => invoices.length;

//   @override
//   int get selectedRowCount => 0;
// }

// // Main HrScreen widget
// class HrScreen extends StatefulWidget {
//   const HrScreen({super.key});

//   @override
//   State<HrScreen> createState() => HrScreenState();
// }

// class HrScreenState extends State<HrScreen> {
//   bool isHrForm = true;
//   final List<Invoice> invoices = [
//     Invoice(
//         invoiceNumber: 'Inv001',
//         date: '2023-10-01',
//         customerName: 'John Doe',
//         amount: 150.00,
//         status: 'Paid'),
//     Invoice(
//         invoiceNumber: 'INV002',
//         date: '2023-10-02',
//         customerName: 'Jane Smith',
//         amount: 200.00,
//         status: 'Pending'),
//     Invoice(
//         invoiceNumber: 'INV003',
//         date: '2023-10-03',
//         customerName: 'Acme Corp',
//         amount: 350.00,
//         status: 'Paid'),
//     Invoice(
//         invoiceNumber: 'INV004',
//         date: '2023-10-04',
//         customerName: 'Global Inc',
//         amount: 450.00,
//         status: 'Overdue'),
//     Invoice(
//         invoiceNumber: 'INV005',
//         date: '2023-10-05',
//         customerName: 'Tech Solutions',
//         amount: 600.00,
//         status: 'Paid'),
//   ];

//   String searchQuery = '';
//   String? selectedFilter;
//   void toggleForm() {
//     setState(() {
//       isHrForm = !isHrForm; // Toggle the form type
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredInvoices = _filterInvoices();

//     return ChangeNotifierProvider(
//       create: (context) => FocusNodeProvider(),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: Column(
//             children: [
//               _buildInvoiceButton(),
//               const SizedBox(height: 20),
//               _buildSearchAndFilter(),
//               const SizedBox(height: 20),
//               _buildInvoiceTable(filteredInvoices),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Filter invoices based on search query and selected filter
//   List<Invoice> _filterInvoices() {
//     return invoices.where((invoice) {
//       final matchesSearch = invoice.invoiceNumber.contains(searchQuery) ||
//           invoice.customerName.contains(searchQuery);
//       final matchesFilter = selectedFilter == null ||
//           selectedFilter == 'All' ||
//           selectedFilter == invoice.status;
//       return matchesSearch && matchesFilter;
//     }).toList();
//   }

//   // Build the Invoice button
//   // Build the HR button
// Widget _buildInvoiceButton() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       HoverButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             barrierColor: Colors.transparent, // Remove overlay color
//             builder: (context) => AddNewModal(
//               onClose: () {
//                 Navigator.of(context).pop();
//               },
//               formWidget: isHrForm
//                   ? buildHrFormFields((_) => Navigator.of(context).pop()) // Replace with HR form widget
//                   : buildJobListFormFields((_) => Navigator.of(context).pop()), // Pass the appropriate form widget
//             ),
//           ); 
//         },
//         text: isHrForm ? 'Add HR' : 'Add Job', // Change button text based on form type
//         icon: Icons.add,
//         clickEffectColor: Colors.teal,
//       ),
//     ],
//   );
// }

//   // Widget _buildInvoiceButton() {
//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.start,
//   //     children: [
//   //       HoverButton(
//   //         onPressed: () {
//   //           print('Button Pressed!');
//   //         },
//   //         text: 'Invoice',
//   //         icon: Icons.add,
//   //         clickEffectColor: Colors.teal,
//   //       ),
//   //     ],
//   //   );
//   // }

//   // Build the search and filter row
//   Widget _buildSearchAndFilter() {
//     return Consumer<FocusNodeProvider>(
//       builder: (context, focusNodeProvider, child) {
//         double width = focusNodeProvider.focusNode.hasFocus ? 300 : 250;

//         return Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: width,
//               child: _buildSearchField(focusNodeProvider),
//             ),
//             const SizedBox(width: 20),
//             _buildFilterDropdown(),
//           ],
//         );
//       },
//     );
//   }

//   // Build the search field
//   Widget _buildSearchField(FocusNodeProvider focusNodeProvider) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: TextField(
//         focusNode: focusNodeProvider.focusNode,
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           hintText: 'Invoice number',
//           hintStyle: TextStyle(
//             fontFamily: 'Montserrat',
//             fontSize: 17,
//             color: Color(0xFF114F5A),
//             letterSpacing: 2,
//           ),
//           contentPadding:
//               EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//           suffixIcon: Icon(Icons.search, color: Color(0xFF114F5A)),
//         ),
//         onChanged: (value) {
//           setState(() {
//             searchQuery = value;
//           });
//         },
//       ),
//     );
//   }

//   // Build the filter dropdown
//   Widget _buildFilterDropdown() {
//     return Container(
//       width: 110,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 8.0),
//         child: DropdownButton<String>(
//           hint: const Text('Filter'),
//           value: selectedFilter,
//           icon: const Icon(Icons.tune, color: Color(0xFF114F5A)),
//           isExpanded: true,
//           dropdownColor: Colors.white,
//           style: const TextStyle(
//             color: Color(0xFF114F5A),
//             fontFamily: 'Montserrat',
//             fontSize: 15,
//             letterSpacing: 2,
//           ),
//           underline: Container(),
//           items: <String>['All', 'Paid', 'Pending', 'Overdue']
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             setState(() {
//               selectedFilter = newValue;
//             });
//           },
//         ),
//       ),
//     );
//   }

//   // Build the invoice table
//   Widget _buildInvoiceTable(List<Invoice> filteredInvoices) {
//     final dataSource = InvoiceDataSource(filteredInvoices);

//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: PaginatedDataTable(
//                 header: headerText18('Invoice List'),
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
// }






// // import 'package:flutter/material.dart';
// // import 'package:hrms_app/utils/hover_button.dart';
// // import 'package:hrms_app/widgets/header_text_widget.dart';
// // import 'package:hrms_app/widgets/text_style_small.dart';
// // import 'package:provider/provider.dart';

// // // Invoice model
// // class Invoice {
// //   final String invoiceNumber;
// //   final String date;
// //   final String customerName;
// //   final double amount;
// //   final String status;

// //   Invoice({
// //     required this.invoiceNumber,
// //     required this.date,
// //     required this.customerName,
// //     required this.amount,
// //     required this.status,
// //   });
// // }

// // // FocusNodeProvider to manage FocusNode state
// // class FocusNodeProvider with ChangeNotifier {
// //   final FocusNode _focusNode = FocusNode(); // Make this field final

// //   FocusNode get focusNode => _focusNode;

// //   FocusNodeProvider() {
// //     _focusNode.addListener(() {
// //       notifyListeners(); // Notify listeners when focus changes
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _focusNode.dispose(); // Dispose the FocusNode
// //     super.dispose();
// //   }
// // }

// // // DataTableSource for managing invoice data
// // class InvoiceDataSource extends DataTableSource {
// //   final List<Invoice> invoices;

// //   InvoiceDataSource(this.invoices);

// //   @override
// //   DataRow getRow(int index) {
// //     assert(index >= 0);
// //     if (index >= invoices.length) {
// //       return const DataRow(cells: []); // Return an empty DataRow
// //     }

// //     final invoice = invoices[index];

// //     return DataRow(cells: [
// //       DataCell(textStyleSmall(invoice.invoiceNumber)),
// //       DataCell(textStyleSmall(invoice.date)),
// //       DataCell(textStyleSmall(invoice.customerName)),
// //       DataCell(textStyleSmall('\$${invoice.amount.toStringAsFixed(2)}')),
// //       DataCell(textStyleSmall(invoice.status)),
// //     ]);
// //   }

// //   @override
// //   bool get isRowCountApproximate => false;

// //   @override
// //   int get rowCount => invoices.length;

// //   @override
// //   int get selectedRowCount => 0; // You can implement selection if needed
// // }

// // // Main HrScreen widget
// // class HrScreen extends StatefulWidget {
// //   const HrScreen({super.key});

// //   @override
// //   State<HrScreen> createState() => HrScreenState();
// // }

// // class HrScreenState extends State<HrScreen> {
// //   // Sample invoice data
// //   final List<Invoice> invoices = [
// //     Invoice(
// //         invoiceNumber: 'Inv001',
// //         date: '2023-10-01',
// //         customerName: 'John Doe',
// //         amount: 150.00,
// //         status: 'Paid'),
// //     Invoice(
// //         invoiceNumber: 'INV002',
// //         date: '2023-10-02',
// //         customerName: 'Jane Smith',
// //         amount: 200.00,
// //         status: 'Pending'),
// //     Invoice(
// //         invoiceNumber: 'INV003',
// //         date: '2023-10-03',
// //         customerName: 'Acme Corp',
// //         amount: 350.00,
// //         status: 'Paid'),
// //     Invoice(
// //         invoiceNumber: 'INV004',
// //         date: '2023-10-04',
// //         customerName: 'Global Inc',
// //         amount: 450.00,
// //         status: 'Overdue'),
// //     Invoice(
// //         invoiceNumber: 'INV005',
// //         date: '2023-10-05',
// //         customerName: 'Tech Solutions',
// //         amount: 600.00,
// //         status: 'Paid'),
// //   ];

// //   String searchQuery = '';
// //   String? selectedFilter;

// //   @override
// //   Widget build(BuildContext context) {
// //     final filteredInvoices = invoices.where((invoice) {
// //       final matchesSearch = invoice.invoiceNumber.contains(searchQuery) ||
// //           invoice.customerName.contains(searchQuery);
// //       final matchesFilter = selectedFilter == null ||
// //           (selectedFilter == 'All') ||
// //           (selectedFilter == invoice.status);
// //       return matchesSearch && matchesFilter;
// //     }).toList();

// //     final dataSource = InvoiceDataSource(filteredInvoices);

// //     return ChangeNotifierProvider(
// //       create: (context) => FocusNodeProvider(),
// //       child: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.only(left: 20.0),
// //           child: Column(
// //             children: [
// //               // Row for the Invoice Button
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: [
// //                   HoverButton(
// //             onPressed: () {
// //               // Your onPressed logic here
// //               print('Button Pressed!');
// //             },
// //             text: 'Invoice',
// //             icon: Icons.add,
// //             clickEffectColor: Colors.teal,
// //           ),
// //                 ],
// //               ),
// //               const SizedBox(height: 20),

// //               // Row for Search and Filter
// //               Consumer<FocusNodeProvider>(
// //                 builder: (context, focusNodeProvider, child) {
// //                   double width =
// //                       focusNodeProvider.focusNode.hasFocus ? 300 : 250;

// //                   return Row(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     children: [
// //                       SizedBox(
// //                         width: width,
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             boxShadow: [
// //                               BoxShadow(
// //                                 color: Colors.black
// //                                     .withOpacity(0.1), // Shadow color
// //                                 spreadRadius: 2, // Spread radius
// //                                 blurRadius: 5, // Blur radius
// //                                 offset:
// //                                     const Offset(0, 3), // Offset for the shadow
// //                               ),
// //                             ],
// //                           ),
// //                           child: TextField(
// //                             focusNode: focusNodeProvider.focusNode,
// //                             decoration: const InputDecoration(
// //                                 border: InputBorder.none,
// //                                 focusedBorder: InputBorder.none,
// //                                 hintText: 'Invoice number',
// //                                 hintStyle: TextStyle(
// //                                   fontFamily: 'Montserrat',
// //                                   fontSize: 17,
// //                                   color: Color(0xFF114F5A),
// //                                   letterSpacing: 2,
// //                                 ), // Change hint text color
// //                                 contentPadding: EdgeInsets.symmetric(
// //                                     vertical: 10.0,
// //                                     horizontal:
// //                                         10.0), // Add padding to hint text
// //                                 suffixIcon: Row(
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   children: [
// //                                     // Text('Search'),
// //                                     SizedBox(width: 5),
// //                                     Icon(Icons.search,
// //                                         color: Color(0xFF114F5A)),
// //                                   ],
// //                                 )),
// //                             onChanged: (value) {
// //                               setState(() {
// //                                 searchQuery = value;
// //                               });
// //                             },
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(width: 20),
// //                       Container(
// //                         width: 110,
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color:
// //                                   Colors.black.withOpacity(0.1), // Shadow color
// //                               spreadRadius: 2, // Spread radius
// //                               blurRadius: 5, // Blur radius
// //                               offset:
// //                                   const Offset(0, 3), // Offset for the shadow
// //                             ),
// //                           ],
// //                         ),
// //                         child: Padding(
// //                           padding: const EdgeInsets.only(left: 8.0),
// //                           child: DropdownButton<String>(
// //                             hint: const Text('Filter'),
// //                             value: selectedFilter,
// //                             icon: const Icon(
// //                               Icons.tune,
// //                               color: Color(0xFF114F5A),
// //                             ), // Change to filter icon

// //                             isExpanded:
// //                                 true, // Ensures the dropdown takes the full width
// //                             // itemHeight: 50, // Set the height of each dropdown item
// //                             dropdownColor: Colors
// //                                 .white, // Background color of the dropdown
// //                             style: const TextStyle(
// //                               color: Color(0xFF114F5A),
// //                               fontFamily:
// //                                   'Montserrat', // Change font for the displayed value
// //                               fontSize: 15,
// //                               letterSpacing: 2,
// //                             ), // Text style for dropdown items
// //                             underline: Container(), // Remove the underline
// //                             items: <String>['All', 'Paid', 'Pending', 'Overdue']
// //                                 .map<DropdownMenuItem<String>>((String value) {
// //                               return DropdownMenuItem<String>(
// //                                 value: value,
// //                                 child: Text(value),
// //                               );
// //                             }).toList(),
// //                             onChanged: (String? newValue) {
// //                               setState(() {
// //                                 selectedFilter = newValue;
// //                               });
// //                             },
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   );
// //                 },
// //               ),

// //               const SizedBox(height: 20), // Space between button and table
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: PaginatedDataTable(
// //                       header: headerText18('Invoice List'),

// //                       columns: [
// //                         DataColumn(label: textStyleSmall('Invoice Number')),
// //                         DataColumn(label: textStyleSmall('Date')),
// //                         DataColumn(label: textStyleSmall('Customer Name')),
// //                         DataColumn(label: textStyleSmall('Amount')),
// //                         DataColumn(label: textStyleSmall('Status')),
// //                       ],
// //                       source: dataSource,
// //                       rowsPerPage: 5,
// //                       showCheckboxColumn: true,
// //                       sortAscending: true, // Hide checkbox column if not needed
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
