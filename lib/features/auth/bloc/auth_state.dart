part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.idle() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success({
    required AuthSuccessFlag flag,
    User? firebaseUser,
    Contact? currentUser,
  }) = _Success;
  const factory AuthState.error(AuthException exception) = _Error;
}

enum AuthSuccessFlag {
  signIn,
  signUp,
  setCurrentUser,
}
