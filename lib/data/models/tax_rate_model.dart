// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'tax_rate_model.g.dart';

abstract class TaxRateListResponse
    implements Built<TaxRateListResponse, TaxRateListResponseBuilder> {
  factory TaxRateListResponse([void updates(TaxRateListResponseBuilder b)]) =
      _$TaxRateListResponse;

  TaxRateListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<TaxRateEntity> get data;

  static Serializer<TaxRateListResponse> get serializer =>
      _$taxRateListResponseSerializer;
}

abstract class TaxRateItemResponse
    implements Built<TaxRateItemResponse, TaxRateItemResponseBuilder> {
  factory TaxRateItemResponse([void updates(TaxRateItemResponseBuilder b)]) =
      _$TaxRateItemResponse;

  TaxRateItemResponse._();

  @override
  @memoized
  int get hashCode;

  TaxRateEntity get data;

  static Serializer<TaxRateItemResponse> get serializer =>
      _$taxRateItemResponseSerializer;
}

class TaxRateFields {
  static const String name = 'name';
  static const String rate = 'rate';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
}

abstract class TaxRateEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<TaxRateEntity, TaxRateEntityBuilder> {
  factory TaxRateEntity(
      {String? id, String? name, double? rate, AppState? state}) {
    return _$TaxRateEntity._(
      id: BaseEntity.nextId,
      isChanged: false,
      name: name ?? '',
      rate: rate ?? 0.0,
      isDeleted: false,
      createdAt: 0,
      assignedUserId: '',
      createdUserId: '',
      archivedAt: 0,
      updatedAt: 0,
    );
  }

  TaxRateEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType {
    return EntityType.taxRate;
  }

  String get name;

  double get rate;

  @override
  String get listDisplayName {
    return name;
  }

  bool get isEmpty => rate == 0 && name.isEmpty;

  int compareTo(TaxRateEntity? taxRate, String sortField, bool sortAscending) {
    int response = 0;
    final TaxRateEntity? taxRateA = sortAscending ? this : taxRate;
    final TaxRateEntity? taxRateB = sortAscending ? taxRate : this;

    switch (sortField) {
      case TaxRateFields.name:
        response = taxRateA!.name
            .toLowerCase()
            .compareTo(taxRateB!.name.toLowerCase());
        break;
      case TaxRateFields.rate:
        response = taxRateA!.rate.compareTo(taxRateB!.rate);
        break;
      default:
        print('## ERROR: sort by .$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [name],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [name],
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

    if (!isDeleted! && !multiselect) {
      if (includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
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

  static Serializer<TaxRateEntity> get serializer => _$taxRateEntitySerializer;
}
