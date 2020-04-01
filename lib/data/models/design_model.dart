import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'design_model.g.dart';

abstract class DesignListResponse
    implements Built<DesignListResponse, DesignListResponseBuilder> {
  factory DesignListResponse([void updates(DesignListResponseBuilder b)]) =
      _$DesignListResponse;

  DesignListResponse._();

  BuiltList<DesignEntity> get data;

  static Serializer<DesignListResponse> get serializer =>
      _$designListResponseSerializer;
}

abstract class DesignItemResponse
    implements Built<DesignItemResponse, DesignItemResponseBuilder> {
  factory DesignItemResponse([void updates(DesignItemResponseBuilder b)]) =
      _$DesignItemResponse;

  DesignItemResponse._();

  DesignEntity get data;

  static Serializer<DesignItemResponse> get serializer =>
      _$designItemResponseSerializer;
}

abstract class DesignPreviewRequest
    implements Built<DesignPreviewRequest, DesignPreviewRequestBuilder> {
  factory DesignPreviewRequest({
    EntityType entityType,
    String entityId,
    DesignEntity design,
  }) {
    return _$DesignPreviewRequest._(
      entityType: entityType ?? EntityType.invoice,
      entityId: entityId ?? '',
      design: design,
    );
  }

  DesignPreviewRequest._();

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
      {String id, AppState state, BuiltMap<String, String> design}) {
    return _$DesignEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
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
    );
  }

  DesignEntity._();

  @override
  EntityType get entityType => EntityType.design;

  String get name;

  BuiltMap<String, String> get design;

  @BuiltValueField(wireName: 'is_custom')
  bool get isCustom;

  DesignEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false);

  String get displayName => name;

  String getSection(String section) => design[section];

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (!multiselect && includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }
    }

    if (userCompany.canCreate(EntityType.design) && !multiselect) {
      actions.add(EntityAction.clone);
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(DesignEntity design, String sortField, bool sortAscending) {
    int response = 0;
    final designA = sortAscending ? this : design;
    final designB = sortAscending ? design : this;

    switch (sortField) {
      case DesignFields.updatedAt:
        response = designA.updatedAt.compareTo(designB.updatedAt);
    }

    if (response == 0) {
      return designA.name.toLowerCase().compareTo(designB.name.toLowerCase());
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String filter) {
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
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    return null;
  }

  @override
  String get listDisplayName => name;

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => null;

  static Serializer<DesignEntity> get serializer => _$designEntitySerializer;
}
