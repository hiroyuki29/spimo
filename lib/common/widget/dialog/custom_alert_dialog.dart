import 'package:flutter/cupertino.dart';
import 'package:spimo/common_widget/color/color.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    this.content,
    required this.leftText,
    required this.rightText,
    required this.onTapLeft,
    required this.onTapRight,
  }) : super(key: key);

  final String title;
  final String? content;
  final String leftText;
  final String rightText;
  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: content != null ? Text(content!) : null,
      actions: [
        CupertinoDialogAction(
          onPressed: onTapLeft,
          child: Text(
            leftText,
            style: const TextStyle(
              color: alertColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: onTapRight,
          child: Text(rightText),
        ),
      ],
    );
  }
}
