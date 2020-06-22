// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_rate_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TaxRateListResponse> _$taxRateListResponseSerializer =
    new _$TaxRateListResponseSerializer();
Serializer<TaxRateItemResponse> _$taxRateItemResponseSerializer =
    new _$TaxRateItemResponseSerializer();
Serializer<TaxRateEntity> _$taxRateEntitySerializer =
    new _$TaxRateEntitySerializer();

class _$TaxRateListResponseSerializer
    implements StructuredSerializer<TaxRateListResponse> {
  @override
  final Iterable<Type> types = const [
    TaxRateListResponse,
    _$TaxRateListResponse
  ];
  @override
  final String wireName = 'TaxRateListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, TaxRateListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TaxRateEntity)])),
    ];

    return result;
  }

  @override
  TaxRateListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxRateListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TaxRateEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$TaxRateItemResponseSerializer
    implements StructuredSerializer<TaxRateItemResponse> {
  @override
  final Iterable<Type> types = const [
    TaxRateItemResponse,
    _$TaxRateItemResponse
  ];
  @override
  final String wireName = 'TaxRateItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, TaxRateItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(TaxRateEntity)),
    ];

    return result;
  }

  @override
  TaxRateItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxRateItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaxRateEntity)) as TaxRateEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$TaxRateEntitySerializer implements StructuredSerializer<TaxRateEntity> {
  @override
  final Iterable<Type> types = const [TaxRateEntity, _$TaxRateEntity];
  @override
  final String wireName = 'TaxRateEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, TaxRateEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'rate',
      serializers.serialize(object.rate, specifiedType: const FullType(double)),
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
  TaxRateEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaxRateEntityBuilder();

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
        case 'rate':
          result.rate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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

class _$TaxRateListResponse extends TaxRateListResponse {
  @override
  final BuiltList<TaxRateEntity> data;

  factory _$TaxRateListResponse(
          [void Function(TaxRateListResponseBuilder) updates]) =>
      (new TaxRateListResponseBuilder()..update(updates)).build();

  _$TaxRateListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TaxRateListResponse', 'data');
    }
  }

  @override
  TaxRateListResponse rebuild(
          void Function(TaxRateListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxRateListResponseBuilder toBuilder() =>
      new TaxRateListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxRateListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaxRateListResponse')
          ..add('data', data))
        .toString();
  }
}

class TaxRateListResponseBuilder
    implements Builder<TaxRateListResponse, TaxRateListResponseBuilder> {
  _$TaxRateListResponse _$v;

  ListBuilder<TaxRateEntity> _data;
  ListBuilder<TaxRateEntity> get data =>
      _$this._data ??= new ListBuilder<TaxRateEntity>();
  set data(ListBuilder<TaxRateEntity> data) => _$this._data = data;

  TaxRateListResponseBuilder();

  TaxRateListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxRateListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaxRateListResponse;
  }

  @override
  void update(void Function(TaxRateListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TaxRateListResponse build() {
    _$TaxRateListResponse _$result;
    try {
      _$result = _$v ?? new _$TaxRateListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TaxRateListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaxRateItemResponse extends TaxRateItemResponse {
  @override
  final TaxRateEntity data;

  factory _$TaxRateItemResponse(
          [void Function(TaxRateItemResponseBuilder) updates]) =>
      (new TaxRateItemResponseBuilder()..update(updates)).build();

  _$TaxRateItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('TaxRateItemResponse', 'data');
    }
  }

  @override
  TaxRateItemResponse rebuild(
          void Function(TaxRateItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxRateItemResponseBuilder toBuilder() =>
      new TaxRateItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxRateItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaxRateItemResponse')
          ..add('data', data))
        .toString();
  }
}

class TaxRateItemResponseBuilder
    implements Builder<TaxRateItemResponse, TaxRateItemResponseBuilder> {
  _$TaxRateItemResponse _$v;

  TaxRateEntityBuilder _data;
  TaxRateEntityBuilder get data => _$this._data ??= new TaxRateEntityBuilder();
  set data(TaxRateEntityBuilder data) => _$this._data = data;

  TaxRateItemResponseBuilder();

  TaxRateItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaxRateItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaxRateItemResponse;
  }

  @override
  void update(void Function(TaxRateItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TaxRateItemResponse build() {
    _$TaxRateItemResponse _$result;
    try {
      _$result = _$v ?? new _$TaxRateItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TaxRateItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TaxRateEntity extends TaxRateEntity {
  @override
  final String name;
  @override
  final double rate;
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

  factory _$TaxRateEntity([void Function(TaxRateEntityBuilder) updates]) =>
      (new TaxRateEntityBuilder()..update(updates)).build();

  _$TaxRateEntity._(
      {this.name,
      this.rate,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('TaxRateEntity', 'name');
    }
    if (rate == null) {
      throw new BuiltValueNullFieldError('TaxRateEntity', 'rate');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('TaxRateEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('TaxRateEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('TaxRateEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('TaxRateEntity', 'id');
    }
  }

  @override
  TaxRateEntity rebuild(void Function(TaxRateEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaxRateEntityBuilder toBuilder() => new TaxRateEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaxRateEntity &&
        name == other.name &&
        rate == other.rate &&
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
                                $jc($jc($jc(0, name.hashCode), rate.hashCode),
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
    return (newBuiltValueToStringHelper('TaxRateEntity')
          ..add('name', name)
          ..add('rate', rate)
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

class TaxRateEntityBuilder
    implements Builder<TaxRateEntity, TaxRateEntityBuilder> {
  _$TaxRateEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  double _rate;
  double get rate => _$this._rate;
  set rate(double rate) => _$this._rate = rate;

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

  TaxRateEntityBuilder();

  TaxRateEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _rate = _$v.rate;
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
  void replace(TaxRateEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaxRateEntity;
  }

  @override
  void update(void Function(TaxRateEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TaxRateEntity build() {
    final _$result = _$v ??
        new _$TaxRateEntity._(
            name: name,
            rate: rate,
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
