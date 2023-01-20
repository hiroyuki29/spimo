import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/features/account/data/firebase_auth/firebase_auth_repository.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:spimo/util/validator.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useState<String>('');
    final password = useState<String>('');
    final isMounted = useIsMounted();

    Future<void> submit() async {
      if (formKey.currentState!.validate()) {
        final credential = await ref
            .read(firebaseAuthRepositoryProvider)
            .createUserWithEmailAndPassword(
              emailAddress: email.value,
              password: password.value,
            );
        print(credential);
        if (credential != null && isMounted()) {
          context.goNamed(AppRoute.home.name);
        }
      }
    }

    return Scaffold(
      appBar: CommonAppBar(context),
      body: SafeArea(
          child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                child: const Text('新規登録'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
