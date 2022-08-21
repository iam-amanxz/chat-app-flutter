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
      if (event is ChatsCreate) return _onCreate(event, state);
      if (event is GetChatByParticipants) {
        return _onGetByParticipants(event, state);
      }
    });
  }

  void _onCreate(ChatsCreate event, Emitter<ChatsState> emit) async {
    emit(const ChatsState.loading());
    try {
      await service.createChat(event.participants);
      emit(const ChatsState.success());
    } catch (e) {
      print(e);
      emit(const ChatsState.error());
    }
  }

  void _onGetByParticipants(
      GetChatByParticipants event, Emitter<ChatsState> emit) async {
    emit(const ChatsState.loading());
    try {
      final chat = await service.getChatByParticipants(event.participants);
      if (chat == null) {
        emit(const ChatsState.error(message: "Chat not found"));
      }
      emit(ChatsState.success(chat: chat));
    } catch (e) {
      print(e);
      emit(ChatsState.error(message: "Something went wrong: ${e.toString()}"));
    }
  }
}
