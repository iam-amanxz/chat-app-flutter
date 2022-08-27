part of 'conversation_bloc.dart';

@freezed
class ConversationState with _$ConversationState {
  const factory ConversationState.idle() = _Initial;
  const factory ConversationState.loading() = _Loading;
  const factory ConversationState.success() = _Success;
  const factory ConversationState.error(ConversationException exception) =
      _Error;
}
