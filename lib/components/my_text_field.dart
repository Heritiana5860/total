import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final double vertical;
  final double horizontal;
  final TextEditingController? controller;
  final IconData? icon;
  final Widget? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final void Function()? onPressed;

  const MyTextField({
    super.key,
    this.vertical = 0,
    this.horizontal = 0,
    this.controller,
    this.icon,
    this.label,
    this.hintText,
    this.keyboardType,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical,
        horizontal: horizontal,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
          ),
          label: label,
          hintText: hintText,
        ),
      ),
    );
  }
}
