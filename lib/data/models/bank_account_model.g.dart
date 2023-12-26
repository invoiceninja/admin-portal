// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BankAccountListResponse> _$bankAccountListResponseSerializer =
    new _$BankAccountListResponseSerializer();
Serializer<BankAccountItemResponse> _$bankAccountItemResponseSerializer =
    new _$BankAccountItemResponseSerializer();
Serializer<BankAccountEntity> _$bankAccountEntitySerializer =
    new _$BankAccountEntitySerializer();

class _$BankAccountListResponseSerializer
    implements StructuredSerializer<BankAccountListResponse> {
  @override
  final Iterable<Type> types = const [
    BankAccountListResponse,
    _$BankAccountListResponse
  ];
  @override
  final String wireName = 'BankAccountListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, BankAccountListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              BuiltList, const [const FullType(BankAccountEntity)])),
    ];

    return result;
  }

  @override
  BankAccountListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BankAccountListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BankAccountEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$BankAccountItemResponseSerializer
    implements StructuredSerializer<BankAccountItemResponse> {
  @override
  final Iterable<Type> types = const [
    BankAccountItemResponse,
    _$BankAccountItemResponse
  ];
  @override
  final String wireName = 'BankAccountItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, BankAccountItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(BankAccountEntity)),
    ];

    return result;
  }

  @override
  BankAccountItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BankAccountItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BankAccountEntity))!
              as BankAccountEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$BankAccountEntitySerializer
    implements StructuredSerializer<BankAccountEntity> {
  @override
  final Iterable<Type> types = const [BankAccountEntity, _$BankAccountEntity];
  @override
  final String wireName = 'BankAccountEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, BankAccountEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'bank_account_name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'bank_account_status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
      'bank_account_type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'provider_name',
      serializers.serialize(object.provider,
          specifiedType: const FullType(String)),
      'from_date',
      serializers.serialize(object.fromDate,
          specifiedType: const FullType(String)),
      'auto_sync',
      serializers.serialize(object.autoSync,
          specifiedType: const FullType(bool)),
      'disabled_upstream',
      serializers.serialize(object.disabledUpstream,
          specifiedType: const FullType(bool)),
      'integration_type',
      serializers.serialize(object.integrationType,
          specifiedType: const FullType(String)),
      'balance',
      serializers.serialize(object.balance,
          specifiedType: const FullType(double)),
      'currency',
      serializers.serialize(object.currency,
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
  BankAccountEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BankAccountEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'bank_account_name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'bank_account_status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'bank_account_type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'provider_name':
          result.provider = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'from_date':
          result.fromDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'auto_sync':
          result.autoSync = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'disabled_upstream':
          result.disabledUpstream = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'integration_type':
          result.integrationType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

class _$BankAccountListResponse extends BankAccountListResponse {
  @override
  final BuiltList<BankAccountEntity> data;

  factory _$BankAccountListResponse(
          [void Function(BankAccountListResponseBuilder)? updates]) =>
      (new BankAccountListResponseBuilder()..update(updates))._build();

  _$BankAccountListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'BankAccountListResponse', 'data');
  }

  @override
  BankAccountListResponse rebuild(
          void Function(BankAccountListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BankAccountListResponseBuilder toBuilder() =>
      new BankAccountListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccountListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'BankAccountListResponse')
          ..add('data', data))
        .toString();
  }
}

class BankAccountListResponseBuilder
    implements
        Builder<BankAccountListResponse, BankAccountListResponseBuilder> {
  _$BankAccountListResponse? _$v;

  ListBuilder<BankAccountEntity>? _data;
  ListBuilder<BankAccountEntity> get data =>
      _$this._data ??= new ListBuilder<BankAccountEntity>();
  set data(ListBuilder<BankAccountEntity>? data) => _$this._data = data;

  BankAccountListResponseBuilder();

  BankAccountListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BankAccountListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BankAccountListResponse;
  }

  @override
  void update(void Function(BankAccountListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BankAccountListResponse build() => _build();

  _$BankAccountListResponse _build() {
    _$BankAccountListResponse _$result;
    try {
      _$result = _$v ?? new _$BankAccountListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'BankAccountListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$BankAccountItemResponse extends BankAccountItemResponse {
  @override
  final BankAccountEntity data;

  factory _$BankAccountItemResponse(
          [void Function(BankAccountItemResponseBuilder)? updates]) =>
      (new BankAccountItemResponseBuilder()..update(updates))._build();

  _$BankAccountItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'BankAccountItemResponse', 'data');
  }

  @override
  BankAccountItemResponse rebuild(
          void Function(BankAccountItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BankAccountItemResponseBuilder toBuilder() =>
      new BankAccountItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccountItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'BankAccountItemResponse')
          ..add('data', data))
        .toString();
  }
}

