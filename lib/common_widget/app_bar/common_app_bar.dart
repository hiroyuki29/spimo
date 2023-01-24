import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar CommonAppBar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    title: Text(title),
    leading: Container(
      child: IconButton(
        icon: const Icon(
          Icons.chevron_left,
        ),
        onPressed: () => context.pop(),
      ),
    ),
  );
}
