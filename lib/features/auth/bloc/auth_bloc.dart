import 'package:bloc/bloc.dart';
import 'package:chat_app/features/auth/current_user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

import '../../../features/auth/auth_exception.dart';
import '../../../features/auth/auth_service.dart';
import '../../../features/auth/dto/create_user_dto.dart';
import '../../../features/auth/dto/sign_in_dto.dart';
import '../../../features/auth/dto/sign_up_dto.dart';
import '../../../features/notification/model/notification.dart';
import '../../../features/notification/notification_service.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService auth;
  final NotificationService notification;
  final Logger logger;
  final Reader reader;

  AuthBloc({
    required this.auth,
    required this.notification,
    required this.logger,
    required this.reader,
  }) : super(const AuthState.idle()) {
    on<AuthSignInEvent>(_onSignIn);
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthCreateUserEvent>(_onCreateUser);
    on<AuthSetCurrentUserEvent>(_onSetCurrentUser);
  }
  Future<void> _onSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    logger.d('AuthBloc: _onSignUp');
    emit(const AuthState.loading());
    try {
      final credentials = await auth.signUp(event.dto);
      emit(const AuthState.success());
      logger.i('AuthBloc: _onSignUp : success');
      add(
        AuthCreateUserEvent(
          dto: CreateUserDto(
            id: credentials.user!.uid,
            name: event.dto.name,
            username: event.dto.username,
          ),
        ),
      );
      add(AuthSetCurrentUserEvent(firebaseUser: credentials.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthState.error(AuthException.fromFirebase(e)));
      notification.add(Notification.signupFailed(e.message));
      logger.e('AuthBloc: _onSignUp : error : ${e.toString()}');
    } catch (e) {
      emit(const AuthState.error(AuthException.unknown()));
      notification.add(Notification.signupFailed());
      logger.e('AuthBloc: _onSignUp : error : ${e.toString()}');
    }
  }

  Future<void> _onSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    logger.d('AuthBloc: _onSignIn');
    emit(const AuthState.loading());
    try {
      final credentials = await auth.signIn(event.dto);
      emit(const AuthState.success());
      logger.i('AuthBloc: _onSignIn : success');
      add(AuthSetCurrentUserEvent(firebaseUser: credentials.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthState.error(AuthException.fromFirebase(e)));
      notification.add(Notification.signInFailed(e.message));
      logger.e('AuthBloc: _onSignIn : error : ${e.toString()}');
    } catch (e) {
      emit(const AuthState.error(AuthException.unknown()));
      notification.add(Notification.signInFailed());
      logger.e('AuthBloc: _onSignIn : error : ${e.toString()}');
    }
  }

  Future<void> _onCreateUser(
      AuthCreateUserEvent event, Emitter<AuthState> emit) async {
    logger.d('AuthBloc: _onCreateUser');
    emit(const AuthState.loading());
    try {
      await auth.createUser(event.dto);
      emit(const AuthState.success());
      notification.add(Notification.userCreated());
      logger.i('AuthBloc: _onCreate : _onCreateUser');
    } catch (e) {
      logger.e('AuthBloc: _onCreate : _onCreateUser : ${e.toString()}');
      notification.add(Notification.userCreateFailed());
      emit(const AuthState.error(AuthException.unknown()));
    }
  }

  Future<void> _onSetCurrentUser(
      AuthSetCurrentUserEvent event, Emitter<AuthState> emit) async {
    logger.d('AuthBloc: _onSetCurrentUser');
    emit(const AuthState.loading());
    try {
      reader(currentUserState.notifier).state = const AsyncValue.loading();
      final currentUser = await auth.getCurrentUser(event.firebaseUser);
      if (currentUser == null) {
        reader(currentUserState.notifier).state =
            const AsyncValue.error('User not found');
        throw 'User not found';
      }
      emit(const AuthState.success());
      logger.i('AuthBloc: _onSetCurrentUser : success');
      reader(currentUserState.notifier).state = AsyncValue.data(currentUser);
    } catch (e) {
      if (e == 'User not found') {
        notification.add(Notification.userNotFound());
      }
      emit(const AuthState.error(AuthException.unknown()));
      notification.add(Notification.genericAuthError());
      logger.e('AuthBloc: _onSetCurrentUser : error : ${e.toString()}');
    }
  }

  void signUp(SignUpDto dto) => add(AuthEvent.signUp(dto: dto));
  void signIn(SignInDto dto) => add(AuthEvent.signIn(dto: dto));
  void createUser(CreateUserDto dto) => add(AuthEvent.createUser(dto: dto));
  void setCurrentUser(User firebaseUser) =>
      add(AuthEvent.setCurrentUser(firebaseUser: firebaseUser));
}
