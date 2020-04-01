import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
  static const String updatedAt = 'updated_at';
}

abstract class CompanyGatewayEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<CompanyGatewayEntity, CompanyGatewayEntityBuilder> {
  factory CompanyGatewayEntity({String id, AppState state}) {
    return _$CompanyGatewayEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      gateway: GatewayEntity(),
      gatewayId: '',
      acceptedCreditCards: 0,
      showBillingAddress: true,
      showShippingAddress: false,
      updateDetails: true,
      config: '',
      feesAndLimitsMap: BuiltMap<String, FeesAndLimitsSettings>(),
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      updatedAt: 0,
      archivedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      createdAt: 0,
    );
  }

  CompanyGatewayEntity._();

  @override
  EntityType get entityType {
    return EntityType.companyGateway;
  }

  GatewayEntity get gateway;

  @BuiltValueField(wireName: 'gateway_key')
  String get gatewayId;

  @BuiltValueField(wireName: 'accepted_credit_cards')
  int get acceptedCreditCards;

  @BuiltValueField(wireName: 'show_billing_address')
  bool get showBillingAddress;

  @BuiltValueField(wireName: 'show_shipping_address')
  bool get showShippingAddress;

  @BuiltValueField(wireName: 'update_details')
  bool get updateDetails;

  @BuiltValueField(wireName: 'fees_and_limits')
  BuiltMap<String, FeesAndLimitsSettings> get feesAndLimitsMap;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  String get config;

  Map<String, dynamic> get parsedConfig =>
      config.isEmpty ? <String, dynamic>{} : jsonDecode(config);

  FeesAndLimitsSettings getSettingsForGatewayTypeId(String gatewayTypeId) =>
      feesAndLimitsMap[gatewayTypeId] ?? FeesAndLimitsSettings();

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
          bool sortAscending) =>
      0;

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

abstract class FeesAndLimitsSettings
    implements Built<FeesAndLimitsSettings, FeesAndLimitsSettingsBuilder> {
  factory FeesAndLimitsSettings({String id}) {
    return _$FeesAndLimitsSettings._(
      maxLimit: -1,
      minLimit: -1,
      adjustFeePercent: false,
      feeAmount: 0,
      feeCap: 0,
      feePercent: 0,
      taxName1: '',
      taxName2: '',
      taxName3: '',
      taxRate1: 0,
      taxRate2: 0,
      taxRate3: 0,
    );
  }

  FeesAndLimitsSettings._();

  @BuiltValueField(wireName: 'min_limit')
  double get minLimit;

  @BuiltValueField(wireName: 'max_limit')
  double get maxLimit;

  @BuiltValueField(wireName: 'fee_amount')
  double get feeAmount;

  @BuiltValueField(wireName: 'fee_percent')
  double get feePercent;

  @BuiltValueField(wireName: 'fee_cap')
  double get feeCap;

  @BuiltValueField(wireName: 'fee_tax_rate1')
  double get taxRate1;

  @BuiltValueField(wireName: 'fee_tax_name1')
  String get taxName1;

  @BuiltValueField(wireName: 'fee_tax_rate2')
  double get taxRate2;

  @BuiltValueField(wireName: 'fee_tax_name2')
  String get taxName2;

  @BuiltValueField(wireName: 'fee_tax_rate3')
  double get taxRate3;

  @BuiltValueField(wireName: 'fee_tax_name3')
  String get taxName3;

  @BuiltValueField(wireName: 'adjust_fee_percent')
  bool get adjustFeePercent;

  static Serializer<FeesAndLimitsSettings> get serializer =>
      _$feesAndLimitsSettingsSerializer;
}
