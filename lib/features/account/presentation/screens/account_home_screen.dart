import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/indicator/loading_circle_indicator.dart';
import 'package:spimo/features/account/data/firebase_auth/firebase_auth_repository.dart';
import 'package:spimo/routing/app_router.dart';

class AccountHomeScreen extends HookConsumerWidget {
  const AccountHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);
    final isMounted = useIsMounted();

    Future<void> logout() async {
      isLoading.value = true;
      await ref.read(firebaseAuthRepositoryProvider).signOut();
      if (isMounted()) {
        context.goNamed(AppRoute.start.name);
      }
      isLoading.value = false;
    }

    return isLoading.value
        ? const LoadingCircleIndicator()
        : Scaffold(
            appBar: CommonAppBar(context: context, title: 'account'),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('account'),
                  Expanded(child: Container()),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                    ),
                    onPressed: () async {
                      await logout();
                    },
                    child: const Text('ログアウト'),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
  }
}
