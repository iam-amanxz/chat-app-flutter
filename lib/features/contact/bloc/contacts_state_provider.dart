import 'package:chat_app/config/di.dart';
import 'package:chat_app/features/contact/model/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsState = StateProvider<AsyncValue<List<Contact>>>((ref) {
  ref.onDispose(() {
    ref.read(loggerProvider).d('contactsState: disposing');
  });
  return const AsyncValue.data([]);
});
