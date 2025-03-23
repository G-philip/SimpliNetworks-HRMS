// // Build the search and filter row
//   import 'package:flutter/material.dart';

// Widget _buildSearchAndFilter() {
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
// }