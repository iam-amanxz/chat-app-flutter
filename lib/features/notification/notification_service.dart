import 'dart:async';

import 'package:logger/logger.dart';

import 'model/notification.dart';

class NotificationService {
  final Logger _logger;
  final StreamController<Notification> _controller;

  NotificationService({required Logger logger})
      : _logger = logger,
        _controller = StreamController.broadcast();

  void add(Notification notification) {
    _controller.sink.add(notification);
  }

  Stream<Notification> get stream => _controller.stream;

  void dispose() {
    _logger.i('NotificationService: disposing stream');
    _controller.close();
  }
}
