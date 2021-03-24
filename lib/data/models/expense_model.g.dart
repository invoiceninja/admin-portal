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
      final dynamic value = iterator.current;
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
      final dynamic value = iterator.current;
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
    if (object.date != null) {
      result
        ..add('date')
        ..add(serializers.serialize(object.date,
            specifiedType: const FullType(String)));
    }
    if (object.clientId != null) {
      result
        ..add('client_id')
        ..add(serializers.serialize(object.clientId,
            specifiedType: const FullType(String)));
    }
    if (object.invoiceId != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(object.invoiceId,
            specifiedType: const FullType(String)));
    }
    if (object.vendorId != null) {
      result
        ..add('vendor_id')
        ..add(serializers.serialize(object.vendorId,
            specifiedType: const FullType(String)));
    }
    if (object.projectId != null) {
      result
        ..add('project_id')
        ..add(serializers.serialize(object.projectId,
            specifiedType: const FullType(String)));
    }
    if (object.calculateTaxByAmount != null) {
      result
        ..add('calculate_tax_by_amount')
        ..add(serializers.serialize(object.calculateTaxByAmount,
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
  ExpenseEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExpenseEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
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
      final dynamic value = iterator.current;
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
    if (data == null) {
      throw new BuiltValueNullFieldError('ExpenseListResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
    if (data == null) {
      throw new BuiltValueNullFieldError('ExpenseItemResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'privateNotes');
    }
    if (publicNotes == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'publicNotes');
    }
    if (shouldBeInvoiced == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'shouldBeInvoiced');
    }
    if (invoiceDocuments == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'invoiceDocuments');
    }
    if (transactionId == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'transactionId');
    }
    if (transactionReference == null) {
      throw new BuiltValueNullFieldError(
          'ExpenseEntity', 'transactionReference');
    }
    if (bankId == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'bankId');
    }
    if (currencyId == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'currencyId');
    }
    if (categoryId == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'categoryId');
    }
    if (amount == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'amount');
    }
    if (paymentDate == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'paymentDate');
    }
    if (exchangeRate == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'exchangeRate');
    }
    if (invoiceCurrencyId == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'invoiceCurrencyId');
    }
    if (paymentTypeId == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'paymentTypeId');
    }
    if (taxName1 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'taxName1');
    }
    if (taxName2 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'taxName2');
    }
    if (taxRate1 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'taxRate1');
    }
    if (taxRate2 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'taxRate2');
    }
    if (taxName3 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'taxName3');
    }
    if (taxRate3 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'taxRate3');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'customValue4');
    }
    if (taxAmount1 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'taxAmount1');
    }
    if (taxAmount2 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'taxAmount2');
    }
    if (taxAmount3 == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'taxAmount3');
    }
    if (usesInclusiveTaxes == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'usesInclusiveTaxes');
    }
    if (documents == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'documents');
    }
    if (number == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'number');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('ExpenseEntity', 'id');
    }
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, privateNotes.hashCode), publicNotes.hashCode), shouldBeInvoiced.hashCode), invoiceDocuments.hashCode), transactionId.hashCode), transactionReference.hashCode), bankId.hashCode), currencyId.hashCode), categoryId.hashCode), amount.hashCode), date.hashCode), paymentDate.hashCode), exchangeRate.hashCode), invoiceCurrencyId.hashCode), paymentTypeId.hashCode), taxName1.hashCode), taxName2.hashCode), taxRate1.hashCode), taxRate2.hashCode), taxName3.hashCode), taxRate3.hashCode), clientId.hashCode), invoiceId.hashCode), vendorId.hashCode), projectId.hashCode),
                                                                                customValue1.hashCode),
                                                                            customValue2.hashCode),
                                                                        customValue3.hashCode),
                                                                    customValue4.hashCode),
                                                                taxAmount1.hashCode),
                                                            taxAmount2.hashCode),
                                                        taxAmount3.hashCode),
                                                    usesInclusiveTaxes.hashCode),
                                                calculateTaxByAmount.hashCode),
                                            documents.hashCode),
                                        number.hashCode),
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

  ExpenseEntityBuilder();

  ExpenseEntityBuilder get _$this {
    if (_$v != null) {
      _privateNotes = _$v.privateNotes;
      _publicNotes = _$v.publicNotes;
      _shouldBeInvoiced = _$v.shouldBeInvoiced;
      _invoiceDocuments = _$v.invoiceDocuments;
      _transactionId = _$v.transactionId;
      _transactionReference = _$v.transactionReference;
      _bankId = _$v.bankId;
      _currencyId = _$v.currencyId;
      _categoryId = _$v.categoryId;
      _amount = _$v.amount;
      _date = _$v.date;
      _paymentDate = _$v.paymentDate;
      _exchangeRate = _$v.exchangeRate;
      _invoiceCurrencyId = _$v.invoiceCurrencyId;
      _paymentTypeId = _$v.paymentTypeId;
      _taxName1 = _$v.taxName1;
      _taxName2 = _$v.taxName2;
      _taxRate1 = _$v.taxRate1;
      _taxRate2 = _$v.taxRate2;
      _taxName3 = _$v.taxName3;
      _taxRate3 = _$v.taxRate3;
      _clientId = _$v.clientId;
      _invoiceId = _$v.invoiceId;
      _vendorId = _$v.vendorId;
      _projectId = _$v.projectId;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _taxAmount1 = _$v.taxAmount1;
      _taxAmount2 = _$v.taxAmount2;
      _taxAmount3 = _$v.taxAmount3;
      _usesInclusiveTaxes = _$v.usesInclusiveTaxes;
      _calculateTaxByAmount = _$v.calculateTaxByAmount;
      _documents = _$v.documents?.toBuilder();
      _number = _$v.number;
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
  void replace(ExpenseEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              privateNotes: privateNotes,
              publicNotes: publicNotes,
              shouldBeInvoiced: shouldBeInvoiced,
              invoiceDocuments: invoiceDocuments,
              transactionId: transactionId,
              transactionReference: transactionReference,
              bankId: bankId,
              currencyId: currencyId,
              categoryId: categoryId,
              amount: amount,
              date: date,
              paymentDate: paymentDate,
              exchangeRate: exchangeRate,
              invoiceCurrencyId: invoiceCurrencyId,
              paymentTypeId: paymentTypeId,
              taxName1: taxName1,
              taxName2: taxName2,
              taxRate1: taxRate1,
              taxRate2: taxRate2,
              taxName3: taxName3,
              taxRate3: taxRate3,
              clientId: clientId,
              invoiceId: invoiceId,
              vendorId: vendorId,
              projectId: projectId,
              customValue1: customValue1,
              customValue2: customValue2,
              customValue3: customValue3,
              customValue4: customValue4,
              taxAmount1: taxAmount1,
              taxAmount2: taxAmount2,
              taxAmount3: taxAmount3,
              usesInclusiveTaxes: usesInclusiveTaxes,
              calculateTaxByAmount: calculateTaxByAmount,
              documents: documents.build(),
              number: number,
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
        _$failedField = 'documents';
        documents.build();
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

class _$ExpenseStatusEntity extends ExpenseStatusEntity {
  @override
  final String id;
  @override
  final String name;

  factory _$ExpenseStatusEntity(
          [void Function(ExpenseStatusEntityBuilder) updates]) =>
      (new ExpenseStatusEntityBuilder()..update(updates)).build();

  _$ExpenseStatusEntity._({this.id, this.name}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('ExpenseStatusEntity', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('ExpenseStatusEntity', 'name');
    }
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
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseStatusEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExpenseStatusEntity;
  }

  @override
  void update(void Function(ExpenseStatusEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseStatusEntity build() {
    final _$result = _$v ?? new _$ExpenseStatusEntity._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
