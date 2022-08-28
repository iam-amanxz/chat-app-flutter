import 'package:freezed_annotation/freezed_annotation.dart';

import '../../contact/model/contact.dart';
import '../../message/model/message.dart';

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
