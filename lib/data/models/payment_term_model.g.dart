// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_term_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PaymentTermListResponse> _$paymentTermListResponseSerializer =
    new _$PaymentTermListResponseSerializer();
Serializer<PaymentTermItemResponse> _$paymentTermItemResponseSerializer =
    new _$PaymentTermItemResponseSerializer();
Serializer<PaymentTermEntity> _$paymentTermEntitySerializer =
    new _$PaymentTermEntitySerializer();

class _$PaymentTermListResponseSerializer
    implements StructuredSerializer<PaymentTermListResponse> {
  @override
  final Iterable<Type> types = const [
    PaymentTermListResponse,
    _$PaymentTermListResponse
  ];
  @override
  final String wireName = 'PaymentTermListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, PaymentTermListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PaymentTermEntity)])),
    ];

    return result;
  }

  @override
  PaymentTermListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTermListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PaymentTermEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentTermItemResponseSerializer
    implements StructuredSerializer<PaymentTermItemResponse> {
  @override
  final Iterable<Type> types = const [
    PaymentTermItemResponse,
    _$PaymentTermItemResponse
  ];
  @override
  final String wireName = 'PaymentTermItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, PaymentTermItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(PaymentTermEntity)),
    ];

    return result;
  }

  @override
  PaymentTermItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTermItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PaymentTermEntity))
              as PaymentTermEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentTermEntitySerializer
    implements StructuredSerializer<PaymentTermEntity> {
  @override
  final Iterable<Type> types = const [PaymentTermEntity, _$PaymentTermEntity];
  @override
  final String wireName = 'PaymentTermEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, PaymentTermEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'num_days',
      serializers.serialize(object.numDays, specifiedType: const FullType(int)),
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
  PaymentTermEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentTermEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'num_days':
          result.numDays = serializers.deserialize(value,
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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentTermListResponse extends PaymentTermListResponse {
  @override
  final BuiltList<PaymentTermEntity> data;

  factory _$PaymentTermListResponse(
          [void Function(PaymentTermListResponseBuilder) updates]) =>
      (new PaymentTermListResponseBuilder()..update(updates)).build();

  _$PaymentTermListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'PaymentTermListResponse', 'data');
  }

  @override
  PaymentTermListResponse rebuild(
          void Function(PaymentTermListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTermListResponseBuilder toBuilder() =>
      new PaymentTermListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTermListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentTermListResponse')
          ..add('data', data))
        .toString();
  }
}

class PaymentTermListResponseBuilder
    implements
        Builder<PaymentTermListResponse, PaymentTermListResponseBuilder> {
  _$PaymentTermListResponse _$v;

  ListBuilder<PaymentTermEntity> _data;
  ListBuilder<PaymentTermEntity> get data =>
      _$this._data ??= new ListBuilder<PaymentTermEntity>();
  set data(ListBuilder<PaymentTermEntity> data) => _$this._data = data;

  PaymentTermListResponseBuilder();

  PaymentTermListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTermListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentTermListResponse;
  }

  @override
  void update(void Function(PaymentTermListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTermListResponse build() {
    _$PaymentTermListResponse _$result;
    try {
      _$result = _$v ?? new _$PaymentTermListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaymentTermListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentTermItemResponse extends PaymentTermItemResponse {
  @override
  final PaymentTermEntity data;

  factory _$PaymentTermItemResponse(
          [void Function(PaymentTermItemResponseBuilder) updates]) =>
      (new PaymentTermItemResponseBuilder()..update(updates)).build();

  _$PaymentTermItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'PaymentTermItemResponse', 'data');
  }

  @override
  PaymentTermItemResponse rebuild(
          void Function(PaymentTermItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTermItemResponseBuilder toBuilder() =>
      new PaymentTermItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTermItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentTermItemResponse')
          ..add('data', data))
        .toString();
  }
}

class PaymentTermItemResponseBuilder
    implements
        Builder<PaymentTermItemResponse, PaymentTermItemResponseBuilder> {
  _$PaymentTermItemResponse _$v;

  PaymentTermEntityBuilder _data;
  PaymentTermEntityBuilder get data =>
      _$this._data ??= new PaymentTermEntityBuilder();
  set data(PaymentTermEntityBuilder data) => _$this._data = data;

  PaymentTermItemResponseBuilder();

  PaymentTermItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentTermItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentTermItemResponse;
  }

  @override
  void update(void Function(PaymentTermItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTermItemResponse build() {
    _$PaymentTermItemResponse _$result;
    try {
      _$result = _$v ?? new _$PaymentTermItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaymentTermItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PaymentTermEntity extends PaymentTermEntity {
  @override
  final String name;
  @override
  final int numDays;
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

  factory _$PaymentTermEntity(
          [void Function(PaymentTermEntityBuilder) updates]) =>
      (new PaymentTermEntityBuilder()..update(updates)).build();

  _$PaymentTermEntity._(
      {this.name,
      this.numDays,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'PaymentTermEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        numDays, 'PaymentTermEntity', 'numDays');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'PaymentTermEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'PaymentTermEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'PaymentTermEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'PaymentTermEntity', 'id');
  }

  @override
  PaymentTermEntity rebuild(void Function(PaymentTermEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentTermEntityBuilder toBuilder() =>
      new PaymentTermEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentTermEntity &&
        name == other.name &&
        numDays == other.numDays &&
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
                                    $jc($jc(0, name.hashCode),
                                        numDays.hashCode),
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
    return (newBuiltValueToStringHelper('PaymentTermEntity')
          ..add('name', name)
          ..add('numDays', numDays)
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

class PaymentTermEntityBuilder
    implements Builder<PaymentTermEntity, PaymentTermEntityBuilder> {
  _$PaymentTermEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _numDays;
  int get numDays => _$this._numDays;
  set numDays(int numDays) => _$this._numDays = numDays;

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

  PaymentTermEntityBuilder();

  PaymentTermEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _numDays = $v.numDays;
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
  void replace(PaymentTermEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentTermEntity;
  }

  @override
  void update(void Function(PaymentTermEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentTermEntity build() {
    final _$result = _$v ??
        new _$PaymentTermEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'PaymentTermEntity', 'name'),
            numDays: BuiltValueNullFieldError.checkNotNull(
                numDays, 'PaymentTermEntity', 'numDays'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, 'PaymentTermEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, 'PaymentTermEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(
                archivedAt, 'PaymentTermEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'PaymentTermEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
