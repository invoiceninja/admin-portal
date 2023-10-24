// Package imports:
import 'package:built_collection/built_collection.dart';
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
      //history: EmailHistoryEntity(),
    );
  }

  SystemLogEntity._();

  static const CATEGORY_PAYMENT = 1;
  static const CATEGORY_EMAIL = 2;
  static const CATEGORY_WEBHOOK = 3;
  static const CATEGORY_PDF = 4;
  static const CATEGORY_SECURITY = 5;
  static const CATEGORY_LOG = 6;

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

  //EmailHistoryEntity get history;

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
      case CATEGORY_LOG:
        return 'log';
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
        return 'email_delivered';
      case 35:
        return 'email_opened';
      case 40:
        return 'webhook_response';
      case 41:
        return 'webhook_success';
      case 42:
        return 'webhook_failure';
      case 50:
        return 'pdf_response';
      case 60:
        return 'authentication_failure';
      case 61:
        return 'user';
    }

    return 'Unknown $eventId';
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
      case 307:
        return 'Braintree';
      case 309:
        return 'WePay';
      case 310:
        return 'PayFast';
      case 311:
        return 'PayTrace';
      case 312:
        return 'Mollie';
      case 313:
        return 'eWay';
      case 314:
        return 'Forte';
      case 320:
        return 'Square';
      case 321:
        return 'GoCardless';
      case 322:
        return 'Razorpay';
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
      case 800:
        return 'login_success';
      case 801:
        return 'login_failure';
      case 900:
        return 'unknown';
    }

    return 'Unknown $typeId';
  }

  /*
  // ignore: unused_element
  static void _initializeBuilder(SystemLogEntityBuilder builder) =>
      builder..history.replace(EmailHistoryEntity()
      );
  */

  static Serializer<SystemLogEntity> get serializer =>
      _$systemLogEntitySerializer;
}

abstract class EmailHistoryEntity
    implements Built<EmailHistoryEntity, EmailHistoryEntityBuilder> {
  factory EmailHistoryEntity() {
    return _$EmailHistoryEntity._(
      recipients: '',
      subject: '',
      entity: '',
      entityId: '',
      events: BuiltList<EmailHistoryEventEntity>(),
    );
  }

  EmailHistoryEntity._();

  @override
  @memoized
  int get hashCode;

  String get recipients;

  String get subject;

  String get entity;

  @BuiltValueField(wireName: 'entity_id')
  String get entityId;

  BuiltList<EmailHistoryEventEntity> get events;

  // ignore: unused_element
  static void _initializeBuilder(EmailHistoryEntityBuilder builder) => builder
    ..recipients = ''
    ..subject = ''
    ..entity = ''
    ..entityId = ''
    ..events.replace(BuiltList<EmailHistoryEventEntity>());

  static Serializer<EmailHistoryEntity> get serializer =>
      _$emailHistoryEntitySerializer;
}

abstract class EmailHistoryEventEntity
    implements Built<EmailHistoryEventEntity, EmailHistoryEventEntityBuilder> {
  factory EmailHistoryEventEntity() {
    return _$EmailHistoryEventEntity._(
      recipient: '',
      status: '',
      deliveryMessage: '',
      server: '',
      serverIp: '',
      date: '',
    );
  }

  EmailHistoryEventEntity._();

  @override
  @memoized
  int get hashCode;

  String get recipient;

  String get status;

  @BuiltValueField(wireName: 'delivery_message')
  String get deliveryMessage;

  String get server;

  @BuiltValueField(wireName: 'server_ip')
  String get serverIp;

  String get date;

  // ignore: unused_element
  static void _initializeBuilder(EmailHistoryEventEntityBuilder builder) =>
      builder
        ..recipient = ''
        ..status = ''
        ..deliveryMessage = ''
        ..server = ''
        ..serverIp = '';

  static Serializer<EmailHistoryEventEntity> get serializer =>
      _$emailHistoryEventEntitySerializer;
}
