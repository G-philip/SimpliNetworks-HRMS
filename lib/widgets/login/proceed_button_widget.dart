import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';

Widget buildProceedButton(LoginState loginState, BuildContext context, firstOtpFocusNode) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
          // loginState.proceedWithOtp();
          // loginState.clearOtpFields(loginState, firstOtpFocusNode);
          // Navigator.pushReplacementNamed(context, '/home');
        },
        // ignore: prefer_const_constructors
        child: Row(
          mainAxisSize: MainAxisSize.min, // Set to min to fit the button size
          children: const [
            Icon(
              Icons.arrow_forward, // Use an arrow icon for proceed action
              color: Color(0xFF114F5A), // Set the icon color to white or match your theme
            ),
            SizedBox(width: 8),
            Text('Proceed',
                style: TextStyle(
                  fontFamily:
                      'PlayfairDisplay', // Use the font family defined in pubspec.yaml
                  fontSize: 16, // Adjust the font size as needed
                  // fontWeight: FontWeight.bold, // Set the font weight to bold
                  color: Color(0xFF114F5A),
                  letterSpacing: 2, // Adjust the letter spacing for separation
                )),
          ],
        ),
      ),
    ],
  );
}
