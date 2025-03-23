import 'package:flutter/material.dart';
import 'package:simpli/services/login_state.dart';
import 'package:simpli/widgets/boardered_input_field_widget.dart';
import 'package:simpli/widgets/forgotpassword/forgot_password_button.dart';
import 'package:simpli/widgets/login/login_button.dart';

Widget buildLoginFormFields(LoginState loginState, BuildContext context, firstOtpFocusNode) {
    return Column(
      children: [
        BorderedInputField(
          controller: loginState.emailController,
          labelText: 'Email',
        ),
        const SizedBox(height: 10),
        BorderedInputField(
          controller: loginState.passwordController,
          labelText: 'Password',
          
          obscureText: true,
        ),
        const SizedBox(height: 20),
        buildLoginButton(loginState, context, firstOtpFocusNode),
        const SizedBox(height: 20),
        buildForgotPasswordButton(context, loginState),
      ],
    );
  }
