import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';

Widget buildOtpInputFields(LoginState loginState, BuildContext context,
    firstOtpFocusNode, otpFocusNodes) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(4, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: 60,
          child: TextField(
            focusNode: index == 0 ? firstOtpFocusNode : otpFocusNodes[index],
            controller: loginState.otpControllers[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            textAlign: TextAlign.center,
            showCursor: true,
            autofocus: index == 0,
            decoration: InputDecoration(
              counterText: '',
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF114F5A),
                  width: 2.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF114F5A),
                  width: 2.0,
                ),
              ),
              hintText: (index == 0)
                  ? ''
                  : (otpFocusNodes[index].hasFocus)
                      ? ''
                      : '0', 
            ),
            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              // Trigger the proceed action when the last input (index 3) has a value
              if (index == 3 && value.isNotEmpty) {
                loginState.handleProceed(loginState, context, firstOtpFocusNode);
              }
            },
          ),
        ),
      );
    }),
  );
}
