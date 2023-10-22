// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'payment_type_model.g.dart';

abstract class PaymentTypeListResponse
    implements Built<PaymentTypeListResponse, PaymentTypeListResponseBuilder> {
  factory PaymentTypeListResponse(
          [void updates(PaymentTypeListResponseBuilder b)]) =
      _$PaymentTypeListResponse;
  PaymentTypeListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<PaymentTypeEntity> get data;

  static Serializer<PaymentTypeListResponse> get serializer =>
      _$paymentTypeListResponseSerializer;
}

abstract class PaymentTypeItemResponse
    implements Built<PaymentTypeItemResponse, PaymentTypeItemResponseBuilder> {
  factory PaymentTypeItemResponse(
          [void updates(PaymentTypeItemResponseBuilder b)]) =
      _$PaymentTypeItemResponse;
  PaymentTypeItemResponse._();

  @override
  @memoized
  int get hashCode;

  PaymentTypeEntity get data;

  static Serializer<PaymentTypeItemResponse> get serializer =>
      _$paymentTypeItemResponseSerializer;
}

class PaymentTypeFields {
  static const String name = 'name';
  static const String gatewayTypeId = 'gateway_type_id';
}

abstract class PaymentTypeEntity extends Object
    with SelectableEntity
    implements Built<PaymentTypeEntity, PaymentTypeEntityBuilder> {
  factory PaymentTypeEntity() {
    return _$PaymentTypeEntity._(
      id: '',
      name: '',
    );
  }
  PaymentTypeEntity._();

  @override
  @memoized
  int get hashCode;

  String get name;

  @override
  bool matchesFilter(String? filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (name.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String? matchesFilterValue(String? filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    return null;
  }

  @override
  String get listDisplayName => name;

  @override
  double? get listDisplayAmount => null;

  static Serializer<PaymentTypeEntity> get serializer =>
      _$paymentTypeEntitySerializer;
}
