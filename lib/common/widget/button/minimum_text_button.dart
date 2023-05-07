import 'package:flutter/material.dart';

class MinimumTextButton extends StatelessWidget {
  const MinimumTextButton({
    Key? key,
    required this.text,
    this.textStyle = const TextStyle(
      decoration: TextDecoration.underline,
    ),
    required this.onTap,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: textStyle),
    );
  }
}
