import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../features/auth/auth_service.dart';
import '../features/contact/contact_service.dart';
import '../features/notification/notification_service.dart';

final authProvider = Provider.autoDispose((ref) {
  ref.onDispose(() {
    ref.read(loggerProvider).d('authProvider: disposing');
  });
  return AuthService(
    auth: FirebaseAuth.instance,
    db: FirebaseFirestore.instance,
  );
});

final contactProvider = Provider.autoDispose((ref) {
  ref.onDispose(() {
    ref.read(loggerProvider).d('contactProvider: disposing');
  });
  return ContactService(
    db: FirebaseFirestore.instance,
  );
});

final notificationProvider = Provider((ref) {
  ref.onDispose(() {
    ref.read(loggerProvider).d('notificationProvider: disposing');
  });
  return NotificationService(logger: ref.read(loggerProvider));
});

final loggerProvider = Provider((ref) {
  ref.onDispose(() {
    print('loggerProvider: disposing');
  });
  return Logger(printer: PrettyPrinter());
});
