import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/icon_asset/Icon_asset.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:spimo/util/validator.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useState<String>('');
    final password = useState<String>('');
    final nickName = useState<String>('');
    final isMounted = useIsMounted();

    Future<void> submit() async {
      if (formKey.currentState!.validate()) {
        final userId = await ref
            .read(userRepositoryProvider)
            .createUserWithEmailAndPassword(
              emailAddress: email.value,
              password: password.value,
              nickName: nickName.value,
            );
        print(userId);
        if (userId != null && isMounted()) {
          context.goNamed(AppRoute.home.name);
        }
      }
    }

    return Scaffold(
      appBar: CommonAppBar(context: context, title: '新規登録'),
      body: SafeArea(
          child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sizedBoxH16,
              SizedBox(
                height: 160,
                child: IconAsset.spimoLogo,
              ),
              sizedBoxH32,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '名前（ニックネーム）',
                ),
                validator: (value) {
                  String? checkedValue = value == null ? '必須項目です' : null;
                  return checkedValue;
                },
                onChanged: (value) {
                  nickName.value = value;
                },
              ),
              sizedBoxH32,
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
              sizedBoxH32,
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
