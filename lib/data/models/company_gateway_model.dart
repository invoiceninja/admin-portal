import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'company_gateway_model.g.dart';

abstract class CompanyGatewayListResponse
    implements Built<CompanyGatewayListResponse, CompanyGatewayListResponseBuilder> {
  factory CompanyGatewayListResponse([void updates(CompanyGatewayListResponseBuilder b)]) =
  _$CompanyGatewayListResponse;

  CompanyGatewayListResponse._();

  BuiltList<CompanyGatewayEntity> get data;

  static Serializer<CompanyGatewayListResponse> get serializer =>
      _$companyGatewayListResponseSerializer;
}

abstract class CompanyGatewayItemResponse
    implements Built<CompanyGatewayItemResponse, CompanyGatewayItemResponseBuilder> {
  factory CompanyGatewayItemResponse([void updates(CompanyGatewayItemResponseBuilder b)]) =
  _$CompanyGatewayItemResponse;

  CompanyGatewayItemResponse._();

  CompanyGatewayEntity get data;

  static Serializer<CompanyGatewayItemResponse> get serializer =>
      _$companyGatewayItemResponseSerializer;
}

class CompanyGatewayFields {
  static const String name = 'name';
  static const String custom1 = 'customValue1';
  static const String custom2 = 'customValue2';
}

abstract class CompanyGatewayEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<CompanyGatewayEntity, CompanyGatewayEntityBuilder> {
  factory CompanyGatewayEntity({String id}) {
    return _$CompanyGatewayEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      name: '',
      settings: SettingsEntity(),
      customValue1: '',
      customValue2: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  CompanyGatewayEntity._();

  @override
  EntityType get entityType {
    return EntityType.companyGateway;
  }

  String get name;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  SettingsEntity get settings;

  @override
  String get listDisplayName {
    return name;
  }

  int compareTo(CompanyGatewayEntity companyGateway, String sortField, bool sortAscending) {
    const int response = 0;
    final CompanyGatewayEntity companyGatewayA = sortAscending ? this : companyGateway;
    final CompanyGatewayEntity companyGatewayB = sortAscending ? companyGateway : this;

    switch (sortField) {
      case CompanyGatewayFields.name:
      //response = companyGatewayA.balance.compareTo(companyGatewayB.balance);
      //break;
    }

    if (response == 0) {
      return companyGatewayA.name.toLowerCase().compareTo(companyGatewayB.name.toLowerCase());
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

  static Serializer<CompanyGatewayEntity> get serializer => _$companyGatewayEntitySerializer;
}
