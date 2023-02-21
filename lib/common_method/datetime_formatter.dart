import 'package:intl/intl.dart';

///DateTime型をString型（yyyy/M/dd）に変換
String formatDateToString(DateTime date) =>
    DateFormat('yyyy/M/dd').format(date);

///DateTime型をString型（yyyy/M/dd）に変換
String formatDateToStringWithHyphen(DateTime date) =>
    DateFormat('yyyy-MM-dd').format(date);

///年月日のみのDateTime型に変換
DateTime formatDateToYMD(DateTime date) =>
    DateTime(date.year, date.month, date.day);
