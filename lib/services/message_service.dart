import 'dart:async';

import 'package:chat_app/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart' as sb;

import '../models/message/message.dart';

class MessageService {
  final Reader reader;
  final sb.SupabaseClient client;

  MessageService({required this.reader}) : client = reader(sbClientProvider) {
    client.from('messages').on(sb.SupabaseEventTypes.all, (payload) {
      print(payload.newRecord);
    }).subscribe();
  }
  Future<dynamic> sendMessage(Message message) {
    return client
        .from('messages')
        .upsert(
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
        return messages;
      });
}
