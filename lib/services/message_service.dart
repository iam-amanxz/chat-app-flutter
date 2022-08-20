import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message/message.dart';

class MessageService {
  MessageService();

  Future<void> sendMessage(Message message) {
    final ref = FirebaseFirestore.instance.collection('messages').doc();

    return ref.set({
      ...message.jsonToDb(),
      "id": ref.id,
      "createdAt": DateTime.now().toIso8601String(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> stream(String chatId) =>
      FirebaseFirestore.instance
          .collection('messages')
          .where('chatId', isEqualTo: chatId)
          .orderBy('createdAt', descending: true)
          .snapshots();
}
