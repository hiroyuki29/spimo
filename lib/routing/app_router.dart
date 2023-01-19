import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spimo/features/account/presentation/account_home_screen.dart';
import 'package:spimo/features/books/presentation/books_home_screen.dart';
import 'package:spimo/features/home/presentation/home_screen.dart';
import 'package:spimo/features/memos/presentation/memos_home_screen.dart';
import 'package:spimo/features/record/presentation/record_home_screen.dart';

enum AppRoute {
  home,
  memos,
  record,
  books,
  account,
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// final goRouterProvider = Provider.autoDispose<GoRouter>((ref) {
// return
final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: false,
  routes: [
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
// });

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
      label: 'Section A',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/memos',
      icon: Icon(Icons.settings),
      label: 'Section B',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/record',
      icon: Icon(Icons.settings),
      label: 'Section C',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/books',
      icon: Icon(Icons.settings),
      label: 'Section D',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/account',
      icon: Icon(Icons.settings),
      label: 'Section E',
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
