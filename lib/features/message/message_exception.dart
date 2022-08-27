class MessageException {
  final String title;
  final String description;
  const MessageException.unknown()
      : title = 'Unknown Error',
        description = 'An unknown error has occurred';
}
