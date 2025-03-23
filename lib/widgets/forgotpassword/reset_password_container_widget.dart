// Updated Forgot Password Container
import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';
import 'package:simpli/widgets/boardered_input_field_widget.dart';

Widget buildResetPasswordContainer(
    BuildContext context, LoginState loginState) {
  return Column(
    children: [
      // Password Input Field
      BorderedInputField(
        controller: loginState.passwordController,
        labelText: 'New Password',
        obscureText: true, // To hide the password input
      ),
      const SizedBox(height: 10),
      // Reset Password Input Field
      BorderedInputField(
        controller: loginState.passwordController,
        labelText: 'Confirm Password',
        obscureText: true, // To hide the password input
      ),
      const SizedBox(height: 10),
      // Submit Button
      ElevatedButton(
        onPressed: () {
          // Handle submit action for resetting password
          loginState.resetPassword(); // Example method to reset password
          loginState.togglePasswordReset();
        },
        child: const Text('Reset',
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
  );
}
