import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/contact/model/contact.dart';
import 'dto/sign_in_dto.dart';
import 'dto/sign_up_dto.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signIn(SignInDto dto) async {
    final email = '${dto.username}@gmail.com';
    final credentials = await _auth.signInWithEmailAndPassword(
      email: email,
      password: dto.password,
    );
    return credentials;
  }

  Future<UserCredential> signUp(SignUpDto dto) async {
    final email = '${dto.username}@gmail.com';
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: dto.password,
    );
    return credentials;
  }

  Future<Contact?> getCurrentUser(User user) async {
    final ref = FirebaseFirestore.instance.collection('contacts').doc(user.uid);
    final doc = await ref.get();
    final data = doc.data();
    if (data != null) {
      final contact = Contact.fromJson(data);
      return contact;
    }
    return null;
  }
}
