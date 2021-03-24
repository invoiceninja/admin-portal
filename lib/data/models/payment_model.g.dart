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
      final dynamic value = iterator.current;
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
    if (object.isForInvoice != null) {
      result
        ..add('isForInvoice')
        ..add(serializers.serialize(object.isForInvoice,
            specifiedType: const FullType(bool)));
    }
    if (object.isApplying != null) {
      result
        ..add('isApplying')
        ..add(serializers.serialize(object.isApplying,
            specifiedType: const FullType(bool)));
    }
    if (object.sendEmail != null) {
      result
        ..add('sendEmail')
        ..add(serializers.serialize(object.sendEmail,
            specifiedType: const FullType(bool)));
    }
    if (object.gatewayRefund != null) {
      result
        ..add('gatewayRefund')
        ..add(serializers.serialize(object.gatewayRefund,
            specifiedType: const FullType(bool)));
    }
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.createdUserId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.createdUserId,
            specifiedType: const FullType(String)));
    }
    if (object.assignedUserId != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(object.assignedUserId,
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
        case 'isForInvoice':
          result.isForInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
    if (object.invoiceId != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(object.invoiceId,
            specifiedType: const FullType(String)));
    }
    if (object.creditId != null) {
      result
        ..add('credit_id')
        ..add(serializers.serialize(object.creditId,
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
      final dynamic value = iterator.current;
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
  final double applied;
  @override
  final double refunded;
  @override
  final String number;
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
  final String clientContactId;
  @override
  final String companyGatewayId;
  @override
  final String currencyId;
  @override
  final bool isForInvoice;
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
      this.clientContactId,
      this.companyGatewayId,
      this.currencyId,
      this.isForInvoice,
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
    if (amount == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'amount');
    }
    if (applied == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'applied');
    }
    if (refunded == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'refunded');
    }
    if (number == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'number');
    }
    if (clientId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'clientId');
    }
    if (statusId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'statusId');
    }
    if (transactionReference == null) {
      throw new BuiltValueNullFieldError(
          'PaymentEntity', 'transactionReference');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'date');
    }
    if (typeId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'typeId');
    }
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'privateNotes');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'customValue4');
    }
    if (exchangeRate == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'exchangeRate');
    }
    if (exchangeCurrencyId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'exchangeCurrencyId');
    }
    if (isManual == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'isManual');
    }
    if (projectId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'projectId');
    }
    if (vendorId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'vendorId');
    }
    if (invitationId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'invitationId');
    }
    if (clientContactId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'clientContactId');
    }
    if (companyGatewayId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'companyGatewayId');
    }
    if (currencyId == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'currencyId');
    }
    if (paymentables == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'paymentables');
    }
    if (invoices == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'invoices');
    }
    if (credits == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'credits');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('PaymentEntity', 'id');
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
        applied == other.applied &&
        refunded == other.refunded &&
        number == other.number &&
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
        clientContactId == other.clientContactId &&
        companyGatewayId == other.companyGatewayId &&
        currencyId == other.currencyId &&
        isForInvoice == other.isForInvoice &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, amount.hashCode), applied.hashCode), refunded.hashCode), number.hashCode), clientId.hashCode), statusId.hashCode), transactionReference.hashCode), date.hashCode), typeId.hashCode), privateNotes.hashCode), customValue1.hashCode), customValue2.hashCode), customValue3.hashCode), customValue4.hashCode), exchangeRate.hashCode), exchangeCurrencyId.hashCode), isManual.hashCode), projectId.hashCode), vendorId.hashCode),
                                                                                invitationId.hashCode),
                                                                            clientContactId.hashCode),
                                                                        companyGatewayId.hashCode),
                                                                    currencyId.hashCode),
                                                                isForInvoice.hashCode),
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
          ..add('clientContactId', clientContactId)
          ..add('companyGatewayId', companyGatewayId)
          ..add('currencyId', currencyId)
          ..add('isForInvoice', isForInvoice)
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

  bool _isForInvoice;
  bool get isForInvoice => _$this._isForInvoice;
  set isForInvoice(bool isForInvoice) => _$this._isForInvoice = isForInvoice;

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

  PaymentEntityBuilder();

  PaymentEntityBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _applied = _$v.applied;
      _refunded = _$v.refunded;
      _number = _$v.number;
      _clientId = _$v.clientId;
      _statusId = _$v.statusId;
      _transactionReference = _$v.transactionReference;
      _date = _$v.date;
      _typeId = _$v.typeId;
      _privateNotes = _$v.privateNotes;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _exchangeRate = _$v.exchangeRate;
      _exchangeCurrencyId = _$v.exchangeCurrencyId;
      _isManual = _$v.isManual;
      _projectId = _$v.projectId;
      _vendorId = _$v.vendorId;
      _invitationId = _$v.invitationId;
      _clientContactId = _$v.clientContactId;
      _companyGatewayId = _$v.companyGatewayId;
      _currencyId = _$v.currencyId;
      _isForInvoice = _$v.isForInvoice;
      _isApplying = _$v.isApplying;
      _sendEmail = _$v.sendEmail;
      _gatewayRefund = _$v.gatewayRefund;
      _paymentables = _$v.paymentables?.toBuilder();
      _invoices = _$v.invoices?.toBuilder();
      _credits = _$v.credits?.toBuilder();
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
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
    _$PaymentEntity _$result;
    try {
      _$result = _$v ??
          new _$PaymentEntity._(
              amount: amount,
              applied: applied,
              refunded: refunded,
              number: number,
              clientId: clientId,
              statusId: statusId,
              transactionReference: transactionReference,
              date: date,
              typeId: typeId,
              privateNotes: privateNotes,
              customValue1: customValue1,
              customValue2: customValue2,
              customValue3: customValue3,
              customValue4: customValue4,
              exchangeRate: exchangeRate,
              exchangeCurrencyId: exchangeCurrencyId,
              isManual: isManual,
              projectId: projectId,
              vendorId: vendorId,
              invitationId: invitationId,
              clientContactId: clientContactId,
              companyGatewayId: companyGatewayId,
              currencyId: currencyId,
              isForInvoice: isForInvoice,
              isApplying: isApplying,
              sendEmail: sendEmail,
              gatewayRefund: gatewayRefund,
              paymentables: paymentables.build(),
              invoices: invoices.build(),
              credits: credits.build(),
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: id);
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
    if (amount == null) {
      throw new BuiltValueNullFieldError('PaymentableEntity', 'amount');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('PaymentableEntity', 'id');
    }
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
    if (_$v != null) {
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _invoiceId = _$v.invoiceId;
      _creditId = _$v.creditId;
      _amount = _$v.amount;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentableEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
            amount: amount,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
