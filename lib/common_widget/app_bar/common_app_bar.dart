import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar CommonAppBar(BuildContext context) {
  return AppBar(
    title: const Text('新規登録'),
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
