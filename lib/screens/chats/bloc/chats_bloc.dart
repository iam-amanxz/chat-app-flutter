// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/user/user.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/chat_service.dart';

part 'chats_bloc.freezed.dart';
part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatService service;
  ChatsBloc({required this.service}) : super(const ChatsState.started()) {
    on<ChatsEvent>((event, state) {
      if (event is ChatsFetch) return _onFetch(event, state);
      if (event is ChatsCreate) return _onCreate(event, state);
    });
  }

  void _onFetch(ChatsFetch event, Emitter<ChatsState> emit) async {
    emit(const ChatsState.loading());
    try {
      final response = await service.fetchChats();

      List<Chat> chats = [];
      for (var chat in response.data) {
        chats.add(Chat.fromJson(chat));
      }
      emit(ChatsState.success(type: ChatSuccessType.fetch, chats: chats));
    } catch (e) {
      print(e);
      emit(const ChatsState.error());
    }
  }

  void _onCreate(ChatsCreate event, Emitter<ChatsState> emit) async {
    emit(const ChatsState.loading());
    try {
      await service.createChat(event.participants);
      emit(const ChatsState.success(
        type: ChatSuccessType.create,
      ));
      add(ChatsFetch());
    } catch (e) {
      print(e);
      emit(const ChatsState.error());
    }
  }
}
