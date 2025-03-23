import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';
import 'package:simpli/widgets/login/otp_input_fields_widget.dart';
import 'package:simpli/widgets/login/proceed_button_widget.dart';

Widget buildOtpFields(LoginState loginState, BuildContext context,
    FocusNode firstOtpFocusNode, List<FocusNode> otpFocusNodes) {
  return Column(
    children: [
      const SizedBox(height: 20),
      buildOtpInputFields(
          loginState, context, firstOtpFocusNode, otpFocusNodes),
      const SizedBox(height: 20),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Didn\'t receive OTP? '),
          TextButton(
            onPressed: () {
              // Handle resend OTP action here
              // loginState.resendOtp();
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.refresh, // Use a refresh icon for resend action
                  color: Color(0xFF114F5A),
                  size: 16, // Adjust size as needed
                ),
                SizedBox(width: 4), // Add some space between the icon and text
                Text(
                  'Resend',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 16,
                    color: Color(0xFF114F5A),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      buildProceedButton(loginState, context, firstOtpFocusNode),
    ],
  );
}
