import 'package:flutter/material.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final BlaButtonType type;
  final IconData? icon;

  const BlaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = BlaButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = type == BlaButtonType.primary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.blue : Colors.grey.shade300,
        foregroundColor: isPrimary ? Colors.white : Colors.black,
        minimumSize: const Size(double.infinity, 48),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[Icon(icon), const SizedBox(width: 8)],
          Text(label),
        ],
      ),
    );
  }
}
