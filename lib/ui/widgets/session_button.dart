import 'package:flutter/material.dart';

class SessionButton extends StatelessWidget {
  const SessionButton(
    this.label, {
    super.key,
    required this.onTap,
    this.tooltipMessage,
  });

  final String label;
  final VoidCallback onTap;
  final String? tooltipMessage;

  @override
  Widget build(BuildContext context) {
    Widget button = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Color(0xFF204366), width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF204366),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (tooltipMessage != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    // Only wrap with Tooltip if message is provided
    if (tooltipMessage != null) {
      return Tooltip(
        message: tooltipMessage!,
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: button,
      );
    }

    return button;
  }
}
