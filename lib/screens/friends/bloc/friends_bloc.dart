// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/friends_service.dart';

part 'friends_bloc.freezed.dart';
part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final FriendService service;
  FriendsBloc({required this.service}) : super(const FriendsState.started()) {
    on<FriendsEvent>((event, emit) {
      if (event is GetFriend) return _onGetFriend(event, emit);
    });
  }

  void _onGetFriend(GetFriend event, Emitter<FriendsState> emit) async {
    emit(const FriendsState.loading());

    try {
      final friend = await service.getFriendById(event.friendId);
      if (friend == null) {
        emit(const FriendsState.error(message: "Friend not found"));
      } else {
        emit(FriendsState.success(friend: friend));
      }
    } catch (e) {
      emit(
        FriendsState.error(message: "Something went wrong: ${e.toString()}"),
      );
    }
  }
}
