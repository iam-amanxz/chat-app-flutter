part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signIn({required SignInDto dto}) = AuthSignInEvent;
  const factory AuthEvent.signUp({required SignUpDto dto}) = AuthSignUpEvent;
  const factory AuthEvent.setCurrentUser({required User firebaseUser}) =
      AuthSetCurrentUserEvent;
}
