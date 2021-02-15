import 'dart:async';

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
      map: BuiltMap<String, InvoiceEntity>(),
      list: BuiltList<String>(),
    );
  }

  InvoiceState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, InvoiceEntity> get map;

  InvoiceEntity get(String invoiceId) {
    if (map.containsKey(invoiceId)) {
      return map[invoiceId];
    } else {
      return InvoiceEntity(id: invoiceId);
    }
  }

  BuiltList<String> get list;

  InvoiceState loadInvoices(BuiltList<InvoiceEntity> clients) {
    final map = Map<String, InvoiceEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
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
      listUIState: ListUIState(InvoiceFields.number, sortAscending: false),
      editing: InvoiceEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  InvoiceUIState._();

  @override
  @memoized
  int get hashCode;

  @nullable
  InvoiceEntity get editing;

  @nullable
  @BuiltValueField(serialize: false)
  int get editingItemIndex;

  @nullable
  @BuiltValueField(serialize: false)
  String get historyActivityId;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<InvoiceUIState> get serializer =>
      _$invoiceUIStateSerializer;
}
