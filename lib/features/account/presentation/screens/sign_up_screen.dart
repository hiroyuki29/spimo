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
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useState<String>('');
    final password = useState<String>('');
    final nickName = useState<String>('');
    final isMounted = useIsMounted();

    final Uri termsOfServiceUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/terms_of_service');

    final Uri privacyPolicyUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/privacy_policy');

    Future<void> doLaunchingUrl(Uri url) async {
      if (!await launchUrl(url)) {
        throw Exception('接続できませんでした');
      }
    }

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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(context: context, title: '新規登録'),
        body: SafeArea(
            child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
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
                      String? checkedValue =
                          Validator.email(value?.trim() ?? '');
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MinimumTextButton(
                            text: 'ご利用規約',
                            onTap: () async {
                              await doLaunchingUrl(termsOfServiceUrl);
                            },
                          ),
                          const Text('と'),
                          MinimumTextButton(
                            text: 'プライバシポリシー',
                            onTap: () async {
                              await doLaunchingUrl(privacyPolicyUrl);
                            },
                          ),
                          const Text('に同意して、'),
                        ],
                      ),
                      const Text('アカウントを作成する'),
                    ],
                  ),
                  sizedBoxH16,
                  ElevatedButton(
                    onPressed:
                        email.value.isNotEmpty && password.value.isNotEmpty
                            ? submit
                            : null,
                    child: const Text('新規登録'),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class MinimumTextButton extends StatelessWidget {
  const MinimumTextButton({
    Key? key,
    required this.text,
    this.textStyle = const TextStyle(
      decoration: TextDecoration.underline,
    ),
    required this.onTap,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: textStyle),
    );
  }
}
