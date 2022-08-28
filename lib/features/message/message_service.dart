import '../auth/current_user_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dto/send_message_dto.dart';
import 'model/message.dart';

class MessageService {
  final FirebaseFirestore _db;
  final Reader _reader;

  MessageService({required FirebaseFirestore db, required Reader reader})
      : _db = db,
        _reader = reader;

  Stream<List<Message>> getMessages(String conversationId) => _db
      .collection('messages')
      .where('conversationId', isEqualTo: conversationId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList());

  Future<void> sendMessage(SendMessageDto dto) async {
    final ref = _db.collection('messages').doc();
    final message = Message(
      id: ref.id,
      conversationId: dto.conversationId,
      content: dto.content,
      senderId: _reader(currentUserState).value!.id,
      receiverId: dto.receiverId,
      createdAt: DateTime.now(),
    );
    await ref.set(message.toJson());
    await updateConversation(dto.conversationId, message);
  }

  Future<void> updateConversation(
      String conversationId, Message lastMessage) async {
    await _db.collection('conversations').doc(conversationId).update({
      'lastMessage': lastMessage.toJson(),
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }
}
