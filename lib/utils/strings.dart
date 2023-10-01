import 'dart:math';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

String getOnlyDigits(String value) => value.replaceAll(RegExp('[^\\d]'), '');

bool isAllDigits(String value) => getOnlyDigits(value) == value;

String toSnakeCase(String? value) {
  if ((value ?? '').isEmpty) {
    return '';
  }

  return value!.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => '_' + match[0]!.toLowerCase());
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
  if (value.isEmpty) {
    return '';
  }

  return value.replaceAllMapped(
      RegExp(r'[A-Z]'), (Match match) => ' ' + match[0]!.toLowerCase());
}

String toTitleCase(String text) {
  if (text.isEmpty) {
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

    if (word.length <= 1) {
      return word;
    }

    final first = word.substring(0, 1).toUpperCase();
    final rest = word.substring(1).toLowerCase();
    return '$first$rest';
  });

  return capitalized.join(' ');
}

// https://stackoverflow.com/a/57541846/497368
String removeAllHtmlTags(String htmlText) {
  final exp = RegExp(
    r'<[^>]*>',
    multiLine: true,
    caseSensitive: true,
  );

  return htmlText.replaceAll(exp, '');
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
  if (text.length > 20000) {
    text = text.substring(0, 20000);
  }

  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

bool matchesStrings({
  List<String?>? haystacks,
  String? needle,
}) {
  if (needle == null || needle.isEmpty) {
    return true;
  }

  bool isMatch = false;
  haystacks!.forEach((haystack) {
    if (matchesString(
      haystack: haystack,
      needle: needle,
    )) {
      isMatch = true;
    }
  });
  return isMatch;
}

bool matchesString({String? haystack, String? needle}) {
  if (needle == null || needle.isEmpty) {
    return true;
  }

  final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
  final state = store.state;

  if (state.prefState.enableFlexibleSearch) {
    String regExp = '';
    needle.toLowerCase().runes.forEach((int rune) {
      final character = RegExp.escape(String.fromCharCode(rune));
      regExp += character + '.*?';
    });
    return RegExp(regExp).hasMatch(haystack!.toLowerCase());
  } else if (needle.contains(' ')) {
    final parts = needle.toLowerCase().split(' ');
    bool isMatch = true;
    parts.forEach((needle) {
      if (!haystack!.toLowerCase().contains(needle)) {
        isMatch = false;
      }
    });
    return isMatch;
  } else {
    return haystack!.toLowerCase().contains(needle.toLowerCase());
  }
}

String? matchesStringsValue({
  List<String?>? haystacks,
  String? needle,
}) {
  if (needle == null || needle.isEmpty) {
    return null;
  }

  String? match;
  haystacks!.forEach((haystack) {
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

String? matchesStringValue({String? haystack, String? needle}) {
  if (needle == null || needle.isEmpty) {
    return null;
  }

  if (haystack!.toLowerCase().contains(needle.toLowerCase())) {
    return haystack;
  } else {
    return null;
  }

  /*
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
  */
}

int secondToLastIndexOf(String string, String pattern) {
  string = string.substring(0, string.lastIndexOf(pattern));

  return string.lastIndexOf(pattern);
}

String untrimUrl(String url) {
  if (url.startsWith('http://') || url.startsWith('https://')) {
    return url;
  }

  return 'https://$url';
}

String trimUrl(String url) {
  url = url.replaceFirst('http://', '').replaceFirst('https://', '');

  if (url.startsWith('www.')) {
    url = url.replaceFirst('www.', '');
  }

  return url;
}

// https://stackoverflow.com/a/61929967/497368
String getRandomString([int length = 32]) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));
}
