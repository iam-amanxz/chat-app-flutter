enum NotificationType { success, info, error }

class Notification {
  final NotificationType type;
  String? title;
  String? message;
  Notification.generic()
      : type = NotificationType.info,
        title = 'Success',
        message = 'success';
}
