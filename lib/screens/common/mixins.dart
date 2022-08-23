import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/di.dart';
import '../../features/notification/notification_service.dart';

mixin NotificationListener<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  late final NotificationService _service;
  @override
  void initState() {
    super.initState();
    _service = ref.read(notificationProvider);

    _service.stream.listen((notification) {
      snackbarKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(notification.message),
        ),
      );
    });
  }

  @override
  void dispose() {
    ref.read(loggerProvider).d('NotificationListener: disposing stream');
    _service.dispose();
    super.dispose();
  }
}
