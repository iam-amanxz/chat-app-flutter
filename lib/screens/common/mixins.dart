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
    _service = ref.read(notificationServiceProvider);

    _service.stream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(notification.title ?? 'No title'),
        ),
      );
    });
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
