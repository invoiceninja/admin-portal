// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
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
      {FullType specifiedType = FullType.unspecified}) {
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
      {FullType specifiedType = FullType.unspecified}) {
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
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(PaymentEntity)),
    ];

    return result;
  }

  @override
  PaymentItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
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
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'transaction_reference',
      serializers.serialize(object.transactionReference,
          specifiedType: const FullType(String)),
      'payment_date',
      serializers.serialize(object.paymentDate,
          specifiedType: const FullType(String)),
      'payment_type_id',
      serializers.serialize(object.paymentTypeId,
          specifiedType: const FullType(int)),
      'invoice_id',
      serializers.serialize(object.invoiceId,
          specifiedType: const FullType(int)),
      'invoice_number',
      serializers.serialize(object.invoiceNumber,
          specifiedType: const FullType(String)),
      'private_notes',
      serializers.serialize(object.privateNotes,
          specifiedType: const FullType(String)),
      'exchange_rate',
      serializers.serialize(object.exchangeRate,
          specifiedType: const FullType(double)),
      'exchange_currency_id',
      serializers.serialize(object.exchangeCurrencyId,
          specifiedType: const FullType(int)),
    ];
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
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
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  PaymentEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
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
          result.invoiceNumber = serializers.deserialize(value,
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
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
  final String invoiceNumber;
  @override
  final String privateNotes;
  @override
  final double exchangeRate;
  @override
  final int exchangeCurrencyId;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final int id;

  factory _$PaymentEntity([void updates(PaymentEntityBuilder b)]) =>
      (new PaymentEntityBuilder()..update(updates)).build();

  _$PaymentEntity._(
      {this.amount,
      this.transactionReference,
      this.paymentDate,
      this.paymentTypeId,
      this.invoiceId,
      this.invoiceNumber,
      this.privateNotes,
      this.exchangeRate,
      this.exchangeCurrencyId,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.id})
      : super._() {
    if (amount == null)
      throw new BuiltValueNullFieldError('PaymentEntity', 'amount');
    if (transactionReference == null)
      throw new BuiltValueNullFieldError(
          'PaymentEntity', 'transactionReference');
    if (paymentDate == null)
      throw new BuiltValueNullFieldError('PaymentEntity', 'paymentDate');
    if (paymentTypeId == null)
      throw new BuiltValueNullFieldError('PaymentEntity', 'paymentTypeId');
    if (invoiceId == null)
      throw new BuiltValueNullFieldError('PaymentEntity', 'invoiceId');
    if (invoiceNumber == null)
      throw new BuiltValueNullFieldError('PaymentEntity', 'invoiceNumber');
    if (privateNotes == null)
      throw new BuiltValueNullFieldError('PaymentEntity', 'privateNotes');
    if (exchangeRate == null)
      throw new BuiltValueNullFieldError('PaymentEntity', 'exchangeRate');
    if (exchangeCurrencyId == null)
      throw new BuiltValueNullFieldError('PaymentEntity', 'exchangeCurrencyId');
  }

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
        invoiceNumber == other.invoiceNumber &&
        privateNotes == other.privateNotes &&
        exchangeRate == other.exchangeRate &&
        exchangeCurrencyId == other.exchangeCurrencyId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        id == other.id;
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
                                                    $jc(
                                                        $jc(0, amount.hashCode),
                                                        transactionReference
                                                            .hashCode),
                                                    paymentDate.hashCode),
                                                paymentTypeId.hashCode),
                                            invoiceId.hashCode),
                                        invoiceNumber.hashCode),
                                    privateNotes.hashCode),
                                exchangeRate.hashCode),
                            exchangeCurrencyId.hashCode),
                        createdAt.hashCode),
                    updatedAt.hashCode),
                archivedAt.hashCode),
            isDeleted.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentEntity')
          ..add('amount', amount)
          ..add('transactionReference', transactionReference)
          ..add('paymentDate', paymentDate)
          ..add('paymentTypeId', paymentTypeId)
          ..add('invoiceId', invoiceId)
          ..add('invoiceNumber', invoiceNumber)
          ..add('privateNotes', privateNotes)
          ..add('exchangeRate', exchangeRate)
          ..add('exchangeCurrencyId', exchangeCurrencyId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('id', id))
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

  String _invoiceNumber;
  String get invoiceNumber => _$this._invoiceNumber;
  set invoiceNumber(String invoiceNumber) =>
      _$this._invoiceNumber = invoiceNumber;

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

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  PaymentEntityBuilder();

  PaymentEntityBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _transactionReference = _$v.transactionReference;
      _paymentDate = _$v.paymentDate;
      _paymentTypeId = _$v.paymentTypeId;
      _invoiceId = _$v.invoiceId;
      _invoiceNumber = _$v.invoiceNumber;
      _privateNotes = _$v.privateNotes;
      _exchangeRate = _$v.exchangeRate;
      _exchangeCurrencyId = _$v.exchangeCurrencyId;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _id = _$v.id;
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
            invoiceNumber: invoiceNumber,
            privateNotes: privateNotes,
            exchangeRate: exchangeRate,
            exchangeCurrencyId: exchangeCurrencyId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            id: id);
    replace(_$result);
    return _$result;
  }
}
