import 'package:flutter/material.dart';

final List<Map<String, dynamic>> invoiceItems = [
  {
    'code': '590067',
    'name': 'S&S MWEA PISHORI RICE 1KG',
    'units': '24X1KG',
    'qty': 1,
    'unitPrice': 6568.00,
    'total': 6568.00,
    'vat': 0.00,
    'discount': '5%',
  },
  {
    'code': '590050',
    'name': 'S&S MWEA PISHORI RICE 2KGS',
    'units': '12X2KGS',
    'qty': 1,
    'unitPrice': 6250.00,
    'total': 6250.00,
    'vat': 0.00,
    'discount': '5%',
  },
  {
    'code': '590074',
    'name': 'S&S MWEA PISHORI RICE 5KGS',
    'units': '5X5KGS',
    'qty': 1,
    'unitPrice': 6682.00,
    'total': 6682.00,
    'vat': 0.00,
    'discount': '5%',
  },
  {
    'code': '590810',
    'name': 'S&S AROMATIC PARBOILED BASMATI 2',
    'units': '12X2KGS',
    'qty': 1,
    'unitPrice': 4998.00,
    'total': 4998.00,
    'vat': 0.00,
    'discount': '5%',
  },
  {
    'code': '590216',
    'name': 'S&S PREMIUM BASMATI RICE 2KGS',
    'units': '12X2KGS',
    'qty': 1,
    'unitPrice': 7799.00,
    'total': 7799.00,
    'vat': 0.00,
    'discount': '5%',
  },
  {
    'code': '590278',
    'name': 'S&S BROWN RICE 1KG',
    'units': '24X1KG',
    'qty': 2,
    'unitPrice': 7249.00,
    'total': 14498.00,
    'vat': 0.00,
    'discount': '5%',
  },
  {
    'code': '590490',
    'name': 'S&S GREENGRAMS (POLISHED) 1KG',
    'units': '24X1KG',
    'qty': 1,
    'unitPrice': 4394.00,
    'total': 4394.00,
    'vat': 0.00,
    'discount': '5%',
  },
];

