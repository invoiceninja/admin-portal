// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:collection/collection.dart' show IterableExtension;
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'design_state.g.dart';

abstract class DesignState implements Built<DesignState, DesignStateBuilder> {
  factory DesignState() {
    return _$DesignState._(
      map: BuiltMap<String, DesignEntity>(),
      list: BuiltList<String>(),
    );
  }

  DesignState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, DesignEntity> get map;

  BuiltList<String> get list;

  DesignEntity get cleanDesign =>
      map[list.firstWhereOrNull(
          (id) => !map[id]!.isCustom && map[id]!.name == 'Clean')] ??
      DesignEntity();

  List<DesignEntity?> get customDesigns => list
      .where((designId) => map[designId]!.isCustom)
      .map((designId) => map[designId])
      .toList();

  DesignState loadDesigns(BuiltList<DesignEntity> clients) {
    final map = Map<String, DesignEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<DesignState> get serializer => _$designStateSerializer;
}

abstract class DesignUIState extends Object
    with EntityUIState
    implements Built<DesignUIState, DesignUIStateBuilder> {
  factory DesignUIState(PrefStateSortField? sortField) {
    return _$DesignUIState._(
      listUIState: ListUIState(sortField?.field ?? DesignFields.name,
          sortAscending: sortField?.ascending),
      editing: DesignEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  DesignUIState._();

  @override
  @memoized
  int get hashCode;

  DesignEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<DesignUIState> get serializer => _$designUIStateSerializer;
}
