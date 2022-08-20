// ignore: depend_on_referenced_packages

import 'package:chat_app/models/message/message.dart';
import 'package:chat_app/services/message_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages_bloc.freezed.dart';
part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessageService service;
  MessagesBloc({required this.service}) : super(const MessagesState.started()) {
    on<MessagesEvent>((event, state) {
      if (event is MessageSend) return _onCreate(event, state);
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
}
