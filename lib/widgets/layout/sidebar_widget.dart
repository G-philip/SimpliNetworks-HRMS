import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpli/screens/dashboard_screen.dart';
import 'package:simpli/screens/home_screen.dart';
import 'package:simpli/screens/invoice/invoice_screen.dart';
import 'package:simpli/services/layout_state.dart';
import 'package:simpli/services/login_state.dart';
import 'package:simpli/styles/header_text_18.dart';
import 'package:simpli/widgets/text_style_small.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sidebarWidth = screenWidth > 800 ? 260 : 80;

    return Container(
      width: sidebarWidth,
      decoration: const BoxDecoration(
        color: Color(0xFF114F5A),
        border: Border(
          right: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: screenWidth > 800
                  ? const Border(
                      bottom: BorderSide(
                        color: Color(0xFFF8F8F8),
                        width: 2.0,
                      ),
                    )
                  : null,
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16.0),
            child: screenWidth > 800
                ?  headerText18white(
                    'HRMS APP'
                  )
                : Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu,
                            color: Color(0xFFF8F8F8), size: 30),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ],
                  ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 8.0),
              children: [
                ListTile(
                  leading:
                      const Icon(Icons.dashboard, color: Color(0xFFF8F8F8)),
                  title: screenWidth > 800
                      ?  textStyleSmallWhite('Dashboard')
                      : null,
                  onTap: () {
                    // Change the current screen to DashboardScreen
                    Provider.of<LayoutState>(context, listen: false)
                        .setCurrentScreen(const DashboardScreen());
                  },
                  selectedTileColor: const Color(0xFFF8F8F8),
                  selected: true,
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: screenWidth > 800
                      ?  textStyleSmallWhite('Home')
                      : null,
                  onTap: () {
                    // Change the current screen to DashboardScreen
                    Provider.of<LayoutState>(context, listen: false)
                        .setCurrentScreen(const HomeScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.people, color: Colors.white),
                  title: screenWidth > 800
                      ?  textStyleSmallWhite('HR Management')
                      : null,
                      onTap: () {
                    // Change the current screen to DashboardScreen
                    // Provider.of<LayoutState>(context, listen: false)
                        // .setCurrentScreen(HrScreenState());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.receipt,
                      color: Color(0xFFF8F8F8)), // Invoice Icon
                  title: screenWidth > 800
                      ?  textStyleSmallWhite('Invoices')
                      : null,
                  onTap: () {
                    // Change the current screen to DashboardScreen
                    Provider.of<LayoutState>(context, listen: false)
                        .setCurrentScreen(const InvoiceScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on,
                      color: Color(0xFFF8F8F8)), // Payroll Icon
                  title: screenWidth > 800
                      ?  textStyleSmallWhite('Payroll')
                      : null,
                ),
                ListTile(
                  leading: const Icon(Icons.warning,
                      color: Color(0xFFF8F8F8)), // Emergency Icon
                  title: screenWidth > 800
                      ?  textStyleSmallWhite('Emergency')
                      : null,
                ),
                ListTile(
                  leading: const Icon(Icons.help,
                      color: Color(0xFFF8F8F8)), // Help Icon
                  title: screenWidth > 800
                      ?  textStyleSmallWhite('Help')
                      : null,
                ),
              ],
            ),
          ),
          if (screenWidth <= 800)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.logout, color: Color(0xFFF8F8F8)),
                onPressed: () {
                  Provider.of<LoginState>(context, listen: false).logout();
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ),
        ],
      ),
    );
  }
}

