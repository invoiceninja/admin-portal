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
  Iterable<Object> serialize(
      Serializers serializers, TransactionListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TransactionEntity)])),
    ];

    return result;
  }

  @override
  TransactionListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TransactionEntity)]))
              as BuiltList<Object>);
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
  Iterable<Object> serialize(
      Serializers serializers, TransactionItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TransactionEntity)),
    ];

    return result;
  }

  @override
  TransactionItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TransactionEntity))
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
  Iterable<Object> serialize(Serializers serializers, TransactionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'reference',
      serializers.serialize(object.reference,
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
    Object value;
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
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'reference':
          result.reference = serializers.deserialize(value,
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

class _$TransactionListResponse extends TransactionListResponse {
  @override
  final BuiltList<TransactionEntity> data;

  factory _$TransactionListResponse(
          [void Function(TransactionListResponseBuilder) updates]) =>
      (new TransactionListResponseBuilder()..update(updates)).build();

  _$TransactionListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'TransactionListResponse', 'data');
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TransactionListResponse')
          ..add('data', data))
        .toString();
  }
}

class TransactionListResponseBuilder
    implements
        Builder<TransactionListResponse, TransactionListResponseBuilder> {
  _$TransactionListResponse _$v;

  ListBuilder<TransactionEntity> _data;
  ListBuilder<TransactionEntity> get data =>
      _$this._data ??= new ListBuilder<TransactionEntity>();
  set data(ListBuilder<TransactionEntity> data) => _$this._data = data;

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
  void update(void Function(TransactionListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TransactionListResponse build() {
    _$TransactionListResponse _$result;
    try {
      _$result = _$v ?? new _$TransactionListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TransactionListResponse', _$failedField, e.toString());
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
          [void Function(TransactionItemResponseBuilder) updates]) =>
      (new TransactionItemResponseBuilder()..update(updates)).build();

  _$TransactionItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'TransactionItemResponse', 'data');
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TransactionItemResponse')
          ..add('data', data))
        .toString();
  }
}

class TransactionItemResponseBuilder
    implements
        Builder<TransactionItemResponse, TransactionItemResponseBuilder> {
  _$TransactionItemResponse _$v;

  TransactionEntityBuilder _data;
  TransactionEntityBuilder get data =>
      _$this._data ??= new TransactionEntityBuilder();
  set data(TransactionEntityBuilder data) => _$this._data = data;

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
  void update(void Function(TransactionItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TransactionItemResponse build() {
    _$TransactionItemResponse _$result;
    try {
      _$result = _$v ?? new _$TransactionItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TransactionItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TransactionEntity extends TransactionEntity {
  @override
  final String reference;
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

  factory _$TransactionEntity(
          [void Function(TransactionEntityBuilder) updates]) =>
      (new TransactionEntityBuilder()..update(updates)).build();

  _$TransactionEntity._(
      {this.reference,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        reference, 'TransactionEntity', 'reference');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'TransactionEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'TransactionEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'TransactionEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'TransactionEntity', 'id');
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
        reference == other.reference &&
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
                                $jc($jc(0, reference.hashCode),
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
    return (newBuiltValueToStringHelper('TransactionEntity')
          ..add('reference', reference)
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
  _$TransactionEntity _$v;

  String _reference;
  String get reference => _$this._reference;
  set reference(String reference) => _$this._reference = reference;

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

  TransactionEntityBuilder();

  TransactionEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reference = $v.reference;
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
  void update(void Function(TransactionEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TransactionEntity build() {
    final _$result = _$v ??
        new _$TransactionEntity._(
            reference: BuiltValueNullFieldError.checkNotNull(
                reference, 'TransactionEntity', 'reference'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, 'TransactionEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, 'TransactionEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(
                archivedAt, 'TransactionEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'TransactionEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
