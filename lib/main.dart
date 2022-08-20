import 'firebase_options.dart';
import 'screens/messages/bloc/messages_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'di.dart';
import 'models/user/user.dart';
import 'screens/app.dart';
import 'screens/chats/bloc/chats_bloc.dart';
import 'screens/friends/bloc/friends_bloc.dart';

const currentUser = User(
  id: "rwNDeCjUmrfORKjnzZIO",
  username: 'amanxz',
  name: 'Husnul Aman',
  email: 'amanxz@gmail.com',
);

final GoRouter _router = GoRouter(
  initialLocation: '/app',
  routes: <GoRoute>[
    GoRoute(
      path: '/app',
      builder: (BuildContext context, GoRouterState state) {
        return const App();
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatsBloc(
            service: ref.read(chatsServiceProvider),
          ),
        ),
        BlocProvider(
          create: (context) => FriendsBloc(
            service: ref.read(friendServiceProvider),
          ),
        ),
        BlocProvider(
          create: (context) => MessagesBloc(
            service: ref.read(messageServiceProvider),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }
}