class BankAccountItemResponseBuilder
    implements
        Builder<BankAccountItemResponse, BankAccountItemResponseBuilder> {
  _$BankAccountItemResponse? _$v;

  BankAccountEntityBuilder? _data;
  BankAccountEntityBuilder get data =>
      _$this._data ??= new BankAccountEntityBuilder();
  set data(BankAccountEntityBuilder? data) => _$this._data = data;

  BankAccountItemResponseBuilder();

  BankAccountItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BankAccountItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BankAccountItemResponse;
  }

  @override
  void update(void Function(BankAccountItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BankAccountItemResponse build() => _build();

  _$BankAccountItemResponse _build() {
    _$BankAccountItemResponse _$result;
    try {
      _$result = _$v ?? new _$BankAccountItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'BankAccountItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$BankAccountEntity extends BankAccountEntity {
  @override
  final String name;
  @override
  final String status;
  @override
  final String type;
  @override
  final String provider;
  @override
  final String fromDate;
  @override
  final bool autoSync;
  @override
  final bool disabledUpstream;
  @override
  final String integrationType;
  @override
  final double balance;
  @override
  final String currency;
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

  factory _$BankAccountEntity(
          [void Function(BankAccountEntityBuilder)? updates]) =>
      (new BankAccountEntityBuilder()..update(updates))._build();

  _$BankAccountEntity._(
      {required this.name,
      required this.status,
      required this.type,
      required this.provider,
      required this.fromDate,
      required this.autoSync,
      required this.disabledUpstream,
      required this.integrationType,
      required this.balance,
      required this.currency,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'BankAccountEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        status, r'BankAccountEntity', 'status');
    BuiltValueNullFieldError.checkNotNull(type, r'BankAccountEntity', 'type');
    BuiltValueNullFieldError.checkNotNull(
        provider, r'BankAccountEntity', 'provider');
    BuiltValueNullFieldError.checkNotNull(
        fromDate, r'BankAccountEntity', 'fromDate');
    BuiltValueNullFieldError.checkNotNull(
        autoSync, r'BankAccountEntity', 'autoSync');
    BuiltValueNullFieldError.checkNotNull(
        disabledUpstream, r'BankAccountEntity', 'disabledUpstream');
    BuiltValueNullFieldError.checkNotNull(
        integrationType, r'BankAccountEntity', 'integrationType');
    BuiltValueNullFieldError.checkNotNull(
        balance, r'BankAccountEntity', 'balance');
    BuiltValueNullFieldError.checkNotNull(
        currency, r'BankAccountEntity', 'currency');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'BankAccountEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'BankAccountEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'BankAccountEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'BankAccountEntity', 'id');
  }

  @override
  BankAccountEntity rebuild(void Function(BankAccountEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BankAccountEntityBuilder toBuilder() =>
      new BankAccountEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BankAccountEntity &&
        name == other.name &&
        status == other.status &&
        type == other.type &&
        provider == other.provider &&
        fromDate == other.fromDate &&
        autoSync == other.autoSync &&
        disabledUpstream == other.disabledUpstream &&
        integrationType == other.integrationType &&
        balance == other.balance &&
        currency == other.currency &&
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
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, fromDate.hashCode);
    _$hash = $jc(_$hash, autoSync.hashCode);
    _$hash = $jc(_$hash, disabledUpstream.hashCode);
    _$hash = $jc(_$hash, integrationType.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
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
    return (newBuiltValueToStringHelper(r'BankAccountEntity')
          ..add('name', name)
          ..add('status', status)
          ..add('type', type)
          ..add('provider', provider)
          ..add('fromDate', fromDate)
          ..add('autoSync', autoSync)
          ..add('disabledUpstream', disabledUpstream)
          ..add('integrationType', integrationType)
          ..add('balance', balance)
          ..add('currency', currency)
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

class BankAccountEntityBuilder
    implements Builder<BankAccountEntity, BankAccountEntityBuilder> {
  _$BankAccountEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _provider;
  String? get provider => _$this._provider;
  set provider(String? provider) => _$this._provider = provider;

  String? _fromDate;
  String? get fromDate => _$this._fromDate;
  set fromDate(String? fromDate) => _$this._fromDate = fromDate;

  bool? _autoSync;
  bool? get autoSync => _$this._autoSync;
  set autoSync(bool? autoSync) => _$this._autoSync = autoSync;

  bool? _disabledUpstream;
  bool? get disabledUpstream => _$this._disabledUpstream;
  set disabledUpstream(bool? disabledUpstream) =>
      _$this._disabledUpstream = disabledUpstream;

  String? _integrationType;
  String? get integrationType => _$this._integrationType;
  set integrationType(String? integrationType) =>
      _$this._integrationType = integrationType;

  double? _balance;
  double? get balance => _$this._balance;
  set balance(double? balance) => _$this._balance = balance;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

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

  BankAccountEntityBuilder() {
    BankAccountEntity._initializeBuilder(this);
  }

  BankAccountEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _status = $v.status;
      _type = $v.type;
      _provider = $v.provider;
      _fromDate = $v.fromDate;
      _autoSync = $v.autoSync;
      _disabledUpstream = $v.disabledUpstream;
      _integrationType = $v.integrationType;
      _balance = $v.balance;
      _currency = $v.currency;
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
  void replace(BankAccountEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BankAccountEntity;
  }

  @override
  void update(void Function(BankAccountEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BankAccountEntity build() => _build();

  _$BankAccountEntity _build() {
    final _$result = _$v ??
        new _$BankAccountEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'BankAccountEntity', 'name'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'BankAccountEntity', 'status'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'BankAccountEntity', 'type'),
            provider: BuiltValueNullFieldError.checkNotNull(
                provider, r'BankAccountEntity', 'provider'),
            fromDate: BuiltValueNullFieldError.checkNotNull(
                fromDate, r'BankAccountEntity', 'fromDate'),
            autoSync: BuiltValueNullFieldError.checkNotNull(
                autoSync, r'BankAccountEntity', 'autoSync'),
            disabledUpstream: BuiltValueNullFieldError.checkNotNull(
                disabledUpstream, r'BankAccountEntity', 'disabledUpstream'),
            integrationType: BuiltValueNullFieldError.checkNotNull(
                integrationType, r'BankAccountEntity', 'integrationType'),
            balance: BuiltValueNullFieldError.checkNotNull(
                balance, r'BankAccountEntity', 'balance'),
            currency: BuiltValueNullFieldError.checkNotNull(currency, r'BankAccountEntity', 'currency'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'BankAccountEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'BankAccountEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'BankAccountEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(id, r'BankAccountEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
