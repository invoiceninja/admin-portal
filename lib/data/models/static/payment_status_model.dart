// Package imports:
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'payment_status_model.g.dart';

class PaymentStatusFields {
  static const String name = 'name';
}

abstract class PaymentStatusEntity extends Object
    with EntityStatus, SelectableEntity
    implements Built<PaymentStatusEntity, PaymentStatusEntityBuilder> {
  factory PaymentStatusEntity() {
    return _$PaymentStatusEntity._(
      id: '',
      name: '',
    );
  }

  PaymentStatusEntity._();

  @override
  @memoized
  int get hashCode;

  static Serializer<PaymentStatusEntity> get serializer =>
      _$paymentStatusEntitySerializer;
}
