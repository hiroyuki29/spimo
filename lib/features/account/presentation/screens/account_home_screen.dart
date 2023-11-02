import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spimo/common/widget/app_bar/common_app_bar.dart';
import 'package:spimo/common/widget/color/color.dart';
import 'package:spimo/common/widget/dialog/custom_alert_dialog.dart';
import 'package:spimo/common/widget/icon_asset/Icon_asset.dart';
import 'package:spimo/common/widget/indicator/loading_circle_indicator.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/home/presentation/screens/home_screen.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountHomeScreen extends StatefulHookConsumerWidget {
  const AccountHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AccountHomeScreenState();
}

class _AccountHomeScreenState extends ConsumerState<AccountHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);
    final user = ref.watch(userControllerProvider);
    final isAnonymous =
        ref.watch(userControllerProvider.notifier).isAnonymous();

    final Uri termsOfServiceUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/terms_of_service');

    final Uri privacyPolicyUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/privacy_policy');

    final Uri inquiryUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/inquiry');

    Future<void> doLaunchingUrl(Uri url) async {
      if (!await launchUrl(url)) {
        throw Exception(AppLocalizations.of(context)!.canNotConnection);
      }
    }

    Future<void> logout() async {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: AppLocalizations.of(context)!.doLogout,
            leftText: AppLocalizations.of(context)!.logout,
            rightText: AppLocalizations.of(context)!.cancel,
            onTapLeft: () async {
              isLoading.value = true;
              await ref.read(userRepositoryProvider).signOut();
              if (context.mounted) {
                context.goNamed(AppRoute.start.name);
              }
              isLoading.value = false;
            },
            onTapRight: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }

    Future<void> deleteUser() async {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: AppLocalizations.of(context)!.deleteMembershipTitle,
            content: AppLocalizations.of(context)!.deleteMembershipContent,
            leftText: AppLocalizations.of(context)!.deletingMembership,
            rightText: AppLocalizations.of(context)!.cancel,
            onTapLeft: () async {
              isLoading.value = true;
              await ref.read(userRepositoryProvider).deleteUser();
              if (context.mounted) {
                context.goNamed(AppRoute.start.name);
              }
              isLoading.value = false;
            },
            onTapRight: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }

    return isLoading.value
        ? const LoadingCircleIndicator()
        : Scaffold(
            backgroundColor: backgroundGray,
            appBar: CommonAppBar(
                context: context,
                title: 'Account',
                action: IconButton(
                    onPressed: isAnonymous
                        ? () {
                            context.goNamed(AppRoute.signUp.name);
                          }
                        : () {
                            context.goNamed(AppRoute.editAccount.name);
                          },
                    icon: isAnonymous
                        ? Column(
                            children: const [
                              Icon(Icons.manage_accounts),
                              Text(
                                '本登録はこちら',
                                style: TextStyle(fontSize: 9),
                              )
                            ],
                          )
                        : const Icon(Icons.edit))),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (isAnonymous)
                    Container(
                      color: Colors.yellow,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'まだ本登録が完了していません。\n本登録を行うと機種変更後もデータを引き続き使用できます。',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  HomeContent(
                    title: AppLocalizations.of(context)!.nickName,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                  child: Text(
                                user?.nickName ?? '',
                                style: const TextStyle(
                                  color: black,
                                  fontSize: 20,
                                ),
                              )),
                            ),
                          ),
                        )),
                  ),
                  sizedBoxH32,
                  AccountButton(
                    title: AppLocalizations.of(context)!.termsOfUse,
                    onTap: () async {
                      await doLaunchingUrl(termsOfServiceUrl);
                    },
                  ),
                  sizedBoxH24,
                  AccountButton(
                    title: AppLocalizations.of(context)!.privacyPolicy,
                    onTap: () async {
                      await doLaunchingUrl(privacyPolicyUrl);
                    },
                  ),
                  sizedBoxH24,
                  AccountButton(
                    title: AppLocalizations.of(context)!.inquiry,
                    onTap: () async {
                      await doLaunchingUrl(inquiryUrl);
                    },
                  ),
                  sizedBoxH24,
                  AccountButton(
                    title: AppLocalizations.of(context)!.license,
                    onTap: () async {
                      final info = await PackageInfo.fromPlatform();
                      if (!context.mounted) return;
                      showLicensePage(
                        context: context,
                        applicationName: info.appName,
                        applicationVersion: info.version,
                        applicationIcon:
                            SizedBox(height: 50, child: IconAsset.spimoLogo),
                      );
                    },
                  ),
                  sizedBoxH24,
                  if (!isAnonymous)
                    AccountButton(
                      title: AppLocalizations.of(context)!.logout,
                      onTap: () async {
                        await logout();
                      },
                    ),
                  sizedBoxH24,
                  AccountButton(
                    title: AppLocalizations.of(context)!.withdrawal,
                    onTap: () async {
                      await deleteUser();
                    },
                  ),
                  sizedBoxH24,
                ],
              ),
            ),
          );
  }
}

class AccountButton extends StatelessWidget {
  const AccountButton({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
