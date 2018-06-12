// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

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

Serializer<ExpenseListResponse> _$expenseListResponseSerializer =
    new _$ExpenseListResponseSerializer();
Serializer<ExpenseItemResponse> _$expenseItemResponseSerializer =
    new _$ExpenseItemResponseSerializer();
Serializer<ExpenseEntity> _$expenseEntitySerializer =
    new _$ExpenseEntitySerializer();
Serializer<ExpenseCategoryEntity> _$expenseCategoryEntitySerializer =
    new _$ExpenseCategoryEntitySerializer();

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
  Iterable serialize(Serializers serializers, ExpenseListResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ExpenseEntity)])),
    ];

    return result;
  }

  @override
  ExpenseListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
              as BuiltList);
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
  Iterable serialize(Serializers serializers, ExpenseItemResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ExpenseEntity)),
    ];

    return result;
  }

  @override
  ExpenseItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
  Iterable serialize(Serializers serializers, ExpenseEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.privateNotes != null) {
      result
        ..add('private_notes')
        ..add(serializers.serialize(object.privateNotes,
            specifiedType: const FullType(String)));
    }
    if (object.publicNotes != null) {
      result
        ..add('public_notes')
        ..add(serializers.serialize(object.publicNotes,
            specifiedType: const FullType(String)));
    }
    if (object.shouldBeInvoiced != null) {
      result
        ..add('should_be_invoiced')
        ..add(serializers.serialize(object.shouldBeInvoiced,
            specifiedType: const FullType(bool)));
    }
    if (object.transactionId != null) {
      result
        ..add('transaction_id')
        ..add(serializers.serialize(object.transactionId,
            specifiedType: const FullType(String)));
    }
    if (object.transactionReference != null) {
      result
        ..add('transaction_reference')
        ..add(serializers.serialize(object.transactionReference,
            specifiedType: const FullType(String)));
    }
    if (object.bankId != null) {
      result
        ..add('bank_id')
        ..add(serializers.serialize(object.bankId,
            specifiedType: const FullType(String)));
    }
    if (object.expenseCurrencyId != null) {
      result
        ..add('expense_currency_id')
        ..add(serializers.serialize(object.expenseCurrencyId,
            specifiedType: const FullType(int)));
    }
    if (object.exchangeCurrencyId != null) {
      result
        ..add('expense_category_id')
        ..add(serializers.serialize(object.exchangeCurrencyId,
            specifiedType: const FullType(int)));
    }
    if (object.amount != null) {
      result
        ..add('amount')
        ..add(serializers.serialize(object.amount,
            specifiedType: const FullType(double)));
    }
    if (object.expenseDate != null) {
      result
        ..add('expense_date')
        ..add(serializers.serialize(object.expenseDate,
            specifiedType: const FullType(String)));
    }
    if (object.exchangeRate != null) {
      result
        ..add('exchange_rate')
        ..add(serializers.serialize(object.exchangeRate,
            specifiedType: const FullType(double)));
    }
    if (object.invoiceCurrencyId != null) {
      result
        ..add('invoiceCurrencyId')
        ..add(serializers.serialize(object.invoiceCurrencyId,
            specifiedType: const FullType(int)));
    }
    if (object.taxName1 != null) {
      result
        ..add('tax_name1')
        ..add(serializers.serialize(object.taxName1,
            specifiedType: const FullType(String)));
    }
    if (object.taxRate1 != null) {
      result
        ..add('tax_rate1')
        ..add(serializers.serialize(object.taxRate1,
            specifiedType: const FullType(String)));
    }
    if (object.taxRate2 != null) {
      result
        ..add('tax_rate2')
        ..add(serializers.serialize(object.taxRate2,
            specifiedType: const FullType(String)));
    }
    if (object.clientId != null) {
      result
        ..add('client_id')
        ..add(serializers.serialize(object.clientId,
            specifiedType: const FullType(int)));
    }
    if (object.invoiceId != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(object.invoiceId,
            specifiedType: const FullType(int)));
    }
    if (object.vendorId != null) {
      result
        ..add('vendor_id')
        ..add(serializers.serialize(object.vendorId,
            specifiedType: const FullType(int)));
    }
    if (object.customValue1 != null) {
      result
        ..add('custom_value1')
        ..add(serializers.serialize(object.customValue1,
            specifiedType: const FullType(String)));
    }
    if (object.customValue2 != null) {
      result
        ..add('custom_value2')
        ..add(serializers.serialize(object.customValue2,
            specifiedType: const FullType(String)));
    }
    if (object.expenseCtegories != null) {
      result
        ..add('expense_category')
        ..add(serializers.serialize(object.expenseCtegories,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ExpenseCategoryEntity)])));
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
  ExpenseEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
        case 'expense_currency_id':
          result.expenseCurrencyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'expense_category_id':
          result.exchangeCurrencyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'expense_date':
          result.expenseDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'exchange_rate':
          result.exchangeRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'invoiceCurrencyId':
          result.invoiceCurrencyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tax_name1':
          result.taxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate1':
          result.taxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate2':
          result.taxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'vendor_id':
          result.vendorId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expense_category':
          result.expenseCtegories.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ExpenseCategoryEntity)]))
              as BuiltList);
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

