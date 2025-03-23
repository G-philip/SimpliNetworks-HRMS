import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpli/services/modal_position_provider.dart';

class ReusableModal extends StatefulWidget {
  final Widget formWidget; // Accepts any form widget

  const ReusableModal({
    super.key,
    required this.formWidget,
  });

  @override
  State<ReusableModal> createState() => _AddNewInvoiceModalState();
}

class _AddNewInvoiceModalState extends State<ReusableModal> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PositionProvider>(
      builder: (context, positionProvider, child) {
        return Stack(
          children: [
            Positioned(
              left: positionProvider.position.dx,
              top: positionProvider.position.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  positionProvider.updatePosition(details.delta);
                },
                child: Dialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  elevation: 10,
                  child: Container(
                    width: 600,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.zero,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        widget.formWidget, // Render the passed form widget
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


