import 'dart:async';

import 'package:built_value/built_value.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

abstract class EntityUIState {
  bool get isCreatingNew;
  int get selectedId;
  ListUIState get listUIState;

  @nullable
  @BuiltValueField(serialize: false)
  Completer<SelectableEntity> get saveCompleter;
}
