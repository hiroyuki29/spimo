import 'package:flutter/material.dart';

class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: StadiumBorder(
            side: isLightTheme ? const BorderSide(width: 1) : BorderSide.none,
          ),
        ),
        onPressed: onTap,
        icon: SizedBox(
            height: 50,
            child: Image.asset('assets/image/apple/apple_icon_black.png')),
        clipBehavior: Clip.hardEdge,
        label: const Text(
          'Sign in with Apple', // ボタンに表示するテキスト
          style: TextStyle(
            color: Colors.black,
            fontSize: 19, // HIGによると、最小19サイズ
          ),
        ),
      ),
    );
  }
}
