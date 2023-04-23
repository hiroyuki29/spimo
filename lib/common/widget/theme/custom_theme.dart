import 'package:flutter/material.dart';
import 'package:spimo/common/widget/color/color.dart';

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
    displayMedium: TextStyle(
        fontSize: 50, color: primaryDark, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
        fontSize: 20, color: primaryDark, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontSize: 18, color: primaryDark, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        fontSize: 16, color: primaryDark, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(
        fontSize: 14, color: primaryDark, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(
        fontSize: 12, color: primaryDark, fontWeight: FontWeight.normal),
  ),
);
