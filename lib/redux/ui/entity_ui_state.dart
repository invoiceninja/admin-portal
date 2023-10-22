// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_value/built_value.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

abstract mixin class EntityUIState {
  bool get isCreatingNew;

  String get editingId;

  ListUIState get listUIState;

  String? get selectedId;

  bool? get forceSelected;

  int get tabIndex;

  @BuiltValueField(serialize: false)
  Completer<SelectableEntity>? get saveCompleter;

  @BuiltValueField(serialize: false)
  Completer<Null>? get cancelCompleter;
}
