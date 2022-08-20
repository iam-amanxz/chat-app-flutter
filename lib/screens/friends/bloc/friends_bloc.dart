// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/friends_service.dart';

part 'friends_bloc.freezed.dart';
part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final FriendsService service;
  FriendsBloc({required this.service}) : super(const FriendsState.started()) {
    on<FriendsEvent>((event, emit) {
      if (event is FriendsStarted) return _onStarted(event, emit);
    });
  }

  void _onStarted(FriendsStarted event, Emitter<FriendsState> emit) async {
    emit(const FriendsState.loading());
    emit(FriendsState.success(friends: service.subscription));
  }
}
