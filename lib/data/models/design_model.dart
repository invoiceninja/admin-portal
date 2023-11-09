// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'design_model.g.dart';

abstract class DesignListResponse
    implements Built<DesignListResponse, DesignListResponseBuilder> {
  factory DesignListResponse([void updates(DesignListResponseBuilder b)]) =
      _$DesignListResponse;

  DesignListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<DesignEntity> get data;

  static Serializer<DesignListResponse> get serializer =>
      _$designListResponseSerializer;
}

abstract class DesignItemResponse
    implements Built<DesignItemResponse, DesignItemResponseBuilder> {
  factory DesignItemResponse([void updates(DesignItemResponseBuilder b)]) =
      _$DesignItemResponse;

  DesignItemResponse._();

  @override
  @memoized
  int get hashCode;

  DesignEntity get data;

  static Serializer<DesignItemResponse> get serializer =>
      _$designItemResponseSerializer;
}

abstract class DesignPreviewRequest
    implements Built<DesignPreviewRequest, DesignPreviewRequestBuilder> {
  factory DesignPreviewRequest({
    EntityType? entityType,
    String? entityId,
    required DesignEntity design,
  }) {
    return _$DesignPreviewRequest._(
      entityType: entityType ?? EntityType.invoice,
      entityId: entityId ?? '',
      design: design,
    );
  }

  DesignPreviewRequest._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'entity_type')
  EntityType get entityType;

  @BuiltValueField(wireName: 'entity_id')
  String get entityId;

  DesignEntity get design;

  static Serializer<DesignPreviewRequest> get serializer =>
      _$designPreviewRequestSerializer;
}

class DesignFields {
  static const String name = 'name';
  static const String updatedAt = 'updated_at';
}

abstract class DesignEntity extends Object
    with BaseEntity
    implements Built<DesignEntity, DesignEntityBuilder> {
  factory DesignEntity(
      {String? id, AppState? state, BuiltMap<String, String>? design}) {
    if (design == null && state != null) {
      final designMap = state.designState.map;
      design = designMap[state.company.settings.defaultInvoiceDesignId]?.design;
    }

    return _$DesignEntity._(
      id: id ?? BaseEntity.nextId,
      createdAt: 0,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      isChanged: false,
      isFree: true,
      name: '',
      design: design ??
          BuiltMap<String, String>({
            kDesignHeader: '',
            kDesignBody: '',
            kDesignFooter: '',
            kDesignProducts: '',
            kDesignTasks: '',
            kDesignIncludes: '',
          }),
      isCustom: true,
      isTemplate: false,
      entities: '',
    );
  }

  DesignEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType => EntityType.design;

  String get name;

  BuiltMap<String, String> get design;

  @BuiltValueField(wireName: 'is_custom')
  bool get isCustom;

  @BuiltValueField(wireName: 'is_free')
  bool get isFree;

  @BuiltValueField(wireName: 'is_template')
  bool get isTemplate;

  String get entities;

  DesignEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false);

  String get displayName => name;

  String? getSection(String section) => design[section];

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted! && !multiselect) {
      if (includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany!.canCreate(EntityType.invoice)) {
        actions.add(EntityAction.newInvoice);
      }
      if (userCompany.canCreate(EntityType.quote)) {
        actions.add(EntityAction.newQuote);
      }
      if (userCompany.canCreate(EntityType.credit)) {
        actions.add(EntityAction.newClient);
      }
      if (userCompany.canCreate(EntityType.recurringInvoice)) {
        actions.add(EntityAction.newRecurringInvoice);
      }
    }

    if (userCompany!.canCreate(EntityType.design) && !multiselect) {
      actions.add(EntityAction.clone);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(DesignEntity? design, String sortField, bool sortAscending) {
    int response = 0;
    final designA = sortAscending ? this : design;
    final designB = sortAscending ? design : this;

    switch (sortField) {
      case DesignFields.updatedAt:
        response = designA!.updatedAt.compareTo(designB!.updatedAt);
    }

    if (response == 0) {
      return designA!.name.toLowerCase().compareTo(designB!.name.toLowerCase());
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [name],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [name],
      needle: filter,
    );
  }

  @override
  String get listDisplayName => name;

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType? get listDisplayAmountType => null;

  bool supportsEntityType(EntityType entityType) =>
      isTemplate && entities.split(',').contains(entityType.apiValue);

  // ignore: unused_element
  static void _initializeBuilder(DesignEntityBuilder builder) => builder
    ..isFree = true
    ..isTemplate = false
    ..entities = '';

  static Serializer<DesignEntity> get serializer => _$designEntitySerializer;
}
