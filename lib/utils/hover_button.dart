import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color clickEffectColor; // New property for click effect color
  // final Widget Function() formBuilder; // Callback to build the form
  

  const HoverButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.clickEffectColor = Colors.teal,
    // required this.formBuilder, required Widget formWidget, // Default click effect color
  });

  @override
  HoverButtonState createState() => HoverButtonState();
}

class HoverButtonState extends State<HoverButton> {
  bool isHovered = false; // State variable to track hover status

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: const Color(0xFFFFFFFF), // Default background color
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return const Color(
                    0xFF114F5A); // Change background color on hover
              }
              if (states.contains(WidgetState.pressed)) {
                return widget
                    .clickEffectColor; // Use click effect color when pressed
              }
              return null; // Use the default color if not hovered or pressed
            },
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 17,
                color: isHovered
                    ? Colors.white
                    : const Color(0xFF114F5A), // Change text color on hover
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 12.0),
            Icon(
              widget.icon,
              color: isHovered
                  ? Colors.white
                  : const Color(0xFF114F5A), // Change icon color on hover
            ),
          ],
        ),
      ),
    );
  }
}
