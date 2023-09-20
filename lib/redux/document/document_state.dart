// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/document_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'document_state.g.dart';

abstract class DocumentState
    implements Built<DocumentState, DocumentStateBuilder> {
  factory DocumentState() {
    return _$DocumentState._(
      map: BuiltMap<String, DocumentEntity>(),
      list: BuiltList<String>(),
    );
  }

  DocumentState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, DocumentEntity> get map;

  BuiltList<String> get list;

  static Serializer<DocumentState> get serializer => _$documentStateSerializer;
}

abstract class DocumentUIState extends Object
    with EntityUIState
    implements Built<DocumentUIState, DocumentUIStateBuilder> {
  factory DocumentUIState(PrefStateSortField? sortField) {
    return _$DocumentUIState._(
      listUIState: ListUIState(sortField?.field ?? DocumentFields.name,
          sortAscending: sortField?.ascending),
      editing: DocumentEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  DocumentUIState._();

  @override
  @memoized
  int get hashCode;

  DocumentEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<DocumentUIState> get serializer =>
      _$documentUIStateSerializer;
}
