part of 'conversation_bloc.dart';

@freezed
class ConversationEvent with _$ConversationEvent {
  const factory ConversationEvent.loadConversations() = LoadConversationsEvent;
  const factory ConversationEvent.createConversation(
      {required List<Contact> participants}) = CreateConversationsEvent;
}
