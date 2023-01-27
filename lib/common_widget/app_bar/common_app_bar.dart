import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar CommonAppBar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: const TextStyle(color: Colors.blue),
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.chevron_left,
      ),
      onPressed: () => context.pop(),
    ),
    shape: const Border(
      bottom: BorderSide(width: 1, color: Colors.blue),
    ),
    elevation: 0,
  );
}
