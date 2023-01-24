// Package imports:
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'invoice_status_model.g.dart';

class InvoiceStatusFields {
  static const String name = 'name';
}

abstract class InvoiceStatusEntity extends Object
    with EntityStatus, SelectableEntity
    implements Built<InvoiceStatusEntity, InvoiceStatusEntityBuilder> {
  factory InvoiceStatusEntity() {
    return _$InvoiceStatusEntity._(
      id: '',
      name: '',
    );
  }

  InvoiceStatusEntity._();

  @override
  @memoized
  int get hashCode;

  static Serializer<InvoiceStatusEntity> get serializer =>
      _$invoiceStatusEntitySerializer;
}
