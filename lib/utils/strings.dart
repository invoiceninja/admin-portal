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

bool matchesStrings(List<String> haystacks, String needle) {
  bool isMatch = false;
  haystacks.forEach((haystack) {
    if (matchesString(haystack, needle)) {
      isMatch = true;
    }
  });
  return isMatch;
}

bool matchesString(String haystack, String needle) {
  if (needle == null || needle.isEmpty) {
    return true;
  }

  String regExp = '';
  needle.toLowerCase().runes.forEach((int rune) {
    final character = String.fromCharCode(rune);
    regExp += character + '.*?';
  });
  return RegExp(regExp).hasMatch(haystack.toLowerCase());
}

bool isValidDate(String input) {
  try {
    DateTime.parse(input);
    return true;
  } catch (e) {
    return false;
  }
}
