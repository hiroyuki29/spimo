import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/account/data/firebase_auth/firebase_auth_repository.dart';
import 'package:spimo/features/account/presentation/screens/account_home_screen.dart';
import 'package:spimo/features/account/presentation/screens/start_screen.dart';
import 'package:spimo/features/account/presentation/screens/sign_up_screen.dart';
import 'package:spimo/features/books/presentation/screens/books_home_screen.dart';
import 'package:spimo/features/books/presentation/screens/search_books_screen.dart';
import 'package:spimo/features/home/presentation/screens/home_screen.dart';
import 'package:spimo/features/memos/presentation/screens/memos_home_screen.dart';
import 'package:spimo/features/record/presentation/record_home_screen.dart';

enum AppRoute {
  start,
  signUp,
  home,
  memos,
  record,
  books,
  searchBooks,
  account,
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider.autoDispose<GoRouter>((ref) {
  final authRepository = ref.watch(firebaseAuthRepositoryProvider);

  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final currentUser = authRepository.auth.currentUser;
      if (currentUser != null && state.subloc == '/') {
        return '/home';
      }
      if (currentUser == null && state.subloc != '/') {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.start.name,
        builder: (context, state) => const StartScreen(),
        routes: [
          GoRoute(
            path: 'singUp',
            name: AppRoute.signUp.name,
            builder: (context, state) => const SignUpScreen(),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: AppRoute.home.name,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/memos',
            name: AppRoute.memos.name,
            builder: (context, state) => const MemosHomeScreen(),
          ),
          GoRoute(
            path: '/record',
            name: AppRoute.record.name,
            builder: (context, state) => const RecordHomeScreen(),
          ),
          GoRoute(
            path: '/books',
            name: AppRoute.books.name,
            builder: (context, state) => const BooksHomeScreen(),
            routes: [
              GoRoute(
                path: 'search',
                name: AppRoute.searchBooks.name,
                builder: (context, state) => const SearchBooksScreen(),
              )
            ],
          ),
          GoRoute(
            path: '/account',
            name: AppRoute.account.name,
            builder: (context, state) => const AccountHomeScreen(),
          ),
        ],
      )
    ],
  );
});

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  final tabs = [
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/home',
      icon: Icon(Icons.home),
      label: 'home',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/memos',
      icon: Icon(Icons.pages),
      label: 'memo',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/record',
      icon: Icon(Icons.create),
      label: 'record',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/books',
      icon: Icon(Icons.add_box),
      label: 'book',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/account',
      icon: Icon(Icons.person),
      label: 'account',
    ),
  ];

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((tab) => location.startsWith(tab.initialLocation));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: tabs,
        onTap: (tabIndex) => _onItemTapped(context, tabIndex),
      ),
    );
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}
