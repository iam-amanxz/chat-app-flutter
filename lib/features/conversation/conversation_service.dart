import 'package:chat_app/features/auth/current_user_state.dart';
import 'package:chat_app/features/contact/model/contact.dart';
import 'package:chat_app/features/message/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/conversation.dart';

class ConversationService {
  final FirebaseFirestore _db;
  final Reader _reader;

  ConversationService({required FirebaseFirestore db, required Reader reader})
      : _db = db,
        _reader = reader;

  Stream<List<Conversation>> get myConversations => _db
      .collection('conversations')
      .where('participants',
          arrayContains: _reader(currentUserState).value!.toJson())
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => Conversation.fromJson(doc.data()))
            .toList(),
      );

  Future<void> createConversation(List<Contact> participants) async {
    final oldRef = _db.collection('conversations');

    final snapshot = await oldRef.get();
    final exists = snapshot.docs.any((doc) {
      final chat = Conversation.fromJson(doc.data());
      return chat.participants.every((p) => participants.contains(p));
    });

    if (exists) {
      debugPrint('Conversation Exists');
      return;
    }

    final ref = _db.collection('conversations').doc();
    final conversation = Conversation(
      id: ref.id,
      participants: participants,
      updatedAt: DateTime.now(),
    );
    print(conversation.toJson());
    await ref.set(conversation.toJson());
  }

  Future<Conversation?> getConversationByParticipants(
      List<Contact> participants) async {
    final ref = _db.collection('conversations');
    final query = ref.where('participants', isEqualTo: participants);
    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      return Conversation.fromJson(snapshot.docs.first.data());
    } else {
      return null;
    }
  }
}
