import 'package:flutter/material.dart';

const smallTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15,
  color: Color(0xFF114F5A),
  letterSpacing: 2,
);

// Your existing function (unchanged)
Text textStyleSmall(String text) {
  return Text(
    text,
    style: smallTextStyle,
  );
}



// Text textStyleSmall(String text) {
//   return Text(
//     text,
//     style: const TextStyle(
//       fontFamily: 'Montserrat', // Set the desired font family
//       fontSize: 15, // Set the desired font size
//       color: Color(0xFF114F5A), 
//       letterSpacing: 2,
//       // fontWeight: FontWeight.bold,// Set the desired text color
//     ),
//   );
// }

Text textStyleSmallWhite(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Montserrat', // Set the desired font family
      fontSize: 15, // Set the desired font size
      color: Color(0xFFF8F8F8), 
      letterSpacing: 2,
      // fontWeight: FontWeight.bold,// Set the desired text color
    ),
  );
}