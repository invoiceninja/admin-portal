// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubscriptionListResponse> _$subscriptionListResponseSerializer =
    new _$SubscriptionListResponseSerializer();
Serializer<SubscriptionItemResponse> _$subscriptionItemResponseSerializer =
    new _$SubscriptionItemResponseSerializer();
Serializer<SubscriptionEntity> _$subscriptionEntitySerializer =
    new _$SubscriptionEntitySerializer();

class _$SubscriptionListResponseSerializer
    implements StructuredSerializer<SubscriptionListResponse> {
  @override
  final Iterable<Type> types = const [
    SubscriptionListResponse,
    _$SubscriptionListResponse
  ];
  @override
  final String wireName = 'SubscriptionListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, SubscriptionListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(SubscriptionEntity)])),
    ];

    return result;
  }

  @override
  SubscriptionListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubscriptionListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SubscriptionEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$SubscriptionItemResponseSerializer
    implements StructuredSerializer<SubscriptionItemResponse> {
  @override
  final Iterable<Type> types = const [
    SubscriptionItemResponse,
    _$SubscriptionItemResponse
  ];
  @override
  final String wireName = 'SubscriptionItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, SubscriptionItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(SubscriptionEntity)),
    ];

    return result;
  }

  @override
  SubscriptionItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubscriptionItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SubscriptionEntity))
              as SubscriptionEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$SubscriptionEntitySerializer
    implements StructuredSerializer<SubscriptionEntity> {
  @override
  final Iterable<Type> types = const [SubscriptionEntity, _$SubscriptionEntity];
  @override
  final String wireName = 'SubscriptionEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, SubscriptionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
  SubscriptionEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubscriptionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
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

class _$SubscriptionListResponse extends SubscriptionListResponse {
  @override
  final BuiltList<SubscriptionEntity> data;

  factory _$SubscriptionListResponse(
          [void Function(SubscriptionListResponseBuilder) updates]) =>
      (new SubscriptionListResponseBuilder()..update(updates)).build();

  _$SubscriptionListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('SubscriptionListResponse', 'data');
    }
  }

  @override
  SubscriptionListResponse rebuild(
          void Function(SubscriptionListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubscriptionListResponseBuilder toBuilder() =>
      new SubscriptionListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubscriptionListResponse')
          ..add('data', data))
        .toString();
  }
}

class SubscriptionListResponseBuilder
    implements
        Builder<SubscriptionListResponse, SubscriptionListResponseBuilder> {
  _$SubscriptionListResponse _$v;

  ListBuilder<SubscriptionEntity> _data;
  ListBuilder<SubscriptionEntity> get data =>
      _$this._data ??= new ListBuilder<SubscriptionEntity>();
  set data(ListBuilder<SubscriptionEntity> data) => _$this._data = data;

  SubscriptionListResponseBuilder();

  SubscriptionListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubscriptionListResponse;
  }

  @override
  void update(void Function(SubscriptionListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubscriptionListResponse build() {
    _$SubscriptionListResponse _$result;
    try {
      _$result = _$v ?? new _$SubscriptionListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubscriptionListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SubscriptionItemResponse extends SubscriptionItemResponse {
  @override
  final SubscriptionEntity data;

  factory _$SubscriptionItemResponse(
          [void Function(SubscriptionItemResponseBuilder) updates]) =>
      (new SubscriptionItemResponseBuilder()..update(updates)).build();

  _$SubscriptionItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('SubscriptionItemResponse', 'data');
    }
  }

  @override
  SubscriptionItemResponse rebuild(
          void Function(SubscriptionItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubscriptionItemResponseBuilder toBuilder() =>
      new SubscriptionItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubscriptionItemResponse')
          ..add('data', data))
        .toString();
  }
}

class SubscriptionItemResponseBuilder
    implements
        Builder<SubscriptionItemResponse, SubscriptionItemResponseBuilder> {
  _$SubscriptionItemResponse _$v;

  SubscriptionEntityBuilder _data;
  SubscriptionEntityBuilder get data =>
      _$this._data ??= new SubscriptionEntityBuilder();
  set data(SubscriptionEntityBuilder data) => _$this._data = data;

  SubscriptionItemResponseBuilder();

  SubscriptionItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubscriptionItemResponse;
  }

  @override
  void update(void Function(SubscriptionItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubscriptionItemResponse build() {
    _$SubscriptionItemResponse _$result;
    try {
      _$result = _$v ?? new _$SubscriptionItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubscriptionItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SubscriptionEntity extends SubscriptionEntity {
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

  factory _$SubscriptionEntity(
          [void Function(SubscriptionEntityBuilder) updates]) =>
      (new SubscriptionEntityBuilder()..update(updates)).build();

  _$SubscriptionEntity._(
      {this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('SubscriptionEntity', 'id');
    }
  }

  @override
  SubscriptionEntity rebuild(
          void Function(SubscriptionEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubscriptionEntityBuilder toBuilder() =>
      new SubscriptionEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionEntity &&
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
                        $jc($jc($jc(0, isChanged.hashCode), createdAt.hashCode),
                            updatedAt.hashCode),
                        archivedAt.hashCode),
                    isDeleted.hashCode),
                createdUserId.hashCode),
            assignedUserId.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubscriptionEntity')
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

class SubscriptionEntityBuilder
    implements Builder<SubscriptionEntity, SubscriptionEntityBuilder> {
  _$SubscriptionEntity _$v;

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

  SubscriptionEntityBuilder();

  SubscriptionEntityBuilder get _$this {
    if (_$v != null) {
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
  void replace(SubscriptionEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubscriptionEntity;
  }

  @override
  void update(void Function(SubscriptionEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubscriptionEntity build() {
    final _$result = _$v ??
        new _$SubscriptionEntity._(
            isChanged: isChanged,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
