import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/domain/book/book.dart';
import 'package:spimo/domain/repository/books_repository.dart';
import 'package:spimo/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = useState<List<Book>>([]);
    final book = useState<Book?>(null);

    useEffect(() {
      Future(() async {
        final searchedBookList =
            await ref.read(booksProvider).getBookList('test');
        books.value = searchedBookList;
        final id = books.value[5].id;
        book.value = await ref.read(booksProvider).getBook(id);
      });
      return null;
    }, []);
    return Scaffold(
      body: SafeArea(
        child: books.value.isEmpty || book.value == null
            ? const Text('データなし')
            : Column(
                children: [
                  if (book.value!.imageLinks != '')
                    Image.network(book.value!.imageLinks!),
                  Text(book.value!.pageCount.toString()),
                ],
              ),
      ),
    );
  }
}
