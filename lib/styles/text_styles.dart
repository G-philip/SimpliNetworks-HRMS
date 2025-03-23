import 'package:flutter/material.dart';

class AppTextStyles {
  static const String fontFamily = 'Montserrat';

  static TextStyle bodyText1 = const TextStyle(
    fontFamily: 'Montserrat', // Use the font family defined in pubspec.yaml
    fontSize: 36, // Adjust the font size as needed
    // fontWeight: FontWeight.bold, // Set the font weight to bold
    color: Color(0xFF114F5A), // Set the color to match your theme
    letterSpacing: 4, // Adjust the letter spacing for separation
  );

  static TextStyle bodyText2 = const TextStyle(
    fontFamily: 'Montserrat', // Use the same font family for consistency
    fontSize: 24, // Adjust the font size as needed
    // fontWeight: FontWeight.bold, // Set the font weight to bold
    color: Color(0xFF114F5A), // Set the color to match your theme
    letterSpacing: 4, // Adjust the letter spacing for separation
  );

  static TextStyle headline1 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF114F5A),
  );

  static TextStyle headline2 = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    // fontWeight: FontWeight.bold,
    color: Color(0xFFF8F8F8),
    letterSpacing: 2.0,
  );

  // Add more styles as needed
}
