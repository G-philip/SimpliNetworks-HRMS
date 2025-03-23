import 'package:flutter/material.dart';

class LoginState with ChangeNotifier {
    List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());

  bool _isOtpVisible = false;
  bool isEmailPasswordVisible = true; // Initially show email/password
  bool isForgotPasswordVisible = false; // Initially hide forgot password
  bool isResetPasswordVisible = false; // Initially hide reset password
  bool isResetLinkSuccessVisible = false; // Initially hide reset password success message
  bool isResetPasswordSuccessVisible = false; // Initially hide reset password success message

  // Initialize TextEditingControllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController otpController = TextEditingController();
   // Assuming you have a TextEditingController for the last OTP input
final TextEditingController lastOtpController = TextEditingController();


  bool get isOtpVisible => _isOtpVisible;

  // get otpControllers => null;

  // Public setter for _isOtpVisible
  set isOtpVisible(bool value) {
    _isOtpVisible = value;
    notifyListeners(); // Notify listeners to rebuild UI
  }

  void login() {
    isOtpVisible = true; // Show OTP field after login
  }

  void toggleForgotPasswordVisibility() {
    isEmailPasswordVisible = false; // Hide email/password fields
    isForgotPasswordVisible = !isForgotPasswordVisible; // Toggle forgot password visibility
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Method to show reset password container
  void showResetPasswordContainer() {
    isForgotPasswordVisible = false; // Hide forgot password container
    isResetLinkSuccessVisible = true; // Show reset password container
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void onResetPasswordButtonClick() {
    isResetLinkSuccessVisible = false; // Hide reset link success message
    isResetPasswordVisible = true; // Show email/password fields
    notifyListeners(); // Notify listeners to rebuild the UI
}

void onLoginButtonClick() {
    isResetPasswordSuccessVisible = false; // Hide reset password success message
    isEmailPasswordVisible = true; // Show email/password fields
    notifyListeners(); // Notify listeners to rebuild the UI
}
  

void clearOtpFields(LoginState loginState, FocusNode firstOtpFocusNode) {
  // Clear all OTP controllers
  for (var controller in loginState.otpControllers) {
    controller.clear();
  }
  
  // Reset focus to the first OTP input field
  firstOtpFocusNode.requestFocus();
}

// Function to handle the proceed action
void handleProceed(LoginState loginState, BuildContext context, FocusNode firstOtpFocusNode) {
  loginState.proceedWithOtp();
  clearOtpFields(loginState, firstOtpFocusNode);
  Navigator.pushReplacementNamed(context, '/home');
}

  void togglePasswordReset() {
        // If currently hidden, show the reset password container
        isResetPasswordVisible = false;
        isResetPasswordSuccessVisible = true; // Hide success message
    notifyListeners(); // Notify listeners to rebuild the UI
}


  void sendResetLink() {
    // Implement logic to send reset link
  }

  void resetPassword() {
    // Implement logic to reset password
  }

  void logout() {
    isEmailPasswordVisible = true; // Show email/password fields again
    isOtpVisible = false; // Hide OTP fields
    emailController.clear(); // Clear email field
    passwordController.clear(); // Clear password field
    otpController.clear(); // Clear OTP field
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void proceedWithOtp() {
    // Logic for OTP verification can be added here
    // For now, we can just reset the state
    isOtpVisible = false; // Reset visibility if needed
  }

  @override
  void dispose() {
    // Dispose of the controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    otpController.dispose();
    super.dispose();
  }
}