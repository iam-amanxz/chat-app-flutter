import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../features/auth/auth_service.dart';
import '../features/contact/contact_service.dart';
import '../features/contact/model/contact.dart';
import '../features/notification/notification_service.dart';

final currentUserProvider = StateProvider<Contact?>((ref) {
  return null;
});
final authServiceProvider = Provider((ref) {
  return AuthService();
});
final contactServiceProvider = Provider((ref) {
  return ContactService();
});
final notificationServiceProvider = Provider((ref) {
  return NotificationService();
});
final loggerProvider = Provider((ref) {
  return Logger(printer: PrettyPrinter());
});
