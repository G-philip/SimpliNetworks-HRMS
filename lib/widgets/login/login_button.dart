import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';
Widget buildLoginButton(
    LoginState loginState, BuildContext context, firstOtpFocusNode) {
  return ElevatedButton(
    onPressed: () {
      loginState.login();
      loginState.isEmailPasswordVisible = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(firstOtpFocusNode);
      });
    },
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min, // Set to min to fit the button size
      children: [
        Icon(
          Icons.login, // Use the login icon
          color: Color(0xFF114F5A), // Match the icon color with your theme
        ),
        SizedBox(width: 12.0),
        Text(
          'Login',
          style: TextStyle(
            fontFamily:
                'PlayfairDisplay', // Use the font family defined in pubspec.yaml
            fontSize: 18, // Adjust the font size as needed
            // fontWeight: FontWeight.bold, // Set the font weight to bold
            color: Color(0xFF114F5A), // Set the color to match your theme
            letterSpacing: 2, // Adjust the letter spacing for separation
          ),
        ),
      ],
    ),
  );
}
