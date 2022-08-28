import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/styles/form_styles.dart';
import '../../common/styles/text_styles.dart';
import '../../common/validations/auth_validations.dart';
import '../../config/di.dart';
import '../../features/auth/auth_state.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/dto/sign_in_dto.dart';
import '../../features/auth/dto/sign_up_dto.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  FirebaseAuthState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends FirebaseAuthState<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    // _nameController.text = 'John Doe';
    // _usernameController.text = 'johndoe';
    // _passwordController.text = 'password';
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
                loading: () => setState(() => _isLoading = true),
                orElse: () => setState(() => _isLoading = false),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isSignUp ? 'Sign Up' : 'Sign In',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _isSignUp
                          ? TextFormField(
                              style: Theme.of(context).textTheme.bodyText1,
                              controller: _nameController,
                              validator: nameValidation,
                              decoration:
                                  formInputDecoration(labelText: 'Name'),
                            )
                          : Container(),
                      _isSignUp ? const SizedBox(height: 10) : Container(),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: _usernameController,
                        validator: _isSignUp
                            ? usernameValidationSignUp
                            : usernameValidationSignIn,
                        decoration: formInputDecoration(labelText: 'Username'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: _passwordController,
                        validator: _isSignUp ? passwordValidationSignUp : null,
                        obscureText: true,
                        decoration: formInputDecoration(labelText: 'Password'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: !_isLoading
                            ? () {
                                bool isFormValid =
                                    _formKey.currentState!.validate();
                                if (!isFormValid) return;

                                _isSignUp
                                    ? context.read<AuthBloc>().signUp(
                                          SignUpDto(
                                            name: _nameController.text.trim(),
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
                          style: Theme.of(context).textTheme.bodyText1,
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
    GoRouter.of(context).go('/app');
  }
}
