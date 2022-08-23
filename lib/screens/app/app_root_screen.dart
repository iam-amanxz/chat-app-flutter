import 'package:chat_app/features/auth/current_user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/auth_state.dart';

class AppRootScreen extends ConsumerStatefulWidget {
  const AppRootScreen({Key? key}) : super(key: key);

  @override
  AuthRequiredState<AppRootScreen> createState() => _AppRootScreenState();
}

class _AppRootScreenState extends AuthRequiredState<AppRootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Root'),
      ),
      body: Column(
        children: [
          ref.watch(currentUserState).when(
                data: (data) => Text(data?.username ?? ''),
                error: (e, s) => Text(e.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Sign Out'),
            ),
          ),
        ],
      ),
    );
  }
}
