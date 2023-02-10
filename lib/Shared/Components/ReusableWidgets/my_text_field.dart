import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.style,
    required this.hintStyle,
  });

  final TextEditingController controller;
  final String hintText;
  final TextStyle style, hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      controller: controller,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      style: style,
      decoration: InputDecoration.collapsed(
        hintText: hintText,
        hintStyle: hintStyle,
      ),
    );
  }
}
