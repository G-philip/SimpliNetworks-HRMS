import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';
import 'package:simpli/widgets/forgotpassword/forgot_password_container_widget.dart';
import 'package:simpli/widgets/forgotpassword/reset_password_container_widget.dart';
import 'package:simpli/widgets/layout/logo_widget.dart';
import 'package:simpli/widgets/login/didnt_receive_text_button.dart';
import 'package:simpli/widgets/login/login_form_fields_widget.dart';
import 'package:simpli/widgets/success/build_reset_link_success_widget.dart';
import 'package:simpli/widgets/success/buildreset_password_success_widget.dart';

Widget buildLoginContainer(LoginState loginState, BuildContext context,
    firstOtpFocusNode, otpFocusNodes) {
  return Container(
    width: 500,
    height: 400,
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Color(0xFFF8F8F8),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Conditionally display the LogoWidget
          if (loginState.isEmailPasswordVisible)
            const LogoWidget(), // Show LogoWidget if either container is visible

          // Email/Password Fields
          if (loginState.isForgotPasswordVisible)
            const Text(
              'Request Password Reset',
              style: TextStyle(
                fontFamily:
                    'PlayfairDisplay', // Use the font family defined in pubspec.yaml
                fontSize: 24, // Adjust the font size as needed
                // fontWeight: FontWeight.bold, // Set the font weight to bold
                color: Color(0xFF114F5A), // Set the color to match your theme
                letterSpacing: 2, // Adjust the letter spacing for separation
              ),
            ),

          // Reset Password Success Message
          if (loginState.isResetPasswordVisible)
            const Text(
              'Password Reset',
              style: TextStyle(
                fontFamily:
                    'PlayfairDisplay', // Use the font family defined in pubspec.yaml
                fontSize: 24, // Adjust the font size as needed
                // fontWeight: FontWeight.bold, // Set the font weight to bold
                color:
                    Color(0xFF114F5A), // Set the color to match your theme
                letterSpacing:
                    2, // Adjust the letter spacing for separation
              ),
            ),

          // OTP Success Message
          if (loginState.isOtpVisible)
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ONE TIME PIN',
                  style: TextStyle(
                    fontFamily:
                        'PlayfairDisplay', // Use the font family defined in pubspec.yaml
                    fontSize: 24, // Adjust the font size as needed
                    // fontWeight: FontWeight.bold, // Set the font weight to bold
                    color:
                        Color(0xFF114F5A), // Set the color to match your theme
                    letterSpacing:
                        2, // Adjust the letter spacing for separation
                  ),
                ), // Display countdown
              ],
            ),

          // const LogoWidget(),
          const SizedBox(height: 10),
          if (loginState.isEmailPasswordVisible)
            buildLoginFormFields(loginState, context, firstOtpFocusNode),
          if (loginState.isOtpVisible)
            buildOtpFields(
                loginState, context, firstOtpFocusNode, otpFocusNodes),

          // **Forgot Password Container**
          if (loginState.isForgotPasswordVisible) ...[
            buildForgotPasswordContainer(context, loginState),
          ],

          // **Reset Password Container**
          if (loginState.isResetPasswordVisible) ...[
            buildResetPasswordContainer(context, loginState),
          ],

          // **Reset Link Success Container**
          if (loginState.isResetLinkSuccessVisible) ...[
            buildResetLinkSuccess(context, loginState),
          ],

          // **Reset Password Success Container**
          if (loginState.isResetPasswordSuccessVisible) ...[
            buildResetPasswordSuccess(context, loginState),
          ],
        ],
      ),
    ),
  );
}
