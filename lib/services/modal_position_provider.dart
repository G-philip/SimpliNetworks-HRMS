import 'package:flutter/material.dart';

class PositionProvider with ChangeNotifier {
  Offset _position = const Offset(350, 70); // Initial position

  Offset get position => _position;

  void updatePosition(Offset delta) {
    _position += delta;
    notifyListeners(); // Notify listeners to rebuild
  }
}