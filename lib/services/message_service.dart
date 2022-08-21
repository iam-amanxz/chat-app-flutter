import 'dart:async';

import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/user/user.dart';
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

  Future<Chat?> getChatByParticipants(List<User> participants) {
    final json = [];
    for (var participant in participants) {
      json.add(participant.toJson());
    }
    final chatRef = FirebaseFirestore.instance.collection('chats');
    return chatRef
        .where('participants', arrayContainsAny: json)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return Chat.fromJson(snapshot.docs.first.data());
      } else {
        return null;
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> stream(String chatId) =>
      FirebaseFirestore.instance
          .collection('messages')
          .where('chatId', isEqualTo: chatId)
          .orderBy('createdAt', descending: true)
          .snapshots();
}
