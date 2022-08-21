import 'package:chat_app/models/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/chat_service.dart';
import 'services/friends_service.dart';
import 'services/message_service.dart';

final chatsServiceProvider = Provider<ChatService>((ref) => ChatService());
final friendServiceProvider = Provider<FriendService>((ref) => FriendService());
final messageServiceProvider =
    Provider<MessageService>((ref) => MessageService());

const authUser1 = User(
  id: "rwNDeCjUmrfORKjnzZIO",
  username: 'amanxz',
  name: 'Husnul Aman',
  email: 'amanxz@gmail.com',
);
const authUser2 = User(
  id: " YmShkMEJpSVpAduF31ox",
  username: 'leaxx_32',
  name: 'Leanne Graham',
  email: 'Sincere@april.biz',
);
final currentUserProvider = StateProvider<User>((ref) => authUser1);
