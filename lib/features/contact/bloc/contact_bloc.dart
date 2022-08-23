import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

import '../../../features/contact/contact_exception.dart';
import '../../../features/contact/contact_service.dart';
import '../../../features/notification/notification_service.dart';

part 'contact_bloc.freezed.dart';
part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService contact;
  final Logger logger;
  final NotificationService notification;

  ContactBloc({
    required this.contact,
    required this.notification,
    required this.logger,
  }) : super(const ContactState.idle()) {}
}
