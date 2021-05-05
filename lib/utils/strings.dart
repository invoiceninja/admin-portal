bool isAllDigits(String value) {
  return value.replaceAll(RegExp('[^\\d]'), '') == value;
}

String toSnakeCase(String value) {
  if ((value ?? '').isEmpty) {
    return '';
  }

  return value.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => '_' + match[0].toLowerCase());
}

String toCamelCase(String subject) {
  final _splittedString = subject.split('_');

  if (_splittedString.isEmpty) {
    return '';
  }

  final _firstWord = _splittedString[0].toLowerCase();
  final _restWords = _splittedString
      .sublist(1)
      .map((String word) => toTitleCase(word))
      .toList();

  return _firstWord + _restWords.join('');
}

String toSpaceCase(String value) {
  if ((value ?? '').isEmpty) {
    return '';
  }

  return value.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => ' ' + match[0].toLowerCase());
}

String toTitleCase(String text) {
  if ((text ?? '').isEmpty) {
    return '';
  }

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

bool isValidDate(String input) {
  try {
    DateTime.parse(input);
    return true;
  } catch (e) {
    return false;
  }
}

void printWrapped(String text) {
  if (text.length > 5000) {
    text = text.substring(0, 5000);
  }

  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

bool matchesStrings({
  List<String> haystacks,
  String needle,
}) {
  if (needle == null || needle.isEmpty) {
    return true;
  }

  bool isMatch = false;
  haystacks.forEach((haystack) {
    if (matchesString(
      haystack: haystack,
      needle: needle,
    )) {
      isMatch = true;
    }
  });
  return isMatch;
}

bool matchesString({String haystack, String needle}) {
  if (needle == null || needle.isEmpty) {
    return true;
  }

  String regExp = '';
  needle.toLowerCase().runes.forEach((int rune) {
    final character = RegExp.escape(String.fromCharCode(rune));
    regExp += character + '.*?';
  });
  return RegExp(regExp).hasMatch(haystack.toLowerCase());
}

String matchesStringsValue({
  List<String> haystacks,
  String needle,
}) {
  if (needle == null || needle.isEmpty) {
    return null;
  }

  String match;
  haystacks.forEach((haystack) {
    final value = matchesStringValue(
      haystack: haystack,
      needle: needle,
    );
    if (value != null) {
      match = value;
    }
  });
  return match;
}

String matchesStringValue({String haystack, String needle}) {
  if (needle == null || needle.isEmpty) {
    return null;
  }

  String regExp = '';
  needle.toLowerCase().runes.forEach((int rune) {
    final character = RegExp.escape(String.fromCharCode(rune));
    regExp += character + '.*?';
  });

  if (RegExp(regExp).hasMatch(haystack.toLowerCase())) {
    return haystack;
  } else {
    return null;
  }
}

int secondToLastIndexOf(String string, String pattern) {
  string = string.substring(0, string.lastIndexOf(pattern));

  return string.lastIndexOf(pattern);
}
