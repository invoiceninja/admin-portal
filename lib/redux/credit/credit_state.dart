// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'credit_state.g.dart';

abstract class CreditState implements Built<CreditState, CreditStateBuilder> {
  factory CreditState() {
    return _$CreditState._(
      map: BuiltMap<String, InvoiceEntity>(),
      list: BuiltList<String>(),
    );
  }

  CreditState._();

  InvoiceEntity get(String creditId) {
    if (map.containsKey(creditId)) {
      return map[creditId]!;
    } else {
      return InvoiceEntity(id: creditId, entityType: EntityType.credit);
    }
  }

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, InvoiceEntity> get map;

  BuiltList<String> get list;

  CreditState loadCredits(BuiltList<InvoiceEntity> clients) {
    final map = Map<String, InvoiceEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<CreditState> get serializer => _$creditStateSerializer;
}

abstract class CreditUIState extends Object
    with EntityUIState
    implements Built<CreditUIState, CreditUIStateBuilder> {
  factory CreditUIState(PrefStateSortField? sortField) {
    return _$CreditUIState._(
      listUIState: ListUIState(sortField?.field ?? CreditFields.number,
          sortAscending: sortField?.ascending ?? false),
      editing: InvoiceEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  CreditUIState._();

  @override
  @memoized
  int get hashCode;

  InvoiceEntity? get editing;

  @BuiltValueField(serialize: false)
  int? get editingItemIndex;

  @BuiltValueField(serialize: false)
  String? get historyActivityId;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<CreditUIState> get serializer => _$creditUIStateSerializer;
}
