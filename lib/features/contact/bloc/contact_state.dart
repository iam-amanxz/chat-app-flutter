part of 'contact_bloc.dart';

@freezed
class ContactState with _$ContactState {
  const factory ContactState.idle() = _Initial;
  const factory ContactState.loading() = _Loading;
  const factory ContactState.success() = _Success;
  const factory ContactState.error(ContactException exception) = _Error;
}
