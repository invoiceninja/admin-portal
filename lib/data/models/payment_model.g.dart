// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<PaymentListResponse> _$paymentListResponseSerializer =
    new _$PaymentListResponseSerializer();
Serializer<PaymentItemResponse> _$paymentItemResponseSerializer =
    new _$PaymentItemResponseSerializer();
Serializer<PaymentEntity> _$paymentEntitySerializer =
    new _$PaymentEntitySerializer();

class _$PaymentListResponseSerializer
    implements StructuredSerializer<PaymentListResponse> {
  @override
  final Iterable<Type> types = const [
    PaymentListResponse,
    _$PaymentListResponse
  ];
  @override
  final String wireName = 'PaymentListResponse';

  @override
  Iterable serialize(Serializers serializers, PaymentListResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(PaymentEntity)])),
    ];

    return result;
  }

  @override
  PaymentListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new PaymentListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentEntity)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentItemResponseSerializer
    implements StructuredSerializer<PaymentItemResponse> {
  @override
  final Iterable<Type> types = const [
    PaymentItemResponse,
    _$PaymentItemResponse
  ];
  @override
  final String wireName = 'PaymentItemResponse';

  @override
  Iterable serialize(Serializers serializers, PaymentItemResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(PaymentEntity)),
    ];

    return result;
  }

  @override
  PaymentItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new PaymentItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(PaymentEntity)) as PaymentEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentEntitySerializer implements StructuredSerializer<PaymentEntity> {
  @override
  final Iterable<Type> types = const [PaymentEntity, _$PaymentEntity];
  @override
  final String wireName = 'PaymentEntity';

  @override
  Iterable serialize(Serializers serializers, PaymentEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.amount != null) {
      result
        ..add('amount')
        ..add(serializers.serialize(object.amount,
            specifiedType: const FullType(double)));
    }
    if (object.transactionReference != null) {
      result
        ..add('transaction_reference')
        ..add(serializers.serialize(object.transactionReference,
            specifiedType: const FullType(String)));
    }
    if (object.paymentDate != null) {
      result
        ..add('payment_date')
        ..add(serializers.serialize(object.paymentDate,
            specifiedType: const FullType(String)));
    }
    if (object.paymentTypeId != null) {
      result
        ..add('payment_type_id')
        ..add(serializers.serialize(object.paymentTypeId,
            specifiedType: const FullType(int)));
    }
    if (object.invoiceId != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(object.invoiceId,
            specifiedType: const FullType(int)));
    }
    if (object.invoice_number != null) {
      result
        ..add('invoice_number')
        ..add(serializers.serialize(object.invoice_number,
            specifiedType: const FullType(String)));
    }
    if (object.privateNotes != null) {
      result
        ..add('private_notes')
        ..add(serializers.serialize(object.privateNotes,
            specifiedType: const FullType(String)));
    }
    if (object.exchangeRate != null) {
      result
        ..add('exchange_rate')
        ..add(serializers.serialize(object.exchangeRate,
            specifiedType: const FullType(double)));
    }
    if (object.exchangeCurrencyId != null) {
      result
        ..add('exchange_currency_id')
        ..add(serializers.serialize(object.exchangeCurrencyId,
            specifiedType: const FullType(int)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }
    if (object.archivedAt != null) {
      result
        ..add('archived_at')
        ..add(serializers.serialize(object.archivedAt,
            specifiedType: const FullType(int)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }

    return result;
  }

  @override
  PaymentEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new PaymentEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'transaction_reference':
          result.transactionReference = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_date':
          result.paymentDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_type_id':
          result.paymentTypeId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_number':
          result.invoice_number = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'private_notes':
          result.privateNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'exchange_rate':
          result.exchangeRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'exchange_currency_id':
          result.exchangeCurrencyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentListResponse extends PaymentListResponse {
  @override
  final BuiltList<PaymentEntity> data;

  factory _$PaymentListResponse([void updates(PaymentListResponseBuilder b)]) =>
      (new PaymentListResponseBuilder()..update(updates)).build();

  _$PaymentListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('PaymentListResponse', 'data');
  }

  @override
  PaymentListResponse rebuild(void updates(PaymentListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentListResponseBuilder toBuilder() =>
      new PaymentListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! PaymentListResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentListResponse')
          ..add('data', data))
        .toString();
  }
}

class PaymentListResponseBuilder
    implements Builder<PaymentListResponse, PaymentListResponseBuilder> {
  _$PaymentListResponse _$v;

  ListBuilder<PaymentEntity> _data;
  ListBuilder<PaymentEntity> get data =>
      _$this._data ??= new ListBuilder<PaymentEntity>();
  set data(ListBuilder<PaymentEntity> data) => _$this._data = data;

  PaymentListResponseBuilder();

  PaymentListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentListResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$PaymentListResponse;
  }

  @override
  void update(void updates(PaymentListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentListResponse build() {
    _$PaymentListResponse _$result;
    try {
      _$result = _$v ?? new _$PaymentListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaymentListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentItemResponse extends PaymentItemResponse {
  @override
  final PaymentEntity data;

  factory _$PaymentItemResponse([void updates(PaymentItemResponseBuilder b)]) =>
      (new PaymentItemResponseBuilder()..update(updates)).build();

  _$PaymentItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('PaymentItemResponse', 'data');
  }

  @override
  PaymentItemResponse rebuild(void updates(PaymentItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentItemResponseBuilder toBuilder() =>
      new PaymentItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! PaymentItemResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentItemResponse')
          ..add('data', data))
        .toString();
  }
}

class PaymentItemResponseBuilder
    implements Builder<PaymentItemResponse, PaymentItemResponseBuilder> {
  _$PaymentItemResponse _$v;

  PaymentEntityBuilder _data;
  PaymentEntityBuilder get data => _$this._data ??= new PaymentEntityBuilder();
  set data(PaymentEntityBuilder data) => _$this._data = data;

  PaymentItemResponseBuilder();

  PaymentItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentItemResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$PaymentItemResponse;
  }

  @override
  void update(void updates(PaymentItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentItemResponse build() {
    _$PaymentItemResponse _$result;
    try {
      _$result = _$v ?? new _$PaymentItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaymentItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentEntity extends PaymentEntity {
  @override
  final double amount;
  @override
  final String transactionReference;
  @override
  final String paymentDate;
  @override
  final int paymentTypeId;
  @override
  final int invoiceId;
  @override
  final String invoice_number;
  @override
  final String privateNotes;
  @override
  final double exchangeRate;
  @override
  final int exchangeCurrencyId;
  @override
  final int id;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;

  factory _$PaymentEntity([void updates(PaymentEntityBuilder b)]) =>
      (new PaymentEntityBuilder()..update(updates)).build();

  _$PaymentEntity._(
      {this.amount,
      this.transactionReference,
      this.paymentDate,
      this.paymentTypeId,
      this.invoiceId,
      this.invoice_number,
      this.privateNotes,
      this.exchangeRate,
      this.exchangeCurrencyId,
      this.id,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted})
      : super._();

  @override
  PaymentEntity rebuild(void updates(PaymentEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentEntityBuilder toBuilder() => new PaymentEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! PaymentEntity) return false;
    return amount == other.amount &&
        transactionReference == other.transactionReference &&
        paymentDate == other.paymentDate &&
        paymentTypeId == other.paymentTypeId &&
        invoiceId == other.invoiceId &&
        invoice_number == other.invoice_number &&
        privateNotes == other.privateNotes &&
        exchangeRate == other.exchangeRate &&
        exchangeCurrencyId == other.exchangeCurrencyId &&
        id == other.id &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(0, amount.hashCode),
                                                    transactionReference
                                                        .hashCode),
                                                paymentDate.hashCode),
                                            paymentTypeId.hashCode),
                                        invoiceId.hashCode),
                                    invoice_number.hashCode),
                                privateNotes.hashCode),
                            exchangeRate.hashCode),
                        exchangeCurrencyId.hashCode),
                    id.hashCode),
                updatedAt.hashCode),
            archivedAt.hashCode),
        isDeleted.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentEntity')
          ..add('amount', amount)
          ..add('transactionReference', transactionReference)
          ..add('paymentDate', paymentDate)
          ..add('paymentTypeId', paymentTypeId)
          ..add('invoiceId', invoiceId)
          ..add('invoice_number', invoice_number)
          ..add('privateNotes', privateNotes)
          ..add('exchangeRate', exchangeRate)
          ..add('exchangeCurrencyId', exchangeCurrencyId)
          ..add('id', id)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted))
        .toString();
  }
}

