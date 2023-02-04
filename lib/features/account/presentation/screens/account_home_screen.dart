import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/indicator/loading_circle_indicator.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/account/data/firebase_auth/firebase_auth_repository.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final isMounted = useIsMounted();

    final Uri privacyPolicyUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/privacy_policy');
    final Uri termsOfServiceUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/privacy_policy');
    final Uri inquiryUrl =
        Uri.parse('https://spimo-project.firebaseapp.com/inquiry');

    Future<void> doLaunchingUrl(Uri url) async {
      if (!await launchUrl(url)) {
        throw Exception('接続できませんでした');
      }
    }

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
            backgroundColor: backgroundGray,
            appBar: CommonAppBar(context: context, title: 'account'),
            body: Center(
              child: Column(
                children: [
                  sizedBoxH32,
                  AccountButton(
                    title: 'ご利用規約',
                    privacyPolicyUrl: termsOfServiceUrl,
                    onTap: () async {
                      await doLaunchingUrl(termsOfServiceUrl);
                    },
                  ),
                  sizedBoxH24,
                  AccountButton(
                    title: 'プライバシーポリシー',
                    privacyPolicyUrl: privacyPolicyUrl,
                    onTap: () async {
                      await doLaunchingUrl(privacyPolicyUrl);
                    },
                  ),
                  sizedBoxH24,
                  AccountButton(
                    title: 'お問い合わせ',
                    privacyPolicyUrl: inquiryUrl,
                    onTap: () async {
                      await doLaunchingUrl(inquiryUrl);
                    },
                  ),
                  sizedBoxH24,
                  AccountButton(
                    title: 'ログアウト',
                    privacyPolicyUrl: inquiryUrl,
                    onTap: () async {
                      await logout();
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
  }
}

class AccountButton extends StatelessWidget {
  const AccountButton({
    Key? key,
    required this.privacyPolicyUrl,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final Uri privacyPolicyUrl;
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
