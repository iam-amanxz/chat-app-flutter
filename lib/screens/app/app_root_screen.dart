import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/di.dart';
import '../../features/auth/auth_state.dart';
import '../common/mixins.dart' as mix;

class AppRootScreen extends ConsumerStatefulWidget {
  const AppRootScreen({Key? key}) : super(key: key);

  @override
  AuthRequiredState<AppRootScreen> createState() => _AppRootScreenState();
}

class _AppRootScreenState extends AuthRequiredState<AppRootScreen>
    with mix.NotificationListener {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Root'),
      ),
      body: Column(
        children: [
          Text('Signed in as ${ref.watch(currentUserProvider)?.name}'),
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
