// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'expense_category_model.g.dart';

abstract class ExpenseCategoryListResponse
    implements
        Built<ExpenseCategoryListResponse, ExpenseCategoryListResponseBuilder> {
  factory ExpenseCategoryListResponse(
          [void updates(ExpenseCategoryListResponseBuilder b)]) =
      _$ExpenseCategoryListResponse;

  ExpenseCategoryListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<ExpenseCategoryEntity> get data;

  static Serializer<ExpenseCategoryListResponse> get serializer =>
      _$expenseCategoryListResponseSerializer;
}

abstract class ExpenseCategoryItemResponse
    implements
        Built<ExpenseCategoryItemResponse, ExpenseCategoryItemResponseBuilder> {
  factory ExpenseCategoryItemResponse(
          [void updates(ExpenseCategoryItemResponseBuilder b)]) =
      _$ExpenseCategoryItemResponse;

  ExpenseCategoryItemResponse._();

  @override
  @memoized
  int get hashCode;

  ExpenseCategoryEntity get data;

  static Serializer<ExpenseCategoryItemResponse> get serializer =>
      _$expenseCategoryItemResponseSerializer;
}

class ExpenseCategoryFields {
  static const String name = 'name';
}

abstract class ExpenseCategoryEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ExpenseCategoryEntity, ExpenseCategoryEntityBuilder> {
  factory ExpenseCategoryEntity({String? id, AppState? state}) {
    return _$ExpenseCategoryEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      name: '',
      color: '',
      isDeleted: false,
      createdAt: 0,
      updatedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      archivedAt: 0,
    );
  }

  ExpenseCategoryEntity._();

  @override
  EntityType get entityType {
    return EntityType.expenseCategory;
  }

  @override
  @memoized
  int get hashCode;

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted! && !multiselect) {
      if (includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (actions.isNotEmpty && actions.last != null) {
        actions.add(null);
      }
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  @override
  bool matchesFilter(String? filter) {
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
  String? matchesFilterValue(String? filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  String get name;

  String get color;

  int compareTo(
      {ExpenseCategoryEntity? expenseCategory,
      String? sortField,
      required bool sortAscending}) {
    int response = 0;
    final ExpenseCategoryEntity? categoryA =
        sortAscending ? this : expenseCategory;
    final ExpenseCategoryEntity? categoryB =
        sortAscending ? expenseCategory : this;

    switch (sortField) {
      case ExpenseCategoryFields.name:
        response = categoryA!.name
            .toLowerCase()
            .compareTo(categoryB!.name.toLowerCase());
        break;
      default:
        print(
            '## ERROR: sort by expoense_category.$sortField is not implemented');
        break;
    }

    return response;
  }

  // ignore: unused_element
  static void _initializeBuilder(ExpenseCategoryEntityBuilder builder) =>
      builder..color = '';

  static Serializer<ExpenseCategoryEntity> get serializer =>
      _$expenseCategoryEntitySerializer;
}
