import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:spimo/common/widget/app_bar/common_app_bar.dart';
import 'package:spimo/common/widget/button/long_width_button.dart';
import 'package:spimo/common/widget/icon_asset/Icon_asset.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:spimo/util/validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountEditScreen extends HookConsumerWidget {
  const AccountEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userControllerProvider);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useState<String>(currentUser?.email ?? '');
    final password = useState<String>('');
    final nickName = useState<String>(currentUser?.nickName ?? '');
    final isLoading = useState<bool>(false);

    Future<void> submit() async {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        await ref
            .read(userControllerProvider.notifier)
            .editUser(
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
        if (context.mounted) {
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
              title: AppLocalizations.of(context)!.editUserInfo),
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
                      initialValue: nickName.value,
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
                      initialValue: email.value,
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
                      initialValue: password.value,
                      validator: (value) {
                        if (password.value == '') return null;
                        String? checkedValue =
                            Validator.password(context, value?.trim() ?? '');
                        return checkedValue;
                      },
                      onChanged: (value) {
                        password.value = value;
                      },
                    ),
                    const SizedBox(height: 30),
                    sizedBoxH16,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: LongWidthButton(
                        title: AppLocalizations.of(context)!.editUserInfo,
                        onTap: submit,
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
