// FocusNodeProvider to manage FocusNode state
import 'package:flutter/material.dart';

class FocusNodeProvider with ChangeNotifier {
  final FocusNode _focusNode = FocusNode();

  FocusNode get focusNode => _focusNode;

  FocusNodeProvider() {
    _focusNode.addListener(() {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}