import 'package:chat_app/features/message/message_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../features/auth/auth_service.dart';
import '../features/contact/contact_service.dart';
import '../features/conversation/conversation_service.dart';
import '../features/notification/notification_service.dart';

final authProvider = Provider.autoDispose((ref) {
  return AuthService(
    auth: FirebaseAuth.instance,
    db: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance,
  );
});

final contactProvider = Provider((ref) {
  return ContactService(
    db: FirebaseFirestore.instance,
  );
});

final conversationProvider = Provider((ref) {
  return ConversationService(
    reader: ref.read,
    db: FirebaseFirestore.instance,
  );
});

final messageProvider = Provider((ref) {
  return MessageService(
    reader: ref.read,
    db: FirebaseFirestore.instance,
  );
});

final notificationProvider = Provider((ref) {
  return NotificationService(logger: ref.read(loggerProvider));
});

final loggerProvider = Provider((ref) {
  return Logger(printer: PrettyPrinter());
});
