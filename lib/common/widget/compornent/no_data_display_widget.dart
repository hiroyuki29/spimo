import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spimo/common_widget/icon_asset/Icon_asset.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spimo/routing/app_router.dart';

class NoDataDisplayWidget extends StatelessWidget {
  const NoDataDisplayWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.iconSize = 160,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final double iconSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          children: [
            sizedBoxH32,
            SizedBox(
              height: iconSize,
              child: icon,
            ),
            sizedBoxH8,
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NoSelectedBookWidget extends StatelessWidget {
  const NoSelectedBookWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoDataDisplayWidget(
      text: AppLocalizations.of(context)!.noSelectedBook,
      icon: IconAsset.book,
      onTap: () => context.goNamed(AppRoute.books.name),
    );
  }
}

class NoSavedMemoWidget extends StatelessWidget {
  const NoSavedMemoWidget({
    Key? key,
    this.iconSize = 160,
  }) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return NoDataDisplayWidget(
      text: AppLocalizations.of(context)!.noSavedMemo,
      icon: IconAsset.speech,
      iconSize: iconSize,
      onTap: () => context.goNamed(
        AppRoute.record.name,
      ),
    );
  }
}
