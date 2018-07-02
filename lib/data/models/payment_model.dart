import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'payment_model.g.dart';

abstract class PaymentListResponse implements Built<PaymentListResponse, PaymentListResponseBuilder> {

  BuiltList<PaymentEntity> get data;

  PaymentListResponse._();
  factory PaymentListResponse([void updates(PaymentListResponseBuilder b)]) = _$PaymentListResponse;
  static Serializer<PaymentListResponse> get serializer => _$paymentListResponseSerializer;
}

abstract class PaymentItemResponse implements Built<PaymentItemResponse, PaymentItemResponseBuilder> {

  PaymentEntity get data;

  PaymentItemResponse._();
  factory PaymentItemResponse([void updates(PaymentItemResponseBuilder b)]) = _$PaymentItemResponse;
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

  @override
  EntityType get entityType {
    return EntityType.payment;
  }

  static int counter = 0;
  factory PaymentEntity() {
    return _$PaymentEntity._(
      id: --PaymentEntity.counter,
      amount: 0.0,
      transactionReference: '',
      paymentDate: '',
      paymentTypeId: 0,
      invoiceId: 0,
      invoiceNumber: '',
      privateNotes: '',
      exchangeRate: 0.0,
      exchangeCurrencyId: 0,
      
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  double get amount;

  @BuiltValueField(wireName: 'transaction_reference')
  String get transactionReference;

  @BuiltValueField(wireName: 'payment_date')
  String get paymentDate;

  @BuiltValueField(wireName: 'payment_type_id')
  int get paymentTypeId;

  @BuiltValueField(wireName: 'invoice_id')
  int get invoiceId;

  @BuiltValueField(wireName: 'invoice_number')
  String get invoiceNumber;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

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

  @override
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return privateNotes.contains(search);
  }
  
  PaymentEntity._();
  static Serializer<PaymentEntity> get serializer => _$paymentEntitySerializer;
}
