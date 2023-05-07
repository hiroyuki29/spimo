import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:spimo/common/widget/app_bar/common_app_bar.dart';
import 'package:spimo/common/widget/button/long_width_button.dart';
import 'package:spimo/common/widget/button/minimum_text_button.dart';
import 'package:spimo/common/widget/icon_asset/Icon_asset.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/common/widget/snackBar/custom_snack_bar.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
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
            .linkWithEmailAndPassword(
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
          ref.read(userControllerProvider.notifier).fetchUser(userId);
          context.goNamed(AppRoute.account.name);
        }
        isLoading.value = false;
      }
    }

    Future<void> appleLink() async {
      isLoading.value = true;
      final userId = await ref
          .read(userRepositoryProvider)
          .linkWithApple()
          .catchError((e) {
        customSnackBar(context, e);
        isLoading.value = false;
        return null;
      });
      if (userId != null && context.mounted) {
        ref.read(userControllerProvider.notifier).fetchUser(userId);
        context.goNamed(AppRoute.account.name);
      }

      isLoading.value = false;
    }

    Future<void> googleLink() async {
      isLoading.value = true;
      final userId = await ref
          .read(userRepositoryProvider)
          .linkWithGoogle()
          .catchError((e) {
        customSnackBar(context, e);
        isLoading.value = false;
        return null;
      });
      if (userId != null && context.mounted) {
        ref.read(userControllerProvider.notifier).fetchUser(userId);
        context.goNamed(AppRoute.account.name);
      }

      isLoading.value = false;
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
                    sizedBoxH8,
                    SizedBox(
                      height: 160,
                      child: IconAsset.spimoLogo,
                    ),
                    sizedBoxH16,
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
                    sizedBoxH16,
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
                    sizedBoxH16,
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
                    sizedBoxH8,
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
                    sizedBoxH32,
                    SignInButton(
                      Buttons.Apple,
                      onPressed: appleLink,
                    ),
                    sizedBoxH8,
                    SignInButton(
                      Buttons.Google,
                      onPressed: googleLink,
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
