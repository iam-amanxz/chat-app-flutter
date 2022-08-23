import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/conversation.dart';

class ConversationService {
  static const currentUserId = 'xxzas';
  final _db = FirebaseFirestore.instance;

  // get realtime conversations for the logged in user
  Stream<List<Conversation>> get myConversations => _db
      .collection('conversations')
      .where('participantIds', arrayContains: currentUserId)
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
