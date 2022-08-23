import 'package:chat_app/config/di.dart';
import 'package:chat_app/screens/common/mixins.dart' as mix;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/firebase_options.dart';
import 'config/router.dart';
import 'config/theme.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/contact/bloc/contact_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: App()),
  );
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with mix.NotificationListener {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            auth: ref.read(authProvider),
            notification: ref.read(notificationProvider),
            reader: ref.read,
            logger: ref.read(loggerProvider),
          ),
        ),
        BlocProvider(
          create: (context) => ContactBloc(
            notification: ref.read(notificationProvider),
            contact: ref.read(contactProvider),
            logger: ref.read(loggerProvider),
          ),
        ),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: snackbarKey,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}
