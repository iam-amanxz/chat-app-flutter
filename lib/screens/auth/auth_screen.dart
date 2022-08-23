import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../config/di.dart';
import '../../features/auth/auth_state.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/dto/sign_in_dto.dart';
import '../../features/auth/dto/sign_up_dto.dart';
import '../../features/contact/bloc/contact_bloc.dart';
import '../../features/contact/dto/create_contact_dto.dart';
import '../common/mixins.dart' as mix;
import '../common/styles.dart';
import '../common/validations.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  FirebaseAuthState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends FirebaseAuthState<AuthScreen>
    with mix.NotificationListener {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final Logger _logger;
  bool _isSignUp = false;
  bool _isLoading = false;

  void toggleAuthMode() {
    setState(() {
      _isSignUp = !_isSignUp;
    });
  }

  @override
  void initState() {
    super.initState();
    _logger = ref.read(loggerProvider);
    _nameController.text = 'John Doe';
    _usernameController.text = 'johndoe';
    _passwordController.text = 'password';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                success: (flag, firebaseUser, currentUser) {
                  if (flag == AuthSuccessFlag.signUp) {
                    _logger.i('AuthScreen: signUp: success');
                    context.read<ContactBloc>().createContact(
                          CreateContactDto(
                            id: firebaseUser!.uid,
                            name: _nameController.text.trim(),
                            username: _usernameController.text.trim(),
                          ),
                        );
                  }
                  if (flag == AuthSuccessFlag.signIn ||
                      flag == AuthSuccessFlag.signUp) {
                    _logger.i('AuthScreen: signIn || signUp: success');
                    context.read<AuthBloc>().setCurrentUser(firebaseUser!);
                  }
                  if (flag == AuthSuccessFlag.setCurrentUser) {
                    _logger.i('AuthScreen: setCurrentUser: success');
                    ref.read(currentUserProvider.notifier).state = currentUser;
                    GoRouter.of(context).go('/app');
                  }
                },
                loading: () => setState(() => _isLoading = true),
                error: (e) {
                  _logger.e(
                      'AuthScreen: _AuthScreenState: build: error: ${e.toString()}');
                  setState(() => _isLoading = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.description),
                    ),
                  );
                },
                orElse: () => setState(() => _isLoading = false),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isSignUp ? 'Sign Up' : 'Sign In',
                  style: titleStyle(),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _isSignUp
                          ? TextFormField(
                              controller: _nameController,
                              validator: nameValidation,
                              decoration:
                                  formInputDecoration(labelText: 'Name'),
                            )
                          : Container(),
                      _isSignUp ? const SizedBox(height: 10) : Container(),
                      TextFormField(
                        controller: _usernameController,
                        validator: _isSignUp
                            ? usernameValidationSignUp
                            : usernameValidationSignIn,
                        decoration: formInputDecoration(labelText: 'Username'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        validator: _isSignUp ? passwordValidationSignUp : null,
                        obscureText: true,
                        decoration: formInputDecoration(labelText: 'Password'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: primaryButtonStyle(),
                        onPressed: !_isLoading
                            ? () {
                                bool isFormValid =
                                    _formKey.currentState!.validate();
                                if (!isFormValid) return;

                                _isSignUp
                                    ? context.read<AuthBloc>().signUp(
                                          SignUpDto(
                                            username:
                                                _usernameController.text.trim(),
                                            password: _passwordController.text,
                                          ),
                                        )
                                    : context.read<AuthBloc>().signIn(
                                          SignInDto(
                                            username:
                                                _usernameController.text.trim(),
                                            password: _passwordController.text,
                                          ),
                                        );
                              }
                            : null,
                        child: !_isLoading
                            ? Text(_isSignUp ? 'Sign Up' : 'Sign In')
                            : const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: toggleAuthMode,
                        child: Text(
                          _isSignUp
                              ? "Already have an account? Sign In"
                              : "Don't have an account? Sign Up",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onUnauthenticated() {
    ref.read(loggerProvider).d("AuthScreen: onUnauthenticated");
  }

  @override
  void onAuthenticated(User session) {
    ref.read(loggerProvider).d("AuthScreen: onAuthenticated");
  }
}
