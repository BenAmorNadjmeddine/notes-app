import 'package:flutter/material.dart';
import 'package:notes_app/Shared/Cubit/cubit.dart';
import 'package:notes_app/Shared/Style/colors.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    Key? key,
    required this.onTap,
    required this.colorIndex,
  }) : super(key: key);

  final VoidCallback onTap;
  final int colorIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppCubit.get(context).currentColorIndex == colorIndex ? 100.0 : 45.0,
        decoration: BoxDecoration(
          color: noteColors[colorIndex],
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
