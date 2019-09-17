String toSnakeCase(String value) {
  return value.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => '_' + match[0].toLowerCase());
}

String getFirstName(String value) {
  final parts = value.split(' ');
  if (parts.length > 1) {
    parts.removeLast();
  }
  return parts.join(' ');
}

String getLastName(String value) {
  final parts = value.split(' ');
  if (parts.length <= 1) {
    return '';
  }
  return parts.last;
}
