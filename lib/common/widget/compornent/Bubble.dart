import 'package:flutter/material.dart';
import 'package:spimo/common/widget/color/color.dart';

class Bubble extends StatelessWidget {
  const Bubble({Key? key, required this.text, required this.textStyle})
      : super(key: key);

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 32, top: 8, right: 32, bottom: 8),
      // ここにconstつけるとhot reloadで変わらない
      decoration: const ShapeDecoration(
        color: alertColor,
        shadows: [
          BoxShadow(
            color: Color(0x80000000),
            offset: Offset(0, 2),
            blurRadius: 2,
          )
        ],
        shape: BubbleBorder(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

class BubbleBorder extends ShapeBorder {
  final bool usePadding;

  const BubbleBorder({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      // xは少なくなると左、多くなると右
      // yは少なくなると上に移動する
      ..moveTo(rect.bottomCenter.dx + 58, rect.bottomCenter.dy)
      ..relativeLineTo(45, 16)
      ..relativeLineTo(6, -16)
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)))
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
