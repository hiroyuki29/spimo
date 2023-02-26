import 'package:flutter/material.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';

class NoDataDisplayWidget extends StatelessWidget {
  const NoDataDisplayWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.iconSize = 160,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final double iconSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          children: [
            sizedBoxH32,
            SizedBox(
              height: iconSize,
              child: icon,
            ),
            sizedBoxH8,
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
