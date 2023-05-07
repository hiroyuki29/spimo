import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:spimo/common/method/show_update_dialog.dart';
import 'package:spimo/common/provider/remote_config_provider.dart';
import 'package:spimo/common/widget/button/long_width_button.dart';
import 'package:spimo/common/widget/button/minimum_text_button.dart';
import 'package:spimo/common/widget/icon_asset/Icon_asset.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/common/widget/snackBar/custom_snack_bar.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class StartScreen extends HookConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useState<String>('');
    final password = useState<String>('');
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

    Future<void> newStart() async {
      isLoading.value = true;
      if (formKey.currentState!.validate()) {
        final userId = await ref
            .read(userRepositoryProvider)
            .signInAnonymously()
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
                        height: 220,
                        child: IconAsset.spimoLogo,
                      ),
                      Text(
                        AppLocalizations.of(context)!.subTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'spiMo',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      sizedBoxH32,
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
                      LongWidthButton(
                        title: AppLocalizations.of(context)!.newStart,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        onTap: newStart,
                      ),
                      sizedBoxH32,
                      Text(
                        AppLocalizations.of(context)!.alreadySignUp,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      sizedBoxH8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: LongWidthButton(
                          title: AppLocalizations.of(context)!.login,
                          onTap: () => context.goNamed(AppRoute.login.name),
                        ),
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
