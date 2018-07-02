import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'credit_model.g.dart';

abstract class CreditListResponse implements Built<CreditListResponse, CreditListResponseBuilder> {

  BuiltList<CreditEntity> get data;

  CreditListResponse._();
  factory CreditListResponse([void updates(CreditListResponseBuilder b)]) = _$CreditListResponse;
  static Serializer<CreditListResponse> get serializer => _$creditListResponseSerializer;
}

abstract class CreditItemResponse implements Built<CreditItemResponse, CreditItemResponseBuilder> {

  CreditEntity get data;

  CreditItemResponse._();
  factory CreditItemResponse([void updates(CreditItemResponseBuilder b)]) = _$CreditItemResponse;
  static Serializer<CreditItemResponse> get serializer => _$creditItemResponseSerializer;
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

abstract class CreditEntity extends Object with BaseEntity implements Built<CreditEntity, CreditEntityBuilder> {

  @override
  EntityType get entityType {
    return EntityType.credit;
  }

  static int counter = 0;
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

  
  int compareTo(CreditEntity credit, String sortField, bool sortAscending) {
    int response = 0;
    CreditEntity creditA = sortAscending ? this : credit;
    CreditEntity creditB = sortAscending ? credit: this;

    switch (sortField) {
      case CreditFields.amount:
        response = creditA.amount.compareTo(creditB.amount);
    }
    
    return response;
  }
  
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return publicNotes.contains(search);
  }
  
  CreditEntity._();
  static Serializer<CreditEntity> get serializer => _$creditEntitySerializer;
}
