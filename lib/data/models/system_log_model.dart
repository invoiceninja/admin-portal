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
  static const CATEGORY_WEBHOOK = 3;
  static const CATEGORY_PDF = 4;
  static const CATEGORY_SECURITY = 5;

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
      case CATEGORY_PDF:
        return 'pdf';
      case CATEGORY_SECURITY:
        return 'security';
      case CATEGORY_WEBHOOK:
        return 'webhook';
    }

    return '';
  }

  bool get isVisible => eventId >= 20;

  // https://github.com/invoiceninja/invoiceninja/blob/v5-develop/app/Models/SystemLog.php
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
      case 32:
        return 'email_bounced';
      case 33:
        return 'email_spam_complaint';
      case 34:
        return 'email_delivery';
      case 40:
        return 'webhook_response';
      case 50:
        return 'pdf_response';
      case 60:
        return 'authentication_failure';
      case 61:
        return 'user';
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
      case 306:
        return 'custom';
      case 400:
        return 'quota_exceeded';
      case 401:
        return 'upstream_failure';
      case 500:
        return 'webhook_response';
      case 600:
        return 'pdf_failed';
      case 601:
        return 'pdf_success';
      case 701:
        return 'modified';
      case 702:
        return 'deleted';
    }

    return '';
  }

  static Serializer<SystemLogEntity> get serializer =>
      _$systemLogEntitySerializer;
}
