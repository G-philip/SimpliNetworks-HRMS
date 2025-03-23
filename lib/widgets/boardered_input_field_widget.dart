// Bordered Input Field Widget
import 'package:flutter/material.dart';

class BorderedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Color labelTextColor; // New parameter for label text color

  const BorderedInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.labelTextColor = const Color(0xFF114F5A), // Default color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: labelTextColor), // Set label text color
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero, // Rounded corners
            borderSide: BorderSide(
              color: Color(0xFF114F5A), // Default border color
              width: 1.0, // Default border width
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero, // Rounded corners
            borderSide: BorderSide(
              color: Color(0xFF114F5A), // Border color when enabled
              width: 1.0, // Border width when enabled
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero, // Rounded corners
            borderSide: BorderSide(
              color: Color(0xFF114F5A), // Border color when focused
              width: 1.0, // Border width when focused
            ),
          ),
        ),
      ),
    );
  }
}