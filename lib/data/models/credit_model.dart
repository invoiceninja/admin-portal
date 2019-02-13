import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'credit_model.g.dart';

abstract class CreditListResponse
    implements Built<CreditListResponse, CreditListResponseBuilder> {
  factory CreditListResponse([void updates(CreditListResponseBuilder b)]) =
      _$CreditListResponse;

  CreditListResponse._();

  BuiltList<CreditEntity> get data;

  static Serializer<CreditListResponse> get serializer =>
      _$creditListResponseSerializer;
}

abstract class CreditItemResponse
    implements Built<CreditItemResponse, CreditItemResponseBuilder> {
  factory CreditItemResponse([void updates(CreditItemResponseBuilder b)]) =
      _$CreditItemResponse;

  CreditItemResponse._();

  CreditEntity get data;

  static Serializer<CreditItemResponse> get serializer =>
      _$creditItemResponseSerializer;
}

class CreditFields {
  static const String amount = 'amount';
  static const String balance = 'balance';
  static const String creditDate = 'creditDate';
  static const String creditNumber = 'creditNumber';
  static const String privateNotes = 'privateNotes';
  static const String publicNotes = 'publicNotes';
  static const String clientId = 'clientId';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class CreditEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<CreditEntity, CreditEntityBuilder> {
  factory CreditEntity() {
    return _$CreditEntity._(
      id: --CreditEntity.counter,
      amount: 0.0,
      balance: 0.0,
      creditDate: '',
      creditNumber: '',
      privateNotes: '',
      publicNotes: '',
      clientId: 0,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  CreditEntity._();

  static int counter = 0;

  CreditEntity get clone => rebuild((b) => b
    ..id = --CreditEntity.counter
    ..isDeleted = false);

  @override
  EntityType get entityType {
    return EntityType.credit;
  }

  double get amount;

  double get balance;

  @BuiltValueField(wireName: 'credit_date')
  String get creditDate;

  @BuiltValueField(wireName: 'credit_number')
  String get creditNumber;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  List<EntityAction> getEntityActions({UserEntity user, ClientEntity client}) {
    final actions = <EntityAction>[];

    return actions..addAll(getBaseActions(user: user));
  }

  int compareTo(CreditEntity credit, String sortField, bool sortAscending) {
    int response = 0;
    final CreditEntity creditA = sortAscending ? this : credit;
    final CreditEntity creditB = sortAscending ? credit : this;

    switch (sortField) {
      case CreditFields.amount:
        response = creditA.amount.compareTo(creditB.amount);
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    return publicNotes.toLowerCase().contains(filter);
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return publicNotes;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static Serializer<CreditEntity> get serializer => _$creditEntitySerializer;
}
