class ConversationException {
  final String title;
  final String description;
  const ConversationException.unknown()
      : title = 'Unknown Error',
        description = 'An unknown error has occurred';
}
