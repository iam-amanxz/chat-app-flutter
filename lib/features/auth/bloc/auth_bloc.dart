// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chat_app/config/di.dart';
import 'package:chat_app/features/auth/auth_exception.dart';
import 'package:chat_app/features/auth/auth_service.dart';
import 'package:chat_app/features/auth/dto/sign_in_dto.dart';
import 'package:chat_app/features/auth/dto/sign_up_dto.dart';
import 'package:chat_app/features/contact/model/contact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import '../../contact/model/contact.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService service;
  final WidgetRef ref;
  final Logger logger;

  AuthBloc(this.ref)
      : service = ref.read(authServiceProvider),
        logger = ref.read(loggerProvider),
        super(const AuthState.idle()) {
    on<AuthSignInEvent>(_onSignIn);
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthSetCurrentUserEvent>(_onSetCurrentUser);
  }
  Future<void> _onSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    logger.d('AuthBloc: _onSignUp');
    emit(const AuthState.loading());
    try {
      final credentials = await service.signUp(event.dto);
      emit(AuthState.success(
          firebaseUser: credentials.user, flag: AuthSuccessFlag.signUp));
      logger.i('AuthBloc: _onSignUp : success');
    } on FirebaseAuthException catch (e) {
      emit(AuthState.error(AuthException.fromFirebase(e)));
      logger.e('AuthBloc: _onSignUp : error : ${e.toString()}');
    } catch (e) {
      emit(const AuthState.error(AuthException.unknown()));
      logger.e('AuthBloc: _onSignUp : error : ${e.toString()}');
    }
  }

  Future<void> _onSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    logger.d('AuthBloc: _onSignIn');
    emit(const AuthState.loading());
    try {
      final credentials = await service.signIn(event.dto);
      emit(AuthState.success(
          firebaseUser: credentials.user, flag: AuthSuccessFlag.signIn));
      logger.i('AuthBloc: _onSignIn : success');
    } on FirebaseAuthException catch (e) {
      emit(AuthState.error(AuthException.fromFirebase(e)));
      logger.e('AuthBloc: _onSignIn : error : ${e.toString()}');
    } catch (e) {
      emit(const AuthState.error(AuthException.unknown()));
      logger.e('AuthBloc: _onSignIn : error : ${e.toString()}');
    }
  }

  Future<void> _onSetCurrentUser(
      AuthSetCurrentUserEvent event, Emitter<AuthState> emit) async {
    logger.d('AuthBloc: _onSetCurrentUser');
    emit(const AuthState.loading());
    try {
      final currentUser = await service.getCurrentUser(event.firebaseUser);
      emit(
        AuthState.success(
          currentUser: currentUser,
          flag: AuthSuccessFlag.setCurrentUser,
        ),
      );
      logger.i('AuthBloc: _onSetCurrentUser : success');
    } catch (e) {
      emit(const AuthState.error(AuthException.unknown()));
      logger.e('AuthBloc: _onSetCurrentUser : error : ${e.toString()}');
    }
  }

  void signUp(SignUpDto dto) => add(AuthEvent.signUp(dto: dto));
  void signIn(SignInDto dto) => add(AuthEvent.signIn(dto: dto));
  void setCurrentUser(User firebaseUser) =>
      add(AuthEvent.setCurrentUser(firebaseUser: firebaseUser));
}
