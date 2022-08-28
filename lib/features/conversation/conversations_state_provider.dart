import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/conversation.dart';

final conversationsState = StateProvider<AsyncValue<List<Conversation>>>((ref) {
  return const AsyncValue.data([]);
});
