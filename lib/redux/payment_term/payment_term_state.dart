import 'dart:async';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'payment_term_state.g.dart';

abstract class PaymentTermState
    implements Built<PaymentTermState, PaymentTermStateBuilder> {
  factory PaymentTermState() {
    return _$PaymentTermState._(
      lastUpdated: 0,
      map: BuiltMap<String, PaymentTermEntity>(),
      list: BuiltList<String>(),
    );
  }
  PaymentTermState._();

  @override
  @memoized
  int get hashCode;

  @nullable
  int get lastUpdated;

  BuiltMap<String, PaymentTermEntity> get map;
  BuiltList<String> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  PaymentTermState loadPaymentTerms(BuiltList<PaymentTermEntity> clients) {
    final map = Map<String, PaymentTermEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..lastUpdated = DateTime.now().millisecondsSinceEpoch
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<PaymentTermState> get serializer =>
      _$paymentTermStateSerializer;
}

abstract class PaymentTermUIState extends Object
    with EntityUIState
    implements Built<PaymentTermUIState, PaymentTermUIStateBuilder> {
  factory PaymentTermUIState() {
    return _$PaymentTermUIState._(
      listUIState: ListUIState(PaymentTermFields.name),
      editing: PaymentTermEntity(),
      selectedId: '',
    );
  }
  PaymentTermUIState._();

  @override
  @memoized
  int get hashCode;

  @nullable
  PaymentTermEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  @override
  String get editingId => editing.id;

  static Serializer<PaymentTermUIState> get serializer =>
      _$paymentTermUIStateSerializer;
}
