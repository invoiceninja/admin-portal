// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'payment_term_state.g.dart';

abstract class PaymentTermState
    implements Built<PaymentTermState, PaymentTermStateBuilder> {
  factory PaymentTermState() {
    return _$PaymentTermState._(
      map: BuiltMap<String, PaymentTermEntity>(),
      list: BuiltList<String>(),
    );
  }

  PaymentTermState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, PaymentTermEntity> get map;

  BuiltList<String> get list;

  PaymentTermState loadPaymentTerms(BuiltList<PaymentTermEntity> clients) {
    final map = Map<String, PaymentTermEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<PaymentTermState> get serializer =>
      _$paymentTermStateSerializer;
}

abstract class PaymentTermUIState extends Object
    with EntityUIState
    implements Built<PaymentTermUIState, PaymentTermUIStateBuilder> {
  factory PaymentTermUIState(PrefStateSortField? sortField) {
    return _$PaymentTermUIState._(
      listUIState: ListUIState(sortField?.field ?? PaymentTermFields.name,
          sortAscending: sortField?.ascending),
      editing: PaymentTermEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  PaymentTermUIState._();

  @override
  @memoized
  int get hashCode;

  PaymentTermEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<PaymentTermUIState> get serializer =>
      _$paymentTermUIStateSerializer;
}
