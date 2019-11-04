import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'company_gateway_model.g.dart';

abstract class CompanyGatewayListResponse
    implements
        Built<CompanyGatewayListResponse, CompanyGatewayListResponseBuilder> {
  factory CompanyGatewayListResponse(
          [void updates(CompanyGatewayListResponseBuilder b)]) =
      _$CompanyGatewayListResponse;

  CompanyGatewayListResponse._();

  BuiltList<CompanyGatewayEntity> get data;

  static Serializer<CompanyGatewayListResponse> get serializer =>
      _$companyGatewayListResponseSerializer;
}

abstract class CompanyGatewayItemResponse
    implements
        Built<CompanyGatewayItemResponse, CompanyGatewayItemResponseBuilder> {
  factory CompanyGatewayItemResponse(
          [void updates(CompanyGatewayItemResponseBuilder b)]) =
      _$CompanyGatewayItemResponse;

  CompanyGatewayItemResponse._();

  CompanyGatewayEntity get data;

  static Serializer<CompanyGatewayItemResponse> get serializer =>
      _$companyGatewayItemResponseSerializer;
}

class CompanyGatewayFields {
  static const String name = 'name';
  static const String priority = 'priority';
  static const String updatedAt = 'updatedAt';
}

abstract class CompanyGatewayEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<CompanyGatewayEntity, CompanyGatewayEntityBuilder> {
  factory CompanyGatewayEntity({String id}) {
    return _$CompanyGatewayEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      gateway: GatewayEntity(),
      gatewayId: null,
      acceptedCreditCards: 0,
      showBillingAddress: true,
      showShippingAddress: false,
      updateDetails: true,
      customValue1: '',
      customValue2: '',
      config: '',
      priority: 0,
    );
  }

  CompanyGatewayEntity._();

  @override
  EntityType get entityType {
    return EntityType.companyGateway;
  }

  GatewayEntity get gateway;

  @nullable
  @BuiltValueField(wireName: 'gateway_key')
  String get gatewayId;

  @nullable
  @BuiltValueField(wireName: 'gateway_type_id')
  String get gatewayTypeId;

  @BuiltValueField(wireName: 'accepted_credit_cards')
  int get acceptedCreditCards;

  @BuiltValueField(wireName: 'show_billing_address')
  bool get showBillingAddress;

  @BuiltValueField(wireName: 'show_shipping_address')
  bool get showShippingAddress;

  @BuiltValueField(wireName: 'update_details')
  bool get updateDetails;

  @nullable
  @BuiltValueField(wireName: 'priority_id')
  int get priority;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'min_limit')
  double get minLimit;

  @nullable
  @BuiltValueField(wireName: 'max_limit')
  double get maxLimit;

  @nullable
  @BuiltValueField(wireName: 'fee_amount')
  double get feeAmount;

  @nullable
  @BuiltValueField(wireName: 'fee_percent')
  double get feePercent;

  @nullable
  @BuiltValueField(wireName: 'fee_cap')
  double get feeCap;

  @nullable
  @BuiltValueField(wireName: 'fee_tax_rate1')
  double get taxRate1;

  @nullable
  @BuiltValueField(wireName: 'fee_tax_name1')
  String get taxName1;

  @nullable
  @BuiltValueField(wireName: 'fee_tax_rate2')
  double get taxRate2;

  @nullable
  @BuiltValueField(wireName: 'fee_tax_name2')
  String get taxName2;

  @nullable
  @BuiltValueField(wireName: 'fee_tax_rate3')
  double get taxRate3;

  @nullable
  @BuiltValueField(wireName: 'fee_tax_name3')
  String get taxName3;

  String get config;

  Map<String, dynamic> get parsedConfig =>
      config.isEmpty ? <String, dynamic>{} : jsonDecode(config);

  @override
  String get listDisplayName {
    return gateway.name;
  }

  bool supportsCard(int cardType) => acceptedCreditCards & cardType > 0;

  CompanyGatewayEntity addCard(int cardType) =>
      rebuild((b) => b..acceptedCreditCards = acceptedCreditCards | cardType);

  CompanyGatewayEntity removeCard(int cardType) =>
      rebuild((b) => b..acceptedCreditCards = acceptedCreditCards ^ cardType);

  CompanyGatewayEntity updateConfig(String field, dynamic value) {
    final updatedConfig = parsedConfig;
    if (value.runtimeType == String && value == '') {
      updatedConfig.remove(field);
    } else {
      updatedConfig[field] = value;
    }

    return rebuild((b) => b..config = jsonEncode(updatedConfig));
  }

  int compareTo(CompanyGatewayEntity companyGateway, String sortField,
      bool sortAscending) {
    int response = 0;
    final CompanyGatewayEntity companyGatewayA =
        sortAscending ? this : companyGateway;
    final CompanyGatewayEntity companyGatewayB =
        sortAscending ? companyGateway : this;

    switch (sortField) {
      case CompanyGatewayFields.priority:
        response = (companyGatewayA.priority ?? 0)
            .compareTo(companyGatewayB.priority ?? 0);
        break;
    }

    if (response == 0) {
      return companyGatewayA.gateway.name
          .toLowerCase()
          .compareTo(companyGatewayB.gateway.name.toLowerCase());
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

    if (gateway.name.toLowerCase().contains(filter)) {
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

  static Serializer<CompanyGatewayEntity> get serializer =>
      _$companyGatewayEntitySerializer;
}
