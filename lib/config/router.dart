import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/app/app_root_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/auth',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen();
      },
    ),
    GoRoute(
      path: '/app',
      builder: (BuildContext context, GoRouterState state) {
        return const AppRootScreen();
      },
    ),
    GoRoute(
      path: '/app/contacts',
      builder: (BuildContext context, GoRouterState state) {
        return Text(state.location);
      },
    ),
    GoRoute(
      path: '/app/contacts/:contactId',
      builder: (BuildContext context, GoRouterState state) {
        return Text(state.location);
      },
    ),
    GoRoute(
      path: '/app/conversations',
      builder: (BuildContext context, GoRouterState state) {
        return Text(state.location);
      },
    ),
    GoRoute(
      path: '/app/conversations/:conversationId',
      builder: (BuildContext context, GoRouterState state) {
        return Text(state.location);
      },
    ),
    GoRoute(
      path: '/app/profile',
      builder: (BuildContext context, GoRouterState state) {
        return Text(state.location);
      },
    ),
  ],
);
