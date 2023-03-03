import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validator {
  static String? email(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.requiredFields;
    }
    if (!EmailValidator.validate(value)) {
      return AppLocalizations.of(context)!.emailValidator;
    }
    return null;
  }

  static String? password(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.requiredFields;
    }
    RegExp regExp = RegExp(r'^[a-zA-Z0-9!@#\$&*~]{6,}$');
    if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.passwordValidator;
    }
    return null;
  }
}
