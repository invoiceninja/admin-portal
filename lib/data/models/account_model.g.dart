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
      'report_errors',
      serializers.serialize(object.reportErrors,
          specifiedType: const FullType(bool)),
      'plan',
      serializers.serialize(object.plan, specifiedType: const FullType(String)),
      'plan_expires',
      serializers.serialize(object.planExpires,
          specifiedType: const FullType(String)),
      'latest_version',
      serializers.serialize(object.latestVersion,
          specifiedType: const FullType(String)),
      'current_version',
      serializers.serialize(object.currentVersion,
          specifiedType: const FullType(String)),
      'debug_enabled',
      serializers.serialize(object.debugEnabled,
          specifiedType: const FullType(bool)),
      'is_docker',
      serializers.serialize(object.isDocker,
          specifiedType: const FullType(bool)),
      'is_scheduler_running',
      serializers.serialize(object.isSchedulerRunning,
          specifiedType: const FullType(bool)),
      'disable_auto_update',
      serializers.serialize(object.disableAutoUpdate,
          specifiedType: const FullType(bool)),
      'default_company_id',
      serializers.serialize(object.defaultCompanyId,
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
        case 'report_errors':
          result.reportErrors = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'plan':
          result.plan = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'plan_expires':
          result.planExpires = serializers.deserialize(value,
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
        case 'debug_enabled':
          result.debugEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_docker':
          result.isDocker = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_scheduler_running':
          result.isSchedulerRunning = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'disable_auto_update':
          result.disableAutoUpdate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'default_company_id':
          result.defaultCompanyId = serializers.deserialize(value,
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
  final bool reportErrors;
  @override
  final String plan;
  @override
  final String planExpires;
  @override
  final String latestVersion;
  @override
  final String currentVersion;
  @override
  final bool debugEnabled;
  @override
  final bool isDocker;
  @override
  final bool isSchedulerRunning;
  @override
  final bool disableAutoUpdate;
  @override
  final String defaultCompanyId;

  factory _$AccountEntity([void Function(AccountEntityBuilder) updates]) =>
      (new AccountEntityBuilder()..update(updates)).build();

  _$AccountEntity._(
      {this.id,
      this.defaultUrl,
      this.reportErrors,
      this.plan,
      this.planExpires,
      this.latestVersion,
      this.currentVersion,
      this.debugEnabled,
      this.isDocker,
      this.isSchedulerRunning,
      this.disableAutoUpdate,
      this.defaultCompanyId})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'id');
    }
    if (defaultUrl == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'defaultUrl');
    }
    if (reportErrors == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'reportErrors');
    }
    if (plan == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'plan');
    }
    if (planExpires == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'planExpires');
    }
    if (latestVersion == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'latestVersion');
    }
    if (currentVersion == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'currentVersion');
    }
    if (debugEnabled == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'debugEnabled');
    }
    if (isDocker == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'isDocker');
    }
    if (isSchedulerRunning == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'isSchedulerRunning');
    }
    if (disableAutoUpdate == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'disableAutoUpdate');
    }
    if (defaultCompanyId == null) {
      throw new BuiltValueNullFieldError('AccountEntity', 'defaultCompanyId');
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
        reportErrors == other.reportErrors &&
        plan == other.plan &&
        planExpires == other.planExpires &&
        latestVersion == other.latestVersion &&
        currentVersion == other.currentVersion &&
        debugEnabled == other.debugEnabled &&
        isDocker == other.isDocker &&
        isSchedulerRunning == other.isSchedulerRunning &&
        disableAutoUpdate == other.disableAutoUpdate &&
        defaultCompanyId == other.defaultCompanyId;
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
                                            $jc($jc(0, id.hashCode),
                                                defaultUrl.hashCode),
                                            reportErrors.hashCode),
                                        plan.hashCode),
                                    planExpires.hashCode),
                                latestVersion.hashCode),
                            currentVersion.hashCode),
                        debugEnabled.hashCode),
                    isDocker.hashCode),
                isSchedulerRunning.hashCode),
            disableAutoUpdate.hashCode),
        defaultCompanyId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AccountEntity')
          ..add('id', id)
          ..add('defaultUrl', defaultUrl)
          ..add('reportErrors', reportErrors)
          ..add('plan', plan)
          ..add('planExpires', planExpires)
          ..add('latestVersion', latestVersion)
          ..add('currentVersion', currentVersion)
          ..add('debugEnabled', debugEnabled)
          ..add('isDocker', isDocker)
          ..add('isSchedulerRunning', isSchedulerRunning)
          ..add('disableAutoUpdate', disableAutoUpdate)
          ..add('defaultCompanyId', defaultCompanyId))
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

  bool _reportErrors;
  bool get reportErrors => _$this._reportErrors;
  set reportErrors(bool reportErrors) => _$this._reportErrors = reportErrors;

  String _plan;
  String get plan => _$this._plan;
  set plan(String plan) => _$this._plan = plan;

  String _planExpires;
  String get planExpires => _$this._planExpires;
  set planExpires(String planExpires) => _$this._planExpires = planExpires;

  String _latestVersion;
  String get latestVersion => _$this._latestVersion;
  set latestVersion(String latestVersion) =>
      _$this._latestVersion = latestVersion;

  String _currentVersion;
  String get currentVersion => _$this._currentVersion;
  set currentVersion(String currentVersion) =>
      _$this._currentVersion = currentVersion;

  bool _debugEnabled;
  bool get debugEnabled => _$this._debugEnabled;
  set debugEnabled(bool debugEnabled) => _$this._debugEnabled = debugEnabled;

  bool _isDocker;
  bool get isDocker => _$this._isDocker;
  set isDocker(bool isDocker) => _$this._isDocker = isDocker;

  bool _isSchedulerRunning;
  bool get isSchedulerRunning => _$this._isSchedulerRunning;
  set isSchedulerRunning(bool isSchedulerRunning) =>
      _$this._isSchedulerRunning = isSchedulerRunning;

  bool _disableAutoUpdate;
  bool get disableAutoUpdate => _$this._disableAutoUpdate;
  set disableAutoUpdate(bool disableAutoUpdate) =>
      _$this._disableAutoUpdate = disableAutoUpdate;

  String _defaultCompanyId;
  String get defaultCompanyId => _$this._defaultCompanyId;
  set defaultCompanyId(String defaultCompanyId) =>
      _$this._defaultCompanyId = defaultCompanyId;

  AccountEntityBuilder() {
    AccountEntity._initializeBuilder(this);
  }

  AccountEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _defaultUrl = _$v.defaultUrl;
      _reportErrors = _$v.reportErrors;
      _plan = _$v.plan;
      _planExpires = _$v.planExpires;
      _latestVersion = _$v.latestVersion;
      _currentVersion = _$v.currentVersion;
      _debugEnabled = _$v.debugEnabled;
      _isDocker = _$v.isDocker;
      _isSchedulerRunning = _$v.isSchedulerRunning;
      _disableAutoUpdate = _$v.disableAutoUpdate;
      _defaultCompanyId = _$v.defaultCompanyId;
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
            reportErrors: reportErrors,
            plan: plan,
            planExpires: planExpires,
            latestVersion: latestVersion,
            currentVersion: currentVersion,
            debugEnabled: debugEnabled,
            isDocker: isDocker,
            isSchedulerRunning: isSchedulerRunning,
            disableAutoUpdate: disableAutoUpdate,
            defaultCompanyId: defaultCompanyId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
