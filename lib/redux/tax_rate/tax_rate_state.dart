import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/tax_rate_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'tax_rate_state.g.dart';

abstract class TaxRateState
    implements Built<TaxRateState, TaxRateStateBuilder> {
  factory TaxRateState() {
    return _$TaxRateState._(
      lastUpdated: 0,
      map: BuiltMap<String, TaxRateEntity>(),
      list: BuiltList<String>(),
    );
  }
  TaxRateState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, TaxRateEntity> get map;
  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<TaxRateState> get serializer => _$taxRateStateSerializer;
}

abstract class TaxRateUIState extends Object
    with EntityUIState
    implements Built<TaxRateUIState, TaxRateUIStateBuilder> {
  factory TaxRateUIState() {
    return _$TaxRateUIState._(
      listUIState: ListUIState(TaxRateFields.name),
      editing: TaxRateEntity(),
      selectedId: '',
    );
  }
  TaxRateUIState._();

  @nullable
  TaxRateEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<TaxRateUIState> get serializer =>
      _$taxRateUIStateSerializer;
}
