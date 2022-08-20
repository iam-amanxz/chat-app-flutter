import 'package:cloud_firestore/cloud_firestore.dart';

class FriendService {
  Stream<QuerySnapshot<Map<String, dynamic>>> get stream =>
      FirebaseFirestore.instance.collection('users').snapshots();
}
