import 'dart:async';

import 'model/notification.dart';

class NotificationService {
  final StreamController<Notification> _controller;

  NotificationService() : _controller = StreamController<Notification>();

  void add(Notification notification) {
    _controller.sink.add(notification);
  }

  Stream<Notification> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
