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
      routes: <RouteBase>[
        ///todo: uncomment/remove here
        /*GoRoute(
          path: 'product/:productId',
          builder: (BuildContext context, GoRouterState state) {
            final blocProvider = BlocProvider.of<ProductBloc>(context);
            final productId = state.pathParameters['productId'] ?? "";
            blocProvider.add(UpdateProductID(state.pathParameters['productId'] ?? ""));

            return ProductScreen(productId: productId);
          },
        ),*/
      ],
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

    //profile
    GoRoute(
      path: '/sharescreen',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ShareScreen(),
          transitionsBuilder: customTransitionBuilder,
        );
      },
    ),

    ///todo: uncomment/remove here
    //search
    /*GoRoute(
      path: '/search',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const SearchPage(),
          transitionsBuilder: customTransitionBuilder,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'item/:searchItem',
          builder: (BuildContext context, GoRouterState state) {
            BlocProvider.of<SearchBloc>(context).add(UpdateSearchedText(state.pathParameters['searchItem'] ?? ""));
            return const SearchPage();
          },
        ),
      ],
    ),*/
  ],
);

/*ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomBar(),
        );
      },
      routes: [
        //home
        GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder: customTransitionBuilder,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'product/:productId',
              builder: (BuildContext context, GoRouterState state) {
                final blocProvider = BlocProvider.of<ProductBloc>(context);
                final productId = state.pathParameters['productId'] ?? "";
                blocProvider.add(UpdateProductID(state.pathParameters['productId'] ?? ""));

                return BlocProvider(
                    create: (context) => ProductBloc()..add(UpdateProductID(productId)),
                    child: ProductScreen(productId: productId));
              },
            ),
          ],
        ),

        //cart
        GoRoute(
          path: '/cart',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const Cart(),
              transitionsBuilder: customTransitionBuilder,
            );
          },
        ),

        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const Profile(),
              transitionsBuilder: customTransitionBuilder,
            );
          },
        ),
      ],
    )*/