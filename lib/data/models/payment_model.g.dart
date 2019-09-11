// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
  Iterable<Object> serialize(
      Serializers serializers, PaymentListResponse object,
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
  PaymentListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
              as BuiltList<dynamic>);
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
  Iterable<Object> serialize(
      Serializers serializers, PaymentItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(PaymentEntity)),
    ];

    return result;
  }

  @override
  PaymentItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
  Iterable<Object> serialize(Serializers serializers, PaymentEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'refunded',
      serializers.serialize(object.refunded,
          specifiedType: const FullType(double)),
      'payment_status_id',
      serializers.serialize(object.paymentStatusId,
          specifiedType: const FullType(String)),
      'transaction_reference',
      serializers.serialize(object.transactionReference,
          specifiedType: const FullType(String)),
      'payment_date',
      serializers.serialize(object.paymentDate,
          specifiedType: const FullType(String)),
      'payment_type_id',
      serializers.serialize(object.paymentTypeId,
          specifiedType: const FullType(String)),
      'invoice_id',
      serializers.serialize(object.invoiceId,
          specifiedType: const FullType(String)),
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
          specifiedType: const FullType(String)),
    ];
    if (object.clientId != null) {
      result
        ..add('client_id')
        ..add(serializers.serialize(object.clientId,
            specifiedType: const FullType(String)));
    }
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
    if (object.isOwner != null) {
      result
        ..add('is_owner')
        ..add(serializers.serialize(object.isOwner,
            specifiedType: const FullType(bool)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PaymentEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
        case 'refunded':
          result.refunded = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'payment_status_id':
          result.paymentStatusId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
              specifiedType: const FullType(String)) as String;
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
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentListResponse extends PaymentListResponse {
  @override
  final BuiltList<PaymentEntity> data;

  factory _$PaymentListResponse(
          [void Function(PaymentListResponseBuilder) updates]) =>
      (new PaymentListResponseBuilder()..update(updates)).build();

  _$PaymentListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('PaymentListResponse', 'data');
    }
  }

  @override
  PaymentListResponse rebuild(
          void Function(PaymentListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentListResponseBuilder toBuilder() =>
      new PaymentListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentListResponse && data == other.data;
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
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentListResponse;
  }

  @override
  void update(void Function(PaymentListResponseBuilder) updates) {
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

  factory _$PaymentItemResponse(
          [void Function(PaymentItemResponseBuilder) updates]) =>
      (new PaymentItemResponseBuilder()..update(updates)).build();

  _$PaymentItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('PaymentItemResponse', 'data');
    }
  }

  @override
  PaymentItemResponse rebuild(
          void Function(PaymentItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentItemResponseBuilder toBuilder() =>
      new PaymentItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentItemResponse && data == other.data;
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
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentItemResponse;
  }

  @override
  void update(void Function(PaymentItemResponseBuilder) updates) {
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
  final double refunded;
  @override
  final String paymentStatusId;
  @override
  final String transactionReference;
  @override
  final String paymentDate;
  @override
  final String paymentTypeId;
  @override
  final String invoiceId;
  @override
  final String clientId;
  @override
  final String invoiceNumber;
  @override
  final String privateNotes;
  @override
  final double exchangeRate;
  @override
  final String exchangeCurrencyId;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final bool isOwner;
  @override
  final String id;

  factory _$PaymentEntity([void Function(PaymentEntityBuilder) updates]) =>
      (new PaymentEntityBuilder()..update(updates)).build();

  _$PaymentEntity._(
      {this.amount,
      this.refunded,
      this.paymentStatusId,
      this.transactionReference,
      this.paymentDate,
      this.paymentTypeId,
      this.invoiceId,
      this.clientId,
      this.invoiceNumber,
      this.privateNotes,
      this.exchangeRate,
      this.exchangeCurrencyId,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
      : super._() {
    if (amount == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'amount');
    }
    if (refunded == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'refunded');
    }
    if (paymentStatusId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'paymentStatusId');
    }
    if (transactionReference == null) {
      throw new BuiltValueNullFieldError(
          'PaymentEntity', 'transactionReference');
    }
    if (paymentDate == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'paymentDate');
    }
    if (paymentTypeId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'paymentTypeId');
    }
    if (invoiceId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'invoiceId');
    }
    if (invoiceNumber == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'invoiceNumber');
    }
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'privateNotes');
    }
    if (exchangeRate == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'exchangeRate');
    }
    if (exchangeCurrencyId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'exchangeCurrencyId');
    }
  }

  @override
  PaymentEntity rebuild(void Function(PaymentEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentEntityBuilder toBuilder() => new PaymentEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentEntity &&
        amount == other.amount &&
        refunded == other.refunded &&
        paymentStatusId == other.paymentStatusId &&
        transactionReference == other.transactionReference &&
        paymentDate == other.paymentDate &&
        paymentTypeId == other.paymentTypeId &&
        invoiceId == other.invoiceId &&
        clientId == other.clientId &&
        invoiceNumber == other.invoiceNumber &&
        privateNotes == other.privateNotes &&
        exchangeRate == other.exchangeRate &&
        exchangeCurrencyId == other.exchangeCurrencyId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        isOwner == other.isOwner &&
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
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            0,
                                                                            amount
                                                                                .hashCode),
                                                                        refunded
                                                                            .hashCode),
                                                                    paymentStatusId
                                                                        .hashCode),
                                                                transactionReference
                                                                    .hashCode),
                                                            paymentDate
                                                                .hashCode),
                                                        paymentTypeId.hashCode),
                                                    invoiceId.hashCode),
                                                clientId.hashCode),
                                            invoiceNumber.hashCode),
                                        privateNotes.hashCode),
                                    exchangeRate.hashCode),
                                exchangeCurrencyId.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentEntity')
          ..add('amount', amount)
          ..add('refunded', refunded)
          ..add('paymentStatusId', paymentStatusId)
          ..add('transactionReference', transactionReference)
          ..add('paymentDate', paymentDate)
          ..add('paymentTypeId', paymentTypeId)
          ..add('invoiceId', invoiceId)
          ..add('clientId', clientId)
          ..add('invoiceNumber', invoiceNumber)
          ..add('privateNotes', privateNotes)
          ..add('exchangeRate', exchangeRate)
          ..add('exchangeCurrencyId', exchangeCurrencyId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
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

  double _refunded;
  double get refunded => _$this._refunded;
  set refunded(double refunded) => _$this._refunded = refunded;

  String _paymentStatusId;
  String get paymentStatusId => _$this._paymentStatusId;
  set paymentStatusId(String paymentStatusId) =>
      _$this._paymentStatusId = paymentStatusId;

  String _transactionReference;
  String get transactionReference => _$this._transactionReference;
  set transactionReference(String transactionReference) =>
      _$this._transactionReference = transactionReference;

  String _paymentDate;
  String get paymentDate => _$this._paymentDate;
  set paymentDate(String paymentDate) => _$this._paymentDate = paymentDate;

  String _paymentTypeId;
  String get paymentTypeId => _$this._paymentTypeId;
  set paymentTypeId(String paymentTypeId) =>
      _$this._paymentTypeId = paymentTypeId;

  String _invoiceId;
  String get invoiceId => _$this._invoiceId;
  set invoiceId(String invoiceId) => _$this._invoiceId = invoiceId;

  String _clientId;
  String get clientId => _$this._clientId;
  set clientId(String clientId) => _$this._clientId = clientId;

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

  String _exchangeCurrencyId;
  String get exchangeCurrencyId => _$this._exchangeCurrencyId;
  set exchangeCurrencyId(String exchangeCurrencyId) =>
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

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  PaymentEntityBuilder();

  PaymentEntityBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _refunded = _$v.refunded;
      _paymentStatusId = _$v.paymentStatusId;
      _transactionReference = _$v.transactionReference;
      _paymentDate = _$v.paymentDate;
      _paymentTypeId = _$v.paymentTypeId;
      _invoiceId = _$v.invoiceId;
      _clientId = _$v.clientId;
      _invoiceNumber = _$v.invoiceNumber;
      _privateNotes = _$v.privateNotes;
      _exchangeRate = _$v.exchangeRate;
      _exchangeCurrencyId = _$v.exchangeCurrencyId;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _isOwner = _$v.isOwner;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentEntity;
  }

  @override
  void update(void Function(PaymentEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentEntity build() {
    final _$result = _$v ??
        new _$PaymentEntity._(
            amount: amount,
            refunded: refunded,
            paymentStatusId: paymentStatusId,
            transactionReference: transactionReference,
            paymentDate: paymentDate,
            paymentTypeId: paymentTypeId,
            invoiceId: invoiceId,
            clientId: clientId,
            invoiceNumber: invoiceNumber,
            privateNotes: privateNotes,
            exchangeRate: exchangeRate,
            exchangeCurrencyId: exchangeCurrencyId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            isOwner: isOwner,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
