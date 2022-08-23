class ContactException {
  final String title;
  final String description;
  const ContactException.unknown()
      : title = 'Unknown Error',
        description = 'An unknown error has occurred';
}
