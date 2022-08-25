import 'dart:async';
import 'dart:io';

import 'package:chat_app/features/auth/dto/create_user_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/contact/model/contact.dart';
import 'dto/sign_in_dto.dart';
import 'dto/sign_up_dto.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  AuthService(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage})
      : _auth = auth,
        _db = db,
        _storage = storage;

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

  Future<void> createUser(CreateUserDto dto) async {
    final ref = _db.collection('contacts').doc(dto.id);
    final contact = Contact(
      id: dto.id,
      username: dto.username,
      name: dto.name,
    );
    await ref.set(contact.toJson());
  }

  Future<Contact?> updateUser(Contact dto) async {
    final ref = _db.collection('contacts').doc(dto.id);
    await ref.update(dto.toJson());
    final doc = await ref.get();
    final data = doc.data();
    if (data != null) {
      final contact = Contact.fromJson(data);
      return contact;
    }
    return null;
  }

  Future<String> uploadProfilePhoto(XFile file) async {
    Reference ref = _storage.ref().child('profile-pics').child(file.name);

    if (kIsWeb) {
      await ref.putFile(File(file.path));
    } else {
      await ref.putData(await file.readAsBytes());
    }

    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }
}
