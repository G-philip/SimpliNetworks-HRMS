import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpli/services/layout_state.dart';
import 'package:simpli/widgets/layout/navbar_widget.dart';
import 'package:simpli/widgets/layout/sidebar_widget.dart';

class Layout extends StatefulWidget {
  final Widget child;

  const Layout({super.key, required this.child});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LayoutState(), // Provide LayoutState
      child: Consumer<LayoutState>(
        builder: (context, layoutState, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: Row(
              children: [
                if (layoutState.isSidebarVisible) const Sidebar(), // Sidebar conditionally rendered
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      bool isLargeScreen = constraints.maxWidth > 800;

                      return Column(
                        children: [
                          if (isLargeScreen && layoutState.isNavbarVisible) const Navbar(), // Navbar conditionally rendered
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50.0, top: 50.0, right: 60.0),
                                
                                child: layoutState.currentScreen,
                              ), // Use currentScreen from LayoutState
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


