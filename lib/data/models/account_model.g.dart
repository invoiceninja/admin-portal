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
      'current_version',
      serializers.serialize(object.currentVersion,
          specifiedType: const FullType(String)),
    ];

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

  factory _$AccountEntity([void Function(AccountEntityBuilder) updates]) =>
      (new AccountEntityBuilder()..update(updates)).build();

  _$AccountEntity._(
      {this.id,
      this.defaultUrl,
      this.plan,
      this.latestVersion,
      this.currentVersion})
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
    if (currentVersion == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'currentVersion');
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
        currentVersion == other.currentVersion;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), defaultUrl.hashCode), plan.hashCode),
            latestVersion.hashCode),
        currentVersion.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AccountEntity')
          ..add('id', id)
          ..add('defaultUrl', defaultUrl)
          ..add('plan', plan)
          ..add('latestVersion', latestVersion)
          ..add('currentVersion', currentVersion))
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

  AccountEntityBuilder();

  AccountEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _defaultUrl = _$v.defaultUrl;
      _plan = _$v.plan;
      _latestVersion = _$v.latestVersion;
      _currentVersion = _$v.currentVersion;
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
            currentVersion: currentVersion);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
