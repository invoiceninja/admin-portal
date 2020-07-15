import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

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
    );
  }

  WebhookEntity._();

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

  @override
  String get listDisplayName {
    return targetUrl;
  }

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
    if (filter == null || filter.isEmpty) {
      return true;
    }
    filter = filter.toLowerCase();

    if (targetUrl.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    return null;
  }

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    // TODO remove ??
    if (!(isDeleted ?? false)) {
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => null;

  static Serializer<WebhookEntity> get serializer => _$webhookEntitySerializer;
}
