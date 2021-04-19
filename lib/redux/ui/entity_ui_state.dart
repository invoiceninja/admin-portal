import 'dart:async';

import 'package:built_value/built_value.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

abstract class EntityUIState {
  bool get isCreatingNew;

  String get editingId;

  ListUIState get listUIState;

  @nullable
  String get selectedId;

  @nullable
  bool get forceSelected;

  int get tabIndex;

  @nullable
  @BuiltValueField(serialize: false)
  Completer<SelectableEntity> get saveCompleter;

  @nullable
  @BuiltValueField(serialize: false)
  Completer<Null> get cancelCompleter;
}
