import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final double vertical;
  final double horizontal;
  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const MyText({
    super.key,
    this.vertical = 0.0,
    this.horizontal = 0.0,
    required this.text,
    this.textAlign,
    this.overflow,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical,
        horizontal: horizontal,
      ),
      child: Text(
        text,
        textAlign: textAlign,
        overflow: overflow,
        selectionColor: Colors.blue[300],
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
