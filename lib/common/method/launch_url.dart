import 'package:url_launcher/url_launcher.dart';

/// 指定のURLを起動する. App Store or Play Storeのリンク
void launchURL(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
