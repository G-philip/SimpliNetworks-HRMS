import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final Widget formWidget; // Accepts any form widget

  const FormContainer({
    super.key,
    required this.formWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Optional: Customize border radius
      ),
      elevation: 10,
      child: Container(
        width: 600, // Set a fixed width or make it responsive
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), // Match the Dialog's border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensure the column takes only the required space
          children: [
            const SizedBox(height: 10), // Optional: Add spacing
            formWidget, // Render the passed form widget
          ],
        ),
      ),
    );
  }
}