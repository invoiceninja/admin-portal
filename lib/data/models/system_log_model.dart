import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'system_log_model.g.dart';

abstract class SystemLogEntity
    implements Built<SystemLogEntity, SystemLogEntityBuilder> {
  factory SystemLogEntity() {
    return _$SystemLogEntity._(
      id: '',
      clientId: '',
      createdAt: 0,
      companyId: '',
      categoryId: 0,
      eventId: 0,
      log: '',
      typeId: 0,
      userId: '',
    );
  }

  SystemLogEntity._();

  static const CATEGORY_PAYMENT = 1;
  static const CATEGORY_EMAIL = 2;

  @override
  @memoized
  int get hashCode;

  String get id;

  @BuiltValueField(wireName: 'company_id')
  String get companyId;

  @BuiltValueField(wireName: 'user_id')
  String get userId;

  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'event_id')
  int get eventId;

  @BuiltValueField(wireName: 'category_id')
  int get categoryId;

  @BuiltValueField(wireName: 'type_id')
  int get typeId;

  String get log;

  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  String get category {
    switch (categoryId) {
      case CATEGORY_PAYMENT:
        return 'payment';
      case CATEGORY_EMAIL:
        return 'email';
    }

    return '';
  }

  bool get isVisible => eventId >= 20;

  String get event {
    switch (eventId) {
      case 10:
        return 'payment_reconciliation_failure';
      case 11:
        return 'payment_reconciliation_success';
      case 21:
        return 'gateway_success';
      case 22:
        return 'gateway_failure';
      case 23:
        return 'gateway_error';
      case 30:
        return 'email_send';
      case 31:
        return 'email_retry_queue';
    }

    return '';
  }

  String get type {
    switch (typeId) {
      case 300:
        return 'PayPal';
      case 301:
        return 'Stripe';
      case 302:
        return 'ledger';
      case 303:
        return 'failure';
      case 304:
        return 'Checkout.com';
      case 305:
        return 'Authorize.net';
      case 400:
        return 'quota_exceeded';
      case 401:
        return 'upstream_failure';
    }

    return '';
  }

  static Serializer<SystemLogEntity> get serializer =>
      _$systemLogEntitySerializer;
}
