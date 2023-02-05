import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:spimo/common_widget/icon_asset/Icon_asset.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:spimo/util/validator.dart';

class StartScreen extends HookConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useState<String>('');
    final password = useState<String>('');
    final isMounted = useIsMounted();
    final isLoading = useState<bool>(false);

    Future<void> submit() async {
      isLoading.value = true;
      if (formKey.currentState!.validate()) {
        final userId =
            await ref.read(userRepositoryProvider).signInWithEmailAndPassword(
                  emailAddress: email.value,
                  password: password.value,
                );
        print(userId.toString());
        if (userId != null && isMounted()) {
          context.goNamed(AppRoute.home.name);
        }
      }
      isLoading.value = false;
    }

    return LoadingOverlay(
      isLoading: isLoading.value,
      child: Scaffold(
        body: SafeArea(
            child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 260,
                  child: IconAsset.spimoLogo,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'メールアドレス',
                  ),
                  validator: (value) {
                    String? checkedValue = Validator.email(value?.trim() ?? '');
                    return checkedValue;
                  },
                  onChanged: (value) {
                    email.value = value;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'パスワード',
                  ),
                  validator: (value) {
                    String? checkedValue =
                        Validator.password(value?.trim() ?? '');
                    return checkedValue;
                  },
                  onChanged: (value) {
                    password.value = value;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: email.value.isNotEmpty && password.value.isNotEmpty
                      ? submit
                      : null,
                  child: const Text('ログイン'),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () => context.goNamed(AppRoute.signUp.name),
                  child: const Text('新規登録'),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
