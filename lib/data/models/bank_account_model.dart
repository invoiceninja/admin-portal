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
  // STARTER: fields - do not remove comment
  static const String name = 'name';
}

abstract class BankAccountEntity extends Object
    with BaseEntity
    implements Built<BankAccountEntity, BankAccountEntityBuilder> {
  factory BankAccountEntity({String id, AppState state}) {
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
    );
  }

  BankAccountEntity._();

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

  double get balance;

  String get currency;

  @override
  EntityType get entityType => EntityType.bankAccount;

  String get displayName {
    // STARTER: display name - do not remove comment
    return name;
  }

  /*
  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    return actions..addAll(super.getActions(userCompany: userCompany));
  }
  */

  int compareTo(
      BankAccountEntity bankAccount, String sortField, bool sortAscending) {
    int response = 0;
    final bankAccountA = sortAscending ? this : bankAccount;
    final bankAccountB = sortAscending ? bankAccount : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      case BankAccountFields.name:
        response = bankAccountA.name.compareTo(bankAccountB.name);
        break;

      default:
        print('## ERROR: sort by bankAccount.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return bankAccountA.name.compareTo(bankAccountB.name);
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String filter) {
    return matchesStrings(
      haystacks: [
        name,
        type,
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        name,
        type,
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName => null;

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => null;

  static Serializer<BankAccountEntity> get serializer =>
      _$bankAccountEntitySerializer;
}