class PaymentEntityBuilder
    implements Builder<PaymentEntity, PaymentEntityBuilder> {
  _$PaymentEntity _$v;

  double _amount;
  double get amount => _$this._amount;
  set amount(double amount) => _$this._amount = amount;

  String _transactionReference;
  String get transactionReference => _$this._transactionReference;
  set transactionReference(String transactionReference) =>
      _$this._transactionReference = transactionReference;

  String _paymentDate;
  String get paymentDate => _$this._paymentDate;
  set paymentDate(String paymentDate) => _$this._paymentDate = paymentDate;

  int _paymentTypeId;
  int get paymentTypeId => _$this._paymentTypeId;
  set paymentTypeId(int paymentTypeId) => _$this._paymentTypeId = paymentTypeId;

  int _invoiceId;
  int get invoiceId => _$this._invoiceId;
  set invoiceId(int invoiceId) => _$this._invoiceId = invoiceId;

  String _invoice_number;
  String get invoice_number => _$this._invoice_number;
  set invoice_number(String invoice_number) =>
      _$this._invoice_number = invoice_number;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

  double _exchangeRate;
  double get exchangeRate => _$this._exchangeRate;
  set exchangeRate(double exchangeRate) => _$this._exchangeRate = exchangeRate;

  int _exchangeCurrencyId;
  int get exchangeCurrencyId => _$this._exchangeCurrencyId;
  set exchangeCurrencyId(int exchangeCurrencyId) =>
      _$this._exchangeCurrencyId = exchangeCurrencyId;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  PaymentEntityBuilder();

  PaymentEntityBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _transactionReference = _$v.transactionReference;
      _paymentDate = _$v.paymentDate;
      _paymentTypeId = _$v.paymentTypeId;
      _invoiceId = _$v.invoiceId;
      _invoice_number = _$v.invoice_number;
      _privateNotes = _$v.privateNotes;
      _exchangeRate = _$v.exchangeRate;
      _exchangeCurrencyId = _$v.exchangeCurrencyId;
      _id = _$v.id;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$PaymentEntity;
  }

  @override
  void update(void updates(PaymentEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentEntity build() {
    final _$result = _$v ??
        new _$PaymentEntity._(
            amount: amount,
            transactionReference: transactionReference,
            paymentDate: paymentDate,
            paymentTypeId: paymentTypeId,
            invoiceId: invoiceId,
            invoice_number: invoice_number,
            privateNotes: privateNotes,
            exchangeRate: exchangeRate,
            exchangeCurrencyId: exchangeCurrencyId,
            id: id,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted);
    replace(_$result);
    return _$result;
  }
}
