// Flutter imports:
import 'package:developerlook_task_app/Screens%20&%20Features/Authentication/Data/auth_services.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Presentation/share_screen.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Social%20Feed%20Screen/Presentation/social_feed_screen.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import '../../Screens & Features/Authentication/Presentation/login_page.dart';
import 'transition_animation.dart';

final GoRouter router = GoRouter(
  redirect: (context, state) {
    final bool isLoggedIn = AuthService.instance.isSignedIn();
    if (!isLoggedIn && state.uri.toString() != '/login') {
      return '/login';
    }
    return null;
  },
  routes: <RouteBase>[
    //ShellRoute was here
    //home
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const SocialFeedScreen(),
          transitionsBuilder: customTransitionBuilder,
        );
      },
    ),

    // login page
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(), // Replace with your actual LoginPage widget
          transitionsBuilder: customTransitionBuilder,
        );
      },
    ),

    //Share page
    GoRoute(
      path: '/sharescreen',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ShareScreen(), // Replace with your actual LoginPage widget
          transitionsBuilder: customTransitionBuilder,
        );
      },
    ),

  ],
);