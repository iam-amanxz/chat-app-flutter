part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signIn({required SignInDto dto}) = AuthSignInEvent;
  const factory AuthEvent.signUp({required SignUpDto dto}) = AuthSignUpEvent;
  const factory AuthEvent.signOut() = AuthSignOutEvent;
  const factory AuthEvent.createUser({required CreateUserDto dto}) =
      AuthCreateUserEvent;
  const factory AuthEvent.setCurrentUser({required User firebaseUser}) =
      AuthSetCurrentUserEvent;
  const factory AuthEvent.updateCurrentUser({required Contact user}) =
      AuthUpdateCurrentUserEvent;
  const factory AuthEvent.updateProfilePhoto({required XFile image}) =
      AuthUpdateProfilePhotoEvent;
}
