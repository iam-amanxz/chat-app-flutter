part of 'chats_bloc.dart';

@freezed
class ChatsState with _$ChatsState {
  const factory ChatsState.started() = _Initial;
  const factory ChatsState.loading() = _Loading;
  const factory ChatsState.success({Chat? chat}) = _Success;
  const factory ChatsState.error({String? message}) = _Error;
}
