import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spimo/common_widget/color/color.dart';

AppBar CommonAppBar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(color: primaryDark),
      ),
    ),
    leading: Navigator.of(context).canPop()
        ? IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: primaryDark,
            ),
            onPressed: () => context.pop(),
          )
        : const SizedBox.shrink(),
    shape: const Border(
      bottom: BorderSide(width: 1, color: primaryDark),
    ),
    elevation: 0,
  );
}
