import 'package:bloc/bloc.dart';
import 'package:chat_app/features/contact/model/contact.dart';
import 'package:chat_app/features/message/dto/send_message_dto.dart';
import 'package:chat_app/features/message/message_service.dart';
import 'package:chat_app/features/message/messages_state_provider.dart';
import 'package:chat_app/features/message/model/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

import '../../../features/notification/notification_service.dart';
import '../../notification/model/notification.dart';
import '../message_exception.dart';

part 'message_bloc.freezed.dart';
part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageService service;
  final Logger logger;
  final Reader reader;
  final NotificationService notification;

  MessageBloc({
    required this.service,
    required this.notification,
    required this.logger,
    required this.reader,
  }) : super(const MessageState.idle()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessagesEvent>(_onSendMessage);
  }

  Future<void> _onLoadMessages(
      LoadMessagesEvent event, Emitter<MessageState> emit) async {
    logger.d('MessageBloc: _onLoadMessages');
    emit(const MessageState.loading());
    try {
      service.getMessages(event.conversationId).listen((event) {
        print('HELLOOOO');
        reader(messagesState.notifier).state = AsyncValue.data(event);
      });
      emit(const MessageState.success());
      logger.i('MessageBloc: _onLoadMessages : success');
    } catch (e) {
      emit(const MessageState.error(MessageException.unknown()));
      notification.add(Notification.loadMessagesFailed());
      logger.e('AuthBloc: _onLoadMessages : error : ${e.toString()}');
    }
  }

  Future<void> _onSendMessage(
      SendMessagesEvent event, Emitter<MessageState> emit) async {
    logger.d('MessageBloc: _onSendMessage');
    emit(const MessageState.loading());
    try {
      service.sendMessage(event.dto);
      emit(const MessageState.success());
      logger.i('MessageBloc: _onSendMessage : success');
    } catch (e) {
      emit(const MessageState.error(MessageException.unknown()));
      notification.add(Notification.sendMessageFailed());
      logger.e('AuthBloc: _onSendMessage : error : ${e.toString()}');
    }
  }

  void loadMessages(String conversationId) =>
      add(MessageEvent.loadMessages(conversationId: conversationId));

  void sendMessage(SendMessageDto dto) =>
      add(MessageEvent.sendMessage(dto: dto));
}
