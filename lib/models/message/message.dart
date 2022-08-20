import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String content,
    required String senderId,
    required String chatId,
    required DateTime createdAt,
  }) = _Message;

  factory Message.toDb({
    required String chatId,
    required String content,
    required String senderId,
  }) {
    return Message(
      id: '_',
      chatId: chatId,
      content: content,
      senderId: senderId,
      createdAt: DateTime.now(),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

extension JsonToDb on Message {
  Map<String, dynamic> jsonToDb() => {
        "chatId": chatId,
        "content": content,
        "senderId": senderId,
      };
}

extension FormatMessage on Message {
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
