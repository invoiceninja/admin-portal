import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_type_model.g.dart';

abstract class PaymentTypeListResponse implements Built<PaymentTypeListResponse, PaymentTypeListResponseBuilder> {

  factory PaymentTypeListResponse([void updates(PaymentTypeListResponseBuilder b)]) = _$PaymentTypeListResponse;
  PaymentTypeListResponse._();

  BuiltList<PaymentTypeEntity> get data;

  static Serializer<PaymentTypeListResponse> get serializer => _$paymentTypeListResponseSerializer;
}

abstract class PaymentTypeItemResponse implements Built<PaymentTypeItemResponse, PaymentTypeItemResponseBuilder> {

  factory PaymentTypeItemResponse([void updates(PaymentTypeItemResponseBuilder b)]) = _$PaymentTypeItemResponse;
  PaymentTypeItemResponse._();

  PaymentTypeEntity get data;

  static Serializer<PaymentTypeItemResponse> get serializer => _$paymentTypeItemResponseSerializer;
}

class PaymentTypeFields {
  static const String name = 'name';
  static const String gatewayTypeId = 'gatewayTypeId';
  
}

abstract class PaymentTypeEntity implements Built<PaymentTypeEntity, PaymentTypeEntityBuilder> {

  factory PaymentTypeEntity() {
    return _$PaymentTypeEntity._(
      id: 0,
      name: '',
    );
  }
  PaymentTypeEntity._();

  int get id;
  String get name;

  static Serializer<PaymentTypeEntity> get serializer => _$paymentTypeEntitySerializer;
}

