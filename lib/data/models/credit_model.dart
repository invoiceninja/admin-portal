import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'credit_model.g.dart';

abstract class CreditListResponse implements Built<CreditListResponse, CreditListResponseBuilder> {

  BuiltList<CreditEntity> get data;

  CreditListResponse._();
  factory CreditListResponse([updates(CreditListResponseBuilder b)]) = _$CreditListResponse;
  static Serializer<CreditListResponse> get serializer => _$creditListResponseSerializer;
}

abstract class CreditItemResponse implements Built<CreditItemResponse, CreditItemResponseBuilder> {

  CreditEntity get data;

  CreditItemResponse._();
  factory CreditItemResponse([updates(CreditItemResponseBuilder b)]) = _$CreditItemResponse;
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

  @nullable
  double get amount;

  @nullable
  double get balance;

  @nullable
  @BuiltValueField(wireName: 'credit_date')
  String get creditDate;

  @nullable
  @BuiltValueField(wireName: 'credit_number')
  String get creditNumber;

  @nullable
  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @nullable
  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @nullable
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
  factory CreditEntity([updates(CreditEntityBuilder b)]) = _$CreditEntity;
  static Serializer<CreditEntity> get serializer => _$creditEntitySerializer;
}
