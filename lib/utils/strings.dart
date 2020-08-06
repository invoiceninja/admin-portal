String toSnakeCase(String value) {
  if ((value ?? '').isEmpty) {
    return '';
  }

  return value.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => '_' + match[0].toLowerCase());
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
  //print(text);

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
    final character = String.fromCharCode(rune);
    regExp += character + '.*?';
  });
  return RegExp(regExp).hasMatch(haystack.toLowerCase());
}
