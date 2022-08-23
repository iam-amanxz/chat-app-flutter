import 'package:cloud_firestore/cloud_firestore.dart';

import 'dto/send_message_dto.dart';
import 'model/message.dart';

class ConversationService {
  static const currentUserId = 'xxzas';
  final _db = FirebaseFirestore.instance;

  // get realtime messages for the conversation
  Stream<List<Message>> getMessages(String conversationId) => _db
      .collection('messages')
      .where('conversationId', isEqualTo: conversationId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList());

  // create a new conversation
  Future<void> sendMessage(SendMessageDto data) async {
    final ref = _db.collection('messages').doc();
    final message = Message(
      id: ref.id,
      conversationId: data.conversationId,
      content: data.content,
      senderId: currentUserId,
      receiverId: data.receiverId,
      createdAt: DateTime.now(),
    );
    await ref.set(message.toJson());
  }

  // update conversation updatedAt
  Future<void> updateUpdatedAt(String conversationId) async {
    await _db.collection('conversations').doc(conversationId).update({
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }
}
