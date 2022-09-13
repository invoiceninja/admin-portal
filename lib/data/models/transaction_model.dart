import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'transaction_model.g.dart';

abstract class TransactionListResponse
    implements Built<TransactionListResponse, TransactionListResponseBuilder> {
  factory TransactionListResponse(
          [void updates(TransactionListResponseBuilder b)]) =
      _$TransactionListResponse;

  TransactionListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<TransactionEntity> get data;

  static Serializer<TransactionListResponse> get serializer =>
      _$transactionListResponseSerializer;
}

abstract class TransactionItemResponse
    implements Built<TransactionItemResponse, TransactionItemResponseBuilder> {
  factory TransactionItemResponse(
          [void updates(TransactionItemResponseBuilder b)]) =
      _$TransactionItemResponse;

  TransactionItemResponse._();

  @override
  @memoized
  int get hashCode;

  TransactionEntity get data;

  static Serializer<TransactionItemResponse> get serializer =>
      _$transactionItemResponseSerializer;
}

class TransactionFields {
  // STARTER: fields - do not remove comment
  static const String reference = 'reference';
  static const String date = 'date';
}

abstract class TransactionEntity extends Object
    with BaseEntity
    implements Built<TransactionEntity, TransactionEntityBuilder> {
  factory TransactionEntity({String id, AppState state}) {
    return _$TransactionEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      createdAt: 0,
      updatedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      archivedAt: 0,
      reference: '',
    );
  }

  TransactionEntity._();

  @override
  @memoized
  int get hashCode;

  String get reference;

  @override
  EntityType get entityType => EntityType.transaction;

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

  int compareTo(
      TransactionEntity transaction, String sortField, bool sortAscending) {
    int response = 0;
    final transactionA = sortAscending ? this : transaction;
    final transactionB = sortAscending ? transaction : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      case TransactionFields.reference:
        response = transactionA.reference
            .toLowerCase()
            .compareTo(transactionB.reference.toLowerCase());
        break;

      default:
        print('## ERROR: sort by transaction.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return transactionA.reference
          .toLowerCase()
          .compareTo(transactionB.reference.toLowerCase());
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

  static Serializer<TransactionEntity> get serializer =>
      _$transactionEntitySerializer;
}
