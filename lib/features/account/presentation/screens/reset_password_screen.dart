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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends HookConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useState<String>('');
    final isLoading = useState<bool>(false);

    Future<void> sendEmail() async {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        await ref
            .read(userRepositoryProvider)
            .resetPassword(
              emailAddress: email.value,
            )
            .catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e),
          ));
          return null;
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.sentEmail),
          ));
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
              context: context,
              title: AppLocalizations.of(context)!.resetPassword),
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
                    Text(
                      AppLocalizations.of(context)!.sendEmailForPassword,
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
                    const SizedBox(height: 30),
                    sizedBoxH16,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: LongWidthButton(
                        title: AppLocalizations.of(context)!.send,
                        onTap: email.value.isNotEmpty ? sendEmail : null,
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
