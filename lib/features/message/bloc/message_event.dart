part of 'message_bloc.dart';

@freezed
class MessageEvent with _$MessageEvent {
  const factory MessageEvent.loadMessages({required String conversationId}) =
      LoadMessagesEvent;
  const factory MessageEvent.sendMessage({required SendMessageDto dto}) =
      SendMessagesEvent;
}
