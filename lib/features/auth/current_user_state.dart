import 'package:chat_app/config/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../contact/model/contact.dart';

final currentUserState = StateProvider.autoDispose<AsyncValue<Contact?>>((ref) {
  ref.onDispose(() {
    ref.read(loggerProvider).d('currentUserState: disposing');
  });
  return const AsyncValue.data(null);
});