class ShowInvoiceItem extends StatelessWidget {
  const ShowInvoiceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 70.0), // Fixed: Use named parameter 'width'
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KINGS COMMODITIES LTD',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                      height: 8), // Fixed: Use named parameter 'height'
                  Text('Behind Vision Plaza.'),
                  Text('Tel:+254(020)2042414/8000860'),
                  Text('0737560962/0722324828/0722-319267'),
                  Text('---communications.com'),
                ],
              ),
            ),
            const SizedBox(width: 40.0), // Fixed: Use named parameter 'width'
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Profoma Invoice',
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Color(0xFF114F5A)),
                    ),
                  ),
                  // const SizedBox(height: 8), // Fixed: Use named parameter 'height'
                  Row(
                    children: [
                      Expanded(
                        child:
                            Container(), // Empty container to push the table to the right
                      ),
                      Container(
                        width: 300, // Set the width of the table
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: const Color(0xFF114F5A)),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Table(
                            border: const TableBorder.symmetric(
                              inside: BorderSide(
                                  width: 1.0, color: Color(0xFF114F5A)),
                            ),
                            children: const [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      'Date',
                                      style: TextStyle(
                                          fontSize: 15,
                                          letterSpacing: 2,
                                          color: Color(0xFF114F5A)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      'Invoice Number',
                                      style: TextStyle(
                                          fontSize: 15,
                                          letterSpacing: 2,
                                          color: Color(0xFF114F5A)),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '8-Jul-2024',
                                      style: TextStyle(
                                          fontSize: 15,
                                          letterSpacing: 2,
                                          color: Color(0xFF114F5A)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'E-CU46535',
                                      style: TextStyle(
                                          fontSize: 15,
                                          letterSpacing: 2,
                                          color: Color(0xFF114F5A)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        

        //the end
        const SizedBox(height: 52),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 300, // Set the width of the table
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0,
                      color: const Color(0xFF114F5A),
                      style: BorderStyle.solid),
                  // Add border to the container
                  borderRadius: BorderRadius.circular(
                      7), // Add border radius to the container
                ),

                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(7), // Clip the table's outer edges
                  child: Table(
                    border: const TableBorder.symmetric(
                      // Add internal borders (sharp corners)
                      outside: BorderSide.none,
                      inside: BorderSide(
                          width: 1.0,
                          color: Colors.black,
                          style: BorderStyle.solid),
                    ),
                    children: const [
                      // Table header row
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'To: SimpliNetworks',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                width: 270, // Set the width of the table
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0,
                      color: const Color(0xFF114F5A),
                      style: BorderStyle.solid),
                  // Add border to the container
                  borderRadius: BorderRadius.circular(
                      7), // Add border radius to the container
                ),

                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(7), // Clip the table's outer edges
                  child: Table(
                    border: const TableBorder.symmetric(
                      // Add internal borders (sharp corners)
                      outside: BorderSide.none,
                      inside: BorderSide(
                          width: 1.0,
                          color: Color(0xFF114F5A),
                          style: BorderStyle.solid),
                    ),
                    children: const [
                      // Table header row
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              'Delivered To',
                              // style: TextStyle(
                              // fontSize: 12.0,
                              // fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      // Table data row
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('JUJA EASTMART'),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Text('E-CU46535'),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ]),

        // const SizedBox(height: 16),

        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                width: 400, // Set the width of the table
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0,
                      color: const Color(0xFF114F5A),
                      style: BorderStyle.solid),
                  // Add border to the container
                  borderRadius: BorderRadius.circular(
                      7), // Add border radius to the container
                ),

                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(7), // Clip the table's outer edges
                  child: Table(
                    border: const TableBorder.symmetric(
                      // Add internal borders (sharp corners)
                      outside: BorderSide.none,
                      inside: BorderSide(
                          width: 1.0,
                          color: Color(0xFF114F5A),
                          style: BorderStyle.solid),
                    ),
                    children: const [
                      // Table header row
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              'Due Date',
                              // style: TextStyle(
                              // fontSize: 12.0,
                              // fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              'LPO No',
                              // style: TextStyle(
                              // fontSize: 12.0,
                              // fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              'Terms',
                              // style: TextStyle(
                              // fontSize: 12.0,
                              // fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      // Table data row
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('19/02/2025'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(' '),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('14'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ]),

        // const SizedBox(height: 16),
//         Container(
//   decoration: BoxDecoration(
//     border: Border.all(
//       width: 1.0,
//       color: const Color(0xFF114F5A),
//       style: BorderStyle.solid,
//     ),
//     borderRadius: BorderRadius.circular(7), // Add border radius to the container
//   ),
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(7),
//     child: Column(
//       children: [
//         // Table
//         Container(
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide.none, // Remove bottom border for the table
//             ),
//           ),
//           child: Table(
//             border: const TableBorder(
//               // Add vertical borders only
//               verticalInside: BorderSide(
//                 width: 1.0,
//                 color: Color(0xFF114F5A),
//                 style: BorderStyle.solid,
//               ),
//               // Remove horizontal borders
//               horizontalInside: BorderSide.none,
//             ),
//             columnWidths: const {
//               // Adjust column widths
//               0: FlexColumnWidth(0.8), // Code column
//               1: FlexColumnWidth(3.2), // Name column
//               2: FlexColumnWidth(1.0), // Units column
//               3: FlexColumnWidth(0.5), // Qty column
//               4: FlexColumnWidth(1.0), // Unit Price column
//               5: FlexColumnWidth(1.0), // Total column
//               6: FlexColumnWidth(0.6), // VAT column
//               7: FlexColumnWidth(0.8), // Discount column
//             },
//             children: [
//               // Header Row
//               const TableRow(
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       width: 1.0,
//                       color: Color(0xFF114F5A),
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                 ),
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Code'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Name'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Units'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Qty'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Unit Price'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Total'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('VAT'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Disc(%)'),
//                   ),
//                 ],
//               ),
//               // Data Rows
//               ...invoiceItems.map((item) {
//                 return TableRow(
//                   decoration: const BoxDecoration(
//                     // Remove horizontal borders for data rows
//                     border: Border(
//                       bottom: BorderSide.none,
//                     ),
//                   ),
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['code']),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['name']),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['units']),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['qty'].toString()),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['unitPrice'].toString()),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['total'].toString()),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['vat'].toString()),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['discount'].toString()),
//                     ),
//                   ],
//                 );
//               }),
//               // Add empty space after the last row
//               TableRow(
//                 children: List.generate(8, (index) => const SizedBox(height: 16)), // Add empty space
//               ),
//             ],
//           ),
//         ),
//         // Footer
//         Container(
//   decoration: BoxDecoration(
//     border: Border.all(
//       width: 1.0,
//       color: const Color(0xFF114F5A),
//       style: BorderStyle.solid,
//     ),
//     borderRadius: BorderRadius.circular(7), // Add border radius to the container
//   ),
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(7),
//     child: Column(
//       children: [
//         // First Row: Approved By, Date, Signature
//         Row(
//           children: [
//             // First Column
//             Container(
//               width: 480, // Specific width for the first column
//               decoration: const BoxDecoration(
//                 border: Border(
//                   right: BorderSide(
//                     width: 1.0,
//                     color: Color(0xFF114F5A),
//                     style: BorderStyle.solid,
//                   ),
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Approved By: ......'),
//                     Text('Date: ......'),
//                     Text('Signature: ......'),
//                   ],
//                 ),
//               ),
//             ),
//             // Second Column
//             Container(
//               width: 174.5, // Specific width for the second column
//               decoration: const BoxDecoration(
//                 border: Border(
//                   right: BorderSide(
//                     width: 1.0,
//                     color: Color(0xFF114F5A),
//                     style: BorderStyle.solid,
//                   ),
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Exclusive Vat'),
//                     Text('Total Discount'),
//                     Text('Total Vat'),
//                   ],
//                 ),
//               ),
//             ),
//             // Third Column
//             Expanded(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     right: BorderSide(
//                       width: 1.0,
//                       color: Color(0xFF114F5A),
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         calculateTotal(invoiceItems).toStringAsFixed(2),
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 4), // Reduced spacing
//                       const Text(
//                         '2,559.45', // Total Discount value
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 4), // Reduced spacing
//                       const Text(
//                         '0.00', // Total VAT value
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         // Second Row: Grand Total and Sum
//         Container(
//           decoration: const BoxDecoration(
//             border: Border(
//               top: BorderSide(
//                 width: 1.0,
//                 color: Color(0xFF114F5A),
//                 style: BorderStyle.solid,
//               ),
//             ),
//           ),
//           child: Row(
//             children: [
//               // Empty space for the first column
//               Container(
//                 width: 480, // Same width as the first column
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     right: BorderSide(
//                       width: 1.0,
//                       color: Color(0xFF114F5A),
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                 ),
//               ),
//               // Grand Total text in the second column
//               Container(
//                 width: 174.5, // Same width as the second column
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     right: BorderSide(
//                       width: 1.0,
//                       color: Color(0xFF114F5A),
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('Grand Total'),
//                 ),
//               ),
//               // Sum of Total Amount, Total Discount, and Total VAT in the third column
//               Expanded(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     border: Border(
//                       right: BorderSide(
//                         width: 1.0,
//                         color: Color(0xFF114F5A),
//                         style: BorderStyle.solid,
//                       ),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       (calculateTotal(invoiceItems) - 2559.45 - 0.00).toStringAsFixed(2), // Sum calculation
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
//         // Add empty space after the footer
//         const SizedBox(height: 16), // Add empty space
//       ],
//     ),
//   ),
// ),





        Container(
          // height: 800,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.0, color: const Color(0xFF114F5A), style: BorderStyle.solid),
            // Add border to the container
            borderRadius:
                BorderRadius.circular(7), // Add border radius to the container
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Column(
              children: [
                // Table
                Container(
                  
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide.none, // Remove bottom border for the table
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0), // Adjust as needed
                      bottomRight: Radius.circular(0), // Adjust as needed
                    ),
                  ),
                  child: Table(
                    border: const TableBorder(
                      // Add vertical borders only
                      verticalInside: BorderSide(
                        width: 1.0,
                        color: Color(0xFF114F5A),
                        style: BorderStyle.solid,
                      ),
                      // Remove horizontal borders
                      horizontalInside: BorderSide.none,
                    ),
                    columnWidths: const {
                      // Adjust column widths
                      0: FlexColumnWidth(0.8), // Code column
                      1: FlexColumnWidth(3.2), // Name column
                      2: FlexColumnWidth(1.0), // Units column
                      3: FlexColumnWidth(0.5), // Qty column
                      4: FlexColumnWidth(1.0), // Unit Price column
                      5: FlexColumnWidth(1.0), // Total column
                      6: FlexColumnWidth(0.6), // VAT column
                      7: FlexColumnWidth(0.8), // Discount column
                    },
                    children: [
                      // Header Row
                      const TableRow(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: Color(0xFF114F5A),
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Code'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Name'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Units'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Qty'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Unit Price'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Total'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('VAT'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Disc(%)'),
                          ),
                        ],
                      ),
                      // Data Rows
                      ...invoiceItems.map((item) {
                        return TableRow(
                          decoration: const BoxDecoration(
                            // Remove horizontal borders for data rows
                            border: Border(
                              bottom: BorderSide.none,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['code']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['name']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['units']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['qty'].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['unitPrice'].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['total'].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['vat'].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['discount'].toString()),
                            ),
                            
                          ],

                          
                        );
                        
                      }),
                       // Add empty space after the last row
              TableRow(
                children: List.generate(8, (index) => const SizedBox(height: 270)), // Add empty space
              ),
                    ],
                  ),
                 
                ),
                
                // Footer Row (placed outside the table)
                Container(
                  height: 120, // Set height for the entire footer
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.0,
                          color: Color(0xFF114F5A),
                          style: BorderStyle.solid),
                      right: BorderSide.none,
                      left: BorderSide.none,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      // First Column with specific width
                      Container(
                        width: 480, // Specific width for the first column
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 1.0,
                              color: Color(0xFF114F5A),
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Approved By: ......'),
                              Text('Date: ......'),
                              Text('Signature: ......'),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      // Second and Third Columns with a shared border top
                      Expanded(
                        child: Column(
                          children: [
                            // First Row for the second and third columns
                            Expanded(
                              child: Row(
                                children: [
                                  // Second Column with specific width
                                  Container(
                                    width:
                                        174.5, // Specific width for the second column
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xFF114F5A),
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Exclusive Vat'),
                                          Text('Total Discount'),
                                          Text('Total Vat'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Third Column (takes remaining space)
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            width: 1.0,
                                            color: Color(0xFF114F5A),
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              calculateTotal(invoiceItems)
                                                  .toStringAsFixed(2),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                             // Add spacing
                                            const Text(
                                              '2,559.45', // Total Discount value
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                             // Add spacing
                                            const Text(
                                              '0.00', // Total VAT value
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Second Row for the Grand Total and sum with a border top
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1.0,
                                    color: Color(0xFF114F5A),
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Grand Total text in the second column
                                  Container(
                                    width:
                                        174.5, // Same width as the second column
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xFF114F5A),
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Grand Total'),
                                    ),
                                  ),
                                  // Sum of Total Amount, Total Discount, and Total VAT in the third column
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            width: 1.0,
                                            color: Color(0xFF114F5A),
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          (calculateTotal(invoiceItems) -
                                                  2559.45 -
                                                  0.00)
                                              .toStringAsFixed(
                                                  2), // Sum calculation
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),
        const Text('NB. This is not an Invoice'),
      ],
    );
  }

  double calculateTotal(List<Map<String, dynamic>> items) {
    return items.fold(0.0, (sum, item) => sum + (item['total'] as double));
  }
}








// import 'package:flutter/material.dart';

// final List<Map<String, dynamic>> invoiceItems = [
//   {
//     'code': '590067',
//     'name': 'S&S MWEA PISHORI RICE 1KG',
//     'units': '24X1KG',
//     'qty': 1,
//     'unitPrice': 6568.00,
//     'total': 6568.00,
//     'vat': 0.00,
//     'discount': '5%',
//   },
//   {
//     'code': '590050',
//     'name': 'S&S MWEA PISHORI RICE 2KGS',
//     'units': '12X2KGS',
//     'qty': 1,
//     'unitPrice': 6250.00,
//     'total': 6250.00,
//     'vat': 0.00,
//     'discount': '5%',
//   },
//   {
//     'code': '590074',
//     'name': 'S&S MWEA PISHORI RICE 5KGS',
//     'units': '5X5KGS',
//     'qty': 1,
//     'unitPrice': 6682.00,
//     'total': 6682.00,
//     'vat': 0.00,
//     'discount': '5%',
//   },
//   {
//     'code': '590810',
//     'name': 'S&S AROMATIC PARBOILED BASMATI 2',
//     'units': '12X2KGS',
//     'qty': 1,
//     'unitPrice': 4998.00,
//     'total': 4998.00,
//     'vat': 0.00,
//     'discount': '5%',
//   },
//   {
//     'code': '590216',
//     'name': 'S&S PREMIUM BASMATI RICE 2KGS',
//     'units': '12X2KGS',
//     'qty': 1,
//     'unitPrice': 7799.00,
//     'total': 7799.00,
//     'vat': 0.00,
//     'discount': '5%',
//   },
//   {
//     'code': '590278',
//     'name': 'S&S BROWN RICE 1KG',
//     'units': '24X1KG',
//     'qty': 2,
//     'unitPrice': 7249.00,
//     'total': 14498.00,
//     'vat': 0.00,
//     'discount': '5%',
//   },
//   {
//     'code': '590490',
//     'name': 'S&S GREENGRAMS (POLISHED) 1KG',
//     'units': '24X1KG',
//     'qty': 1,
//     'unitPrice': 4394.00,
//     'total': 4394.00,
//     'vat': 0.00,
//     'discount': '5%',
//   },
// ];

// class ShowInvoiceItem extends StatelessWidget {
//   const ShowInvoiceItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(width: 70.0), // Fixed: Use named parameter 'width'
//             const Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'KINGS COMMODITIES LTD',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                       height: 8), // Fixed: Use named parameter 'height'
//                   Text('Behind Vision Plaza.'),
//                   Text('Tel:+254(020)2042414/8000860'),
//                   Text('0737560962/0722324828/0722-319267'),
//                   Text('---communications.com'),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 40.0), // Fixed: Use named parameter 'width'
//             Expanded(
//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start, // Align text to the left
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(left: 32.0),
//                     child: Text(
//                       'Profoma Invoice',
//                       style: TextStyle(
//                           fontSize: 15,
//                           letterSpacing: 2,
//                           color: Color(0xFF114F5A)),
//                     ),
//                   ),
//                   // const SizedBox(height: 8), // Fixed: Use named parameter 'height'
//                   Row(
//                     children: [
//                       Expanded(
//                         child:
//                             Container(), // Empty container to push the table to the right
//                       ),
//                       Container(
//                         width: 300, // Set the width of the table
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               width: 1.0, color: const Color(0xFF114F5A)),
//                           borderRadius: BorderRadius.circular(7),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(7),
//                           child: Table(
//                             border: const TableBorder.symmetric(
//                               inside: BorderSide(
//                                   width: 1.0, color: Color(0xFF114F5A)),
//                             ),
//                             children: const [
//                               TableRow(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(6.0),
//                                     child: Text(
//                                       'Date',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           letterSpacing: 2,
//                                           color: Color(0xFF114F5A)),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(6.0),
//                                     child: Text(
//                                       'Invoice Number',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           letterSpacing: 2,
//                                           color: Color(0xFF114F5A)),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               TableRow(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       '8-Jul-2024',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           letterSpacing: 2,
//                                           color: Color(0xFF114F5A)),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'E-CU46535',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           letterSpacing: 2,
//                                           color: Color(0xFF114F5A)),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
        

//         //the end
//         const SizedBox(height: 52),
//         Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Expanded(
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 300, // Set the width of the table
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 1.0,
//                       color: const Color(0xFF114F5A),
//                       style: BorderStyle.solid),
//                   // Add border to the container
//                   borderRadius: BorderRadius.circular(
//                       7), // Add border radius to the container
//                 ),

//                 child: ClipRRect(
//                   borderRadius:
//                       BorderRadius.circular(7), // Clip the table's outer edges
//                   child: Table(
//                     border: const TableBorder.symmetric(
//                       // Add internal borders (sharp corners)
//                       outside: BorderSide.none,
//                       inside: BorderSide(
//                           width: 1.0,
//                           color: Colors.black,
//                           style: BorderStyle.solid),
//                     ),
//                     children: const [
//                       // Table header row
//                       TableRow(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(16.0),
//                             child: Text(
//                               'To: SimpliNetworks',
//                               style: TextStyle(
//                                   fontSize: 15.0, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           )),
//           Expanded(
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//               Container(
//                 width: 270, // Set the width of the table
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 1.0,
//                       color: const Color(0xFF114F5A),
//                       style: BorderStyle.solid),
//                   // Add border to the container
//                   borderRadius: BorderRadius.circular(
//                       7), // Add border radius to the container
//                 ),

//                 child: ClipRRect(
//                   borderRadius:
//                       BorderRadius.circular(7), // Clip the table's outer edges
//                   child: Table(
//                     border: const TableBorder.symmetric(
//                       // Add internal borders (sharp corners)
//                       outside: BorderSide.none,
//                       inside: BorderSide(
//                           width: 1.0,
//                           color: Color(0xFF114F5A),
//                           style: BorderStyle.solid),
//                     ),
//                     children: const [
//                       // Table header row
//                       TableRow(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(7.0),
//                             child: Text(
//                               'Delivered To',
//                               // style: TextStyle(
//                               // fontSize: 12.0,
//                               // fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Table data row
//                       TableRow(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('JUJA EASTMART'),
//                           ),
//                           // Padding(
//                           //   padding: EdgeInsets.all(8.0),
//                           //   child: Text('E-CU46535'),
//                           // ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//         ]),

//         // const SizedBox(height: 16),

//         Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Expanded(
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//               Container(
//                 width: 400, // Set the width of the table
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       width: 1.0,
//                       color: const Color(0xFF114F5A),
//                       style: BorderStyle.solid),
//                   // Add border to the container
//                   borderRadius: BorderRadius.circular(
//                       7), // Add border radius to the container
//                 ),

//                 child: ClipRRect(
//                   borderRadius:
//                       BorderRadius.circular(7), // Clip the table's outer edges
//                   child: Table(
//                     border: const TableBorder.symmetric(
//                       // Add internal borders (sharp corners)
//                       outside: BorderSide.none,
//                       inside: BorderSide(
//                           width: 1.0,
//                           color: Color(0xFF114F5A),
//                           style: BorderStyle.solid),
//                     ),
//                     children: const [
//                       // Table header row
//                       TableRow(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(7.0),
//                             child: Text(
//                               'Due Date',
//                               // style: TextStyle(
//                               // fontSize: 12.0,
//                               // fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(7.0),
//                             child: Text(
//                               'LPO No',
//                               // style: TextStyle(
//                               // fontSize: 12.0,
//                               // fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(7.0),
//                             child: Text(
//                               'Terms',
//                               // style: TextStyle(
//                               // fontSize: 12.0,
//                               // fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Table data row
//                       TableRow(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('19/02/2025'),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text(' '),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text('14'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//         ]),

//         // const SizedBox(height: 16),
//         Container(
//   decoration: BoxDecoration(
//     border: Border.all(
//       width: 1.0,
//       color: const Color(0xFF114F5A),
//       style: BorderStyle.solid,
//     ),
//     borderRadius: BorderRadius.circular(7), // Add border radius to the container
//   ),
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(7),
//     child: Column(
//       children: [
//         // Table
//         Container(
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide.none, // Remove bottom border for the table
//             ),
//           ),
//           child: Table(
//             border: const TableBorder(
//               // Add vertical borders only
//               verticalInside: BorderSide(
//                 width: 1.0,
//                 color: Color(0xFF114F5A),
//                 style: BorderStyle.solid,
//               ),
//               // Remove horizontal borders
//               horizontalInside: BorderSide.none,
//             ),
//             columnWidths: const {
//               // Adjust column widths
//               0: FlexColumnWidth(0.8), // Code column
//               1: FlexColumnWidth(3.2), // Name column
//               2: FlexColumnWidth(1.0), // Units column
//               3: FlexColumnWidth(0.5), // Qty column
//               4: FlexColumnWidth(1.0), // Unit Price column
//               5: FlexColumnWidth(1.0), // Total column
//               6: FlexColumnWidth(0.6), // VAT column
//               7: FlexColumnWidth(0.8), // Discount column
//             },
//             children: [
//               // Header Row
//               const TableRow(
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       width: 1.0,
//                       color: Color(0xFF114F5A),
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                 ),
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Code'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Name'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Units'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Qty'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Unit Price'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Total'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('VAT'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Disc(%)'),
//                   ),
//                 ],
//               ),
//               // Data Rows
//               ...invoiceItems.map((item) {
//                 return TableRow(
//                   decoration: const BoxDecoration(
//                     // Remove horizontal borders for data rows
//                     border: Border(
//                       bottom: BorderSide.none,
//                     ),
//                   ),
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['code']),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['name']),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['units']),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['qty'].toString()),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['unitPrice'].toString()),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['total'].toString()),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['vat'].toString()),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
//                       child: Text(item['discount'].toString()),
//                     ),
//                   ],
//                 );
//               }),
//               // Add empty space after the last row
//               TableRow(
//                 children: List.generate(8, (index) => const SizedBox(height: 16)), // Add empty space
//               ),
//             ],
//           ),
//         ),
//         // Footer
//         Container(
//   decoration: BoxDecoration(
//     border: Border.all(
//       width: 1.0,
//       color: const Color(0xFF114F5A),
//       style: BorderStyle.solid,
//     ),
//     borderRadius: BorderRadius.circular(7), // Add border radius to the container
//   ),
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(7),
//     child: Column(
//       children: [
//         // First Row: Approved By, Date, Signature
//         Row(
//           children: [
//             // First Column
//             Container(
//               width: 480, // Specific width for the first column
//               decoration: const BoxDecoration(
//                 border: Border(
//                   right: BorderSide(
//                     width: 1.0,
//                     color: Color(0xFF114F5A),
//                     style: BorderStyle.solid,
//                   ),
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Approved By: ......'),
//                     Text('Date: ......'),
//                     Text('Signature: ......'),
//                   ],
//                 ),
//               ),
//             ),
//             // Second Column
//             Container(
//               width: 174.5, // Specific width for the second column
//               decoration: const BoxDecoration(
//                 border: Border(
//                   right: BorderSide(
//                     width: 1.0,
//                     color: Color(0xFF114F5A),
//                     style: BorderStyle.solid,
//                   ),
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Exclusive Vat'),
//                     Text('Total Discount'),
//                     Text('Total Vat'),
//                   ],
//                 ),
//               ),
//             ),
//             // Third Column
//             Expanded(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     right: BorderSide(
//                       width: 1.0,
//                       color: Color(0xFF114F5A),
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         calculateTotal(invoiceItems).toStringAsFixed(2),
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 4), // Reduced spacing
//                       const Text(
//                         '2,559.45', // Total Discount value
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 4), // Reduced spacing
//                       const Text(
//                         '0.00', // Total VAT value
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         // Second Row: Grand Total and Sum
//         Container(
//           decoration: const BoxDecoration(
//             border: Border(
//               top: BorderSide(
//                 width: 1.0,
//                 color: Color(0xFF114F5A),
//                 style: BorderStyle.solid,
//               ),
//             ),
//           ),
//           child: Row(
//             children: [
//               // Empty space for the first column
//               Container(
//                 width: 480, // Same width as the first column
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     right: BorderSide(
//                       width: 1.0,
//                       color: Color(0xFF114F5A),
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                 ),
//               ),
//               // Grand Total text in the second column
//               Container(
//                 width: 174.5, // Same width as the second column
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     right: BorderSide(
//                       width: 1.0,
//                       color: Color(0xFF114F5A),
//                       style: BorderStyle.solid,
//                     ),
//                   ),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('Grand Total'),
//                 ),
//               ),
//               // Sum of Total Amount, Total Discount, and Total VAT in the third column
//               Expanded(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     border: Border(
//                       right: BorderSide(
//                         width: 1.0,
//                         color: Color(0xFF114F5A),
//                         style: BorderStyle.solid,
//                       ),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       (calculateTotal(invoiceItems) - 2559.45 - 0.00).toStringAsFixed(2), // Sum calculation
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
//         // Add empty space after the footer
//         const SizedBox(height: 16), // Add empty space
//       ],
//     ),
//   ),
// ),





//         // Container(
//         //   // height: 800,
//         //   decoration: BoxDecoration(
//         //     border: Border.all(
//         //         width: 1.0, color: const Color(0xFF114F5A), style: BorderStyle.solid),
//         //     // Add border to the container
//         //     borderRadius:
//         //         BorderRadius.circular(7), // Add border radius to the container
//         //   ),
//         //   child: ClipRRect(
//         //     borderRadius: BorderRadius.circular(7),
//         //     child: Column(
//         //       children: [
//         //         // Table
//         //         Container(
                  
//         //           decoration: const BoxDecoration(
//         //             border: Border(
//         //               bottom:
//         //                   BorderSide.none, // Remove bottom border for the table
//         //             ),
//         //             borderRadius: BorderRadius.only(
//         //               bottomLeft: Radius.circular(0), // Adjust as needed
//         //               bottomRight: Radius.circular(0), // Adjust as needed
//         //             ),
//         //           ),
//         //           child: Table(
//         //             border: const TableBorder(
//         //               // Add vertical borders only
//         //               verticalInside: BorderSide(
//         //                 width: 1.0,
//         //                 color: Color(0xFF114F5A),
//         //                 style: BorderStyle.solid,
//         //               ),
//         //               // Remove horizontal borders
//         //               horizontalInside: BorderSide.none,
//         //             ),
//         //             columnWidths: const {
//         //               // Adjust column widths
//         //               0: FlexColumnWidth(0.8), // Code column
//         //               1: FlexColumnWidth(3.2), // Name column
//         //               2: FlexColumnWidth(1.0), // Units column
//         //               3: FlexColumnWidth(0.5), // Qty column
//         //               4: FlexColumnWidth(1.0), // Unit Price column
//         //               5: FlexColumnWidth(1.0), // Total column
//         //               6: FlexColumnWidth(0.6), // VAT column
//         //               7: FlexColumnWidth(0.8), // Discount column
//         //             },
//         //             children: [
//         //               // Header Row
//         //               const TableRow(
//         //                 decoration: BoxDecoration(
//         //                   border: Border(
//         //                     bottom: BorderSide(
//         //                       width: 1.0,
//         //                       color: Color(0xFF114F5A),
//         //                       style: BorderStyle.solid,
//         //                     ),
//         //                   ),
//         //                 ),
//         //                 children: [
//         //                   Padding(
//         //                     padding: EdgeInsets.all(8.0),
//         //                     child: Text('Code'),
//         //                   ),
//         //                   Padding(
//         //                     padding: EdgeInsets.all(8.0),
//         //                     child: Text('Name'),
//         //                   ),
//         //                   Padding(
//         //                     padding: EdgeInsets.all(8.0),
//         //                     child: Text('Units'),
//         //                   ),
//         //                   Padding(
//         //                     padding: EdgeInsets.all(8.0),
//         //                     child: Text('Qty'),
//         //                   ),
//         //                   Padding(
//         //                     padding: EdgeInsets.all(8.0),
//         //                     child: Text('Unit Price'),
//         //                   ),
//         //                   Padding(
//         //                     padding: EdgeInsets.all(8.0),
//         //                     child: Text('Total'),
//         //                   ),
//         //                   Padding(
//         //                     padding: EdgeInsets.all(8.0),
//         //                     child: Text('VAT'),
//         //                   ),
//         //                   Padding(
//         //                     padding: EdgeInsets.all(8.0),
//         //                     child: Text('Disc(%)'),
//         //                   ),
//         //                 ],
//         //               ),
//         //               // Data Rows
//         //               ...invoiceItems.map((item) {
//         //                 return TableRow(
//         //                   decoration: const BoxDecoration(
//         //                     // Remove horizontal borders for data rows
//         //                     border: Border(
//         //                       bottom: BorderSide.none,
//         //                     ),
//         //                   ),
//         //                   children: [
//         //                     Padding(
//         //                       padding: const EdgeInsets.all(8.0),
//         //                       child: Text(item['code']),
//         //                     ),
//         //                     Padding(
//         //                       padding: const EdgeInsets.all(8.0),
//         //                       child: Text(item['name']),
//         //                     ),
//         //                     Padding(
//         //                       padding: const EdgeInsets.all(8.0),
//         //                       child: Text(item['units']),
//         //                     ),
//         //                     Padding(
//         //                       padding: const EdgeInsets.all(8.0),
//         //                       child: Text(item['qty'].toString()),
//         //                     ),
//         //                     Padding(
//         //                       padding: const EdgeInsets.all(8.0),
//         //                       child: Text(item['unitPrice'].toString()),
//         //                     ),
//         //                     Padding(
//         //                       padding: const EdgeInsets.all(8.0),
//         //                       child: Text(item['total'].toString()),
//         //                     ),
//         //                     Padding(
//         //                       padding: const EdgeInsets.all(8.0),
//         //                       child: Text(item['vat'].toString()),
//         //                     ),
//         //                     Padding(
//         //                       padding: const EdgeInsets.all(8.0),
//         //                       child: Text(item['discount'].toString()),
//         //                     ),
                            
//         //                   ],

                          
//         //                 );
                        
//         //               }),
//         //             ],
//         //           ),
//         //         ),
                
//         //         // Footer Row (placed outside the table)
//         //         Container(
//         //           height: 120, // Set height for the entire footer
//         //           decoration: const BoxDecoration(
//         //             border: Border(
//         //               top: BorderSide(
//         //                   width: 1.0,
//         //                   color: Color(0xFF114F5A),
//         //                   style: BorderStyle.solid),
//         //               right: BorderSide.none,
//         //               left: BorderSide.none,
//         //             ),
//         //             borderRadius: BorderRadius.only(
//         //               bottomLeft: Radius.circular(8.0),
//         //               bottomRight: Radius.circular(8.0),
//         //             ),
//         //           ),
//         //           child: Row(
//         //             children: [
//         //               // First Column with specific width
//         //               Container(
//         //                 width: 480, // Specific width for the first column
//         //                 decoration: const BoxDecoration(
//         //                   border: Border(
//         //                     right: BorderSide(
//         //                       width: 1.0,
//         //                       color: Color(0xFF114F5A),
//         //                       style: BorderStyle.solid,
//         //                     ),
//         //                   ),
//         //                 ),
//         //                 child: const Padding(
//         //                   padding: EdgeInsets.all(8.0),
//         //                   child: Column(
//         //                     crossAxisAlignment: CrossAxisAlignment.start,
//         //                     children: [
//         //                       Text('Approved By: ......'),
//         //                       Text('Date: ......'),
//         //                       Text('Signature: ......'),
//         //                       SizedBox(height: 16),
//         //                     ],
//         //                   ),
//         //                 ),
//         //               ),
//         //               // Second and Third Columns with a shared border top
//         //               Expanded(
//         //                 child: Column(
//         //                   children: [
//         //                     // First Row for the second and third columns
//         //                     Expanded(
//         //                       child: Row(
//         //                         children: [
//         //                           // Second Column with specific width
//         //                           Container(
//         //                             width:
//         //                                 174.5, // Specific width for the second column
//         //                             decoration: const BoxDecoration(
//         //                               border: Border(
//         //                                 right: BorderSide(
//         //                                   width: 1.0,
//         //                                   color: Color(0xFF114F5A),
//         //                                   style: BorderStyle.solid,
//         //                                 ),
//         //                               ),
//         //                             ),
//         //                             child: const Padding(
//         //                               padding: EdgeInsets.all(8.0),
//         //                               child: Column(
//         //                                 crossAxisAlignment:
//         //                                     CrossAxisAlignment.start,
//         //                                 children: [
//         //                                   Text('Exclusive Vat'),
//         //                                   Text('Total Discount'),
//         //                                   Text('Total Vat'),
//         //                                 ],
//         //                               ),
//         //                             ),
//         //                           ),
//         //                           // Third Column (takes remaining space)
//         //                           Expanded(
//         //                             child: Container(
//         //                               decoration: const BoxDecoration(
//         //                                 border: Border(
//         //                                   right: BorderSide(
//         //                                     width: 1.0,
//         //                                     color: Color(0xFF114F5A),
//         //                                     style: BorderStyle.solid,
//         //                                   ),
//         //                                 ),
//         //                               ),
//         //                               child: Padding(
//         //                                 padding: const EdgeInsets.all(8.0),
//         //                                 child: Column(
//         //                                   crossAxisAlignment:
//         //                                       CrossAxisAlignment.end,
//         //                                   children: [
//         //                                     Text(
//         //                                       calculateTotal(invoiceItems)
//         //                                           .toStringAsFixed(2),
//         //                                       style: const TextStyle(
//         //                                           fontWeight: FontWeight.bold),
//         //                                     ),
//         //                                      // Add spacing
//         //                                     const Text(
//         //                                       '2,559.45', // Total Discount value
//         //                                       style: TextStyle(
//         //                                           fontWeight: FontWeight.bold),
//         //                                     ),
//         //                                      // Add spacing
//         //                                     const Text(
//         //                                       '0.00', // Total VAT value
//         //                                       style: TextStyle(
//         //                                           fontWeight: FontWeight.bold),
//         //                                     ),
//         //                                   ],
//         //                                 ),
//         //                               ),
//         //                             ),
//         //                           ),
//         //                         ],
//         //                       ),
//         //                     ),
//         //                     // Second Row for the Grand Total and sum with a border top
//         //                     Container(
//         //                       decoration: const BoxDecoration(
//         //                         border: Border(
//         //                           top: BorderSide(
//         //                             width: 1.0,
//         //                             color: Color(0xFF114F5A),
//         //                             style: BorderStyle.solid,
//         //                           ),
//         //                         ),
//         //                       ),
//         //                       child: Row(
//         //                         children: [
//         //                           // Grand Total text in the second column
//         //                           Container(
//         //                             width:
//         //                                 174.5, // Same width as the second column
//         //                             decoration: const BoxDecoration(
//         //                               border: Border(
//         //                                 right: BorderSide(
//         //                                   width: 1.0,
//         //                                   color: Color(0xFF114F5A),
//         //                                   style: BorderStyle.solid,
//         //                                 ),
//         //                               ),
//         //                             ),
//         //                             child: const Padding(
//         //                               padding: EdgeInsets.all(8.0),
//         //                               child: Text('Grand Total'),
//         //                             ),
//         //                           ),
//         //                           // Sum of Total Amount, Total Discount, and Total VAT in the third column
//         //                           Expanded(
//         //                             child: Container(
//         //                               decoration: const BoxDecoration(
//         //                                 border: Border(
//         //                                   right: BorderSide(
//         //                                     width: 1.0,
//         //                                     color: Color(0xFF114F5A),
//         //                                     style: BorderStyle.solid,
//         //                                   ),
//         //                                 ),
//         //                               ),
//         //                               child: Padding(
//         //                                 padding: const EdgeInsets.all(8.0),
//         //                                 child: Text(
//         //                                   (calculateTotal(invoiceItems) -
//         //                                           2559.45 -
//         //                                           0.00)
//         //                                       .toStringAsFixed(
//         //                                           2), // Sum calculation
//         //                                   style: const TextStyle(
//         //                                       fontWeight: FontWeight.bold),
//         //                                 ),
//         //                               ),
//         //                             ),
//         //                           ),
//         //                         ],
//         //                       ),
//         //                     ),
//         //                   ],
//         //                 ),
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // ),

//         const SizedBox(height: 8),
//         const Text('NB. This is not an Invoice'),
//       ],
//     );
//   }

//   double calculateTotal(List<Map<String, dynamic>> items) {
//     return items.fold(0.0, (sum, item) => sum + (item['total'] as double));
//   }
// }
