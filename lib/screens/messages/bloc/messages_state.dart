part of 'messages_bloc.dart';

@freezed
class MessagesState with _$MessagesState {
  const factory MessagesState.started() = _Initial;
  const factory MessagesState.loading() = _Loading;
  const factory MessagesState.success({
    User? friend,
    Chat? chat,
  }) = _Success;
  const factory MessagesState.error() = _Error;
}
