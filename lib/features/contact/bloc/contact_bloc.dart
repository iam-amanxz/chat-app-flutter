// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chat_app/config/di.dart';
import 'package:chat_app/features/contact/contact_exception.dart';
import 'package:chat_app/features/contact/contact_service.dart';
import 'package:chat_app/features/contact/dto/create_contact_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'contact_event.dart';
part 'contact_state.dart';
part 'contact_bloc.freezed.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService service;
  final Logger logger;
  final WidgetRef ref;
  ContactBloc(this.ref)
      : service = ref.read(contactServiceProvider),
        logger = ref.read(loggerProvider),
        super(const ContactState.idle()) {
    on<ContactCreateEvent>(_onCreate);
  }

  Future<void> _onCreate(
      ContactCreateEvent event, Emitter<ContactState> emit) async {
    logger.d('ContactBloc: _onCreate');
    emit(const ContactState.loading());
    try {
      await service.createContact(event.dto);
      emit(const ContactState.success());
      logger.i('ContactBloc: _onCreate : success');
    } catch (e) {
      logger.e('ContactBloc: _onCreate : error : ${e.toString()}');
      emit(const ContactState.error(ContactException.unknown()));
    }
  }

  void createContact(CreateContactDto dto) =>
      add(ContactEvent.create(dto: dto));
}
