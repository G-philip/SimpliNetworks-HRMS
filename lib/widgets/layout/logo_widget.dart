import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min, // Use minimum size for the column
      children: [
        Text(
          'SimpliNetworks',
          style: TextStyle(
            fontFamily: 'Montserrat', // Use the font family defined in pubspec.yaml
            fontSize: 36, // Adjust the font size as needed
            // fontWeight: FontWeight.bold, // Set the font weight to bold
            color: Color(0xFF114F5A), // Set the color to match your theme
            letterSpacing: 4, // Adjust the letter spacing for separation
          ),
        ),
        SizedBox(height: 4), // Add some space between the texts
        Text(
          'HRMS',
          style: TextStyle(
            fontFamily: 'Montserrat', // Use the same font family for consistency
            fontSize: 24, // Adjust the font size as needed
            // fontWeight: FontWeight.bold, // Set the font weight to bold
            color: Color(0xFF114F5A), // Set the color to match your theme
            letterSpacing: 4, // Adjust the letter spacing for separation
          ),
        ),
      ],
    );
  }
}