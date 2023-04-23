import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:spimo/common/widget/app_bar/common_app_bar.dart';
import 'package:spimo/common/widget/button/long_width_button.dart';
import 'package:spimo/common/widget/icon_asset/Icon_asset.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:spimo/util/validator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useState<String>('');
    final password = useState<String>('');
    final nickName = useState<String>('');
    final isLoading = useState<bool>(false);

    final Uri termsOfServiceUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/terms_of_service');

    final Uri privacyPolicyUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/privacy_policy');

    Future<void> doLaunchingUrl(Uri url) async {
      if (!await launchUrl(url)) {
        throw Exception(AppLocalizations.of(context)!.canNotConnection);
      }
    }

    Future<void> submit() async {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        final userId = await ref
            .read(userRepositoryProvider)
            .createUserWithEmailAndPassword(
              emailAddress: email.value,
              password: password.value,
              nickName: nickName.value,
            )
            .catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e),
          ));
          return null;
        });
        if (userId != null && context.mounted) {
          context.goNamed(AppRoute.home.name);
        }
        isLoading.value = false;
      }
    }

    return LoadingOverlay(
      isLoading: isLoading.value,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CommonAppBar(
              context: context, title: AppLocalizations.of(context)!.signUp),
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
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.nickName,
                      ),
                      validator: (value) {
                        String? checkedValue = value == null
                            ? AppLocalizations.of(context)!.requiredFields
                            : null;
                        return checkedValue;
                      },
                      onChanged: (value) {
                        nickName.value = value;
                      },
                    ),
                    sizedBoxH32,
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                      ),
                      validator: (value) {
                        String? checkedValue =
                            Validator.email(context, value?.trim() ?? '');
                        return checkedValue;
                      },
                      onChanged: (value) {
                        email.value = value;
                      },
                    ),
                    sizedBoxH32,
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.passoword,
                      ),
                      validator: (value) {
                        String? checkedValue =
                            Validator.password(context, value?.trim() ?? '');
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
                              text: AppLocalizations.of(context)!.termsOfUse,
                              onTap: () async {
                                await doLaunchingUrl(termsOfServiceUrl);
                              },
                            ),
                            Text(AppLocalizations.of(context)!.and),
                            MinimumTextButton(
                              text: AppLocalizations.of(context)!.privacyPolicy,
                              onTap: () async {
                                await doLaunchingUrl(privacyPolicyUrl);
                              },
                            ),
                            Text(AppLocalizations.of(context)!.agreeOnlyJp),
                          ],
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .agreeToTheAboveAndCreateAccount,
                        ),
                      ],
                    ),
                    sizedBoxH16,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: LongWidthButton(
                        title: AppLocalizations.of(context)!.signUp,
                        onTap:
                            email.value.isNotEmpty && password.value.isNotEmpty
                                ? submit
                                : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
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
