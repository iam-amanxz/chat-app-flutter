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
}
