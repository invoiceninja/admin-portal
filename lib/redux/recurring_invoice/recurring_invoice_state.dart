import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'recurring_invoice_state.g.dart';

abstract class RecurringInvoiceState
    implements Built<RecurringInvoiceState, RecurringInvoiceStateBuilder> {
  factory RecurringInvoiceState() {
    return _$RecurringInvoiceState._(
      map: BuiltMap<String, InvoiceEntity>(),
      list: BuiltList<String>(),
    );
  }

  RecurringInvoiceState._();

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

  RecurringInvoiceState loadRecurringInvoices(
      BuiltList<InvoiceEntity> clients) {
    final map = Map<String, InvoiceEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<RecurringInvoiceState> get serializer =>
      _$recurringInvoiceStateSerializer;
}

abstract class RecurringInvoiceUIState extends Object
    with EntityUIState
    implements Built<RecurringInvoiceUIState, RecurringInvoiceUIStateBuilder> {
  factory RecurringInvoiceUIState() {
    return _$RecurringInvoiceUIState._(
      listUIState: ListUIState(InvoiceFields.number),
      editing: InvoiceEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  RecurringInvoiceUIState._();

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

  static Serializer<RecurringInvoiceUIState> get serializer =>
      _$recurringInvoiceUIStateSerializer;
}
