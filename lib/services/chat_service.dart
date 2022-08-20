import 'dart:async';

import 'package:chat_app/models/message/message.dart';
import 'package:chat_app/models/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart' as sb;

import '../di.dart';
import '../models/chat/chat.dart';

class ChatService {
  late final Reader reader;
  late final sb.SupabaseClient client;
  late final Stream<List<Chat>> subscription;

  final List<Chat> _chats = [];

  set chats(List<Chat> chats) {
    _chats.clear();
    _chats.addAll(chats);
  }

  List<Chat> get chats => _chats;

  Future<sb.PostgrestResponse<dynamic>> fetchChats() {
    return client.from('chats').select().execute();
  }

  Future<dynamic> createChat(List<User> participants) {
    final json = Chat.toDb(
      participants: participants,
    ).jsonToDb();

    return client
        .from('chats')
        .upsert(
          json,
          returning: sb.ReturningOption.minimal,
        )
        .execute()
        .then((value) => value.data);
  }

  Future<dynamic> sendMessage(Message message) {
    return client
        .from('messages')
        .insert(
          message.jsonToDb(),
          returning: sb.ReturningOption.minimal,
        )
        .execute()
        .then((value) => value.data);
  }

  Stream<List<Message>> messagesSub(String chatId) => client
      .from('messages:chatId=eq.$chatId')
      .stream(['id'])
      .order('createdAt', ascending: true)
      .execute()
      .map((json) {
        List<Message> messages = [];
        for (var message in json) {
          messages.add(Message.fromJson(message));
        }
        print(messages);
        return messages;
      });

  ChatService({required this.reader}) : client = reader(sbClientProvider) {
    subscription = client
        .from('chats')
        .stream(['id'])
        .order('updatedAt')
        .execute()
        .map((json) {
          List<Chat> chats = [];
          for (var chat in json) {
            chats.add(Chat.fromJson(chat));
          }
          return chats;
        });
  }

  Stream<List<Chat>> get chatsStream => subscription;
}
