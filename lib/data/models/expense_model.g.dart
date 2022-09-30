// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ExpenseListResponse> _$expenseListResponseSerializer =
    new _$ExpenseListResponseSerializer();
Serializer<ExpenseItemResponse> _$expenseItemResponseSerializer =
    new _$ExpenseItemResponseSerializer();
Serializer<ExpenseEntity> _$expenseEntitySerializer =
    new _$ExpenseEntitySerializer();
Serializer<ExpenseScheduleEntity> _$expenseScheduleEntitySerializer =
    new _$ExpenseScheduleEntitySerializer();
Serializer<ExpenseStatusEntity> _$expenseStatusEntitySerializer =
    new _$ExpenseStatusEntitySerializer();

class _$ExpenseListResponseSerializer
    implements StructuredSerializer<ExpenseListResponse> {
  @override
  final Iterable<Type> types = const [
    ExpenseListResponse,
    _$ExpenseListResponse
  ];
  @override
  final String wireName = 'ExpenseListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ExpenseListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ExpenseEntity)])),
    ];

    return result;
  }

  @override
  ExpenseListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ExpenseEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$ExpenseItemResponseSerializer
    implements StructuredSerializer<ExpenseItemResponse> {
  @override
  final Iterable<Type> types = const [
    ExpenseItemResponse,
    _$ExpenseItemResponse
  ];
  @override
  final String wireName = 'ExpenseItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ExpenseItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ExpenseEntity)),
    ];

    return result;
  }

  @override
  ExpenseItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(ExpenseEntity)) as ExpenseEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$ExpenseEntitySerializer implements StructuredSerializer<ExpenseEntity> {
  @override
  final Iterable<Type> types = const [ExpenseEntity, _$ExpenseEntity];
  @override
  final String wireName = 'ExpenseEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, ExpenseEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'private_notes',
      serializers.serialize(object.privateNotes,
          specifiedType: const FullType(String)),
      'public_notes',
      serializers.serialize(object.publicNotes,
          specifiedType: const FullType(String)),
      'should_be_invoiced',
      serializers.serialize(object.shouldBeInvoiced,
          specifiedType: const FullType(bool)),
      'invoice_documents',
      serializers.serialize(object.invoiceDocuments,
          specifiedType: const FullType(bool)),
      'transaction_id',
      serializers.serialize(object.transactionId,
          specifiedType: const FullType(String)),
      'transaction_reference',
      serializers.serialize(object.transactionReference,
          specifiedType: const FullType(String)),
      'bank_id',
      serializers.serialize(object.bankId,
          specifiedType: const FullType(String)),
      'currency_id',
      serializers.serialize(object.currencyId,
          specifiedType: const FullType(String)),
      'category_id',
      serializers.serialize(object.categoryId,
          specifiedType: const FullType(String)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'payment_date',
      serializers.serialize(object.paymentDate,
          specifiedType: const FullType(String)),
      'exchange_rate',
      serializers.serialize(object.exchangeRate,
          specifiedType: const FullType(double)),
      'invoice_currency_id',
      serializers.serialize(object.invoiceCurrencyId,
          specifiedType: const FullType(String)),
      'payment_type_id',
      serializers.serialize(object.paymentTypeId,
          specifiedType: const FullType(String)),
      'tax_name1',
      serializers.serialize(object.taxName1,
          specifiedType: const FullType(String)),
      'tax_name2',
      serializers.serialize(object.taxName2,
          specifiedType: const FullType(String)),
      'tax_rate1',
      serializers.serialize(object.taxRate1,
          specifiedType: const FullType(double)),
      'tax_rate2',
      serializers.serialize(object.taxRate2,
          specifiedType: const FullType(double)),
      'tax_name3',
      serializers.serialize(object.taxName3,
          specifiedType: const FullType(String)),
      'tax_rate3',
      serializers.serialize(object.taxRate3,
          specifiedType: const FullType(double)),
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
      'tax_amount1',
      serializers.serialize(object.taxAmount1,
          specifiedType: const FullType(double)),
      'tax_amount2',
      serializers.serialize(object.taxAmount2,
          specifiedType: const FullType(double)),
      'tax_amount3',
      serializers.serialize(object.taxAmount3,
          specifiedType: const FullType(double)),
      'uses_inclusive_taxes',
      serializers.serialize(object.usesInclusiveTaxes,
          specifiedType: const FullType(bool)),
      'documents',
      serializers.serialize(object.documents,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
      'number',
      serializers.serialize(object.number,
          specifiedType: const FullType(String)),
      'frequency_id',
      serializers.serialize(object.frequencyId,
          specifiedType: const FullType(String)),
      'last_sent_date',
      serializers.serialize(object.lastSentDate,
          specifiedType: const FullType(String)),
      'next_send_date',
      serializers.serialize(object.nextSendDate,
          specifiedType: const FullType(String)),
      'remaining_cycles',
      serializers.serialize(object.remainingCycles,
          specifiedType: const FullType(int)),
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
    value = object.date;
    if (value != null) {
      result
        ..add('date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientId;
    if (value != null) {
      result
        ..add('client_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.invoiceId;
    if (value != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.vendorId;
    if (value != null) {
      result
        ..add('vendor_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.projectId;
    if (value != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.statusId;
    if (value != null) {
      result
        ..add('status_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.calculateTaxByAmount;
    if (value != null) {
      result
        ..add('calculate_tax_by_amount')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.recurringId;
    if (value != null) {
      result
        ..add('recurring_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.recurringDates;
    if (value != null) {
      result
        ..add('recurring_dates')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ExpenseScheduleEntity)])));
    }
    value = object.loadedAt;
    if (value != null) {
      result
        ..add('loadedAt')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
    value = object.entityType;
    if (value != null) {
      result
        ..add('entity_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(EntityType)));
    }
    value = object.idempotencyKey;
    if (value != null) {
      result
        ..add('idempotency_key')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ExpenseEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'private_notes':
          result.privateNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'public_notes':
          result.publicNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'should_be_invoiced':
          result.shouldBeInvoiced = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_documents':
          result.invoiceDocuments = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'transaction_id':
          result.transactionId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'transaction_reference':
          result.transactionReference = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bank_id':
          result.bankId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'category_id':
          result.categoryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_date':
          result.paymentDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'exchange_rate':
          result.exchangeRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'invoice_currency_id':
          result.invoiceCurrencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_type_id':
          result.paymentTypeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_name1':
          result.taxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_name2':
          result.taxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate1':
          result.taxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_rate2':
          result.taxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name3':
          result.taxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate3':
          result.taxRate3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vendor_id':
          result.vendorId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status_id':
          result.statusId = serializers.deserialize(value,
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
        case 'tax_amount1':
          result.taxAmount1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_amount2':
          result.taxAmount2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_amount3':
          result.taxAmount3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'uses_inclusive_taxes':
          result.usesInclusiveTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'calculate_tax_by_amount':
          result.calculateTaxByAmount = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))
              as BuiltList<Object>);
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'recurring_id':
          result.recurringId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'frequency_id':
          result.frequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_sent_date':
          result.lastSentDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'next_send_date':
          result.nextSendDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'remaining_cycles':
          result.remainingCycles = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'recurring_dates':
          result.recurringDates.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ExpenseScheduleEntity)]))
              as BuiltList<Object>);
          break;
        case 'loadedAt':
          result.loadedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
        case 'entity_type':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
          break;
        case 'idempotency_key':
          result.idempotencyKey = serializers.deserialize(value,
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

class _$ExpenseScheduleEntitySerializer
    implements StructuredSerializer<ExpenseScheduleEntity> {
  @override
  final Iterable<Type> types = const [
    ExpenseScheduleEntity,
    _$ExpenseScheduleEntity
  ];
  @override
  final String wireName = 'ExpenseScheduleEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ExpenseScheduleEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'send_date',
      serializers.serialize(object.sendDate,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ExpenseScheduleEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseScheduleEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'send_date':
          result.sendDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ExpenseStatusEntitySerializer
    implements StructuredSerializer<ExpenseStatusEntity> {
  @override
  final Iterable<Type> types = const [
    ExpenseStatusEntity,
    _$ExpenseStatusEntity
  ];
  @override
  final String wireName = 'ExpenseStatusEntity';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ExpenseStatusEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ExpenseStatusEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseStatusEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ExpenseListResponse extends ExpenseListResponse {
  @override
  final BuiltList<ExpenseEntity> data;

  factory _$ExpenseListResponse(
          [void Function(ExpenseListResponseBuilder) updates]) =>
      (new ExpenseListResponseBuilder()..update(updates)).build();

  _$ExpenseListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'ExpenseListResponse', 'data');
  }

  @override
  ExpenseListResponse rebuild(
          void Function(ExpenseListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseListResponseBuilder toBuilder() =>
      new ExpenseListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseListResponse')
          ..add('data', data))
        .toString();
  }
}

class ExpenseListResponseBuilder
    implements Builder<ExpenseListResponse, ExpenseListResponseBuilder> {
  _$ExpenseListResponse _$v;

  ListBuilder<ExpenseEntity> _data;
  ListBuilder<ExpenseEntity> get data =>
      _$this._data ??= new ListBuilder<ExpenseEntity>();
  set data(ListBuilder<ExpenseEntity> data) => _$this._data = data;

  ExpenseListResponseBuilder();

  ExpenseListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseListResponse;
  }

  @override
  void update(void Function(ExpenseListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseListResponse build() {
    _$ExpenseListResponse _$result;
    try {
      _$result = _$v ?? new _$ExpenseListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ExpenseListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ExpenseItemResponse extends ExpenseItemResponse {
  @override
  final ExpenseEntity data;

  factory _$ExpenseItemResponse(
          [void Function(ExpenseItemResponseBuilder) updates]) =>
      (new ExpenseItemResponseBuilder()..update(updates)).build();

  _$ExpenseItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'ExpenseItemResponse', 'data');
  }

  @override
  ExpenseItemResponse rebuild(
          void Function(ExpenseItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseItemResponseBuilder toBuilder() =>
      new ExpenseItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseItemResponse')
          ..add('data', data))
        .toString();
  }
}

class ExpenseItemResponseBuilder
    implements Builder<ExpenseItemResponse, ExpenseItemResponseBuilder> {
  _$ExpenseItemResponse _$v;

  ExpenseEntityBuilder _data;
  ExpenseEntityBuilder get data => _$this._data ??= new ExpenseEntityBuilder();
  set data(ExpenseEntityBuilder data) => _$this._data = data;

  ExpenseItemResponseBuilder();

  ExpenseItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseItemResponse;
  }

  @override
  void update(void Function(ExpenseItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseItemResponse build() {
    _$ExpenseItemResponse _$result;
    try {
      _$result = _$v ?? new _$ExpenseItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ExpenseItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ExpenseEntity extends ExpenseEntity {
  @override
  final String privateNotes;
  @override
  final String publicNotes;
  @override
  final bool shouldBeInvoiced;
  @override
  final bool invoiceDocuments;
  @override
  final String transactionId;
  @override
  final String transactionReference;
  @override
  final String bankId;
  @override
  final String currencyId;
  @override
  final String categoryId;
  @override
  final double amount;
  @override
  final String date;
  @override
  final String paymentDate;
  @override
  final double exchangeRate;
  @override
  final String invoiceCurrencyId;
  @override
  final String paymentTypeId;
  @override
  final String taxName1;
  @override
  final String taxName2;
  @override
  final double taxRate1;
  @override
  final double taxRate2;
  @override
  final String taxName3;
  @override
  final double taxRate3;
  @override
  final String clientId;
  @override
  final String invoiceId;
  @override
  final String vendorId;
  @override
  final String projectId;
  @override
  final String statusId;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final double taxAmount1;
  @override
  final double taxAmount2;
  @override
  final double taxAmount3;
  @override
  final bool usesInclusiveTaxes;
  @override
  final bool calculateTaxByAmount;
  @override
  final BuiltList<DocumentEntity> documents;
  @override
  final String number;
  @override
  final String recurringId;
  @override
  final String frequencyId;
  @override
  final String lastSentDate;
  @override
  final String nextSendDate;
  @override
  final int remainingCycles;
  @override
  final BuiltList<ExpenseScheduleEntity> recurringDates;
  @override
  final int loadedAt;
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
  final EntityType entityType;
  @override
  final String idempotencyKey;
  @override
  final String id;

  factory _$ExpenseEntity([void Function(ExpenseEntityBuilder) updates]) =>
      (new ExpenseEntityBuilder()..update(updates)).build();

  _$ExpenseEntity._(
      {this.privateNotes,
      this.publicNotes,
      this.shouldBeInvoiced,
      this.invoiceDocuments,
      this.transactionId,
      this.transactionReference,
      this.bankId,
      this.currencyId,
      this.categoryId,
      this.amount,
      this.date,
      this.paymentDate,
      this.exchangeRate,
      this.invoiceCurrencyId,
      this.paymentTypeId,
      this.taxName1,
      this.taxName2,
      this.taxRate1,
      this.taxRate2,
      this.taxName3,
      this.taxRate3,
      this.clientId,
      this.invoiceId,
      this.vendorId,
      this.projectId,
      this.statusId,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.taxAmount1,
      this.taxAmount2,
      this.taxAmount3,
      this.usesInclusiveTaxes,
      this.calculateTaxByAmount,
      this.documents,
      this.number,
      this.recurringId,
      this.frequencyId,
      this.lastSentDate,
      this.nextSendDate,
      this.remainingCycles,
      this.recurringDates,
      this.loadedAt,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.entityType,
      this.idempotencyKey,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        privateNotes, 'ExpenseEntity', 'privateNotes');
    BuiltValueNullFieldError.checkNotNull(
        publicNotes, 'ExpenseEntity', 'publicNotes');
    BuiltValueNullFieldError.checkNotNull(
        shouldBeInvoiced, 'ExpenseEntity', 'shouldBeInvoiced');
    BuiltValueNullFieldError.checkNotNull(
        invoiceDocuments, 'ExpenseEntity', 'invoiceDocuments');
    BuiltValueNullFieldError.checkNotNull(
        transactionId, 'ExpenseEntity', 'transactionId');
    BuiltValueNullFieldError.checkNotNull(
        transactionReference, 'ExpenseEntity', 'transactionReference');
    BuiltValueNullFieldError.checkNotNull(bankId, 'ExpenseEntity', 'bankId');
    BuiltValueNullFieldError.checkNotNull(
        currencyId, 'ExpenseEntity', 'currencyId');
    BuiltValueNullFieldError.checkNotNull(
        categoryId, 'ExpenseEntity', 'categoryId');
    BuiltValueNullFieldError.checkNotNull(amount, 'ExpenseEntity', 'amount');
    BuiltValueNullFieldError.checkNotNull(
        paymentDate, 'ExpenseEntity', 'paymentDate');
    BuiltValueNullFieldError.checkNotNull(
        exchangeRate, 'ExpenseEntity', 'exchangeRate');
    BuiltValueNullFieldError.checkNotNull(
        invoiceCurrencyId, 'ExpenseEntity', 'invoiceCurrencyId');
    BuiltValueNullFieldError.checkNotNull(
        paymentTypeId, 'ExpenseEntity', 'paymentTypeId');
    BuiltValueNullFieldError.checkNotNull(
        taxName1, 'ExpenseEntity', 'taxName1');
    BuiltValueNullFieldError.checkNotNull(
        taxName2, 'ExpenseEntity', 'taxName2');
    BuiltValueNullFieldError.checkNotNull(
        taxRate1, 'ExpenseEntity', 'taxRate1');
    BuiltValueNullFieldError.checkNotNull(
        taxRate2, 'ExpenseEntity', 'taxRate2');
    BuiltValueNullFieldError.checkNotNull(
        taxName3, 'ExpenseEntity', 'taxName3');
    BuiltValueNullFieldError.checkNotNull(
        taxRate3, 'ExpenseEntity', 'taxRate3');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, 'ExpenseEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, 'ExpenseEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, 'ExpenseEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, 'ExpenseEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        taxAmount1, 'ExpenseEntity', 'taxAmount1');
    BuiltValueNullFieldError.checkNotNull(
        taxAmount2, 'ExpenseEntity', 'taxAmount2');
    BuiltValueNullFieldError.checkNotNull(
        taxAmount3, 'ExpenseEntity', 'taxAmount3');
    BuiltValueNullFieldError.checkNotNull(
        usesInclusiveTaxes, 'ExpenseEntity', 'usesInclusiveTaxes');
    BuiltValueNullFieldError.checkNotNull(
        documents, 'ExpenseEntity', 'documents');
    BuiltValueNullFieldError.checkNotNull(number, 'ExpenseEntity', 'number');
    BuiltValueNullFieldError.checkNotNull(
        frequencyId, 'ExpenseEntity', 'frequencyId');
    BuiltValueNullFieldError.checkNotNull(
        lastSentDate, 'ExpenseEntity', 'lastSentDate');
    BuiltValueNullFieldError.checkNotNull(
        nextSendDate, 'ExpenseEntity', 'nextSendDate');
    BuiltValueNullFieldError.checkNotNull(
        remainingCycles, 'ExpenseEntity', 'remainingCycles');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'ExpenseEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'ExpenseEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'ExpenseEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'ExpenseEntity', 'id');
  }

  @override
  ExpenseEntity rebuild(void Function(ExpenseEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseEntityBuilder toBuilder() => new ExpenseEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseEntity &&
        privateNotes == other.privateNotes &&
        publicNotes == other.publicNotes &&
        shouldBeInvoiced == other.shouldBeInvoiced &&
        invoiceDocuments == other.invoiceDocuments &&
        transactionId == other.transactionId &&
        transactionReference == other.transactionReference &&
        bankId == other.bankId &&
        currencyId == other.currencyId &&
        categoryId == other.categoryId &&
        amount == other.amount &&
        date == other.date &&
        paymentDate == other.paymentDate &&
        exchangeRate == other.exchangeRate &&
        invoiceCurrencyId == other.invoiceCurrencyId &&
        paymentTypeId == other.paymentTypeId &&
        taxName1 == other.taxName1 &&
        taxName2 == other.taxName2 &&
        taxRate1 == other.taxRate1 &&
        taxRate2 == other.taxRate2 &&
        taxName3 == other.taxName3 &&
        taxRate3 == other.taxRate3 &&
        clientId == other.clientId &&
        invoiceId == other.invoiceId &&
        vendorId == other.vendorId &&
        projectId == other.projectId &&
        statusId == other.statusId &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        taxAmount1 == other.taxAmount1 &&
        taxAmount2 == other.taxAmount2 &&
        taxAmount3 == other.taxAmount3 &&
        usesInclusiveTaxes == other.usesInclusiveTaxes &&
        calculateTaxByAmount == other.calculateTaxByAmount &&
        documents == other.documents &&
        number == other.number &&
        recurringId == other.recurringId &&
        frequencyId == other.frequencyId &&
        lastSentDate == other.lastSentDate &&
        nextSendDate == other.nextSendDate &&
        remainingCycles == other.remainingCycles &&
        recurringDates == other.recurringDates &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        entityType == other.entityType &&
        idempotencyKey == other.idempotencyKey &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, privateNotes.hashCode), publicNotes.hashCode), shouldBeInvoiced.hashCode), invoiceDocuments.hashCode), transactionId.hashCode), transactionReference.hashCode), bankId.hashCode), currencyId.hashCode), categoryId.hashCode), amount.hashCode), date.hashCode), paymentDate.hashCode), exchangeRate.hashCode), invoiceCurrencyId.hashCode), paymentTypeId.hashCode), taxName1.hashCode), taxName2.hashCode), taxRate1.hashCode), taxRate2.hashCode), taxName3.hashCode), taxRate3.hashCode), clientId.hashCode), invoiceId.hashCode), vendorId.hashCode), projectId.hashCode), statusId.hashCode), customValue1.hashCode), customValue2.hashCode), customValue3.hashCode), customValue4.hashCode), taxAmount1.hashCode), taxAmount2.hashCode), taxAmount3.hashCode), usesInclusiveTaxes.hashCode),
                                                                                calculateTaxByAmount.hashCode),
                                                                            documents.hashCode),
                                                                        number.hashCode),
                                                                    recurringId.hashCode),
                                                                frequencyId.hashCode),
                                                            lastSentDate.hashCode),
                                                        nextSendDate.hashCode),
                                                    remainingCycles.hashCode),
                                                recurringDates.hashCode),
                                            isChanged.hashCode),
                                        createdAt.hashCode),
                                    updatedAt.hashCode),
                                archivedAt.hashCode),
                            isDeleted.hashCode),
                        createdUserId.hashCode),
                    assignedUserId.hashCode),
                entityType.hashCode),
            idempotencyKey.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseEntity')
          ..add('privateNotes', privateNotes)
          ..add('publicNotes', publicNotes)
          ..add('shouldBeInvoiced', shouldBeInvoiced)
          ..add('invoiceDocuments', invoiceDocuments)
          ..add('transactionId', transactionId)
          ..add('transactionReference', transactionReference)
          ..add('bankId', bankId)
          ..add('currencyId', currencyId)
          ..add('categoryId', categoryId)
          ..add('amount', amount)
          ..add('date', date)
          ..add('paymentDate', paymentDate)
          ..add('exchangeRate', exchangeRate)
          ..add('invoiceCurrencyId', invoiceCurrencyId)
          ..add('paymentTypeId', paymentTypeId)
          ..add('taxName1', taxName1)
          ..add('taxName2', taxName2)
          ..add('taxRate1', taxRate1)
          ..add('taxRate2', taxRate2)
          ..add('taxName3', taxName3)
          ..add('taxRate3', taxRate3)
          ..add('clientId', clientId)
          ..add('invoiceId', invoiceId)
          ..add('vendorId', vendorId)
          ..add('projectId', projectId)
          ..add('statusId', statusId)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('taxAmount1', taxAmount1)
          ..add('taxAmount2', taxAmount2)
          ..add('taxAmount3', taxAmount3)
          ..add('usesInclusiveTaxes', usesInclusiveTaxes)
          ..add('calculateTaxByAmount', calculateTaxByAmount)
          ..add('documents', documents)
          ..add('number', number)
          ..add('recurringId', recurringId)
          ..add('frequencyId', frequencyId)
          ..add('lastSentDate', lastSentDate)
          ..add('nextSendDate', nextSendDate)
          ..add('remainingCycles', remainingCycles)
          ..add('recurringDates', recurringDates)
          ..add('loadedAt', loadedAt)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('entityType', entityType)
          ..add('idempotencyKey', idempotencyKey)
          ..add('id', id))
        .toString();
  }
}

