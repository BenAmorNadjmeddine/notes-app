import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  const FAB({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(text),
      icon: Icon(icon),
    );
  }
}
