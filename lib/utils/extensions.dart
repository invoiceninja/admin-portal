// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

extension ContextHelper on BuildContext {
  AppLocalization? get localization {
    return AppLocalization.of(this);
  }

  Store<AppState> get store {
    return StoreProvider.of<AppState>(this);
  }

  AppState get state {
    return store.state;
  }
}

extension ListHelper<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;

  T? get lastOrNull => isEmpty ? null : last;
}
