import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'payment_model.g.dart';

abstract class PaymentListResponse implements Built<PaymentListResponse, PaymentListResponseBuilder> {

  BuiltList<PaymentEntity> get data;

  PaymentListResponse._();
  factory PaymentListResponse([updates(PaymentListResponseBuilder b)]) = _$PaymentListResponse;
  static Serializer<PaymentListResponse> get serializer => _$paymentListResponseSerializer;
}

abstract class PaymentItemResponse implements Built<PaymentItemResponse, PaymentItemResponseBuilder> {

  PaymentEntity get data;

  PaymentItemResponse._();
  factory PaymentItemResponse([updates(PaymentItemResponseBuilder b)]) = _$PaymentItemResponse;
  static Serializer<PaymentItemResponse> get serializer => _$paymentItemResponseSerializer;
}


class PaymentFields {
  static const String amount = 'amount';
  static const String transactionReference = 'transactionReference';
  static const String paymentDate = 'paymentDate';
  static const String paymentTypeId = 'paymentTypeId';
  static const String invoiceId = 'invoiceId';
  static const String invoiceNumber = 'invoiceNumber';
  static const String privateNotes = 'privateNotes';
  static const String exchangeRate = 'exchangeRate';
  static const String exchangeCurrencyId = 'exchangeCurrencyId';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class PaymentEntity extends Object with BaseEntity implements Built<PaymentEntity, PaymentEntityBuilder> {

  static int counter = 0;
  factory PaymentEntity() {
    return _$PaymentEntity._(
      id: --PaymentEntity.counter,
    );
  }

  @nullable
  double get amount;

  @nullable
  @BuiltValueField(wireName: 'transaction_reference')
  String get transactionReference;

  @nullable
  @BuiltValueField(wireName: 'payment_date')
  String get paymentDate;

  @nullable
  @BuiltValueField(wireName: 'payment_type_id')
  int get paymentTypeId;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  int get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'invoice_number')
  String get invoice_number;

  @nullable
  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @nullable
  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @nullable
  @BuiltValueField(wireName: 'exchange_currency_id')
  int get exchangeCurrencyId;
  
  int compareTo(PaymentEntity credit, String sortField, bool sortAscending) {
    int response = 0;
    PaymentEntity creditA = sortAscending ? this : credit;
    PaymentEntity creditB = sortAscending ? credit: this;

    switch (sortField) {
      case PaymentFields.amount:
        response = creditA.amount.compareTo(creditB.amount);
    }
    
    return response;
  }
  
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return privateNotes.contains(search);
  }
  
  PaymentEntity._();
  static Serializer<PaymentEntity> get serializer => _$paymentEntitySerializer;
}
