import 'package:flutter/material.dart';

class SessionButton extends StatelessWidget {
  const SessionButton(
    this.label, {
    super.key,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.cyan, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}