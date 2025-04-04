import 'package:flutter/material.dart';

Text textStyleHeadingWhite(String text) {
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