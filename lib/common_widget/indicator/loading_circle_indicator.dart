import 'package:flutter/material.dart';
import 'package:spimo/common_widget/color/color.dart';

class LoadingCircleIndicator extends StatelessWidget {
  const LoadingCircleIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: primary.withOpacity(0.3),
      ),
    );
  }
}
