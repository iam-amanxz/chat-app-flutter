import 'package:chat_app/features/message/model/message.dart';
import 'package:intl/intl.dart';

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
