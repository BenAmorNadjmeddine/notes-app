import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.onTap,
    required this.itemColor,
    required this.iconBoxColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
    required this.text,
  });

  final VoidCallback onTap;
  final Color itemColor, iconBoxColor, iconColor, textColor;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: itemColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: iconBoxColor,
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(text, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor)),
    );
  }
}
