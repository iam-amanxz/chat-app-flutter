import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

import '../../../features/contact/contact_exception.dart';
import '../../../features/contact/contact_service.dart';
import '../../../features/notification/notification_service.dart';
import '../../notification/model/notification.dart';
import 'contacts_state_provider.dart';

part 'contact_bloc.freezed.dart';
part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService contact;
  final Logger logger;
  final Reader reader;
  final NotificationService notification;

  ContactBloc({
    required this.contact,
    required this.notification,
    required this.logger,
    required this.reader,
  }) : super(const ContactState.idle()) {
    on<LoadContactsEvent>(_onLoadContacts);
  }

  Future<void> _onLoadContacts(
      LoadContactsEvent event, Emitter<ContactState> emit) async {
    logger.d('ContactBloc: _onLoadContacts');
    emit(const ContactState.loading());
    try {
      final contacts = await contact.contacts;
      reader(contactsState.notifier).state = AsyncValue.data(contacts);
      emit(const ContactState.success());
      logger.i('ContactBloc: _onLoadContacts : success');
    } catch (e) {
      emit(const ContactState.error(ContactException.unknown()));
      notification.add(Notification.loadContactsFailed());
      logger.e('AuthBloc: _onSignUp : error : ${e.toString()}');
    }
  }

  void loadContacts() => add(const ContactEvent.loadContacts());
}
