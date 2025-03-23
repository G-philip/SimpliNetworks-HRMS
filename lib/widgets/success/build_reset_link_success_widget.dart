import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';

Widget buildResetLinkSuccess(BuildContext context, LoginState loginState) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle, // Success icon
              color: Color(0xFF114F5A),
              size: 40,
            ),
            SizedBox(width: 10), // Space between icon and text
            Text(
              'Reset link sent successfully!',
              style: TextStyle(
                fontFamily:
                    'PlayfairDisplay', // Use the font family defined in pubspec.yaml
                fontSize: 24, // Adjust the font size as needed
                // fontWeight: FontWeight.bold, // Set the font weight to bold
                color: Color(0xFF114F5A), // Set the color to match your theme
                letterSpacing: 2, // Adjust the letter spacing for separation
              ),
            ),
          ],
        ),
        const SizedBox(height: 20), // Space between text and button
        ElevatedButton(
          onPressed: () {
            // Navigate to login screen
            loginState.onResetPasswordButtonClick();
          },
          child: const Text('Reset password',
              style: TextStyle(
                fontFamily:
                    'PlayfairDisplay', // Use the font family defined in pubspec.yaml
                fontSize: 16, // Adjust the font size as needed
                // fontWeight: FontWeight.bold, // Set the font weight to bold
                color: Color(0xFF114F5A),
                letterSpacing: 2, // Adjust the letter spacing for separation
              )),
        ),
      ],
    ),
  );
}
