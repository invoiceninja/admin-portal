import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'transaction_rule_model.g.dart';

abstract class TransactionRuleListResponse
    implements
        Built<TransactionRuleListResponse, TransactionRuleListResponseBuilder> {
  factory TransactionRuleListResponse(
          [void updates(TransactionRuleListResponseBuilder b)]) =
      _$TransactionRuleListResponse;

  TransactionRuleListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<TransactionRuleEntity> get data;

  static Serializer<TransactionRuleListResponse> get serializer =>
      _$transactionRuleListResponseSerializer;
}

abstract class TransactionRuleItemResponse
    implements
        Built<TransactionRuleItemResponse, TransactionRuleItemResponseBuilder> {
  factory TransactionRuleItemResponse(
          [void updates(TransactionRuleItemResponseBuilder b)]) =
      _$TransactionRuleItemResponse;

  TransactionRuleItemResponse._();

  @override
  @memoized
  int get hashCode;

  TransactionRuleEntity get data;

  static Serializer<TransactionRuleItemResponse> get serializer =>
      _$transactionRuleItemResponseSerializer;
}

class TransactionRuleFields {
  static const String name = 'name';
}

abstract class TransactionRuleEntity extends Object
    with BaseEntity
    implements Built<TransactionRuleEntity, TransactionRuleEntityBuilder> {
  factory TransactionRuleEntity({String? id, AppState? state}) {
    return _$TransactionRuleEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      createdAt: 0,
      updatedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      archivedAt: 0,
      name: '',
      matchesOnAll: true,
      autoConvert: false,
      appliesTo: TransactionEntity.TYPE_WITHDRAWL,
      vendorId: '',
      categoryId: '',
      rules: BuiltList<TransactionRuleCriteriaEntity>(),
    );
  }

  TransactionRuleEntity._();

  @override
  @memoized
  int get hashCode;

  String get name;

  @BuiltValueField(wireName: 'matches_on_all')
  bool get matchesOnAll;

  @BuiltValueField(wireName: 'auto_convert')
  bool get autoConvert;

  @BuiltValueField(wireName: 'applies_to')
  String get appliesTo;

  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  @BuiltValueField(wireName: 'category_id')
  String get categoryId;

  BuiltList<TransactionRuleCriteriaEntity> get rules;

  @override
  EntityType get entityType => EntityType.transactionRule;

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted! &&
        !multiselect &&
        includeEdit &&
        userCompany!.canEditEntity(this)) {
      actions.add(EntityAction.edit);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(TransactionRuleEntity? transactionRule, String sortField,
      bool sortAscending) {
    int response = 0;
    final transactionRuleA = sortAscending ? this : transactionRule;
    final transactionRuleB = sortAscending ? transactionRule : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      case TransactionRuleFields.name:
        response = transactionRuleA!.name
            .toLowerCase()
            .compareTo(transactionRuleB!.name.toLowerCase());
        break;

      default:
        print(
            '## ERROR: sort by transactionRule.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return transactionRuleA!.name.compareTo(transactionRuleB!.name);
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        name,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        //
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName => name;

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType? get listDisplayAmountType => null;

  static Serializer<TransactionRuleEntity> get serializer =>
      _$transactionRuleEntitySerializer;
}

abstract class TransactionRuleCriteriaEntity
    implements
        Built<TransactionRuleCriteriaEntity,
            TransactionRuleCriteriaEntityBuilder> {
  factory TransactionRuleCriteriaEntity(
      {String? searchKey, String? operator, String? value}) {
    return _$TransactionRuleCriteriaEntity._(
      searchKey: searchKey ?? SEARCH_KEY_DESCRIPTION,
      operator: operator ?? STRING_OPERATOR_CONTAINS,
      value: value ?? '',
    );
  }

  TransactionRuleCriteriaEntity._();

  static const SEARCH_KEY_DESCRIPTION = 'description';
  static const SEARCH_KEY_AMOUNT = 'amount';

  static const NUMBER_OPERATOR_EQUALS = '=';
  static const NUMBER_OPERATOR_GREATER_THAN = '>';
  static const NUMBER_OPERATOR_GREATER_THAN_OR_EQUALS = '>=';
  static const NUMBER_OPERATOR_LESS_THAN = '<';
  static const NUMBER_OPERATOR_LESS_THAN_OR_EQUALS = '<=';

  static const STRING_OPERATOR_IS = 'is';
  static const STRING_OPERATOR_CONTAINS = 'contains';
  static const STRING_OPERATOR_STARTS_WITH = 'starts_with';
  static const STRING_OPERATOR_IS_EMPTY = 'is_empty';

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'search_key')
  String get searchKey;

  String get operator;

  String get value;

  // ignore: unused_element
  static void _initializeBuilder(
          TransactionRuleCriteriaEntityBuilder builder) =>
      builder..value = '';

  static Serializer<TransactionRuleCriteriaEntity> get serializer =>
      _$transactionRuleCriteriaEntitySerializer;
}
