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
  factory TransactionRuleEntity({String id, AppState state}) {
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

  @override
  EntityType get entityType => EntityType.transactionRule;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted &&
        !multiselect &&
        includeEdit &&
        userCompany.canEditEntity(this)) {
      actions.add(EntityAction.edit);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(TransactionRuleEntity transactionRule, String sortField,
      bool sortAscending) {
    int response = 0;
    final transactionRuleA = sortAscending ? this : transactionRule;
    final transactionRuleB = sortAscending ? transactionRule : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      case TransactionRuleFields.name:
        response = transactionRuleA.name
            .toLowerCase()
            .compareTo(transactionRuleB.name.toLowerCase());
        break;

      default:
        print(
            '## ERROR: sort by transactionRule.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return transactionRuleA.name.compareTo(transactionRuleB.name);
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String filter) {
    return matchesStrings(
      haystacks: [
        //
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        //
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

  static Serializer<TransactionRuleEntity> get serializer =>
      _$transactionRuleEntitySerializer;
}
