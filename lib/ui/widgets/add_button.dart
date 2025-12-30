import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String label;
  final void Function() onTap;

  const AddButton(
    this.label, {
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,

      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[800],
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          const Icon(
            Icons.add,
            color: Colors.white,
            size: 18,
          ),

          const SizedBox(width: 6),

          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
