import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

import '../../../features/notification/notification_service.dart';
import '../../notification/model/notification.dart';
import '../conversation_exception.dart';
import '../conversation_service.dart';
import 'conversations_state_provider.dart';

part 'conversation_bloc.freezed.dart';
part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationService service;
  final Logger logger;
  final Reader reader;
  final NotificationService notification;

  ConversationBloc({
    required this.service,
    required this.notification,
    required this.logger,
    required this.reader,
  }) : super(const ConversationState.idle()) {
    on<LoadConversationsEvent>(_onLoadConversations);
  }

  Future<void> _onLoadConversations(
      LoadConversationsEvent event, Emitter<ConversationState> emit) async {
    logger.d('ContactBloc: _onLoadConversations');
    emit(const ConversationState.loading());
    try {
      service.myConversations.listen((event) {
        reader(conversationsState.notifier).state = AsyncValue.data(event);
      });
      emit(const ConversationState.success());
      logger.i('ContactBloc: _onLoadConversations : success');
    } catch (e) {
      emit(const ConversationState.error(ConversationException.unknown()));
      notification.add(Notification.loadConversationsFailed());
      logger.e('AuthBloc: _onLoadConversations : error : ${e.toString()}');
    }
  }

  void loadConversations() => add(const ConversationEvent.loadConversations());
}
