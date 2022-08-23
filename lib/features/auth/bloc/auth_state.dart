part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.idle() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success() = _Success;
  const factory AuthState.error(AuthException exception) = _Error;
}

enum AuthSuccessFlag {
  signIn,
  signUp,
  createUser,
  setCurrentUser,
}
