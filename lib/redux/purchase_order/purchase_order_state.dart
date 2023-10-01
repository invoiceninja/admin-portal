import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/purchase_order_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'purchase_order_state.g.dart';

abstract class PurchaseOrderState
    implements Built<PurchaseOrderState, PurchaseOrderStateBuilder> {
  factory PurchaseOrderState() {
    return _$PurchaseOrderState._(
      map: BuiltMap<String, InvoiceEntity>(),
      list: BuiltList<String>(),
    );
  }
  PurchaseOrderState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, InvoiceEntity> get map;
  BuiltList<String> get list;

  InvoiceEntity get(String purchaseOrderId) {
    if (map.containsKey(purchaseOrderId)) {
      return map[purchaseOrderId]!;
    } else {
      return InvoiceEntity(id: purchaseOrderId);
    }
  }

  PurchaseOrderState loadPurchaseOrders(BuiltList<InvoiceEntity> clients) {
    final map = Map<String, InvoiceEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<PurchaseOrderState> get serializer =>
      _$purchaseOrderStateSerializer;
}

abstract class PurchaseOrderUIState extends Object
    with EntityUIState
    implements Built<PurchaseOrderUIState, PurchaseOrderUIStateBuilder> {
  factory PurchaseOrderUIState(PrefStateSortField? sortField) {
    return _$PurchaseOrderUIState._(
      listUIState: ListUIState(
        sortField?.field ?? PurchaseOrderFields.number,
        sortAscending: sortField?.ascending ?? false,
      ),
      editing: InvoiceEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }
  PurchaseOrderUIState._();

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

  static Serializer<PurchaseOrderUIState> get serializer =>
      _$purchaseOrderUIStateSerializer;
}
