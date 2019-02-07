import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'payment_state.g.dart';

abstract class PaymentState
    implements Built<PaymentState, PaymentStateBuilder> {
  factory PaymentState() {
    return _$PaymentState._(
      lastUpdated: 0,
      map: BuiltMap<int, PaymentEntity>(),
      list: BuiltList<int>(),
    );
  }

  PaymentState._();

  @nullable
  int get lastUpdated;

  BuiltMap<int, PaymentEntity> get map;

  BuiltList<int> get list;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated >
        kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<PaymentState> get serializer => _$paymentStateSerializer;
}

abstract class PaymentUIState extends Object
    with EntityUIState
    implements Built<PaymentUIState, PaymentUIStateBuilder> {
  factory PaymentUIState() {
    return _$PaymentUIState._(
      listUIState: ListUIState(PaymentFields.paymentDate, sortAscending: false),
      editing: PaymentEntity(),
      selectedId: 0,
    );
  }

  PaymentUIState._();

  @nullable
  PaymentEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<PaymentUIState> get serializer =>
      _$paymentUIStateSerializer;
}
