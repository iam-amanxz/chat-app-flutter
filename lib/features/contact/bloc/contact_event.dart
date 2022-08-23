part of 'contact_bloc.dart';

@freezed
class ContactEvent with _$ContactEvent {
  const factory ContactEvent.create({required CreateContactDto dto}) =
      ContactCreateEvent;
}