class _$ExpenseCategoryEntitySerializer
    implements StructuredSerializer<ExpenseCategoryEntity> {
  @override
  final Iterable<Type> types = const [
    ExpenseCategoryEntity,
    _$ExpenseCategoryEntity
  ];
  @override
  final String wireName = 'ExpenseCategoryEntity';

  @override
  Iterable serialize(Serializers serializers, ExpenseCategoryEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
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
  ExpenseCategoryEntity deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ExpenseCategoryEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$ExpenseListResponse extends ExpenseListResponse {
  @override
  final BuiltList<ExpenseEntity> data;

  factory _$ExpenseListResponse([void updates(ExpenseListResponseBuilder b)]) =>
      (new ExpenseListResponseBuilder()..update(updates)).build();

  _$ExpenseListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('ExpenseListResponse', 'data');
  }

  @override
  ExpenseListResponse rebuild(void updates(ExpenseListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseListResponseBuilder toBuilder() =>
      new ExpenseListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ExpenseListResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ExpenseListResponse;
  }

  @override
  void update(void updates(ExpenseListResponseBuilder b)) {
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

  factory _$ExpenseItemResponse([void updates(ExpenseItemResponseBuilder b)]) =>
      (new ExpenseItemResponseBuilder()..update(updates)).build();

  _$ExpenseItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('ExpenseItemResponse', 'data');
  }

  @override
  ExpenseItemResponse rebuild(void updates(ExpenseItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseItemResponseBuilder toBuilder() =>
      new ExpenseItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ExpenseItemResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ExpenseItemResponse;
  }

  @override
  void update(void updates(ExpenseItemResponseBuilder b)) {
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
  final String transactionId;
  @override
  final String transactionReference;
  @override
  final String bankId;
  @override
  final int expenseCurrencyId;
  @override
  final int exchangeCurrencyId;
  @override
  final double amount;
  @override
  final String expenseDate;
  @override
  final double exchangeRate;
  @override
  final int invoiceCurrencyId;
  @override
  final String taxName1;
  @override
  final String taxRate1;
  @override
  final String taxRate2;
  @override
  final int clientId;
  @override
  final int invoiceId;
  @override
  final int vendorId;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final BuiltList<ExpenseCategoryEntity> expenseCtegories;
  @override
  final int id;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;

  factory _$ExpenseEntity([void updates(ExpenseEntityBuilder b)]) =>
      (new ExpenseEntityBuilder()..update(updates)).build();

  _$ExpenseEntity._(
      {this.privateNotes,
      this.publicNotes,
      this.shouldBeInvoiced,
      this.transactionId,
      this.transactionReference,
      this.bankId,
      this.expenseCurrencyId,
      this.exchangeCurrencyId,
      this.amount,
      this.expenseDate,
      this.exchangeRate,
      this.invoiceCurrencyId,
      this.taxName1,
      this.taxRate1,
      this.taxRate2,
      this.clientId,
      this.invoiceId,
      this.vendorId,
      this.customValue1,
      this.customValue2,
      this.expenseCtegories,
      this.id,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted})
      : super._();

  @override
  ExpenseEntity rebuild(void updates(ExpenseEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseEntityBuilder toBuilder() => new ExpenseEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ExpenseEntity) return false;
    return privateNotes == other.privateNotes &&
        publicNotes == other.publicNotes &&
        shouldBeInvoiced == other.shouldBeInvoiced &&
        transactionId == other.transactionId &&
        transactionReference == other.transactionReference &&
        bankId == other.bankId &&
        expenseCurrencyId == other.expenseCurrencyId &&
        exchangeCurrencyId == other.exchangeCurrencyId &&
        amount == other.amount &&
        expenseDate == other.expenseDate &&
        exchangeRate == other.exchangeRate &&
        invoiceCurrencyId == other.invoiceCurrencyId &&
        taxName1 == other.taxName1 &&
        taxRate1 == other.taxRate1 &&
        taxRate2 == other.taxRate2 &&
        clientId == other.clientId &&
        invoiceId == other.invoiceId &&
        vendorId == other.vendorId &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        expenseCtegories == other.expenseCtegories &&
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
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc(0, privateNotes.hashCode), publicNotes.hashCode), shouldBeInvoiced.hashCode), transactionId.hashCode), transactionReference.hashCode), bankId.hashCode),
                                                                                expenseCurrencyId.hashCode),
                                                                            exchangeCurrencyId.hashCode),
                                                                        amount.hashCode),
                                                                    expenseDate.hashCode),
                                                                exchangeRate.hashCode),
                                                            invoiceCurrencyId.hashCode),
                                                        taxName1.hashCode),
                                                    taxRate1.hashCode),
                                                taxRate2.hashCode),
                                            clientId.hashCode),
                                        invoiceId.hashCode),
                                    vendorId.hashCode),
                                customValue1.hashCode),
                            customValue2.hashCode),
                        expenseCtegories.hashCode),
                    id.hashCode),
                updatedAt.hashCode),
            archivedAt.hashCode),
        isDeleted.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseEntity')
          ..add('privateNotes', privateNotes)
          ..add('publicNotes', publicNotes)
          ..add('shouldBeInvoiced', shouldBeInvoiced)
          ..add('transactionId', transactionId)
          ..add('transactionReference', transactionReference)
          ..add('bankId', bankId)
          ..add('expenseCurrencyId', expenseCurrencyId)
          ..add('exchangeCurrencyId', exchangeCurrencyId)
          ..add('amount', amount)
          ..add('expenseDate', expenseDate)
          ..add('exchangeRate', exchangeRate)
          ..add('invoiceCurrencyId', invoiceCurrencyId)
          ..add('taxName1', taxName1)
          ..add('taxRate1', taxRate1)
          ..add('taxRate2', taxRate2)
          ..add('clientId', clientId)
          ..add('invoiceId', invoiceId)
          ..add('vendorId', vendorId)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('expenseCtegories', expenseCtegories)
          ..add('id', id)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted))
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

  int _expenseCurrencyId;
  int get expenseCurrencyId => _$this._expenseCurrencyId;
  set expenseCurrencyId(int expenseCurrencyId) =>
      _$this._expenseCurrencyId = expenseCurrencyId;

  int _exchangeCurrencyId;
  int get exchangeCurrencyId => _$this._exchangeCurrencyId;
  set exchangeCurrencyId(int exchangeCurrencyId) =>
      _$this._exchangeCurrencyId = exchangeCurrencyId;

  double _amount;
  double get amount => _$this._amount;
  set amount(double amount) => _$this._amount = amount;

  String _expenseDate;
  String get expenseDate => _$this._expenseDate;
  set expenseDate(String expenseDate) => _$this._expenseDate = expenseDate;

  double _exchangeRate;
  double get exchangeRate => _$this._exchangeRate;
  set exchangeRate(double exchangeRate) => _$this._exchangeRate = exchangeRate;

  int _invoiceCurrencyId;
  int get invoiceCurrencyId => _$this._invoiceCurrencyId;
  set invoiceCurrencyId(int invoiceCurrencyId) =>
      _$this._invoiceCurrencyId = invoiceCurrencyId;

  String _taxName1;
  String get taxName1 => _$this._taxName1;
  set taxName1(String taxName1) => _$this._taxName1 = taxName1;

  String _taxRate1;
  String get taxRate1 => _$this._taxRate1;
  set taxRate1(String taxRate1) => _$this._taxRate1 = taxRate1;

  String _taxRate2;
  String get taxRate2 => _$this._taxRate2;
  set taxRate2(String taxRate2) => _$this._taxRate2 = taxRate2;

  int _clientId;
  int get clientId => _$this._clientId;
  set clientId(int clientId) => _$this._clientId = clientId;

  int _invoiceId;
  int get invoiceId => _$this._invoiceId;
  set invoiceId(int invoiceId) => _$this._invoiceId = invoiceId;

  int _vendorId;
  int get vendorId => _$this._vendorId;
  set vendorId(int vendorId) => _$this._vendorId = vendorId;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  ListBuilder<ExpenseCategoryEntity> _expenseCtegories;
  ListBuilder<ExpenseCategoryEntity> get expenseCtegories =>
      _$this._expenseCtegories ??= new ListBuilder<ExpenseCategoryEntity>();
  set expenseCtegories(ListBuilder<ExpenseCategoryEntity> expenseCtegories) =>
      _$this._expenseCtegories = expenseCtegories;

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

  ExpenseEntityBuilder();

  ExpenseEntityBuilder get _$this {
    if (_$v != null) {
      _privateNotes = _$v.privateNotes;
      _publicNotes = _$v.publicNotes;
      _shouldBeInvoiced = _$v.shouldBeInvoiced;
      _transactionId = _$v.transactionId;
      _transactionReference = _$v.transactionReference;
      _bankId = _$v.bankId;
      _expenseCurrencyId = _$v.expenseCurrencyId;
      _exchangeCurrencyId = _$v.exchangeCurrencyId;
      _amount = _$v.amount;
      _expenseDate = _$v.expenseDate;
      _exchangeRate = _$v.exchangeRate;
      _invoiceCurrencyId = _$v.invoiceCurrencyId;
      _taxName1 = _$v.taxName1;
      _taxRate1 = _$v.taxRate1;
      _taxRate2 = _$v.taxRate2;
      _clientId = _$v.clientId;
      _invoiceId = _$v.invoiceId;
      _vendorId = _$v.vendorId;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _expenseCtegories = _$v.expenseCtegories?.toBuilder();
      _id = _$v.id;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ExpenseEntity;
  }

  @override
  void update(void updates(ExpenseEntityBuilder b)) {
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
              transactionId: transactionId,
              transactionReference: transactionReference,
              bankId: bankId,
              expenseCurrencyId: expenseCurrencyId,
              exchangeCurrencyId: exchangeCurrencyId,
              amount: amount,
              expenseDate: expenseDate,
              exchangeRate: exchangeRate,
              invoiceCurrencyId: invoiceCurrencyId,
              taxName1: taxName1,
              taxRate1: taxRate1,
              taxRate2: taxRate2,
              clientId: clientId,
              invoiceId: invoiceId,
              vendorId: vendorId,
              customValue1: customValue1,
              customValue2: customValue2,
              expenseCtegories: _expenseCtegories?.build(),
              id: id,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'expenseCtegories';
        _expenseCtegories?.build();
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

class _$ExpenseCategoryEntity extends ExpenseCategoryEntity {
  @override
  final String name;
  @override
  final int id;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;

  factory _$ExpenseCategoryEntity(
          [void updates(ExpenseCategoryEntityBuilder b)]) =>
      (new ExpenseCategoryEntityBuilder()..update(updates)).build();

  _$ExpenseCategoryEntity._(
      {this.name, this.id, this.updatedAt, this.archivedAt, this.isDeleted})
      : super._();

  @override
  ExpenseCategoryEntity rebuild(void updates(ExpenseCategoryEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseCategoryEntityBuilder toBuilder() =>
      new ExpenseCategoryEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ExpenseCategoryEntity) return false;
    return name == other.name &&
        id == other.id &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, name.hashCode), id.hashCode), updatedAt.hashCode),
            archivedAt.hashCode),
        isDeleted.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExpenseCategoryEntity')
          ..add('name', name)
          ..add('id', id)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted))
        .toString();
  }
}

class ExpenseCategoryEntityBuilder
    implements Builder<ExpenseCategoryEntity, ExpenseCategoryEntityBuilder> {
  _$ExpenseCategoryEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

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

  ExpenseCategoryEntityBuilder();

  ExpenseCategoryEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _id = _$v.id;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseCategoryEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ExpenseCategoryEntity;
  }

  @override
  void update(void updates(ExpenseCategoryEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ExpenseCategoryEntity build() {
    final _$result = _$v ??
        new _$ExpenseCategoryEntity._(
            name: name,
            id: id,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted);
    replace(_$result);
    return _$result;
  }
}
