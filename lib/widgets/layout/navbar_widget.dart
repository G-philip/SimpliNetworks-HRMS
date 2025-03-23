import 'package:flutter/material.dart';
// import 'package:hrms_app/services/layout_state.dart'; // Import LayoutState
import 'package:provider/provider.dart';
import 'package:simpli/services/login_state.dart';
import 'package:simpli/styles/header_text_18.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.0),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           headerText24(
            'SimpliNetworks'
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF114F5A)),
            onPressed: () {
              Provider.of<LoginState>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      );
    }
}