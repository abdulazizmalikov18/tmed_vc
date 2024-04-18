import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmed_vc/constants/app_route_path.dart';
import 'package:tmed_vc/screens/error_screen.dart';
import 'package:tmed_vc/screens/home_screen.dart';
import 'package:tmed_vc/screens/splash_screen.dart';
import 'package:tmed_vc/screens/viewer_join_screen.dart';

sealed class AppRouts {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutePath.splash,
    errorBuilder: (context, state) =>
        ErrorScreen(error: state.error?.message ?? "ERROR"),
    routes: [
      GoRoute(
        path: AppRoutePath.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRoutePath.viewerJoinScreen,
        path: AppRoutePath.viewerJoinScreen,
        builder: (context, state) => ViewerJoinScreen(
          id: state.uri.queryParameters['fid'] ?? "",
        ),
      ),
      GoRoute(
        path: AppRoutePath.splash,
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );
}
