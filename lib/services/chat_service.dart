import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat/chat.dart';
import '../models/user/user.dart';

class ChatService {
  Future<Chat?> getChatByParticipants(List<User> participants) {
    final json = [];
    for (var participant in participants) {
      json.add(participant.toJson());
    }
    final chatRef = FirebaseFirestore.instance.collection('chats');
    final query = chatRef.where('participants', arrayContainsAny: json);
    return query.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return Chat.fromJson(snapshot.docs.first.data());
      } else {
        return null;
      }
    });
  }

  Future<void> createChat(List<User> participants) async {
    final chatRef = FirebaseFirestore.instance.collection('chats');
    final snapshot = await chatRef.get();
    final exists = snapshot.docs.any((doc) {
      final chat = Chat.fromJson(doc.data());
      return chat.participants.every((p) => participants.contains(p));
    });

    if (exists) {
      return;
    }

    final ref = FirebaseFirestore.instance.collection('chats').doc();
    final chat = Chat.toDb(
      participants: participants,
    );

    return ref.set({
      ...chat.jsonToDb(),
      "id": ref.id,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get stream =>
      FirebaseFirestore.instance
          .collection('chats')
          .orderBy('updatedAt')
          .snapshots();
}
