import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/chat_service.dart';
import 'services/friends_service.dart';
import 'services/message_service.dart';

final chatsServiceProvider = Provider<ChatService>((ref) => ChatService());
final friendServiceProvider = Provider<FriendService>((ref) => FriendService());
final messageServiceProvider =
    Provider<MessageService>((ref) => MessageService());
