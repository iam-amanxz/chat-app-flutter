import 'package:chat_app/services/friends_service.dart';
import 'package:chat_app/services/message_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart' as sb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/chat_service.dart';

final chatsProvider =
    Provider<ChatService>((ref) => ChatService(reader: ref.read));
final currentIndexProvider = StateProvider<int>(
  (ref) => 0,
);
final friendsProvider =
    Provider<FriendsService>((ref) => FriendsService(reader: ref.read));
final messageProvider =
    Provider<MessageService>((ref) => MessageService(reader: ref.read));
final sbClientProvider = Provider<sb.SupabaseClient>((ref) {
  String url = dotenv.get('SUPBASE_URL');
  String key = dotenv.get('SUPBASE_KEY');
  return sb.SupabaseClient(url, key);
});
