import 'package:flutter/material.dart';
import 'package:simpli/screens/home_screen.dart';

class LayoutState extends ChangeNotifier {
  bool _isNavbarVisible = true;
  bool _isSidebarVisible = true;
  Widget _currentScreen = const HomeScreen(); // Default screen

  bool get isNavbarVisible => _isNavbarVisible;
  bool get isSidebarVisible => _isSidebarVisible;
  Widget get currentScreen => _currentScreen; // Getter for current screen

  void toggleNavbar() {
    _isNavbarVisible = !_isNavbarVisible;
    notifyListeners();
  }

  void toggleSidebar() {
    _isSidebarVisible = !_isSidebarVisible;
    notifyListeners();
  }

  void setCurrentScreen(Widget screen) {
    _currentScreen = screen; // Set the current screen
    notifyListeners(); // Notify listeners to rebuild
  }
}