class ExpenseEntityBuilder
    implements Builder<ExpenseEntity, ExpenseEntityBuilder> {
  _$ExpenseEntity _$v;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

  String _publicNotes;
  String get publicNotes => _$this._publicNotes;
  set publicNotes(String publicNotes) => _$this._publicNotes = publicNotes;

  bool _shouldBeInvoiced;
  bool get shouldBeInvoiced => _$this._shouldBeInvoiced;
  set shouldBeInvoiced(bool shouldBeInvoiced) =>
      _$this._shouldBeInvoiced = shouldBeInvoiced;

  bool _invoiceDocuments;
  bool get invoiceDocuments => _$this._invoiceDocuments;
  set invoiceDocuments(bool invoiceDocuments) =>
      _$this._invoiceDocuments = invoiceDocuments;

  String _transactionId;
  String get transactionId => _$this._transactionId;
  set transactionId(String transactionId) =>
      _$this._transactionId = transactionId;

  String _transactionReference;
  String get transactionReference => _$this._transactionReference;
  set transactionReference(String transactionReference) =>
      _$this._transactionReference = transactionReference;

  String _bankId;
  String get bankId => _$this._bankId;
  set bankId(String bankId) => _$this._bankId = bankId;

  String _currencyId;
  String get currencyId => _$this._currencyId;
  set currencyId(String currencyId) => _$this._currencyId = currencyId;

  String _categoryId;
  String get categoryId => _$this._categoryId;
  set categoryId(String categoryId) => _$this._categoryId = categoryId;

  double _amount;
  double get amount => _$this._amount;
  set amount(double amount) => _$this._amount = amount;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

  String _paymentDate;
  String get paymentDate => _$this._paymentDate;
  set paymentDate(String paymentDate) => _$this._paymentDate = paymentDate;

  double _exchangeRate;
  double get exchangeRate => _$this._exchangeRate;
  set exchangeRate(double exchangeRate) => _$this._exchangeRate = exchangeRate;

  String _invoiceCurrencyId;
  String get invoiceCurrencyId => _$this._invoiceCurrencyId;
  set invoiceCurrencyId(String invoiceCurrencyId) =>
      _$this._invoiceCurrencyId = invoiceCurrencyId;

  String _paymentTypeId;
  String get paymentTypeId => _$this._paymentTypeId;
  set paymentTypeId(String paymentTypeId) =>
      _$this._paymentTypeId = paymentTypeId;

  String _taxName1;
  String get taxName1 => _$this._taxName1;
  set taxName1(String taxName1) => _$this._taxName1 = taxName1;

  String _taxName2;
  String get taxName2 => _$this._taxName2;
  set taxName2(String taxName2) => _$this._taxName2 = taxName2;

  double _taxRate1;
  double get taxRate1 => _$this._taxRate1;
  set taxRate1(double taxRate1) => _$this._taxRate1 = taxRate1;

  double _taxRate2;
  double get taxRate2 => _$this._taxRate2;
  set taxRate2(double taxRate2) => _$this._taxRate2 = taxRate2;

  String _taxName3;
  String get taxName3 => _$this._taxName3;
  set taxName3(String taxName3) => _$this._taxName3 = taxName3;

  double _taxRate3;
  double get taxRate3 => _$this._taxRate3;
  set taxRate3(double taxRate3) => _$this._taxRate3 = taxRate3;

  String _clientId;
  String get clientId => _$this._clientId;
  set clientId(String clientId) => _$this._clientId = clientId;

  String _invoiceId;
  String get invoiceId => _$this._invoiceId;
  set invoiceId(String invoiceId) => _$this._invoiceId = invoiceId;

  String _vendorId;
  String get vendorId => _$this._vendorId;
  set vendorId(String vendorId) => _$this._vendorId = vendorId;

  String _projectId;
  String get projectId => _$this._projectId;
  set projectId(String projectId) => _$this._projectId = projectId;

  String _statusId;
  String get statusId => _$this._statusId;
  set statusId(String statusId) => _$this._statusId = statusId;

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

  double _taxAmount1;
  double get taxAmount1 => _$this._taxAmount1;
  set taxAmount1(double taxAmount1) => _$this._taxAmount1 = taxAmount1;

  double _taxAmount2;
  double get taxAmount2 => _$this._taxAmount2;
  set taxAmount2(double taxAmount2) => _$this._taxAmount2 = taxAmount2;

  double _taxAmount3;
  double get taxAmount3 => _$this._taxAmount3;
  set taxAmount3(double taxAmount3) => _$this._taxAmount3 = taxAmount3;

  bool _usesInclusiveTaxes;
  bool get usesInclusiveTaxes => _$this._usesInclusiveTaxes;
  set usesInclusiveTaxes(bool usesInclusiveTaxes) =>
      _$this._usesInclusiveTaxes = usesInclusiveTaxes;

  bool _calculateTaxByAmount;
  bool get calculateTaxByAmount => _$this._calculateTaxByAmount;
  set calculateTaxByAmount(bool calculateTaxByAmount) =>
      _$this._calculateTaxByAmount = calculateTaxByAmount;

  ListBuilder<DocumentEntity> _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity> documents) =>
      _$this._documents = documents;

  String _number;
  String get number => _$this._number;
  set number(String number) => _$this._number = number;

  String _recurringId;
  String get recurringId => _$this._recurringId;
  set recurringId(String recurringId) => _$this._recurringId = recurringId;

  String _frequencyId;
  String get frequencyId => _$this._frequencyId;
  set frequencyId(String frequencyId) => _$this._frequencyId = frequencyId;

  String _lastSentDate;
  String get lastSentDate => _$this._lastSentDate;
  set lastSentDate(String lastSentDate) => _$this._lastSentDate = lastSentDate;

  String _nextSendDate;
  String get nextSendDate => _$this._nextSendDate;
  set nextSendDate(String nextSendDate) => _$this._nextSendDate = nextSendDate;

  int _remainingCycles;
  int get remainingCycles => _$this._remainingCycles;
  set remainingCycles(int remainingCycles) =>
      _$this._remainingCycles = remainingCycles;

  ListBuilder<ExpenseScheduleEntity> _recurringDates;
  ListBuilder<ExpenseScheduleEntity> get recurringDates =>
      _$this._recurringDates ??= new ListBuilder<ExpenseScheduleEntity>();
  set recurringDates(ListBuilder<ExpenseScheduleEntity> recurringDates) =>
      _$this._recurringDates = recurringDates;

  int _loadedAt;
  int get loadedAt => _$this._loadedAt;
  set loadedAt(int loadedAt) => _$this._loadedAt = loadedAt;

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

  EntityType _entityType;
  EntityType get entityType => _$this._entityType;
  set entityType(EntityType entityType) => _$this._entityType = entityType;

  String _idempotencyKey;
  String get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  ExpenseEntityBuilder() {
    ExpenseEntity._initializeBuilder(this);
  }

  ExpenseEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _privateNotes = $v.privateNotes;
      _publicNotes = $v.publicNotes;
      _shouldBeInvoiced = $v.shouldBeInvoiced;
      _invoiceDocuments = $v.invoiceDocuments;
      _transactionId = $v.transactionId;
      _transactionReference = $v.transactionReference;
      _bankId = $v.bankId;
      _currencyId = $v.currencyId;
      _categoryId = $v.categoryId;
      _amount = $v.amount;
      _date = $v.date;
      _paymentDate = $v.paymentDate;
      _exchangeRate = $v.exchangeRate;
      _invoiceCurrencyId = $v.invoiceCurrencyId;
      _paymentTypeId = $v.paymentTypeId;
      _taxName1 = $v.taxName1;
      _taxName2 = $v.taxName2;
      _taxRate1 = $v.taxRate1;
      _taxRate2 = $v.taxRate2;
      _taxName3 = $v.taxName3;
      _taxRate3 = $v.taxRate3;
      _clientId = $v.clientId;
      _invoiceId = $v.invoiceId;
      _vendorId = $v.vendorId;
      _projectId = $v.projectId;
      _statusId = $v.statusId;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _taxAmount1 = $v.taxAmount1;
      _taxAmount2 = $v.taxAmount2;
      _taxAmount3 = $v.taxAmount3;
      _usesInclusiveTaxes = $v.usesInclusiveTaxes;
      _calculateTaxByAmount = $v.calculateTaxByAmount;
      _documents = $v.documents.toBuilder();
      _number = $v.number;
      _recurringId = $v.recurringId;
      _frequencyId = $v.frequencyId;
      _lastSentDate = $v.lastSentDate;
      _nextSendDate = $v.nextSendDate;
      _remainingCycles = $v.remainingCycles;
      _recurringDates = $v.recurringDates?.toBuilder();
      _loadedAt = $v.loadedAt;
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _entityType = $v.entityType;
      _idempotencyKey = $v.idempotencyKey;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseEntity;
  }

  @override
  void update(void Function(ExpenseEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseEntity build() {
    _$ExpenseEntity _$result;
    try {
      _$result = _$v ??
          new _$ExpenseEntity._(
              privateNotes: BuiltValueNullFieldError.checkNotNull(
                  privateNotes, 'ExpenseEntity', 'privateNotes'),
              publicNotes: BuiltValueNullFieldError.checkNotNull(
                  publicNotes, 'ExpenseEntity', 'publicNotes'),
              shouldBeInvoiced: BuiltValueNullFieldError.checkNotNull(
                  shouldBeInvoiced, 'ExpenseEntity', 'shouldBeInvoiced'),
              invoiceDocuments: BuiltValueNullFieldError.checkNotNull(
                  invoiceDocuments, 'ExpenseEntity', 'invoiceDocuments'),
              transactionId: BuiltValueNullFieldError.checkNotNull(
                  transactionId, 'ExpenseEntity', 'transactionId'),
              transactionReference: BuiltValueNullFieldError.checkNotNull(
                  transactionReference, 'ExpenseEntity', 'transactionReference'),
              bankId: BuiltValueNullFieldError.checkNotNull(
                  bankId, 'ExpenseEntity', 'bankId'),
              currencyId: BuiltValueNullFieldError.checkNotNull(currencyId, 'ExpenseEntity', 'currencyId'),
              categoryId: BuiltValueNullFieldError.checkNotNull(categoryId, 'ExpenseEntity', 'categoryId'),
              amount: BuiltValueNullFieldError.checkNotNull(amount, 'ExpenseEntity', 'amount'),
              date: date,
              paymentDate: BuiltValueNullFieldError.checkNotNull(paymentDate, 'ExpenseEntity', 'paymentDate'),
              exchangeRate: BuiltValueNullFieldError.checkNotNull(exchangeRate, 'ExpenseEntity', 'exchangeRate'),
              invoiceCurrencyId: BuiltValueNullFieldError.checkNotNull(invoiceCurrencyId, 'ExpenseEntity', 'invoiceCurrencyId'),
              paymentTypeId: BuiltValueNullFieldError.checkNotNull(paymentTypeId, 'ExpenseEntity', 'paymentTypeId'),
              taxName1: BuiltValueNullFieldError.checkNotNull(taxName1, 'ExpenseEntity', 'taxName1'),
              taxName2: BuiltValueNullFieldError.checkNotNull(taxName2, 'ExpenseEntity', 'taxName2'),
              taxRate1: BuiltValueNullFieldError.checkNotNull(taxRate1, 'ExpenseEntity', 'taxRate1'),
              taxRate2: BuiltValueNullFieldError.checkNotNull(taxRate2, 'ExpenseEntity', 'taxRate2'),
              taxName3: BuiltValueNullFieldError.checkNotNull(taxName3, 'ExpenseEntity', 'taxName3'),
              taxRate3: BuiltValueNullFieldError.checkNotNull(taxRate3, 'ExpenseEntity', 'taxRate3'),
              clientId: clientId,
              invoiceId: invoiceId,
              vendorId: vendorId,
              projectId: projectId,
              statusId: statusId,
              customValue1: BuiltValueNullFieldError.checkNotNull(customValue1, 'ExpenseEntity', 'customValue1'),
              customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, 'ExpenseEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, 'ExpenseEntity', 'customValue3'),
              customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, 'ExpenseEntity', 'customValue4'),
              taxAmount1: BuiltValueNullFieldError.checkNotNull(taxAmount1, 'ExpenseEntity', 'taxAmount1'),
              taxAmount2: BuiltValueNullFieldError.checkNotNull(taxAmount2, 'ExpenseEntity', 'taxAmount2'),
              taxAmount3: BuiltValueNullFieldError.checkNotNull(taxAmount3, 'ExpenseEntity', 'taxAmount3'),
              usesInclusiveTaxes: BuiltValueNullFieldError.checkNotNull(usesInclusiveTaxes, 'ExpenseEntity', 'usesInclusiveTaxes'),
              calculateTaxByAmount: calculateTaxByAmount,
              documents: documents.build(),
              number: BuiltValueNullFieldError.checkNotNull(number, 'ExpenseEntity', 'number'),
              recurringId: recurringId,
              frequencyId: BuiltValueNullFieldError.checkNotNull(frequencyId, 'ExpenseEntity', 'frequencyId'),
              lastSentDate: BuiltValueNullFieldError.checkNotNull(lastSentDate, 'ExpenseEntity', 'lastSentDate'),
              nextSendDate: BuiltValueNullFieldError.checkNotNull(nextSendDate, 'ExpenseEntity', 'nextSendDate'),
              remainingCycles: BuiltValueNullFieldError.checkNotNull(remainingCycles, 'ExpenseEntity', 'remainingCycles'),
              recurringDates: _recurringDates?.build(),
              loadedAt: loadedAt,
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, 'ExpenseEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, 'ExpenseEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, 'ExpenseEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              entityType: entityType,
              idempotencyKey: idempotencyKey,
              id: BuiltValueNullFieldError.checkNotNull(id, 'ExpenseEntity', 'id'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'documents';
        documents.build();

        _$failedField = 'recurringDates';
        _recurringDates?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ExpenseEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ExpenseScheduleEntity extends ExpenseScheduleEntity {
  @override
  final String sendDate;

  factory _$ExpenseScheduleEntity(
          [void Function(ExpenseScheduleEntityBuilder) updates]) =>
      (new ExpenseScheduleEntityBuilder()..update(updates)).build();

  _$ExpenseScheduleEntity._({this.sendDate}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        sendDate, 'ExpenseScheduleEntity', 'sendDate');
  }

  @override
  ExpenseScheduleEntity rebuild(
          void Function(ExpenseScheduleEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseScheduleEntityBuilder toBuilder() =>
      new ExpenseScheduleEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseScheduleEntity && sendDate == other.sendDate;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, sendDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseScheduleEntity')
          ..add('sendDate', sendDate))
        .toString();
  }
}

class ExpenseScheduleEntityBuilder
    implements Builder<ExpenseScheduleEntity, ExpenseScheduleEntityBuilder> {
  _$ExpenseScheduleEntity _$v;

  String _sendDate;
  String get sendDate => _$this._sendDate;
  set sendDate(String sendDate) => _$this._sendDate = sendDate;

  ExpenseScheduleEntityBuilder();

  ExpenseScheduleEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sendDate = $v.sendDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseScheduleEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseScheduleEntity;
  }

  @override
  void update(void Function(ExpenseScheduleEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseScheduleEntity build() {
    final _$result = _$v ??
        new _$ExpenseScheduleEntity._(
            sendDate: BuiltValueNullFieldError.checkNotNull(
                sendDate, 'ExpenseScheduleEntity', 'sendDate'));
    replace(_$result);
    return _$result;
  }
}

class _$ExpenseStatusEntity extends ExpenseStatusEntity {
  @override
  final String id;
  @override
  final String name;

  factory _$ExpenseStatusEntity(
          [void Function(ExpenseStatusEntityBuilder) updates]) =>
      (new ExpenseStatusEntityBuilder()..update(updates)).build();

  _$ExpenseStatusEntity._({this.id, this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'ExpenseStatusEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(name, 'ExpenseStatusEntity', 'name');
  }

  @override
  ExpenseStatusEntity rebuild(
          void Function(ExpenseStatusEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseStatusEntityBuilder toBuilder() =>
      new ExpenseStatusEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseStatusEntity && id == other.id && name == other.name;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseStatusEntity')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class ExpenseStatusEntityBuilder
    implements Builder<ExpenseStatusEntity, ExpenseStatusEntityBuilder> {
  _$ExpenseStatusEntity _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  ExpenseStatusEntityBuilder();

  ExpenseStatusEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseStatusEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExpenseStatusEntity;
  }

  @override
  void update(void Function(ExpenseStatusEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseStatusEntity build() {
    final _$result = _$v ??
        new _$ExpenseStatusEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'ExpenseStatusEntity', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'ExpenseStatusEntity', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
