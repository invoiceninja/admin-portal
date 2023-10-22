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

part 'tax_rate_state.g.dart';

abstract class TaxRateState
    implements Built<TaxRateState, TaxRateStateBuilder> {
  factory TaxRateState() {
    return _$TaxRateState._(
      map: BuiltMap<String, TaxRateEntity>(),
      list: BuiltList<String>(),
    );
  }

  TaxRateState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, TaxRateEntity> get map;

  BuiltList<String> get list;

  static Serializer<TaxRateState> get serializer => _$taxRateStateSerializer;
}

abstract class TaxRateUIState extends Object
    with EntityUIState
    implements Built<TaxRateUIState, TaxRateUIStateBuilder> {
  factory TaxRateUIState(PrefStateSortField? sortField) {
    return _$TaxRateUIState._(
      listUIState: ListUIState(sortField?.field ?? TaxRateFields.name,
          sortAscending: sortField?.ascending),
      editing: TaxRateEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  TaxRateUIState._();

  @override
  @memoized
  int get hashCode;

  TaxRateEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<TaxRateUIState> get serializer =>
      _$taxRateUIStateSerializer;
}
