// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'webhook_model.g.dart';

abstract class WebhookListResponse
    implements Built<WebhookListResponse, WebhookListResponseBuilder> {
  factory WebhookListResponse([void updates(WebhookListResponseBuilder b)]) =
      _$WebhookListResponse;

  WebhookListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<WebhookEntity> get data;

  static Serializer<WebhookListResponse> get serializer =>
      _$webhookListResponseSerializer;
}

abstract class WebhookItemResponse
    implements Built<WebhookItemResponse, WebhookItemResponseBuilder> {
  factory WebhookItemResponse([void updates(WebhookItemResponseBuilder b)]) =
      _$WebhookItemResponse;

  WebhookItemResponse._();

  @override
  @memoized
  int get hashCode;

  WebhookEntity get data;

  static Serializer<WebhookItemResponse> get serializer =>
      _$webhookItemResponseSerializer;
}

class WebhookFields {
  static const String targetUrl = 'target_url';
  static const String eventId = 'event_id';
}

abstract class WebhookEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<WebhookEntity, WebhookEntityBuilder> {
  factory WebhookEntity({String id, AppState state}) {
    return _$WebhookEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      eventId: '',
      format: 'JSON',
      targetUrl: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      createdAt: 0,
      assignedUserId: '',
      createdUserId: '',
      restMethod: '',
      headers: BuiltMap<String, String>(),
    );
  }

  WebhookEntity._();

  static const EVENT_CREATE_CLIENT = '1';
  static const EVENT_CREATE_INVOICE = '2';
  static const EVENT_CREATE_QUOTE = '3';
  static const EVENT_CREATE_PAYMENT = '4';
  static const EVENT_CREATE_VENDOR = '5';
  static const EVENT_UPDATE_QUOTE = '6';
  static const EVENT_DELETE_QUOTE = '7';
  static const EVENT_UPDATE_INVOICE = '8';
  static const EVENT_DELETE_INVOICE = '9';
  static const EVENT_UPDATE_CLIENT = '10';
  static const EVENT_DELETE_CLIENT = '11';
  static const EVENT_DELETE_PAYMENT = '12';
  static const EVENT_UPDATE_VENDOR = '13';
  static const EVENT_DELETE_VENDOR = '14';
  static const EVENT_CREATE_EXPENSE = '15';
  static const EVENT_UPDATE_EXPENSE = '16';
  static const EVENT_DELETE_EXPENSE = '17';
  static const EVENT_CREATE_TASK = '18';
  static const EVENT_UPDATE_TASK = '19';
  static const EVENT_DELETE_TASK = '20';
  static const EVENT_APPROVE_QUOTE = '21';
  static const EVENT_LATE_INVOICE = '22';
  static const EVENT_EXPIRED_QUOTE = '23';
  static const EVENT_REMIND_INVOICE = '24';
  static const EVENT_CREATE_PROJECT = '25';
  static const EVENT_UPDATE_PROJECT = '26';
  static const EVENT_CREATE_CREDIT = '27';
  static const EVENT_UPDATE_CREDIT = '28';
  static const EVENT_DELETE_CREDIT = '29';
  static const EVENT_DELETE_PROJECT = '30';
  static const EVENT_UPDATE_PAYMENT = '31';

  static const EVENT_MAP = {
    EVENT_CREATE_CLIENT: 'create_client',
    EVENT_UPDATE_CLIENT: 'update_client',
    EVENT_DELETE_CLIENT: 'delete_client',
    EVENT_CREATE_INVOICE: 'create_invoice',
    EVENT_UPDATE_INVOICE: 'update_invoice',
    EVENT_LATE_INVOICE: 'late_invoice',
    EVENT_REMIND_INVOICE: 'remind_invoice',
    EVENT_DELETE_INVOICE: 'delete_invoice',
    EVENT_CREATE_QUOTE: 'create_quote',
    EVENT_UPDATE_QUOTE: 'update_quote',
    EVENT_APPROVE_QUOTE: 'approve_quote',
    EVENT_EXPIRED_QUOTE: 'expired_quote',
    EVENT_DELETE_QUOTE: 'delete_quote',
    EVENT_CREATE_CREDIT: 'create_credit',
    EVENT_UPDATE_CREDIT: 'update_credit',
    EVENT_DELETE_CREDIT: 'delete_credit',
    EVENT_CREATE_PAYMENT: 'create_payment',
    EVENT_UPDATE_PAYMENT: 'update_payment',
    EVENT_DELETE_PAYMENT: 'delete_payment',
    EVENT_CREATE_VENDOR: 'create_vendor',
    EVENT_UPDATE_VENDOR: 'update_vendor',
    EVENT_DELETE_VENDOR: 'delete_vendor',
    EVENT_CREATE_EXPENSE: 'create_expense',
    EVENT_UPDATE_EXPENSE: 'update_expense',
    EVENT_DELETE_EXPENSE: 'delete_expense',
    EVENT_CREATE_TASK: 'create_task',
    EVENT_UPDATE_TASK: 'update_task',
    EVENT_DELETE_TASK: 'delete_task',
    EVENT_CREATE_PROJECT: 'create_project',
    EVENT_UPDATE_PROJECT: 'update_project',
    EVENT_DELETE_PROJECT: 'delete_project',
  };

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType {
    return EntityType.webhook;
  }

  @BuiltValueField(wireName: 'event_id')
  String get eventId;

  @BuiltValueField(wireName: 'target_url')
  String get targetUrl;

  String get format;

  @BuiltValueField(wireName: 'rest_method')
  String get restMethod;

  BuiltMap<String, String> get headers;

  @override
  String get listDisplayName {
    return targetUrl;
  }

  String get eventType => EVENT_MAP[eventId];

  int compareTo(WebhookEntity webhook, String sortField, bool sortAscending) {
    int response = 0;
    final WebhookEntity webhookA = sortAscending ? this : webhook;
    final WebhookEntity webhookB = sortAscending ? webhook : this;

    switch (sortField) {
      case WebhookFields.targetUrl:
        response = webhookA.targetUrl
            .toLowerCase()
            .compareTo(webhookB.targetUrl.toLowerCase());
        break;
      default:
        print('## ERROR: sort by webhook.$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    return matchesStrings(
      haystacks: [
        targetUrl,
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        targetUrl,
      ],
      needle: filter,
    );
  }

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted && !multiselect) {
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => null;

  // ignore: unused_element
  static void _initializeBuilder(WebhookEntityBuilder builder) => builder
    ..headers.replace(BuiltMap<String, String>())
    ..restMethod = '';

  static Serializer<WebhookEntity> get serializer => _$webhookEntitySerializer;
}
