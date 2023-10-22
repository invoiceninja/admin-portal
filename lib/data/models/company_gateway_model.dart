// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/system_log_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'company_gateway_model.g.dart';

abstract class CompanyGatewayListResponse
    implements
        Built<CompanyGatewayListResponse, CompanyGatewayListResponseBuilder> {
  factory CompanyGatewayListResponse(
          [void updates(CompanyGatewayListResponseBuilder b)]) =
      _$CompanyGatewayListResponse;

  CompanyGatewayListResponse._();

  @override
  @memoized
  int get hashCode;

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

  @override
  @memoized
  int get hashCode;

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
  factory CompanyGatewayEntity({String? id, AppState? state}) {
    return _$CompanyGatewayEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      gatewayId: '',
      acceptedCreditCards: 0,
      requireCvv: false,
      requireShippingAddress: false,
      requireBillingAddress: false,
      requireClientName: false,
      requireClientPhone: false,
      requireContactEmail: true,
      requireContactName: false,
      requirePostalCode: true,
      requireCustomValue1: false,
      requireCustomValue2: false,
      requireCustomValue3: false,
      requireCustomValue4: false,
      updateDetails: true,
      config: '',
      feesAndLimitsMap: BuiltMap<String, FeesAndLimitsSettings>(),
      systemLogs: BuiltList<SystemLogEntity>(),
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      updatedAt: 0,
      archivedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      createdAt: 0,
      label: '',
      tokenBilling: SettingsEntity.AUTO_BILL_ALWAYS,
      isTestMode: false,
    );
  }

  CompanyGatewayEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(compare: false)
  int? get loadedAt;

  bool get isLoaded => loadedAt != null && loadedAt! > 0;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - loadedAt! >
        kMillisecondsToRefreshActivities;
  }

  @override
  EntityType get entityType {
    return EntityType.companyGateway;
  }

  @BuiltValueField(wireName: 'gateway_key')
  String get gatewayId;

  @BuiltValueField(wireName: 'accepted_credit_cards')
  int get acceptedCreditCards;

  @BuiltValueField(wireName: 'require_shipping_address')
  bool get requireShippingAddress;

  @BuiltValueField(wireName: 'require_billing_address')
  bool get requireBillingAddress;

  @BuiltValueField(wireName: 'require_client_name')
  bool get requireClientName;

  // TODO remove nullable
  @BuiltValueField(wireName: 'require_postal_code')
  bool? get requirePostalCode;

  @BuiltValueField(wireName: 'require_client_phone')
  bool get requireClientPhone;

  @BuiltValueField(wireName: 'require_contact_name')
  bool get requireContactName;

  @BuiltValueField(wireName: 'require_contact_email')
  bool get requireContactEmail;

  @BuiltValueField(wireName: 'require_custom_value1')
  bool get requireCustomValue1;

  @BuiltValueField(wireName: 'require_custom_value2')
  bool get requireCustomValue2;

  @BuiltValueField(wireName: 'require_custom_value3')
  bool get requireCustomValue3;

  @BuiltValueField(wireName: 'require_custom_value4')
  bool get requireCustomValue4;

  @BuiltValueField(wireName: 'require_cvv')
  bool get requireCvv;

  @BuiltValueField(wireName: 'update_details')
  bool get updateDetails;

  @BuiltValueField(wireName: 'fees_and_limits')
  BuiltMap<String?, FeesAndLimitsSettings> get feesAndLimitsMap;

  @BuiltValueField(wireName: 'system_logs')
  BuiltList<SystemLogEntity> get systemLogs;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  String get config;

  @BuiltValueField(wireName: 'token_billing')
  String get tokenBilling;

  @BuiltValueField(wireName: 'test_mode')
  bool get isTestMode;

  String get label;

  Map<String, dynamic>? get parsedConfig =>
      config.isEmpty ? <String, dynamic>{} : jsonDecode(config);

  FeesAndLimitsSettings getSettingsForGatewayTypeId(String? gatewayTypeId) =>
      feesAndLimitsMap[gatewayTypeId] ?? FeesAndLimitsSettings();

  @override
  String get listDisplayName =>
      (gatewayId == kGatewayCustom ? parsedConfig!['name'] : label) ?? label;

  bool get isCustom => gatewayId == kGatewayCustom;

  bool get isConnected {
    if (gatewayId != kGatewayStripeConnect) {
      return true;
    }

    final accountId = (parsedConfig!['account_id'] ?? '').toString();

    return accountId.isNotEmpty;
  }

  bool supportsCard(int cardType) => acceptedCreditCards & cardType > 0;

  CompanyGatewayEntity addCard(int? cardType) =>
      rebuild((b) => b..acceptedCreditCards = acceptedCreditCards | cardType!);

  CompanyGatewayEntity removeCard(int? cardType) =>
      rebuild((b) => b..acceptedCreditCards = acceptedCreditCards ^ cardType!);

  CompanyGatewayEntity updateConfig(String field, dynamic value) {
    final updatedConfig = parsedConfig;
    if (value.runtimeType == String && value == '') {
      updatedConfig!.remove(field);
    } else {
      updatedConfig![field] = value;
    }

    return rebuild((b) => b..config = jsonEncode(updatedConfig));
  }

  int compareTo(CompanyGatewayEntity? companyGateway, String sortField,
          bool sortAscending) =>
      0;

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        label,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
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

    if (!isDeleted! && !multiselect && userCompany!.canEditEntity(this)) {
      if (includeEdit) {
        actions.add(EntityAction.edit);
      }

      if (gatewayId == kGatewayStripeConnect && !isConnected) {
        actions.add(EntityAction.disconnect);
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

  // ignore: unused_element
  static void _initializeBuilder(CompanyGatewayEntityBuilder builder) => builder
    ..requireCustomValue1 = false
    ..requireCustomValue2 = false
    ..requireCustomValue3 = false
    ..requireCustomValue4 = false;

  static Serializer<CompanyGatewayEntity> get serializer =>
      _$companyGatewayEntitySerializer;
}

abstract class FeesAndLimitsSettings
    implements Built<FeesAndLimitsSettings, FeesAndLimitsSettingsBuilder> {
  factory FeesAndLimitsSettings({String? id, bool? isEnabled}) {
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
      isEnabled: isEnabled ?? false,
    );
  }

  FeesAndLimitsSettings._();

  @override
  @memoized
  int get hashCode;

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

  @BuiltValueField(wireName: 'is_enabled')
  bool get isEnabled;

  double calculateSampleFee(double amount) {
    double fee = 0;

    if (feePercent == 0) {
      fee = feeAmount;
    } else {
      if (adjustFeePercent) {
        fee +=
            round(((feeAmount + amount) / (1 - feePercent / 100)) - amount, 2);
      } else {
        fee = round(feeAmount + (amount * feePercent / 100), 2);
      }
    }

    if (taxRate1 != 0) {
      fee += round(amount * 1 / taxRate1, 2);
    }
    if (taxRate2 != 0) {
      fee += round(amount * 1 / taxRate2, 2);
    }
    if (taxRate2 != 0) {
      fee += round(amount * 1 / taxRate2, 2);
    }

    if (feeCap > 0 && fee > feeCap) {
      fee = feeCap;
    }

    return fee;
  }

  // ignore: unused_element
  static void _initializeBuilder(FeesAndLimitsSettingsBuilder builder) =>
      builder..isEnabled = false;

  static Serializer<FeesAndLimitsSettings> get serializer =>
      _$feesAndLimitsSettingsSerializer;
}
