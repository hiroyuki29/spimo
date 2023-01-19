import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/firebase_options.dart';
import 'package:spimo/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const jaLocale = Locale("ja", "JA");

    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      locale: jaLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        jaLocale,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}





// return Scaffold(
//   body: SafeArea(
//     child: books.value.isEmpty || book.value == null
//         ? const Text('データなし')
//         : Column(
//             children: [
//               if (book.value!.imageLinks != '')
//                 Image.network(book.value!.imageLinks!),
//               Text(book.value!.pageCount.toString()),
//             ],
//           ),
//   ),
// );
