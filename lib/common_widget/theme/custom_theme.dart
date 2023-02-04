import 'package:flutter/material.dart';
import 'package:spimo/common_widget/color/color.dart';

final spimoTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    color: white,
    surfaceTintColor: white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    surfaceTintColor: white,
    textStyle: const TextStyle(
        fontSize: 14, color: primaryDark, fontWeight: FontWeight.normal),
  )),
  scaffoldBackgroundColor: backgroundGray,
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: primaryDarkSwatch,
    accentColor: accentSwatch,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 20, color: primaryDark, fontWeight: FontWeight.bold),
    subtitle1: TextStyle(
        fontSize: 18, color: primaryDark, fontWeight: FontWeight.bold),
    subtitle2: TextStyle(
        fontSize: 16, color: primaryDark, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(
        fontSize: 14, color: primaryDark, fontWeight: FontWeight.normal),
    bodyText2: TextStyle(
        fontSize: 12, color: primaryDark, fontWeight: FontWeight.normal),
  ),
);
