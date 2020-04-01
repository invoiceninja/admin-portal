import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'credit_state.g.dart';

abstract class CreditState implements Built<CreditState, CreditStateBuilder> {
  factory CreditState() {
    return _$CreditState._(
      lastUpdated: 0,
      map: BuiltMap<String, InvoiceEntity>(),
      list: BuiltList<String>(),
    );
  }
  CreditState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, InvoiceEntity> get map;
  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  CreditState loadCredits(BuiltList<InvoiceEntity> clients) {
    final map = Map<String, InvoiceEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..lastUpdated = DateTime.now().millisecondsSinceEpoch
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<CreditState> get serializer => _$creditStateSerializer;
}

abstract class CreditUIState extends Object
    with EntityUIState
    implements Built<CreditUIState, CreditUIStateBuilder> {
  factory CreditUIState() {
    return _$CreditUIState._(
      listUIState: ListUIState(CreditFields.creditNumber),
      editing: InvoiceEntity(),
      selectedId: '',
    );
  }
  CreditUIState._();

  @nullable
  InvoiceEntity get editing;

  @nullable
  @BuiltValueField(serialize: false)
  int get editingItemIndex;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<CreditUIState> get serializer => _$creditUIStateSerializer;
}
