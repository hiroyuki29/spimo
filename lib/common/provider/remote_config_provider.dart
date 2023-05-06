import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spimo/common/constant.dart';
import 'package:spimo/common/method/is_release.dart';

/// Firebase Remote Config Provider
final remoteConfigProvider = Provider<RemoteConfigService>((ref) {
  final rc = RemoteConfigService();
  return rc;
});

class RemoteConfigService {
  RemoteConfigService() {
    initialize();
  }

  final FirebaseRemoteConfig rc = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    final interval =
        isRelease() ? const Duration(minutes: 30) : const Duration(minutes: 5);
    // タイムアウトとフェッチのインターバル時間を設定する
    await rc.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: interval,
    ));
  }

  Future<bool> versionCheck() async {
    final configName = isRelease() ? FORCE_UPDATE_VERSION : DEV_VERSION_CONFIG;

    final PackageInfo info = await PackageInfo.fromPlatform();
    int currentVersion = int.parse(info.buildNumber);

    try {
      // 常にサーバーから取得するようにするため期限を最小限にセット
      await rc.fetchAndActivate();
      int newVersion = rc.getInt(configName);
      if (newVersion > currentVersion) {
        return true;
      }
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be ');
    }
    return false;
  }
}
