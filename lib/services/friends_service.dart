import 'package:chat_app/di.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart' show SupabaseClient;

import '../models/user/user.dart';

class FriendsService {
  late final Reader reader;
  late final SupabaseClient client;
  late final Stream<List<User>> subscription;

  FriendsService({required this.reader}) : client = reader(sbClientProvider) {
    subscription =
        client.from('users').stream(['id']).order('name').execute().map((json) {
              List<User> users = [];
              for (var user in json) {
                users.add(User.fromJson(user));
              }
              return users;
            });
  }
}
