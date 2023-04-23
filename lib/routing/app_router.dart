import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/common/method/show_update_dialog.dart';
import 'package:spimo/common/provider/remote_config_provider.dart';
import 'package:spimo/common/widget/color/color.dart';
import 'package:spimo/common/widget/icon_asset/Icon_asset.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';
import 'package:spimo/features/account/presentation/controller/user_controller.dart';
import 'package:spimo/features/account/presentation/screens/account_home_screen.dart';
import 'package:spimo/features/account/presentation/screens/reset_password_screen.dart';
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
  resetPasword,
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
  ///observerでanalyticsのページ取得を行いたいが、ShellRouteを使用しているとうまくいかないため、
  ///各builderの中でanalyticsメソッドを呼んでいる。
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && state.subloc == '/') {
        return '/home';
      }
      if (currentUser == null &&
          state.subloc != '/' &&
          state.subloc != '/signUp' &&
          state.subloc != '/resetPassword') {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.start.name,
        builder: (context, state) {
          FirebaseAnalytics.instance.logScreenView(screenName: state.location);
          return const StartScreen();
        },
        routes: [
          GoRoute(
            path: 'signUp',
            name: AppRoute.signUp.name,
            builder: (context, state) {
              FirebaseAnalytics.instance
                  .logScreenView(screenName: state.location);
              return const SignUpScreen();
            },
          ),
          GoRoute(
            path: 'resetPassword',
            name: AppRoute.resetPasword.name,
            builder: (context, state) {
              FirebaseAnalytics.instance
                  .logScreenView(screenName: state.location);
              return const ResetPasswordScreen();
            },
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          FirebaseAnalytics.instance.logScreenView(screenName: state.location);
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
                builder: (context, state) {
                  FirebaseAnalytics.instance
                      .logScreenView(screenName: state.location);
                  return const SearchBooksScreen();
                },
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

class ScaffoldWithBottomNavBar extends ConsumerStatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  ConsumerState<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState
    extends ConsumerState<ScaffoldWithBottomNavBar> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(remoteConfigProvider)
          .versionCheck()
          .then((isNeedUpdate) => showUpdateDialog(isNeedUpdate, context));
      await ref
          .read(userControllerProvider.notifier)
          .fetchUser(FirebaseAuth.instance.currentUser!.uid);

      final user = ref.read(userControllerProvider);
      if (user == null) {
        Future(() async {
          await ref.read(userRepositoryProvider).signOut();
          context.goNamed(AppRoute.start.name);
        });
      }
    });

    super.initState();
  }

  final tabs = [
    ScaffoldWithNavBarTabItem(
      initialLocation: '/home',
      icon: SizedBox(width: 32, height: 32, child: IconAsset.home),
      activeIcon: SizedBox(width: 32, child: IconAsset.homeActive),
      label: 'Home',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/memos',
      icon: SizedBox(width: 32, height: 32, child: IconAsset.memo),
      activeIcon: SizedBox(width: 32, child: IconAsset.memoActive),
      label: 'Memo',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/record',
      icon: SizedBox(width: 32, height: 32, child: IconAsset.speech),
      activeIcon: SizedBox(width: 32, child: IconAsset.speechActive),
      label: 'Record',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/books',
      icon: SizedBox(width: 32, height: 32, child: IconAsset.book),
      activeIcon: SizedBox(width: 32, child: IconAsset.bookActive),
      label: 'Book',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/account',
      icon: SizedBox(width: 32, height: 32, child: IconAsset.account),
      activeIcon: SizedBox(width: 32, child: IconAsset.accountActive),
      label: 'Account',
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
    final user = ref.watch(userControllerProvider);

    return Scaffold(
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primary,
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
      {required this.initialLocation,
      required Widget icon,
      required Widget activeIcon,
      String? label})
      : super(icon: icon, activeIcon: activeIcon, label: label);

  /// The initial location/path
  final String initialLocation;
}
