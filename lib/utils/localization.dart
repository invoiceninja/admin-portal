// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/i18n.dart';

class AppLocalization extends LocaleCodeAware with LocalizationsProvider {
  AppLocalization(this.locale) : super(locale.toString());

  final Locale locale;

  static Locale createLocale(String? locale) {
    if (!kLanguages.contains(locale)) {
      return Locale('en');
    }

    final parts = locale!.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : null);
  }

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => kLanguages.contains(locale.toString());

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
