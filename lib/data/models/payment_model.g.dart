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
Serializer<PaymentableEntity> _$paymentableEntitySerializer =
    new _$PaymentableEntitySerializer();

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
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentEntity)]))
              as BuiltList<Object>);
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
      final Object value = iterator.current;
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
      'applied',
      serializers.serialize(object.applied,
          specifiedType: const FullType(double)),
      'refunded',
      serializers.serialize(object.refunded,
          specifiedType: const FullType(double)),
      'number',
      serializers.serialize(object.number,
          specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
      'status_id',
      serializers.serialize(object.statusId,
          specifiedType: const FullType(String)),
      'transaction_reference',
      serializers.serialize(object.transactionReference,
          specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'type_id',
      serializers.serialize(object.typeId,
          specifiedType: const FullType(String)),
      'private_notes',
      serializers.serialize(object.privateNotes,
          specifiedType: const FullType(String)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'custom_value3',
      serializers.serialize(object.customValue3,
          specifiedType: const FullType(String)),
      'custom_value4',
      serializers.serialize(object.customValue4,
          specifiedType: const FullType(String)),
      'exchange_rate',
      serializers.serialize(object.exchangeRate,
          specifiedType: const FullType(double)),
      'exchange_currency_id',
      serializers.serialize(object.exchangeCurrencyId,
          specifiedType: const FullType(String)),
      'is_manual',
      serializers.serialize(object.isManual,
          specifiedType: const FullType(bool)),
      'project_id',
      serializers.serialize(object.projectId,
          specifiedType: const FullType(String)),
      'vendor_id',
      serializers.serialize(object.vendorId,
          specifiedType: const FullType(String)),
      'invitation_id',
      serializers.serialize(object.invitationId,
          specifiedType: const FullType(String)),
      'transaction_id',
      serializers.serialize(object.transactionId,
          specifiedType: const FullType(String)),
      'client_contact_id',
      serializers.serialize(object.clientContactId,
          specifiedType: const FullType(String)),
      'company_gateway_id',
      serializers.serialize(object.companyGatewayId,
          specifiedType: const FullType(String)),
      'currency_id',
      serializers.serialize(object.currencyId,
          specifiedType: const FullType(String)),
      'paymentables',
      serializers.serialize(object.paymentables,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentableEntity)])),
      'invoices',
      serializers.serialize(object.invoices,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentableEntity)])),
      'credits',
      serializers.serialize(object.credits,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentableEntity)])),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'archived_at',
      serializers.serialize(object.archivedAt,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object value;
    value = object.idempotencyKey;
    if (value != null) {
      result
        ..add('idempotency_key')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isApplying;
    if (value != null) {
      result
        ..add('isApplying')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.sendEmail;
    if (value != null) {
      result
        ..add('sendEmail')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.gatewayRefund;
    if (value != null) {
      result
        ..add('gatewayRefund')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isChanged;
    if (value != null) {
      result
        ..add('isChanged')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isDeleted;
    if (value != null) {
      result
        ..add('is_deleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdUserId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assignedUserId;
    if (value != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(value,
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
      final Object value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'applied':
          result.applied = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'refunded':
          result.refunded = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'idempotency_key':
          result.idempotencyKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status_id':
          result.statusId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'transaction_reference':
          result.transactionReference = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type_id':
          result.typeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'private_notes':
          result.privateNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
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
        case 'is_manual':
          result.isManual = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vendor_id':
          result.vendorId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invitation_id':
          result.invitationId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'transaction_id':
          result.transactionId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_contact_id':
          result.clientContactId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'company_gateway_id':
          result.companyGatewayId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isApplying':
          result.isApplying = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'sendEmail':
          result.sendEmail = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'gatewayRefund':
          result.gatewayRefund = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'paymentables':
          result.paymentables.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentableEntity)]))
              as BuiltList<Object>);
          break;
        case 'invoices':
          result.invoices.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentableEntity)]))
              as BuiltList<Object>);
          break;
        case 'credits':
          result.credits.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentableEntity)]))
              as BuiltList<Object>);
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$PaymentableEntitySerializer
    implements StructuredSerializer<PaymentableEntity> {
  @override
  final Iterable<Type> types = const [PaymentableEntity, _$PaymentableEntity];
  @override
  final String wireName = 'PaymentableEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, PaymentableEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object value;
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.invoiceId;
    if (value != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.creditId;
    if (value != null) {
      result
        ..add('credit_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PaymentableEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentableEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_id':
          result.creditId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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
    BuiltValueNullFieldError.checkNotNull(data, 'PaymentListResponse', 'data');
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
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
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
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
    BuiltValueNullFieldError.checkNotNull(data, 'PaymentItemResponse', 'data');
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
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
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
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
  final double applied;
  @override
  final double refunded;
  @override
  final String number;
  @override
  final String idempotencyKey;
  @override
  final String clientId;
  @override
  final String statusId;
  @override
  final String transactionReference;
  @override
  final String date;
  @override
  final String typeId;
  @override
  final String privateNotes;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final double exchangeRate;
  @override
  final String exchangeCurrencyId;
  @override
  final bool isManual;
  @override
  final String projectId;
  @override
  final String vendorId;
  @override
  final String invitationId;
  @override
  final String transactionId;
  @override
  final String clientContactId;
  @override
  final String companyGatewayId;
  @override
  final String currencyId;
  @override
  final bool isApplying;
  @override
  final bool sendEmail;
  @override
  final bool gatewayRefund;
  @override
  final BuiltList<PaymentableEntity> paymentables;
  @override
  final BuiltList<PaymentableEntity> invoices;
  @override
  final BuiltList<PaymentableEntity> credits;
  @override
  final bool isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final String createdUserId;
  @override
  final String assignedUserId;
  @override
  final String id;

  factory _$PaymentEntity([void Function(PaymentEntityBuilder) updates]) =>
      (new PaymentEntityBuilder()..update(updates)).build();

  _$PaymentEntity._(
      {this.amount,
      this.applied,
      this.refunded,
      this.number,
      this.idempotencyKey,
      this.clientId,
      this.statusId,
      this.transactionReference,
      this.date,
      this.typeId,
      this.privateNotes,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.exchangeRate,
      this.exchangeCurrencyId,
      this.isManual,
      this.projectId,
      this.vendorId,
      this.invitationId,
      this.transactionId,
      this.clientContactId,
      this.companyGatewayId,
      this.currencyId,
      this.isApplying,
      this.sendEmail,
      this.gatewayRefund,
      this.paymentables,
      this.invoices,
      this.credits,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(amount, 'PaymentEntity', 'amount');
    BuiltValueNullFieldError.checkNotNull(applied, 'PaymentEntity', 'applied');
    BuiltValueNullFieldError.checkNotNull(
        refunded, 'PaymentEntity', 'refunded');
    BuiltValueNullFieldError.checkNotNull(number, 'PaymentEntity', 'number');
    BuiltValueNullFieldError.checkNotNull(
        clientId, 'PaymentEntity', 'clientId');
    BuiltValueNullFieldError.checkNotNull(
        statusId, 'PaymentEntity', 'statusId');
    BuiltValueNullFieldError.checkNotNull(
        transactionReference, 'PaymentEntity', 'transactionReference');
    BuiltValueNullFieldError.checkNotNull(date, 'PaymentEntity', 'date');
    BuiltValueNullFieldError.checkNotNull(typeId, 'PaymentEntity', 'typeId');
    BuiltValueNullFieldError.checkNotNull(
        privateNotes, 'PaymentEntity', 'privateNotes');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, 'PaymentEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, 'PaymentEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, 'PaymentEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, 'PaymentEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        exchangeRate, 'PaymentEntity', 'exchangeRate');
    BuiltValueNullFieldError.checkNotNull(
        exchangeCurrencyId, 'PaymentEntity', 'exchangeCurrencyId');
    BuiltValueNullFieldError.checkNotNull(
        isManual, 'PaymentEntity', 'isManual');
    BuiltValueNullFieldError.checkNotNull(
        projectId, 'PaymentEntity', 'projectId');
    BuiltValueNullFieldError.checkNotNull(
        vendorId, 'PaymentEntity', 'vendorId');
    BuiltValueNullFieldError.checkNotNull(
        invitationId, 'PaymentEntity', 'invitationId');
    BuiltValueNullFieldError.checkNotNull(
        transactionId, 'PaymentEntity', 'transactionId');
    BuiltValueNullFieldError.checkNotNull(
        clientContactId, 'PaymentEntity', 'clientContactId');
    BuiltValueNullFieldError.checkNotNull(
        companyGatewayId, 'PaymentEntity', 'companyGatewayId');
    BuiltValueNullFieldError.checkNotNull(
        currencyId, 'PaymentEntity', 'currencyId');
    BuiltValueNullFieldError.checkNotNull(
        paymentables, 'PaymentEntity', 'paymentables');
    BuiltValueNullFieldError.checkNotNull(
        invoices, 'PaymentEntity', 'invoices');
    BuiltValueNullFieldError.checkNotNull(credits, 'PaymentEntity', 'credits');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'PaymentEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'PaymentEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'PaymentEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'PaymentEntity', 'id');
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
        applied == other.applied &&
        refunded == other.refunded &&
        number == other.number &&
        idempotencyKey == other.idempotencyKey &&
        clientId == other.clientId &&
        statusId == other.statusId &&
        transactionReference == other.transactionReference &&
        date == other.date &&
        typeId == other.typeId &&
        privateNotes == other.privateNotes &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        exchangeRate == other.exchangeRate &&
        exchangeCurrencyId == other.exchangeCurrencyId &&
        isManual == other.isManual &&
        projectId == other.projectId &&
        vendorId == other.vendorId &&
        invitationId == other.invitationId &&
        transactionId == other.transactionId &&
        clientContactId == other.clientContactId &&
        companyGatewayId == other.companyGatewayId &&
        currencyId == other.currencyId &&
        isApplying == other.isApplying &&
        sendEmail == other.sendEmail &&
        gatewayRefund == other.gatewayRefund &&
        paymentables == other.paymentables &&
        invoices == other.invoices &&
        credits == other.credits &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        id == other.id;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, amount.hashCode), applied.hashCode), refunded.hashCode), number.hashCode), idempotencyKey.hashCode), clientId.hashCode), statusId.hashCode), transactionReference.hashCode), date.hashCode), typeId.hashCode), privateNotes.hashCode), customValue1.hashCode), customValue2.hashCode), customValue3.hashCode), customValue4.hashCode), exchangeRate.hashCode), exchangeCurrencyId.hashCode), isManual.hashCode), projectId.hashCode), vendorId.hashCode),
                                                                                invitationId.hashCode),
                                                                            transactionId.hashCode),
                                                                        clientContactId.hashCode),
                                                                    companyGatewayId.hashCode),
                                                                currencyId.hashCode),
                                                            isApplying.hashCode),
                                                        sendEmail.hashCode),
                                                    gatewayRefund.hashCode),
                                                paymentables.hashCode),
                                            invoices.hashCode),
                                        credits.hashCode),
                                    isChanged.hashCode),
                                createdAt.hashCode),
                            updatedAt.hashCode),
                        archivedAt.hashCode),
                    isDeleted.hashCode),
                createdUserId.hashCode),
            assignedUserId.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentEntity')
          ..add('amount', amount)
          ..add('applied', applied)
          ..add('refunded', refunded)
          ..add('number', number)
          ..add('idempotencyKey', idempotencyKey)
          ..add('clientId', clientId)
          ..add('statusId', statusId)
          ..add('transactionReference', transactionReference)
          ..add('date', date)
          ..add('typeId', typeId)
          ..add('privateNotes', privateNotes)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('exchangeRate', exchangeRate)
          ..add('exchangeCurrencyId', exchangeCurrencyId)
          ..add('isManual', isManual)
          ..add('projectId', projectId)
          ..add('vendorId', vendorId)
          ..add('invitationId', invitationId)
          ..add('transactionId', transactionId)
          ..add('clientContactId', clientContactId)
          ..add('companyGatewayId', companyGatewayId)
          ..add('currencyId', currencyId)
          ..add('isApplying', isApplying)
          ..add('sendEmail', sendEmail)
          ..add('gatewayRefund', gatewayRefund)
          ..add('paymentables', paymentables)
          ..add('invoices', invoices)
          ..add('credits', credits)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
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

  double _applied;
  double get applied => _$this._applied;
  set applied(double applied) => _$this._applied = applied;

  double _refunded;
  double get refunded => _$this._refunded;
  set refunded(double refunded) => _$this._refunded = refunded;

  String _number;
  String get number => _$this._number;
  set number(String number) => _$this._number = number;

  String _idempotencyKey;
  String get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String _clientId;
  String get clientId => _$this._clientId;
  set clientId(String clientId) => _$this._clientId = clientId;

  String _statusId;
  String get statusId => _$this._statusId;
  set statusId(String statusId) => _$this._statusId = statusId;

  String _transactionReference;
  String get transactionReference => _$this._transactionReference;
  set transactionReference(String transactionReference) =>
      _$this._transactionReference = transactionReference;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

  String _typeId;
  String get typeId => _$this._typeId;
  set typeId(String typeId) => _$this._typeId = typeId;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  String _customValue3;
  String get customValue3 => _$this._customValue3;
  set customValue3(String customValue3) => _$this._customValue3 = customValue3;

  String _customValue4;
  String get customValue4 => _$this._customValue4;
  set customValue4(String customValue4) => _$this._customValue4 = customValue4;

  double _exchangeRate;
  double get exchangeRate => _$this._exchangeRate;
  set exchangeRate(double exchangeRate) => _$this._exchangeRate = exchangeRate;

  String _exchangeCurrencyId;
  String get exchangeCurrencyId => _$this._exchangeCurrencyId;
  set exchangeCurrencyId(String exchangeCurrencyId) =>
      _$this._exchangeCurrencyId = exchangeCurrencyId;

  bool _isManual;
  bool get isManual => _$this._isManual;
  set isManual(bool isManual) => _$this._isManual = isManual;

  String _projectId;
  String get projectId => _$this._projectId;
  set projectId(String projectId) => _$this._projectId = projectId;

  String _vendorId;
  String get vendorId => _$this._vendorId;
  set vendorId(String vendorId) => _$this._vendorId = vendorId;

  String _invitationId;
  String get invitationId => _$this._invitationId;
  set invitationId(String invitationId) => _$this._invitationId = invitationId;

  String _transactionId;
  String get transactionId => _$this._transactionId;
  set transactionId(String transactionId) =>
      _$this._transactionId = transactionId;

  String _clientContactId;
  String get clientContactId => _$this._clientContactId;
  set clientContactId(String clientContactId) =>
      _$this._clientContactId = clientContactId;

  String _companyGatewayId;
  String get companyGatewayId => _$this._companyGatewayId;
  set companyGatewayId(String companyGatewayId) =>
      _$this._companyGatewayId = companyGatewayId;

  String _currencyId;
  String get currencyId => _$this._currencyId;
  set currencyId(String currencyId) => _$this._currencyId = currencyId;

  bool _isApplying;
  bool get isApplying => _$this._isApplying;
  set isApplying(bool isApplying) => _$this._isApplying = isApplying;

  bool _sendEmail;
  bool get sendEmail => _$this._sendEmail;
  set sendEmail(bool sendEmail) => _$this._sendEmail = sendEmail;

  bool _gatewayRefund;
  bool get gatewayRefund => _$this._gatewayRefund;
  set gatewayRefund(bool gatewayRefund) =>
      _$this._gatewayRefund = gatewayRefund;

  ListBuilder<PaymentableEntity> _paymentables;
  ListBuilder<PaymentableEntity> get paymentables =>
      _$this._paymentables ??= new ListBuilder<PaymentableEntity>();
  set paymentables(ListBuilder<PaymentableEntity> paymentables) =>
      _$this._paymentables = paymentables;

  ListBuilder<PaymentableEntity> _invoices;
  ListBuilder<PaymentableEntity> get invoices =>
      _$this._invoices ??= new ListBuilder<PaymentableEntity>();
  set invoices(ListBuilder<PaymentableEntity> invoices) =>
      _$this._invoices = invoices;

  ListBuilder<PaymentableEntity> _credits;
  ListBuilder<PaymentableEntity> get credits =>
      _$this._credits ??= new ListBuilder<PaymentableEntity>();
  set credits(ListBuilder<PaymentableEntity> credits) =>
      _$this._credits = credits;

  bool _isChanged;
  bool get isChanged => _$this._isChanged;
  set isChanged(bool isChanged) => _$this._isChanged = isChanged;

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

  String _createdUserId;
  String get createdUserId => _$this._createdUserId;
  set createdUserId(String createdUserId) =>
      _$this._createdUserId = createdUserId;

  String _assignedUserId;
  String get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  PaymentEntityBuilder() {
    PaymentEntity._initializeBuilder(this);
  }

  PaymentEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _applied = $v.applied;
      _refunded = $v.refunded;
      _number = $v.number;
      _idempotencyKey = $v.idempotencyKey;
      _clientId = $v.clientId;
      _statusId = $v.statusId;
      _transactionReference = $v.transactionReference;
      _date = $v.date;
      _typeId = $v.typeId;
      _privateNotes = $v.privateNotes;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _exchangeRate = $v.exchangeRate;
      _exchangeCurrencyId = $v.exchangeCurrencyId;
      _isManual = $v.isManual;
      _projectId = $v.projectId;
      _vendorId = $v.vendorId;
      _invitationId = $v.invitationId;
      _transactionId = $v.transactionId;
      _clientContactId = $v.clientContactId;
      _companyGatewayId = $v.companyGatewayId;
      _currencyId = $v.currencyId;
      _isApplying = $v.isApplying;
      _sendEmail = $v.sendEmail;
      _gatewayRefund = $v.gatewayRefund;
      _paymentables = $v.paymentables.toBuilder();
      _invoices = $v.invoices.toBuilder();
      _credits = $v.credits.toBuilder();
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentEntity;
  }

  @override
  void update(void Function(PaymentEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentEntity build() {
    _$PaymentEntity _$result;
    try {
      _$result = _$v ??
          new _$PaymentEntity._(
              amount: BuiltValueNullFieldError.checkNotNull(
                  amount, 'PaymentEntity', 'amount'),
              applied: BuiltValueNullFieldError.checkNotNull(
                  applied, 'PaymentEntity', 'applied'),
              refunded: BuiltValueNullFieldError.checkNotNull(
                  refunded, 'PaymentEntity', 'refunded'),
              number: BuiltValueNullFieldError.checkNotNull(
                  number, 'PaymentEntity', 'number'),
              idempotencyKey: idempotencyKey,
              clientId: BuiltValueNullFieldError.checkNotNull(
                  clientId, 'PaymentEntity', 'clientId'),
              statusId: BuiltValueNullFieldError.checkNotNull(
                  statusId, 'PaymentEntity', 'statusId'),
              transactionReference: BuiltValueNullFieldError.checkNotNull(
                  transactionReference, 'PaymentEntity', 'transactionReference'),
              date: BuiltValueNullFieldError.checkNotNull(
                  date, 'PaymentEntity', 'date'),
              typeId: BuiltValueNullFieldError.checkNotNull(
                  typeId, 'PaymentEntity', 'typeId'),
              privateNotes: BuiltValueNullFieldError.checkNotNull(privateNotes, 'PaymentEntity', 'privateNotes'),
              customValue1: BuiltValueNullFieldError.checkNotNull(customValue1, 'PaymentEntity', 'customValue1'),
              customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, 'PaymentEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, 'PaymentEntity', 'customValue3'),
              customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, 'PaymentEntity', 'customValue4'),
              exchangeRate: BuiltValueNullFieldError.checkNotNull(exchangeRate, 'PaymentEntity', 'exchangeRate'),
              exchangeCurrencyId: BuiltValueNullFieldError.checkNotNull(exchangeCurrencyId, 'PaymentEntity', 'exchangeCurrencyId'),
              isManual: BuiltValueNullFieldError.checkNotNull(isManual, 'PaymentEntity', 'isManual'),
              projectId: BuiltValueNullFieldError.checkNotNull(projectId, 'PaymentEntity', 'projectId'),
              vendorId: BuiltValueNullFieldError.checkNotNull(vendorId, 'PaymentEntity', 'vendorId'),
              invitationId: BuiltValueNullFieldError.checkNotNull(invitationId, 'PaymentEntity', 'invitationId'),
              transactionId: BuiltValueNullFieldError.checkNotNull(transactionId, 'PaymentEntity', 'transactionId'),
              clientContactId: BuiltValueNullFieldError.checkNotNull(clientContactId, 'PaymentEntity', 'clientContactId'),
              companyGatewayId: BuiltValueNullFieldError.checkNotNull(companyGatewayId, 'PaymentEntity', 'companyGatewayId'),
              currencyId: BuiltValueNullFieldError.checkNotNull(currencyId, 'PaymentEntity', 'currencyId'),
              isApplying: isApplying,
              sendEmail: sendEmail,
              gatewayRefund: gatewayRefund,
              paymentables: paymentables.build(),
              invoices: invoices.build(),
              credits: credits.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, 'PaymentEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, 'PaymentEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, 'PaymentEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(id, 'PaymentEntity', 'id'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'paymentables';
        paymentables.build();
        _$failedField = 'invoices';
        invoices.build();
        _$failedField = 'credits';
        credits.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaymentEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentableEntity extends PaymentableEntity {
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final String invoiceId;
  @override
  final String creditId;
  @override
  final double amount;
  @override
  final String id;

  factory _$PaymentableEntity(
          [void Function(PaymentableEntityBuilder) updates]) =>
      (new PaymentableEntityBuilder()..update(updates)).build();

  _$PaymentableEntity._(
      {this.createdAt,
      this.updatedAt,
      this.invoiceId,
      this.creditId,
      this.amount,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        amount, 'PaymentableEntity', 'amount');
    BuiltValueNullFieldError.checkNotNull(id, 'PaymentableEntity', 'id');
  }

  @override
  PaymentableEntity rebuild(void Function(PaymentableEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentableEntityBuilder toBuilder() =>
      new PaymentableEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentableEntity &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        invoiceId == other.invoiceId &&
        creditId == other.creditId &&
        amount == other.amount &&
        id == other.id;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, createdAt.hashCode), updatedAt.hashCode),
                    invoiceId.hashCode),
                creditId.hashCode),
            amount.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentableEntity')
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('invoiceId', invoiceId)
          ..add('creditId', creditId)
          ..add('amount', amount)
          ..add('id', id))
        .toString();
  }
}

class PaymentableEntityBuilder
    implements Builder<PaymentableEntity, PaymentableEntityBuilder> {
  _$PaymentableEntity _$v;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  String _invoiceId;
  String get invoiceId => _$this._invoiceId;
  set invoiceId(String invoiceId) => _$this._invoiceId = invoiceId;

  String _creditId;
  String get creditId => _$this._creditId;
  set creditId(String creditId) => _$this._creditId = creditId;

  double _amount;
  double get amount => _$this._amount;
  set amount(double amount) => _$this._amount = amount;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  PaymentableEntityBuilder();

  PaymentableEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _invoiceId = $v.invoiceId;
      _creditId = $v.creditId;
      _amount = $v.amount;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentableEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentableEntity;
  }

  @override
  void update(void Function(PaymentableEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentableEntity build() {
    final _$result = _$v ??
        new _$PaymentableEntity._(
            createdAt: createdAt,
            updatedAt: updatedAt,
            invoiceId: invoiceId,
            creditId: creditId,
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, 'PaymentableEntity', 'amount'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'PaymentableEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
