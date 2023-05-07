import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:spimo/common/method/show_update_dialog.dart';
import 'package:spimo/common/provider/remote_config_provider.dart';
import 'package:spimo/common/widget/app_bar/common_app_bar.dart';
import 'package:spimo/common/widget/button/long_width_button.dart';
import 'package:spimo/common/widget/icon_asset/Icon_asset.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/common/widget/snackBar/custom_snack_bar.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:spimo/util/validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useState<String>('');
    final password = useState<String>('');
    final isLoading = useState<bool>(false);

    Future<void> submit() async {
      isLoading.value = true;
      if (formKey.currentState!.validate()) {
        final userId = await ref
            .read(userRepositoryProvider)
            .signInWithEmailAndPassword(
              emailAddress: email.value,
              password: password.value,
            )
            .catchError((e) {
          customSnackBar(context, e);
          return null;
        });
        if (userId != null && context.mounted) {
          context.goNamed(AppRoute.home.name);
        }
      }
      isLoading.value = false;
    }

    Future<void> appleLogin() async {
      isLoading.value = true;
      final userId = await ref
          .read(userRepositoryProvider)
          .signInWithApple()
          .catchError((e) {
        customSnackBar(context, e);
        isLoading.value = false;
        return null;
      });
      if (userId != null && context.mounted) {
        context.goNamed(AppRoute.home.name);
      }

      isLoading.value = false;
    }

    Future<void> googleLogin() async {
      isLoading.value = true;
      final userId = await ref
          .read(userRepositoryProvider)
          .signInWithGoogle()
          .catchError((e) {
        customSnackBar(context, e);
        isLoading.value = false;
        return null;
      });
      if (userId != null && context.mounted) {
        context.goNamed(AppRoute.home.name);
      }

      isLoading.value = false;
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        ref
            .read(remoteConfigProvider)
            .versionCheck()
            .then((isNeedUpdate) => showUpdateDialog(isNeedUpdate, context));
      });
      return null;
    }, []);

    return LoadingOverlay(
      isLoading: isLoading.value,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CommonAppBar(
              context: context, title: AppLocalizations.of(context)!.login),
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 160,
                        child: IconAsset.spimoLogo,
                      ),
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
                      sizedBoxH8,
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
                      sizedBoxH16,
                      LongWidthButton(
                        title: AppLocalizations.of(context)!.login,
                        onTap:
                            email.value.isNotEmpty && password.value.isNotEmpty
                                ? submit
                                : null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () =>
                                context.goNamed(AppRoute.resetPasword.name),
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              // padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.forgotPassword,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      // TextButton(
                      //   onPressed: () => context.goNamed(AppRoute.signUp.name),
                      //   child: Text(
                      //     AppLocalizations.of(context)!.signUp,
                      //     style: const TextStyle(color: Colors.lightBlue),
                      //   ),
                      // ),
                      sizedBoxH8,
                      SignInButton(
                        Buttons.Apple,
                        onPressed: appleLogin,
                      ),
                      sizedBoxH8,
                      SignInButton(
                        Buttons.Google,
                        onPressed: googleLogin,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
