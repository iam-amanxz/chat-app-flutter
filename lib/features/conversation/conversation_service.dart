import 'package:chat_app/features/auth/current_user_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/conversation.dart';

class ConversationService {
  final FirebaseFirestore _db;
  final Reader _reader;

  ConversationService({required FirebaseFirestore db, required Reader reader})
      : _db = db,
        _reader = reader;
  // get realtime conversations for the logged in user
  Stream<List<Conversation>> get myConversations => _db
      .collection('conversations')
      .where('participantIds',
          arrayContains: _reader(currentUserState).value!.id)
      .orderBy('updatedAt')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Conversation.fromJson(doc.data()))
          .toList());

  // create a new conversation
  Future<void> createConversation(List<String> participantIds) async {
    final ref = _db.collection('conversations').doc();
    final conversation = Conversation(
      id: ref.id,
      participantIds: participantIds,
      updatedAt: DateTime.now(),
    );
    await ref.set(conversation.toJson());
  }

  // update conversation updatedAt
  Future<void> updateUpdatedAt(String conversationId) async {
    await _db.collection('conversations').doc(conversationId).update({
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }
}
