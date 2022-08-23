String? nameValidation(value) {
  value = value?.trim();

  if (value == null || value.isEmpty) {
    return 'Name is required';
  }

  if (value.length < 3) {
    return 'Name must be at least 3 characters long';
  }

  if (value.length > 64) {
    return 'Name must be less than 64 characters';
  }

  return null;
}

String? usernameValidationSignUp(value) {
  value = value?.trim();

  if (value == null || value.isEmpty) {
    return 'Username is required';
  }

  if (value.length < 5) {
    return 'Username must be at least 5 characters long';
  }

  if (value.length > 15) {
    return 'Username must be less than 15 characters';
  }

  if (value.contains(' ')) {
    return 'Username must not contain spaces';
  }

  if (value.contains(RegExp(r'\.{2,}'))) {
    return 'Username must not contain more than one period in a row';
  }

  if (value.endsWith('.')) {
    return 'Username must not end with a period';
  }

  if (value.startsWith('.')) {
    return 'Username must not start with a period';
  }

  if (!RegExp(r'^[a-zA-Z0-9_.]+$').hasMatch(value)) {
    return 'Username can only use Roman letters (a-z, A-Z), numbers, underscores and periods';
  }

  return null;
}

String? usernameValidationSignIn(value) {
  value = value?.trim();

  if (value == null || value.isEmpty) {
    return 'Username is required';
  }

  return null;
}

String? passwordValidationSignUp(value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  if (value.length < 5) {
    return 'Password must be at least 6 characters long';
  }

  if (value.trim().length > 24) {
    return 'Password must be less than 24 characters';
  }

  return null;
}
