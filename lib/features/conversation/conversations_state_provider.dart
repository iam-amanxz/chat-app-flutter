import 'package:chat_app/features/conversation/model/conversation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final conversationsState = StateProvider<AsyncValue<List<Conversation>>>((ref) {
  return const AsyncValue.data([]);
});
