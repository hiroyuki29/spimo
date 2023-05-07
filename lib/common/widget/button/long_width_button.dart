import 'package:flutter/material.dart';

class LongWidthButton extends StatelessWidget {
  const LongWidthButton({
    super.key,
    required this.title,
    required this.onTap,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  });

  final String title;
  final VoidCallback? onTap;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
