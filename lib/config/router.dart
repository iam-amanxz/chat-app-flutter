import '../screens/conversations/chat_view.dart';
import '../screens/conversations/contacts_view.dart';
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
        return const ContactsView();
      },
    ),
    GoRoute(
      path: '/app/conversations/:conversationId',
      builder: (BuildContext context, GoRouterState state) {
        final extras = state.extra! as Map<String, dynamic>;
        return ChatView(
          conversationId: state.params['conversationId']!,
          friend: extras['friend'],
        );
      },
    ),
  ],
);
