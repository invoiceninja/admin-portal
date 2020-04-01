import 'dart:async';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/document_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'document_state.g.dart';

abstract class DocumentState
    implements Built<DocumentState, DocumentStateBuilder> {
  factory DocumentState() {
    return _$DocumentState._(
      lastUpdated: 0,
      map: BuiltMap<String, DocumentEntity>(),
      list: BuiltList<String>(),
    );
  }
  DocumentState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, DocumentEntity> get map;
  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<DocumentState> get serializer => _$documentStateSerializer;
}

abstract class DocumentUIState extends Object
    with EntityUIState
    implements Built<DocumentUIState, DocumentUIStateBuilder> {
  factory DocumentUIState() {
    return _$DocumentUIState._(
      listUIState: ListUIState(DocumentFields.name),
      editing: DocumentEntity(),
      selectedId: '',
    );
  }
  DocumentUIState._();

  @nullable
  DocumentEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<DocumentUIState> get serializer =>
      _$documentUIStateSerializer;
}
