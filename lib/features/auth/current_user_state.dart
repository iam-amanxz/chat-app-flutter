import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../contact/model/contact.dart';

final currentUserState = StateProvider<AsyncValue<Contact?>>((ref) {
  return const AsyncValue.data(null);
});
