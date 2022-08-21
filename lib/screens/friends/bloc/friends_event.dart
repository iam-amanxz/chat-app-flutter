part of 'friends_bloc.dart';

@immutable
abstract class FriendsEvent {}

class FriendsStarted extends FriendsEvent {}

class GetFriend extends FriendsEvent {
  final String friendId;
  GetFriend({required this.friendId});
}
