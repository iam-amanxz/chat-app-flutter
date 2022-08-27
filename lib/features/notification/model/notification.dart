enum NotificationType { success, info, error }

class Notification {
  final NotificationType type;
  final String message;
  final String title;
  Notification.custom(
      {required this.type, required this.title, required this.message});
  Notification.genericInfo()
      : type = NotificationType.info,
        title = 'Success',
        message = 'success';

  Notification.userCreated()
      : type = NotificationType.success,
        title = 'Success',
        message = 'Registered successfully';
  Notification.userUpdated()
      : type = NotificationType.success,
        title = 'Success',
        message = 'Profile updated successfully';
  Notification.profilePhotoUpdated()
      : type = NotificationType.success,
        title = 'Success',
        message = 'Profile photo updated successfully';

  Notification.genericError()
      : type = NotificationType.error,
        title = 'Error',
        message = 'Something went wrong';
  Notification.genericAuthError()
      : type = NotificationType.error,
        title = 'Auth Error',
        message = 'Something went wrong';
  Notification.signupFailed([String? message])
      : type = NotificationType.error,
        title = 'Sign up failed',
        message = message ?? 'Something went wrong';
  Notification.signInFailed([String? message])
      : type = NotificationType.error,
        title = 'Sign in failed',
        message = message ?? 'Something went wrong';
  Notification.signOutFailed([String? message])
      : type = NotificationType.error,
        title = 'Sign out failed',
        message = message ?? 'Something went wrong';
  Notification.userNotFound()
      : type = NotificationType.error,
        title = 'Auth Error',
        message = 'User not found';
  Notification.userCreateFailed()
      : type = NotificationType.error,
        title = 'Error',
        message = "Couldn't create user";
  Notification.userUpdateFailed()
      : type = NotificationType.error,
        title = 'Error',
        message = "Couldn't update user";
  Notification.profilePhotoUpdateFailed()
      : type = NotificationType.error,
        title = 'Error',
        message = "Couldn't update photo";
  Notification.loadContactsFailed()
      : type = NotificationType.error,
        title = 'Error',
        message = "Couldn't load contacts";
  Notification.loadConversationsFailed()
      : type = NotificationType.error,
        title = 'Error',
        message = "Couldn't load conversations";
  Notification.createConversationFailed()
      : type = NotificationType.error,
        title = 'Error',
        message = "Couldn't create conversation";
  Notification.loadMessagesFailed()
      : type = NotificationType.error,
        title = 'Error',
        message = "Couldn't load messages";
  Notification.sendMessageFailed()
      : type = NotificationType.error,
        title = 'Error',
        message = "Couldn't send message";
}
