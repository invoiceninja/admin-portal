import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'gateway_token_model.g.dart';

abstract class GatewayTokenListResponse
    implements
        Built<GatewayTokenListResponse, GatewayTokenListResponseBuilder> {
  factory GatewayTokenListResponse(
          [void updates(GatewayTokenListResponseBuilder b)]) =
      _$GatewayTokenListResponse;

  GatewayTokenListResponse._();

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
  factory GatewayTokenEntity({String id}) {
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
    );
  }

  GatewayTokenEntity._();

  @override
  EntityType get entityType {
    return EntityType.gatewayToken;
  }

  String get token;

  @BuiltValueField(wireName: 'gateway_customer_reference')
  String get customerReference;

  @BuiltValueField(wireName: 'gateway_type_id')
  String get gatewayTypeId;

  @BuiltValueField(wireName: 'is_default')
  bool get isDefault;

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
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }
    filter = filter.toLowerCase();

    if (customerReference.toLowerCase().contains(filter)) {
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

      if (userCompany.canEditEntity(this)) {
        actions.add(EntityAction.settings);
      }

      if (userCompany.canCreate(EntityType.client)) {
        actions.add(EntityAction.newClient);
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

  static Serializer<GatewayTokenEntity> get serializer =>
      _$gatewayTokenEntitySerializer;
}
