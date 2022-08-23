import 'dart:async';

import 'package:chat_app/config/di.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

abstract class FirebaseAuthState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  late final StreamSubscription<User?> _authStateListener;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _authStateListener =
          FirebaseAuth.instance.authStateChanges().listen((user) async {
        if (user == null) {
          onUnauthenticated();
        } else {
          onAuthenticated(user);
        }
      });

      _authStateListener.onDone(() {
        ref
            .read(loggerProvider)
            .d('FirebaseAuthState: _authStateListener done');
      });
    });
  }

  @override
  void dispose() {
    _authStateListener.cancel();
    super.dispose();
  }

  void onUnauthenticated();
  void onAuthenticated(User session);

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class AuthRequiredState<T extends ConsumerStatefulWidget>
    extends FirebaseAuthState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      GoRouter.of(context).go('/auth');
    }
  }

  @override
  void onAuthenticated(User session) {}
}
