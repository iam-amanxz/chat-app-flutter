import 'package:firebase_auth/firebase_auth.dart';

Map<String, AuthException> firebaseAuthErrorMapping = {
  'email-already-in-use': const AuthException.usernameAlreadyInUse(),
  'invalid-email': const AuthException.invalidUsername(),
  'weak-password': const AuthException.weakPassword(),
  'user-not-found': const AuthException.userNotFound(),
  'wrong-password': const AuthException.wrongPassword(),
};

class AuthException {
  final String title;
  final String description;
  const AuthException.unknown()
      : title = 'Unknown Error',
        description = 'An unknown error has occurred';
  const AuthException.usernameAlreadyInUse()
      : title = 'Username already in use',
        description = 'Please choose another username to register with';
  const AuthException.invalidUsername()
      : title = 'Invalid username',
        description = 'Please double check your username and try again';
  const AuthException.weakPassword()
      : title = 'Weak password',
        description =
            'Please choose a stronger password consisting of more characters';
  const AuthException.userNotFound()
      : title = 'User not found',
        description = 'The given user was not found';
  const AuthException.wrongPassword()
      : title = 'Wrong password',
        description = 'Please enter the valid password';

  factory AuthException.fromFirebase(FirebaseAuthException exception) =>
      firebaseAuthErrorMapping[exception.code] ?? const AuthException.unknown();
}
