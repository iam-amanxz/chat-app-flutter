part of 'chats_bloc.dart';

@freezed
class ChatsState with _$ChatsState {
  const factory ChatsState.started() = _Initial;
  const factory ChatsState.loading() = _Loading;
  const factory ChatsState.success({
    required ChatSuccessType type,
    List<Chat>? chats,
  }) = _Success;
  const factory ChatsState.error() = _Error;
}

enum ChatSuccessType {
  fetch,
  create,
}
