// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'gateway_token_model.g.dart';

abstract class GatewayTokenListResponse
    implements
        Built<GatewayTokenListResponse, GatewayTokenListResponseBuilder> {
  factory GatewayTokenListResponse(
          [void updates(GatewayTokenListResponseBuilder b)]) =
      _$GatewayTokenListResponse;

  GatewayTokenListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<GatewayTokenEntity> get data;

  static Serializer<GatewayTokenListResponse> get serializer =>
      _$gatewayTokenListResponseSerializer;
}

abstract class GatewayTokenItemResponse
    implements
        Built<GatewayTokenItemResponse, GatewayTokenItemResponseBuilder> {
  factory GatewayTokenItemResponse(
          [void updates(GatewayTokenItemResponseBuilder b)]) =
      _$GatewayTokenItemResponse;

  GatewayTokenItemResponse._();

  @override
  @memoized
  int get hashCode;

  GatewayTokenEntity get data;

  static Serializer<GatewayTokenItemResponse> get serializer =>
      _$gatewayTokenItemResponseSerializer;
}

class GatewayTokenFields {
  static const String name = 'name';
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
}

abstract class GatewayTokenEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<GatewayTokenEntity, GatewayTokenEntityBuilder> {
  factory GatewayTokenEntity({String? id}) {
    return _$GatewayTokenEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      token: '',
      customerReference: '',
      gatewayTypeId: '',
      isDefault: false,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      companyGatewayId: '',
      createdAt: 0,
      assignedUserId: '',
      createdUserId: '',
      meta: GatewayTokenMetaEntity(),
    );
  }

  GatewayTokenEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType {
    return EntityType.gatewayToken;
  }

  String get token;

  @BuiltValueField(wireName: 'gateway_customer_reference')
  String get customerReference;

  @BuiltValueField(wireName: 'company_gateway_id')
  String get companyGatewayId;

  @BuiltValueField(wireName: 'gateway_type_id')
  String get gatewayTypeId;

  @BuiltValueField(wireName: 'is_default')
  bool get isDefault;

  GatewayTokenMetaEntity get meta;

  @override
  String get listDisplayName {
    return customerReference;
  }

  int compareTo(
      GatewayTokenEntity gatewayToken, String sortField, bool sortAscending) {
    const int response = 0;
    final GatewayTokenEntity gatewayTokenA =
        sortAscending ? this : gatewayToken;
    final GatewayTokenEntity gatewayTokenB =
        sortAscending ? gatewayToken : this;

    switch (sortField) {
      case GatewayTokenFields.name:
      //response = gatewayTokenA.balance.compareTo(gatewayTokenB.balance);
      //break;
    }

    if (response == 0) {
      return gatewayTokenA.customerReference
          .toLowerCase()
          .compareTo(gatewayTokenB.customerReference.toLowerCase());
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [customerReference],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [customerReference],
      needle: filter,
    );
  }

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
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType? get listDisplayAmountType => null;

  static Serializer<GatewayTokenEntity> get serializer =>
      _$gatewayTokenEntitySerializer;
}

abstract class GatewayTokenMetaEntity
    implements Built<GatewayTokenMetaEntity, GatewayTokenMetaEntityBuilder> {
  factory GatewayTokenMetaEntity() {
    return _$GatewayTokenMetaEntity._();
  }

  GatewayTokenMetaEntity._();

  @override
  @memoized
  int get hashCode;

  String? get brand;

  String? get last4;

  int? get type;

  @BuiltValueField(wireName: 'exp_month')
  String? get expMonth;

  @BuiltValueField(wireName: 'exp_year')
  String? get expYear;

  static Serializer<GatewayTokenMetaEntity> get serializer =>
      _$gatewayTokenMetaEntitySerializer;
}
