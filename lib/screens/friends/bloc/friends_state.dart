part of 'friends_bloc.dart';

@freezed
class FriendsState with _$FriendsState {
  const factory FriendsState.started() = _Initial;
  const factory FriendsState.loading() = _Loading;
  const factory FriendsState.success({
    User? friend,
  }) = _Success;
  const factory FriendsState.error({
    String? message,
  }) = _Error;
}
