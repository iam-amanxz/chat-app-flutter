import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/di.dart';
import '../features/auth/auth_state.dart';
import '../features/contact/model/contact.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  FirebaseAuthState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends FirebaseAuthState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _recoverFirebaseSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _recoverFirebaseSession() async {
    final bool exist = FirebaseAuth.instance.currentUser != null;
    if (!exist) {
      onUnauthenticated();
    } else {
      onAuthenticated(FirebaseAuth.instance.currentUser!);
    }
  }

  @override
  void onAuthenticated(User session) {
    ref.read(loggerProvider).d("SplashScreen: onAuthenticated");
    ref.read(authServiceProvider).getCurrentUser(session).then((contact) {
      if (contact != null) {
        ref.read(currentUserProvider.notifier).state = contact;
        GoRouter.of(context).go('/app');
      }
    });
  }

  @override
  void onUnauthenticated() {
    ref.read(loggerProvider).d("SplashScreen: Unauthenticated");
    GoRouter.of(context).go('/auth');
  }
}
