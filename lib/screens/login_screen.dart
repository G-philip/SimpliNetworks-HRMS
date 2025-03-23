import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpli/services/login_state.dart';
import 'package:simpli/widgets/login/login_container_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final FocusNode firstOtpFocusNode = FocusNode();
  final List<FocusNode> otpFocusNodes =
      List.generate(4, (index) => FocusNode());
//   

  @override
  void initState() {
    super.initState();
    _initializeFocusNodes();
  }

  void _initializeFocusNodes() {
    for (var focusNode in otpFocusNodes) {
      focusNode.addListener(() {
        if (mounted) {
          setState(() {}); // Trigger a rebuild to update hint text
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _requestFocusForOtp();
  }

  void _requestFocusForOtp() {
    if (Provider.of<LoginState>(context).isOtpVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          FocusScope.of(context).requestFocus(firstOtpFocusNode);
        }
      });
    }
  }

  @override
  void dispose() {
    _disposeFocusNodes();
    super.dispose();
  }

  void _disposeFocusNodes() {
    for (var focusNode in otpFocusNodes) {
      focusNode.removeListener(() {});
      focusNode.dispose();
    }
    firstOtpFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtain the login state from the provider or state management solution
    final loginState = Provider.of<LoginState>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF114F5A),
      body: Center(
        child: buildLoginContainer(
            loginState, // 1. LoginState
            context, // 2. BuildContext
            firstOtpFocusNode, // 3. First OTP Focus Node
            otpFocusNodes // 4. List of OTP Focus Nodes
            ),
      ),
    );
  }
}

