import 'dart:async';

import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'invoice_state.g.dart';

abstract class InvoiceState
    implements Built<InvoiceState, InvoiceStateBuilder> {
  factory InvoiceState() {
    return _$InvoiceState._(
      lastUpdated: 0,
      map: BuiltMap<String, InvoiceEntity>(),
      list: BuiltList<String>(),
    );
  }

  InvoiceState._();

  @nullable
  int get lastUpdated;

  BuiltMap<String, InvoiceEntity> get map;

  InvoiceEntity get(String invoiceId) {
    if (map.containsKey(invoiceId)) {
      return map[invoiceId];
    } else {
      return InvoiceEntity(id: invoiceId);
    }
  }

  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  InvoiceState loadInvoices(BuiltList<InvoiceEntity> clients) {
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

  static Serializer<InvoiceState> get serializer => _$invoiceStateSerializer;
}

abstract class InvoiceUIState extends Object
    with EntityUIState
    implements Built<InvoiceUIState, InvoiceUIStateBuilder> {
  factory InvoiceUIState() {
    return _$InvoiceUIState._(
      listUIState: ListUIState(InvoiceFields.invoiceNumber, sortAscending: false),
      editing: InvoiceEntity(),
      selectedId: '',
    );
  }

  InvoiceUIState._();

  @nullable
  InvoiceEntity get editing;

  @nullable
  @BuiltValueField(serialize: false)
  int get editingItemIndex;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<InvoiceUIState> get serializer =>
      _$invoiceUIStateSerializer;
}
