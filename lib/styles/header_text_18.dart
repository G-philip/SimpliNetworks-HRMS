import 'package:flutter/material.dart';

Text headerText18(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Montserrat', // Set the desired font family
      fontSize: 18, // Set the desired font size
      color: Color(0xFF114F5A), // Set the desired text color
    ),
  );
}

Text headerText18white(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Montserrat', // Set the desired font family
      fontSize: 24,
      letterSpacing: 2.0, // Set the desired font size
      color: Color(0xFFF8F8F8), // Set the desired text color
    ),
  );
}

Text headerText24(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Montserrat', // Set the desired font family
      fontSize: 24, // Set the desired font size
      color: Color(0xFF114F5A), // Set the desired text color
      letterSpacing: 4.0,
    ),
  );
}