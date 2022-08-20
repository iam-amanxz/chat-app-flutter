part of 'chats_bloc.dart';

@immutable
abstract class ChatsEvent {}

class ChatsStarted extends ChatsEvent {}

class ChatsFetch extends ChatsEvent {}

class ChatsCreate extends ChatsEvent {
  final List<User> participants;
  ChatsCreate({required this.participants});
}
