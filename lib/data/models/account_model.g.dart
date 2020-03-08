// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AccountEntity> _$accountEntitySerializer =
    new _$AccountEntitySerializer();

class _$AccountEntitySerializer implements StructuredSerializer<AccountEntity> {
  @override
  final Iterable<Type> types = const [AccountEntity, _$AccountEntity];
  @override
  final String wireName = 'AccountEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, AccountEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'default_url',
      serializers.serialize(object.defaultUrl,
          specifiedType: const FullType(String)),
      'plan',
      serializers.serialize(object.plan, specifiedType: const FullType(String)),
      'latest_version',
      serializers.serialize(object.latestVersion,
          specifiedType: const FullType(String)),
    ];
    if (object.currentVersion != null) {
      result
        ..add('current_version')
        ..add(serializers.serialize(object.currentVersion,
            specifiedType: const FullType(String)));
    }
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
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
    if (object.subEntityType != null) {
      result
        ..add('entity_type')
        ..add(serializers.serialize(object.subEntityType,
            specifiedType: const FullType(EntityType)));
    }
    return result;
  }

  @override
  AccountEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AccountEntityBuilder();

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
        case 'default_url':
          result.defaultUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'plan':
          result.plan = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'latest_version':
          result.latestVersion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'current_version':
          result.currentVersion = serializers.deserialize(value,
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
        case 'entity_type':
          result.subEntityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
          break;
      }
    }

    return result.build();
  }
}

class _$AccountEntity extends AccountEntity {
  @override
  final String id;
  @override
  final String defaultUrl;
  @override
  final String plan;
  @override
  final String latestVersion;
  @override
  final String currentVersion;
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
  final EntityType subEntityType;

  factory _$AccountEntity([void Function(AccountEntityBuilder) updates]) =>
      (new AccountEntityBuilder()..update(updates)).build();

  _$AccountEntity._(
      {this.id,
      this.defaultUrl,
      this.plan,
      this.latestVersion,
      this.currentVersion,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.subEntityType})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'id');
    }
    if (defaultUrl == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'defaultUrl');
    }
    if (plan == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'plan');
    }
    if (latestVersion == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'latestVersion');
    }
  }

  @override
  AccountEntity rebuild(void Function(AccountEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountEntityBuilder toBuilder() => new AccountEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountEntity &&
        id == other.id &&
        defaultUrl == other.defaultUrl &&
        plan == other.plan &&
        latestVersion == other.latestVersion &&
        currentVersion == other.currentVersion &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        subEntityType == other.subEntityType;
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
                                                $jc($jc(0, id.hashCode),
                                                    defaultUrl.hashCode),
                                                plan.hashCode),
                                            latestVersion.hashCode),
                                        currentVersion.hashCode),
                                    isChanged.hashCode),
                                createdAt.hashCode),
                            updatedAt.hashCode),
                        archivedAt.hashCode),
                    isDeleted.hashCode),
                createdUserId.hashCode),
            assignedUserId.hashCode),
        subEntityType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AccountEntity')
          ..add('id', id)
          ..add('defaultUrl', defaultUrl)
          ..add('plan', plan)
          ..add('latestVersion', latestVersion)
          ..add('currentVersion', currentVersion)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('subEntityType', subEntityType))
        .toString();
  }
}

class AccountEntityBuilder
    implements Builder<AccountEntity, AccountEntityBuilder> {
  _$AccountEntity _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _defaultUrl;
  String get defaultUrl => _$this._defaultUrl;
  set defaultUrl(String defaultUrl) => _$this._defaultUrl = defaultUrl;

  String _plan;
  String get plan => _$this._plan;
  set plan(String plan) => _$this._plan = plan;

  String _latestVersion;
  String get latestVersion => _$this._latestVersion;
  set latestVersion(String latestVersion) =>
      _$this._latestVersion = latestVersion;

  String _currentVersion;
  String get currentVersion => _$this._currentVersion;
  set currentVersion(String currentVersion) =>
      _$this._currentVersion = currentVersion;

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

  EntityType _subEntityType;
  EntityType get subEntityType => _$this._subEntityType;
  set subEntityType(EntityType subEntityType) =>
      _$this._subEntityType = subEntityType;

  AccountEntityBuilder();

  AccountEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _defaultUrl = _$v.defaultUrl;
      _plan = _$v.plan;
      _latestVersion = _$v.latestVersion;
      _currentVersion = _$v.currentVersion;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
      _subEntityType = _$v.subEntityType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AccountEntity;
  }

  @override
  void update(void Function(AccountEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AccountEntity build() {
    final _$result = _$v ??
        new _$AccountEntity._(
            id: id,
            defaultUrl: defaultUrl,
            plan: plan,
            latestVersion: latestVersion,
            currentVersion: currentVersion,
            isChanged: isChanged,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            subEntityType: subEntityType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
