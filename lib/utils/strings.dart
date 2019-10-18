String toSnakeCase(String value) {
  return value.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => '_' + match[0].toLowerCase());
}

String toSpaceCase(String value) {
  return value.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => ' ' + match[0].toLowerCase());
}

String toTitleCase(String text) {
  if (text.length <= 1) {
    return text.toUpperCase();
  }

  text = toSpaceCase(text);
  final words = text.split(' ');
  final capitalized = words.map((word) {
    if (word == 'url') {
      return 'URL';
    }
    
    final first = word.substring(0, 1).toUpperCase();
    final rest = word.substring(1);
    return '$first$rest';
  });

  return capitalized.join(' ');
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
