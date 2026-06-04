import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isDestructive
        ? Theme.of(context).colorScheme.error
        : null;

    if (icon != null) {
      return FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: FilledButton.styleFrom(foregroundColor: foregroundColor),
      );
    }

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(foregroundColor: foregroundColor),
      child: Text(label),
    );
  }
}
