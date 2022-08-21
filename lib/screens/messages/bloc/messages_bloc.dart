import 'package:chat_app/di.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/message/message.dart';
import 'package:chat_app/models/user/user.dart';
import 'package:chat_app/services/message_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages_bloc.freezed.dart';
part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final Reader reader;
  final MessageService service;
  MessagesBloc({required this.service, required this.reader})
      : super(const MessagesState.started()) {
    on<MessagesEvent>((event, state) {
      if (event is MessageSend) return _onCreate(event, state);
      if (event is MessageGetChat) return _onGetChat(event, state);
    });
  }

  void _onCreate(MessageSend event, Emitter<MessagesState> emit) async {
    emit(const MessagesState.loading());
    try {
      await service.sendMessage(event.message);
      emit(const MessagesState.success());
    } catch (e) {
      emit(const MessagesState.error());
    }
  }

  void _onGetChat(MessageGetChat event, Emitter<MessagesState> emit) async {
    emit(const MessagesState.loading());
    try {
      final chat = await service.getChatByParticipants(event.participants);
      if (chat == null) {
        emit(const MessagesState.error());
      }
      final friend = event.participants
          .firstWhere((user) => user.id != reader(currentUserProvider).id);
      emit(MessagesState.success(chat: chat, friend: friend));
    } catch (e) {
      emit(const MessagesState.error());
    }
  }
}
