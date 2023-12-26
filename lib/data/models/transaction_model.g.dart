// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TransactionListResponse> _$transactionListResponseSerializer =
    new _$TransactionListResponseSerializer();
Serializer<TransactionItemResponse> _$transactionItemResponseSerializer =
    new _$TransactionItemResponseSerializer();
Serializer<TransactionEntity> _$transactionEntitySerializer =
    new _$TransactionEntitySerializer();
Serializer<TransactionStatusEntity> _$transactionStatusEntitySerializer =
    new _$TransactionStatusEntitySerializer();

class _$TransactionListResponseSerializer
    implements StructuredSerializer<TransactionListResponse> {
  @override
  final Iterable<Type> types = const [
    TransactionListResponse,
    _$TransactionListResponse
  ];
  @override
  final String wireName = 'TransactionListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TransactionListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TransactionEntity)])),
    ];

    return result;
  }

  @override
  TransactionListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TransactionEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$TransactionItemResponseSerializer
    implements StructuredSerializer<TransactionItemResponse> {
  @override
  final Iterable<Type> types = const [
    TransactionItemResponse,
    _$TransactionItemResponse
  ];
  @override
  final String wireName = 'TransactionItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TransactionItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TransactionEntity)),
    ];

    return result;
  }

  @override
  TransactionItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TransactionEntity))!
              as TransactionEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$TransactionEntitySerializer
    implements StructuredSerializer<TransactionEntity> {
  @override
  final Iterable<Type> types = const [TransactionEntity, _$TransactionEntity];
  @override
  final String wireName = 'TransactionEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, TransactionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'currency_id',
      serializers.serialize(object.currencyId,
          specifiedType: const FullType(String)),
      'category_type',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
      'base_type',
      serializers.serialize(object.baseType,
          specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'bank_integration_id',
      serializers.serialize(object.bankAccountId,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'status_id',
      serializers.serialize(object.statusId,
          specifiedType: const FullType(String)),
      'ninja_category_id',
      serializers.serialize(object.categoryId,
          specifiedType: const FullType(String)),
      'invoice_ids',
      serializers.serialize(object.invoiceIds,
          specifiedType: const FullType(String)),
      'payment_id',
      serializers.serialize(object.paymentId,
          specifiedType: const FullType(String)),
      'expense_id',
      serializers.serialize(object.expenseId,
          specifiedType: const FullType(String)),
      'vendor_id',
      serializers.serialize(object.vendorId,
          specifiedType: const FullType(String)),
      'transaction_id',
      serializers.serialize(object.transactionId,
          specifiedType: const FullType(int)),
      'bank_transaction_rule_id',
      serializers.serialize(object.transactionRuleId,
          specifiedType: const FullType(String)),
      'participant_name',
      serializers.serialize(object.participantName,
          specifiedType: const FullType(String)),
      'participant',
      serializers.serialize(object.participant,
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
    Object? value;
    value = object.pendingVendorId;
    if (value != null) {
      result
        ..add('pendingVendorId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  TransactionEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'category_type':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'base_type':
          result.baseType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'bank_integration_id':
          result.bankAccountId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status_id':
          result.statusId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'ninja_category_id':
          result.categoryId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'invoice_ids':
          result.invoiceIds = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'payment_id':
          result.paymentId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'expense_id':
          result.expenseId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'vendor_id':
          result.vendorId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'transaction_id':
          result.transactionId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'bank_transaction_rule_id':
          result.transactionRuleId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'participant_name':
          result.participantName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'participant':
          result.participant = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'pendingVendorId':
          result.pendingVendorId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TransactionStatusEntitySerializer
    implements StructuredSerializer<TransactionStatusEntity> {
  @override
  final Iterable<Type> types = const [
    TransactionStatusEntity,
    _$TransactionStatusEntity
  ];
  @override
  final String wireName = 'TransactionStatusEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TransactionStatusEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TransactionStatusEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionStatusEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TransactionListResponse extends TransactionListResponse {
  @override
  final BuiltList<TransactionEntity> data;

  factory _$TransactionListResponse(
          [void Function(TransactionListResponseBuilder)? updates]) =>
      (new TransactionListResponseBuilder()..update(updates))._build();

  _$TransactionListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'TransactionListResponse', 'data');
  }

  @override
  TransactionListResponse rebuild(
          void Function(TransactionListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionListResponseBuilder toBuilder() =>
      new TransactionListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionListResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionListResponse')
          ..add('data', data))
        .toString();
  }
}

class TransactionListResponseBuilder
    implements
        Builder<TransactionListResponse, TransactionListResponseBuilder> {
  _$TransactionListResponse? _$v;

  ListBuilder<TransactionEntity>? _data;
  ListBuilder<TransactionEntity> get data =>
      _$this._data ??= new ListBuilder<TransactionEntity>();
  set data(ListBuilder<TransactionEntity>? data) => _$this._data = data;

  TransactionListResponseBuilder();

  TransactionListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TransactionListResponse;
  }

  @override
  void update(void Function(TransactionListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionListResponse build() => _build();

  _$TransactionListResponse _build() {
    _$TransactionListResponse _$result;
    try {
      _$result = _$v ?? new _$TransactionListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TransactionListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TransactionItemResponse extends TransactionItemResponse {
  @override
  final TransactionEntity data;

  factory _$TransactionItemResponse(
          [void Function(TransactionItemResponseBuilder)? updates]) =>
      (new TransactionItemResponseBuilder()..update(updates))._build();

  _$TransactionItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'TransactionItemResponse', 'data');
  }

  @override
  TransactionItemResponse rebuild(
          void Function(TransactionItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionItemResponseBuilder toBuilder() =>
      new TransactionItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionItemResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionItemResponse')
          ..add('data', data))
        .toString();
  }
}

class TransactionItemResponseBuilder
    implements
        Builder<TransactionItemResponse, TransactionItemResponseBuilder> {
  _$TransactionItemResponse? _$v;

  TransactionEntityBuilder? _data;
  TransactionEntityBuilder get data =>
      _$this._data ??= new TransactionEntityBuilder();
  set data(TransactionEntityBuilder? data) => _$this._data = data;

  TransactionItemResponseBuilder();

  TransactionItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TransactionItemResponse;
  }

  @override
  void update(void Function(TransactionItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionItemResponse build() => _build();

  _$TransactionItemResponse _build() {
    _$TransactionItemResponse _$result;
    try {
      _$result = _$v ?? new _$TransactionItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TransactionItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TransactionEntity extends TransactionEntity {
  @override
  final double amount;
  @override
  final String currencyId;
  @override
  final String category;
  @override
  final String baseType;
  @override
  final String date;
  @override
  final String bankAccountId;
  @override
  final String description;
  @override
  final String statusId;
  @override
  final String categoryId;
  @override
  final String invoiceIds;
  @override
  final String paymentId;
  @override
  final String expenseId;
  @override
  final String vendorId;
  @override
  final int transactionId;
  @override
  final String transactionRuleId;
  @override
  final String participantName;
  @override
  final String participant;
  @override
  final String? pendingVendorId;
  @override
  final String? pendingCategoryId;
  @override
  final String? pendingExpenseId;
  @override
  final bool? isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool? isDeleted;
  @override
  final String? createdUserId;
  @override
  final String? assignedUserId;
  @override
  final String id;

  factory _$TransactionEntity(
          [void Function(TransactionEntityBuilder)? updates]) =>
      (new TransactionEntityBuilder()..update(updates))._build();

  _$TransactionEntity._(
      {required this.amount,
      required this.currencyId,
      required this.category,
      required this.baseType,
      required this.date,
      required this.bankAccountId,
      required this.description,
      required this.statusId,
      required this.categoryId,
      required this.invoiceIds,
      required this.paymentId,
      required this.expenseId,
      required this.vendorId,
      required this.transactionId,
      required this.transactionRuleId,
      required this.participantName,
      required this.participant,
      this.pendingVendorId,
      this.pendingCategoryId,
      this.pendingExpenseId,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        amount, r'TransactionEntity', 'amount');
    BuiltValueNullFieldError.checkNotNull(
        currencyId, r'TransactionEntity', 'currencyId');
    BuiltValueNullFieldError.checkNotNull(
        category, r'TransactionEntity', 'category');
    BuiltValueNullFieldError.checkNotNull(
        baseType, r'TransactionEntity', 'baseType');
    BuiltValueNullFieldError.checkNotNull(date, r'TransactionEntity', 'date');
    BuiltValueNullFieldError.checkNotNull(
        bankAccountId, r'TransactionEntity', 'bankAccountId');
    BuiltValueNullFieldError.checkNotNull(
        description, r'TransactionEntity', 'description');
    BuiltValueNullFieldError.checkNotNull(
        statusId, r'TransactionEntity', 'statusId');
    BuiltValueNullFieldError.checkNotNull(
        categoryId, r'TransactionEntity', 'categoryId');
    BuiltValueNullFieldError.checkNotNull(
        invoiceIds, r'TransactionEntity', 'invoiceIds');
    BuiltValueNullFieldError.checkNotNull(
        paymentId, r'TransactionEntity', 'paymentId');
    BuiltValueNullFieldError.checkNotNull(
        expenseId, r'TransactionEntity', 'expenseId');
    BuiltValueNullFieldError.checkNotNull(
        vendorId, r'TransactionEntity', 'vendorId');
    BuiltValueNullFieldError.checkNotNull(
        transactionId, r'TransactionEntity', 'transactionId');
    BuiltValueNullFieldError.checkNotNull(
        transactionRuleId, r'TransactionEntity', 'transactionRuleId');
    BuiltValueNullFieldError.checkNotNull(
        participantName, r'TransactionEntity', 'participantName');
    BuiltValueNullFieldError.checkNotNull(
        participant, r'TransactionEntity', 'participant');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'TransactionEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'TransactionEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'TransactionEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'TransactionEntity', 'id');
  }

  @override
  TransactionEntity rebuild(void Function(TransactionEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionEntityBuilder toBuilder() =>
      new TransactionEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionEntity &&
        amount == other.amount &&
        currencyId == other.currencyId &&
        category == other.category &&
        baseType == other.baseType &&
        date == other.date &&
        bankAccountId == other.bankAccountId &&
        description == other.description &&
        statusId == other.statusId &&
        categoryId == other.categoryId &&
        invoiceIds == other.invoiceIds &&
        paymentId == other.paymentId &&
        expenseId == other.expenseId &&
        vendorId == other.vendorId &&
        transactionId == other.transactionId &&
        transactionRuleId == other.transactionRuleId &&
        participantName == other.participantName &&
        participant == other.participant &&
        pendingVendorId == other.pendingVendorId &&
        pendingCategoryId == other.pendingCategoryId &&
        pendingExpenseId == other.pendingExpenseId &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currencyId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, baseType.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, bankAccountId.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, statusId.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, invoiceIds.hashCode);
    _$hash = $jc(_$hash, paymentId.hashCode);
    _$hash = $jc(_$hash, expenseId.hashCode);
    _$hash = $jc(_$hash, vendorId.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, transactionRuleId.hashCode);
    _$hash = $jc(_$hash, participantName.hashCode);
    _$hash = $jc(_$hash, participant.hashCode);
    _$hash = $jc(_$hash, pendingVendorId.hashCode);
    _$hash = $jc(_$hash, pendingCategoryId.hashCode);
    _$hash = $jc(_$hash, pendingExpenseId.hashCode);
    _$hash = $jc(_$hash, isChanged.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdUserId.hashCode);
    _$hash = $jc(_$hash, assignedUserId.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionEntity')
          ..add('amount', amount)
          ..add('currencyId', currencyId)
          ..add('category', category)
          ..add('baseType', baseType)
          ..add('date', date)
          ..add('bankAccountId', bankAccountId)
          ..add('description', description)
          ..add('statusId', statusId)
          ..add('categoryId', categoryId)
          ..add('invoiceIds', invoiceIds)
          ..add('paymentId', paymentId)
          ..add('expenseId', expenseId)
          ..add('vendorId', vendorId)
          ..add('transactionId', transactionId)
          ..add('transactionRuleId', transactionRuleId)
          ..add('participantName', participantName)
          ..add('participant', participant)
          ..add('pendingVendorId', pendingVendorId)
          ..add('pendingCategoryId', pendingCategoryId)
          ..add('pendingExpenseId', pendingExpenseId)
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

class TransactionEntityBuilder
    implements Builder<TransactionEntity, TransactionEntityBuilder> {
  _$TransactionEntity? _$v;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  String? _currencyId;
  String? get currencyId => _$this._currencyId;
  set currencyId(String? currencyId) => _$this._currencyId = currencyId;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _baseType;
  String? get baseType => _$this._baseType;
  set baseType(String? baseType) => _$this._baseType = baseType;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  String? _bankAccountId;
  String? get bankAccountId => _$this._bankAccountId;
  set bankAccountId(String? bankAccountId) =>
      _$this._bankAccountId = bankAccountId;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _statusId;
  String? get statusId => _$this._statusId;
  set statusId(String? statusId) => _$this._statusId = statusId;

  String? _categoryId;
  String? get categoryId => _$this._categoryId;
  set categoryId(String? categoryId) => _$this._categoryId = categoryId;

  String? _invoiceIds;
  String? get invoiceIds => _$this._invoiceIds;
  set invoiceIds(String? invoiceIds) => _$this._invoiceIds = invoiceIds;

  String? _paymentId;
  String? get paymentId => _$this._paymentId;
  set paymentId(String? paymentId) => _$this._paymentId = paymentId;

  String? _expenseId;
  String? get expenseId => _$this._expenseId;
  set expenseId(String? expenseId) => _$this._expenseId = expenseId;

  String? _vendorId;
  String? get vendorId => _$this._vendorId;
  set vendorId(String? vendorId) => _$this._vendorId = vendorId;

  int? _transactionId;
  int? get transactionId => _$this._transactionId;
  set transactionId(int? transactionId) =>
      _$this._transactionId = transactionId;

  String? _transactionRuleId;
  String? get transactionRuleId => _$this._transactionRuleId;
  set transactionRuleId(String? transactionRuleId) =>
      _$this._transactionRuleId = transactionRuleId;

  String? _participantName;
  String? get participantName => _$this._participantName;
  set participantName(String? participantName) =>
      _$this._participantName = participantName;

  String? _participant;
  String? get participant => _$this._participant;
  set participant(String? participant) => _$this._participant = participant;

  String? _pendingVendorId;
  String? get pendingVendorId => _$this._pendingVendorId;
  set pendingVendorId(String? pendingVendorId) =>
      _$this._pendingVendorId = pendingVendorId;

  String? _pendingCategoryId;
  String? get pendingCategoryId => _$this._pendingCategoryId;
  set pendingCategoryId(String? pendingCategoryId) =>
      _$this._pendingCategoryId = pendingCategoryId;

  String? _pendingExpenseId;
  String? get pendingExpenseId => _$this._pendingExpenseId;
  set pendingExpenseId(String? pendingExpenseId) =>
      _$this._pendingExpenseId = pendingExpenseId;

  bool? _isChanged;
  bool? get isChanged => _$this._isChanged;
  set isChanged(bool? isChanged) => _$this._isChanged = isChanged;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  int? _updatedAt;
  int? get updatedAt => _$this._updatedAt;
  set updatedAt(int? updatedAt) => _$this._updatedAt = updatedAt;

  int? _archivedAt;
  int? get archivedAt => _$this._archivedAt;
  set archivedAt(int? archivedAt) => _$this._archivedAt = archivedAt;

  bool? _isDeleted;
  bool? get isDeleted => _$this._isDeleted;
  set isDeleted(bool? isDeleted) => _$this._isDeleted = isDeleted;

  String? _createdUserId;
  String? get createdUserId => _$this._createdUserId;
  set createdUserId(String? createdUserId) =>
      _$this._createdUserId = createdUserId;

  String? _assignedUserId;
  String? get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String? assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  TransactionEntityBuilder() {
    TransactionEntity._initializeBuilder(this);
  }

  TransactionEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _currencyId = $v.currencyId;
      _category = $v.category;
      _baseType = $v.baseType;
      _date = $v.date;
      _bankAccountId = $v.bankAccountId;
      _description = $v.description;
      _statusId = $v.statusId;
      _categoryId = $v.categoryId;
      _invoiceIds = $v.invoiceIds;
      _paymentId = $v.paymentId;
      _expenseId = $v.expenseId;
      _vendorId = $v.vendorId;
      _transactionId = $v.transactionId;
      _transactionRuleId = $v.transactionRuleId;
      _participantName = $v.participantName;
      _participant = $v.participant;
      _pendingVendorId = $v.pendingVendorId;
      _pendingCategoryId = $v.pendingCategoryId;
      _pendingExpenseId = $v.pendingExpenseId;
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
  void replace(TransactionEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TransactionEntity;
  }

  @override
  void update(void Function(TransactionEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionEntity build() => _build();

  _$TransactionEntity _build() {
    final _$result = _$v ??
        new _$TransactionEntity._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'TransactionEntity', 'amount'),
            currencyId: BuiltValueNullFieldError.checkNotNull(
                currencyId, r'TransactionEntity', 'currencyId'),
            category: BuiltValueNullFieldError.checkNotNull(
                category, r'TransactionEntity', 'category'),
            baseType: BuiltValueNullFieldError.checkNotNull(
                baseType, r'TransactionEntity', 'baseType'),
            date: BuiltValueNullFieldError.checkNotNull(
                date, r'TransactionEntity', 'date'),
            bankAccountId: BuiltValueNullFieldError.checkNotNull(
                bankAccountId, r'TransactionEntity', 'bankAccountId'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'TransactionEntity', 'description'),
            statusId: BuiltValueNullFieldError.checkNotNull(
                statusId, r'TransactionEntity', 'statusId'),
            categoryId:
                BuiltValueNullFieldError.checkNotNull(categoryId, r'TransactionEntity', 'categoryId'),
            invoiceIds: BuiltValueNullFieldError.checkNotNull(invoiceIds, r'TransactionEntity', 'invoiceIds'),
            paymentId: BuiltValueNullFieldError.checkNotNull(paymentId, r'TransactionEntity', 'paymentId'),
            expenseId: BuiltValueNullFieldError.checkNotNull(expenseId, r'TransactionEntity', 'expenseId'),
            vendorId: BuiltValueNullFieldError.checkNotNull(vendorId, r'TransactionEntity', 'vendorId'),
            transactionId: BuiltValueNullFieldError.checkNotNull(transactionId, r'TransactionEntity', 'transactionId'),
            transactionRuleId: BuiltValueNullFieldError.checkNotNull(transactionRuleId, r'TransactionEntity', 'transactionRuleId'),
            participantName: BuiltValueNullFieldError.checkNotNull(participantName, r'TransactionEntity', 'participantName'),
            participant: BuiltValueNullFieldError.checkNotNull(participant, r'TransactionEntity', 'participant'),
            pendingVendorId: pendingVendorId,
            pendingCategoryId: pendingCategoryId,
            pendingExpenseId: pendingExpenseId,
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'TransactionEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'TransactionEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'TransactionEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(id, r'TransactionEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$TransactionStatusEntity extends TransactionStatusEntity {
  @override
  final String id;
  @override
  final String name;

  factory _$TransactionStatusEntity(
          [void Function(TransactionStatusEntityBuilder)? updates]) =>
      (new TransactionStatusEntityBuilder()..update(updates))._build();

  _$TransactionStatusEntity._({required this.id, required this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'TransactionStatusEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name, r'TransactionStatusEntity', 'name');
  }

  @override
  TransactionStatusEntity rebuild(
          void Function(TransactionStatusEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionStatusEntityBuilder toBuilder() =>
      new TransactionStatusEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionStatusEntity &&
        id == other.id &&
        name == other.name;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionStatusEntity')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class TransactionStatusEntityBuilder
    implements
        Builder<TransactionStatusEntity, TransactionStatusEntityBuilder> {
  _$TransactionStatusEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TransactionStatusEntityBuilder();

  TransactionStatusEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionStatusEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TransactionStatusEntity;
  }

  @override
  void update(void Function(TransactionStatusEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionStatusEntity build() => _build();

  _$TransactionStatusEntity _build() {
    final _$result = _$v ??
        new _$TransactionStatusEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'TransactionStatusEntity', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'TransactionStatusEntity', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
