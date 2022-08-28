import 'model/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagesState = StateProvider<AsyncValue<List<Message>>>((ref) {
  return const AsyncValue.data([]);
});
