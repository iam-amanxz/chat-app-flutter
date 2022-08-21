import 'package:chat_app/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendService {
  Stream<QuerySnapshot<Map<String, dynamic>>> get stream =>
      FirebaseFirestore.instance.collection('users').snapshots();

  Future<User?> getFriendById(String id) {
    final ref = FirebaseFirestore.instance.collection('users').doc(id);
    return ref.get().then((snapshot) {
      if (snapshot.data() == null) {
        return null;
      }
      return User.fromJson(snapshot.data()!);
    });
  }
}
