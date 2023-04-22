import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spimo/common_widget/color/color.dart';

AppBar CommonAppBar({
  required BuildContext context,
  required String title,
  Widget? action,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline1,
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
    actions: action == null ? null : [action],
    bottom: bottom,
  );
}
