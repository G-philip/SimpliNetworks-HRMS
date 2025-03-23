// Forgot Password Container
import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';
import 'package:simpli/widgets/boardered_input_field_widget.dart';

Widget buildForgotPasswordContainer(
    BuildContext context, LoginState loginState) {
  return Column(
    children: [
      // Email Input Field
      BorderedInputField(
        controller: loginState.emailController,
        labelText: 'Email',
      ),
      const SizedBox(height: 10),
      // Submit Button
      ElevatedButton(
        onPressed: () {
          // Handle submit action for forgot password
          loginState.sendResetLink(); // Example method to send reset link
          loginState.showResetPasswordContainer();
        },
        child: const Text('Submit',
            style: TextStyle(
              fontFamily:
                  'PlayfairDisplay', // Use the font family defined in pubspec.yaml
              fontSize: 16, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Set the font weight to bold
              color: Color(0xFF114F5A),
              letterSpacing: 2, // Adjust the letter spacing for separation
            )),
      ),
    ],
  );
}
