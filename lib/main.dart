import 'package:chat_app/screens/messages/bloc/messages_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'di.dart';
import 'models/user/user.dart';
import 'screens/app.dart';
import 'screens/chats/bloc/chats_bloc.dart';
import 'screens/friends/bloc/friends_bloc.dart';

const currentUser = User(
  id: "d2225da0-c74e-4a53-a889-f197a9b909ab",
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
  await dotenv.load(fileName: ".env");
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
            service: ref.read(chatsProvider),
          ),
        ),
        BlocProvider(
          create: (context) => FriendsBloc(
            service: ref.read(friendsProvider),
          ),
        ),
        BlocProvider(
          create: (context) => MessagesBloc(
            service: ref.read(messageProvider),
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
