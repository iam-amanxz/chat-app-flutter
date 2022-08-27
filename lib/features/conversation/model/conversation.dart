import 'package:chat_app/features/contact/model/contact.dart';
import 'package:chat_app/features/message/model/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required List<Contact> participants,
    required DateTime updatedAt,
    Message? lastMessage,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
