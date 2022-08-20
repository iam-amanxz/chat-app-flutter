import "package:chat_app/models/user/user.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:intl/intl.dart';

import "../message/message.dart";

part "chat.freezed.dart";
part "chat.g.dart";

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String id,
    required List<User> participants,
    // required List<Message> messages,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Chat;

  factory Chat.toDb({
    required List<User> participants,
  }) {
    return Chat(
      id: '_',
      participants: participants,
      // messages: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}

extension JsonToDb on Chat {
  Map<String, dynamic> jsonToDb() => {
        "participants": participants.map((participant) {
          return participant.toJson();
        }).toList(),
      };
}

extension FormatDate on Chat {
  String formattedCreatedAt() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (createdAt.isBefore(today)) {
      return DateFormat.yMMMd().format(createdAt);
    } else {
      return DateFormat.Hm().format(createdAt);
    }
  }
}
