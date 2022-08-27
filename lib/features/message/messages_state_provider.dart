import 'package:chat_app/features/message/model/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagesState = StateProvider<AsyncValue<List<Message>>>((ref) {
  return const AsyncValue.data([]);
});
