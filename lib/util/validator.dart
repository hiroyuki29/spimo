import 'package:email_validator/email_validator.dart';

class Validator {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return '必須項目です';
    }
    if (!EmailValidator.validate(value)) {
      return 'メールアドレスの形式が正しくありません';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '必須項目です';
    }
    RegExp regExp = RegExp(r'^[a-zA-Z0-9!@#\$&*~]{6,}$');
    if (!regExp.hasMatch(value)) {
      return '６文字以上の英数字および記号を入力してください';
    }
    return null;
  }
}
