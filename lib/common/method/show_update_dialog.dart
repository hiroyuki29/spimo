import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spimo/common/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showUpdateDialog(bool needUpdate, BuildContext context) {
  if (!needUpdate) return;

  final Uri appStoreUrl = Uri.parse(APP_STORE_URL);
  final Uri playStoreUrl = Uri.parse(PLAY_STORE_URL);

  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final title = AppLocalizations.of(context)!.updateNotification;
      final message = AppLocalizations.of(context)!.updateMessage;
      final btnLabel = AppLocalizations.of(context)!.updateNow;
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        //TODO:アプリ登録後修正
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              AppLocalizations.of(context)!.close,
              style: const TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
