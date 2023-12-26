import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'bank_account_model.g.dart';

abstract class BankAccountListResponse
    implements Built<BankAccountListResponse, BankAccountListResponseBuilder> {
  factory BankAccountListResponse(
          [void updates(BankAccountListResponseBuilder b)]) =
      _$BankAccountListResponse;

  BankAccountListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<BankAccountEntity> get data;

  static Serializer<BankAccountListResponse> get serializer =>
      _$bankAccountListResponseSerializer;
}

abstract class BankAccountItemResponse
    implements Built<BankAccountItemResponse, BankAccountItemResponseBuilder> {
  factory BankAccountItemResponse(
          [void updates(BankAccountItemResponseBuilder b)]) =
      _$BankAccountItemResponse;

  BankAccountItemResponse._();

  @override
  @memoized
  int get hashCode;

  BankAccountEntity get data;

  static Serializer<BankAccountItemResponse> get serializer =>
      _$bankAccountItemResponseSerializer;
}

class BankAccountFields {
  static const String name = 'name';
  static const String type = 'type';
  static const String balance = 'balance';
}

abstract class BankAccountEntity extends Object
    with BaseEntity
    implements Built<BankAccountEntity, BankAccountEntityBuilder> {
  factory BankAccountEntity({String? id, AppState? state}) {
    return _$BankAccountEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      createdAt: 0,
      updatedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      archivedAt: 0,
      // STARTER: constructor - do not remove comment
      name: '',
      status: '',
      type: '',
      provider: '',
      balance: 0,
      currency: '',
      disabledUpstream: false,
      fromDate: '',
      autoSync: false,
      integrationType: '',
    );
  }

  BankAccountEntity._();

  static const String INTEGRATION_TYPE_YODLEE = 'yodlee';
  static const String INTEGRATION_TYPE_NORDIGEN = 'nordigen';

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'bank_account_name')
  String get name;

  @BuiltValueField(wireName: 'bank_account_status')
  String get status;

  @BuiltValueField(wireName: 'bank_account_type')
  String get type;

  @BuiltValueField(wireName: 'provider_name')
  String get provider;

  @BuiltValueField(wireName: 'from_date')
  String get fromDate;

  @BuiltValueField(wireName: 'auto_sync')
  bool get autoSync;

  @BuiltValueField(wireName: 'disabled_upstream')
  bool get disabledUpstream;

  @BuiltValueField(wireName: 'integration_type')
  String get integrationType;

  double get balance;

  String get currency;

  @override
  EntityType get entityType => EntityType.bankAccount;

  String get displayName {
    // STARTER: display name - do not remove comment
    return name;
  }

  bool get isConnected => type.isNotEmpty;

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted!) {
      if (!multiselect && includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(
      BankAccountEntity? bankAccount, String sortField, bool sortAscending) {
    int response = 0;
    final bankAccountA = sortAscending ? this : bankAccount;
    final bankAccountB = sortAscending ? bankAccount : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      case BankAccountFields.name:
        response = bankAccountA!.name
            .toLowerCase()
            .compareTo(bankAccountB!.name.toLowerCase());
        break;
      case BankAccountFields.balance:
        response = bankAccountA!.balance.compareTo(bankAccountB!.balance);
        break;
      case BankAccountFields.type:
        response = bankAccountA!.type
            .toLowerCase()
            .compareTo(bankAccountB!.type.toLowerCase());
        break;
      default:
        print('## ERROR: sort by bankAccount.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return bankAccountA!.name.compareTo(bankAccountB!.name);
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        name,
        type,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        name,
        type,
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName => name;

  @override
  double get listDisplayAmount => balance;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

// ignore: unused_element
  static void _initializeBuilder(BankAccountEntityBuilder builder) => builder
    ..fromDate = ''
    ..disabledUpstream = false
    ..autoSync = false
    ..integrationType = '';

  static Serializer<BankAccountEntity> get serializer =>
      _$bankAccountEntitySerializer;
}
