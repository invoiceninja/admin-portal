import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'tax_rate_model.g.dart';

abstract class TaxRateListResponse
    implements Built<TaxRateListResponse, TaxRateListResponseBuilder> {
  factory TaxRateListResponse([void updates(TaxRateListResponseBuilder b)]) =
      _$TaxRateListResponse;

  TaxRateListResponse._();

  BuiltList<TaxRateEntity> get data;

  static Serializer<TaxRateListResponse> get serializer =>
      _$taxRateListResponseSerializer;
}

abstract class TaxRateItemResponse
    implements Built<TaxRateItemResponse, TaxRateItemResponseBuilder> {
  factory TaxRateItemResponse([void updates(TaxRateItemResponseBuilder b)]) =
      _$TaxRateItemResponse;

  TaxRateItemResponse._();

  TaxRateEntity get data;

  static Serializer<TaxRateItemResponse> get serializer =>
      _$taxRateItemResponseSerializer;
}

class TaxRateFields {
  static const String name = 'name';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
}

abstract class TaxRateEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<TaxRateEntity, TaxRateEntityBuilder> {
  factory TaxRateEntity({String id, String name, double rate, AppState state}) {
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

  int compareTo(TaxRateEntity taxRate, String sortField, bool sortAscending) {
    const int response = 0;
    final TaxRateEntity taxRateA = sortAscending ? this : taxRate;
    final TaxRateEntity taxRateB = sortAscending ? taxRate : this;

    switch (sortField) {
      //response = taxRateA.balance.compareTo(taxRateB.balance);
      //break;
    }

    if (response == 0) {
      return taxRateA.name.toLowerCase().compareTo(taxRateB.name.toLowerCase());
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

    if (name.toLowerCase().contains(filter)) {
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

  static Serializer<TaxRateEntity> get serializer => _$taxRateEntitySerializer;
}
