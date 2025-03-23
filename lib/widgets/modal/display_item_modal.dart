import 'package:flutter/material.dart';

class DisplayItemModal extends StatelessWidget {
  final Widget child;

  const DisplayItemModal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    
    return Material(
      elevation: 30, // Add elevation for shadow
      borderRadius: BorderRadius.circular(15), // Change border radius
      color: Colors.transparent, // Make the Material widget transparent
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9, // A4 size height
        width: MediaQuery.of(context).size.width * 0.65, // 80% of screen width
        padding: const EdgeInsets.only(top: 70.0, left: 40, right: 70),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.zero
          borderRadius: BorderRadius.circular(1), // Change border radius
        ),
        
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}

void showCustomModal(BuildContext context, {required Widget child, double top = 50, double left = 50}) {
  // Create an OverlayEntry with the DisplayItemModal as its content
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: top,
      left: left,
      child: Material(
        color: Colors.transparent, // Transparent background for the overlay
        child: DisplayItemModal(
          child: child,
        ),
      ),
    ),
  );

  // Insert the overlay into the Overlay
  Overlay.of(context).insert(overlayEntry);
}

