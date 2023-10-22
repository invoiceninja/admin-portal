// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'payment_state.g.dart';

abstract class PaymentState
    implements Built<PaymentState, PaymentStateBuilder> {
  factory PaymentState() {
    return _$PaymentState._(
      map: BuiltMap<String, PaymentEntity>(),
      list: BuiltList<String>(),
    );
  }

  PaymentState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, PaymentEntity> get map;

  BuiltList<String> get list;

  PaymentEntity get(String paymentId) {
    if (map.containsKey(paymentId)) {
      return map[paymentId]!;
    } else {
      return PaymentEntity(id: paymentId);
    }
  }

  PaymentState loadPayments(BuiltList<PaymentEntity> clients) {
    final map = Map<String, PaymentEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<PaymentState> get serializer => _$paymentStateSerializer;
}

abstract class PaymentUIState extends Object
    with EntityUIState
    implements Built<PaymentUIState, PaymentUIStateBuilder> {
  factory PaymentUIState(PrefStateSortField? sortField) {
    return _$PaymentUIState._(
      listUIState: ListUIState(sortField?.field ?? PaymentFields.number,
          sortAscending: sortField?.ascending ?? false),
      editing: PaymentEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  PaymentUIState._();

  @override
  @memoized
  int get hashCode;

  PaymentEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<PaymentUIState> get serializer =>
      _$paymentUIStateSerializer;
}
