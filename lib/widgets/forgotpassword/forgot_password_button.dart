import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';

Widget buildForgotPasswordButton(BuildContext context, LoginState loginState) {
  return TextButton(
    onPressed: () {
      loginState.toggleForgotPasswordVisibility();
    },
    child: const Text(
      'Forgot Password?', 
      style: TextStyle(
        fontFamily: 'PlayfairDisplay', // Use the font family defined in pubspec.yaml
        fontSize: 16, // Adjust the font size as needed
        // fontWeight: FontWeight.bold, // Set the font weight to bold
        color: Color(0xFF114F5A),
        letterSpacing: 2, // Adjust the letter spacing for separation
        )),
  );
}

