import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common/method/is_release.dart';
import 'package:spimo/common/widget/theme/custom_theme.dart';
import 'package:spimo/routing/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spimo/firebase_options_prod.dart' as prod;
import 'package:spimo/firebase_options_dev.dart' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    name: 'spimo-project',
    options: getFirebaseOptions(),
  );
  await FirebaseAppCheck.instance.activate(
    //TODO: リリース時に修正のこと
    androidProvider: AndroidProvider.debug,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

FirebaseOptions getFirebaseOptions() {
  if (isRelease()) {
    return prod.DefaultFirebaseOptions.currentPlatform;
  } else {
    return dev.DefaultFirebaseOptions.currentPlatform;
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(goRouterProvider),
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // localizationsDelegates: const [
      //   AppLocalizations.localizations.Delegates,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: spimoTheme,
    );
  }
}
