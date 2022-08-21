part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent {}

class MessageSend extends MessagesEvent {
  final Message message;
  MessageSend({required this.message});
}

class MessageGetChat extends MessagesEvent {
  final List<User> participants;
  MessageGetChat({required this.participants});
}
