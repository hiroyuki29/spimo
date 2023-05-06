import 'package:flutter/material.dart';
import 'package:spimo/common/widget/color/color.dart';

ScaffoldFeatureController customSnackBar(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: alertColor,
  ));
}
