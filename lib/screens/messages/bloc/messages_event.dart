part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent {}

class MessageCreate extends MessagesEvent {
  final Message message;
  MessageCreate({required this.message});
}
