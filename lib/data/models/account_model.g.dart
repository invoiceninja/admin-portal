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
      'key',
      serializers.serialize(object.key, specifiedType: const FullType(String)),
      'trial_started',
      serializers.serialize(object.trialStarted,
          specifiedType: const FullType(String)),
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
      'is_migrated',
      serializers.serialize(object.isMigrated,
          specifiedType: const FullType(bool)),
      'is_hosted',
      serializers.serialize(object.isHosted,
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
      'hosted_client_count',
      serializers.serialize(object.hostedClientCount,
          specifiedType: const FullType(int)),
      'hosted_company_count',
      serializers.serialize(object.hostedCompanyCount,
          specifiedType: const FullType(int)),
      'set_react_as_default_ap',
      serializers.serialize(object.setReactAsDefaultAP,
          specifiedType: const FullType(bool)),
      'account_sms_verified',
      serializers.serialize(object.accountSmsVerified,
          specifiedType: const FullType(bool)),
      'trial_days_left',
      serializers.serialize(object.trialDaysLeft,
          specifiedType: const FullType(int)),
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
      final Object value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'key':
          result.key = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'trial_started':
          result.trialStarted = serializers.deserialize(value,
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
        case 'is_migrated':
          result.isMigrated = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'is_hosted':
          result.isHosted = serializers.deserialize(value,
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
        case 'hosted_client_count':
          result.hostedClientCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'hosted_company_count':
          result.hostedCompanyCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'set_react_as_default_ap':
          result.setReactAsDefaultAP = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'account_sms_verified':
          result.accountSmsVerified = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'trial_days_left':
          result.trialDaysLeft = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
  final String key;
  @override
  final String trialStarted;
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
  final bool isMigrated;
  @override
  final bool isHosted;
  @override
  final bool isSchedulerRunning;
  @override
  final bool disableAutoUpdate;
  @override
  final String defaultCompanyId;
  @override
  final int hostedClientCount;
  @override
  final int hostedCompanyCount;
  @override
  final bool setReactAsDefaultAP;
  @override
  final bool accountSmsVerified;
  @override
  final int trialDaysLeft;

  factory _$AccountEntity([void Function(AccountEntityBuilder) updates]) =>
      (new AccountEntityBuilder()..update(updates)).build();

  _$AccountEntity._(
      {this.id,
      this.key,
      this.trialStarted,
      this.defaultUrl,
      this.reportErrors,
      this.plan,
      this.planExpires,
      this.latestVersion,
      this.currentVersion,
      this.debugEnabled,
      this.isDocker,
      this.isMigrated,
      this.isHosted,
      this.isSchedulerRunning,
      this.disableAutoUpdate,
      this.defaultCompanyId,
      this.hostedClientCount,
      this.hostedCompanyCount,
      this.setReactAsDefaultAP,
      this.accountSmsVerified,
      this.trialDaysLeft})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'AccountEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(key, 'AccountEntity', 'key');
    BuiltValueNullFieldError.checkNotNull(
        trialStarted, 'AccountEntity', 'trialStarted');
    BuiltValueNullFieldError.checkNotNull(
        defaultUrl, 'AccountEntity', 'defaultUrl');
    BuiltValueNullFieldError.checkNotNull(
        reportErrors, 'AccountEntity', 'reportErrors');
    BuiltValueNullFieldError.checkNotNull(plan, 'AccountEntity', 'plan');
    BuiltValueNullFieldError.checkNotNull(
        planExpires, 'AccountEntity', 'planExpires');
    BuiltValueNullFieldError.checkNotNull(
        latestVersion, 'AccountEntity', 'latestVersion');
    BuiltValueNullFieldError.checkNotNull(
        currentVersion, 'AccountEntity', 'currentVersion');
    BuiltValueNullFieldError.checkNotNull(
        debugEnabled, 'AccountEntity', 'debugEnabled');
    BuiltValueNullFieldError.checkNotNull(
        isDocker, 'AccountEntity', 'isDocker');
    BuiltValueNullFieldError.checkNotNull(
        isMigrated, 'AccountEntity', 'isMigrated');
    BuiltValueNullFieldError.checkNotNull(
        isHosted, 'AccountEntity', 'isHosted');
    BuiltValueNullFieldError.checkNotNull(
        isSchedulerRunning, 'AccountEntity', 'isSchedulerRunning');
    BuiltValueNullFieldError.checkNotNull(
        disableAutoUpdate, 'AccountEntity', 'disableAutoUpdate');
    BuiltValueNullFieldError.checkNotNull(
        defaultCompanyId, 'AccountEntity', 'defaultCompanyId');
    BuiltValueNullFieldError.checkNotNull(
        hostedClientCount, 'AccountEntity', 'hostedClientCount');
    BuiltValueNullFieldError.checkNotNull(
        hostedCompanyCount, 'AccountEntity', 'hostedCompanyCount');
    BuiltValueNullFieldError.checkNotNull(
        setReactAsDefaultAP, 'AccountEntity', 'setReactAsDefaultAP');
    BuiltValueNullFieldError.checkNotNull(
        accountSmsVerified, 'AccountEntity', 'accountSmsVerified');
    BuiltValueNullFieldError.checkNotNull(
        trialDaysLeft, 'AccountEntity', 'trialDaysLeft');
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
        key == other.key &&
        trialStarted == other.trialStarted &&
        defaultUrl == other.defaultUrl &&
        reportErrors == other.reportErrors &&
        plan == other.plan &&
        planExpires == other.planExpires &&
        latestVersion == other.latestVersion &&
        currentVersion == other.currentVersion &&
        debugEnabled == other.debugEnabled &&
        isDocker == other.isDocker &&
        isMigrated == other.isMigrated &&
        isHosted == other.isHosted &&
        isSchedulerRunning == other.isSchedulerRunning &&
        disableAutoUpdate == other.disableAutoUpdate &&
        defaultCompanyId == other.defaultCompanyId &&
        hostedClientCount == other.hostedClientCount &&
        hostedCompanyCount == other.hostedCompanyCount &&
        setReactAsDefaultAP == other.setReactAsDefaultAP &&
        accountSmsVerified == other.accountSmsVerified &&
        trialDaysLeft == other.trialDaysLeft;
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
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc(0, id.hashCode), key.hashCode),
                                                                                trialStarted.hashCode),
                                                                            defaultUrl.hashCode),
                                                                        reportErrors.hashCode),
                                                                    plan.hashCode),
                                                                planExpires.hashCode),
                                                            latestVersion.hashCode),
                                                        currentVersion.hashCode),
                                                    debugEnabled.hashCode),
                                                isDocker.hashCode),
                                            isMigrated.hashCode),
                                        isHosted.hashCode),
                                    isSchedulerRunning.hashCode),
                                disableAutoUpdate.hashCode),
                            defaultCompanyId.hashCode),
                        hostedClientCount.hashCode),
                    hostedCompanyCount.hashCode),
                setReactAsDefaultAP.hashCode),
            accountSmsVerified.hashCode),
        trialDaysLeft.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AccountEntity')
          ..add('id', id)
          ..add('key', key)
          ..add('trialStarted', trialStarted)
          ..add('defaultUrl', defaultUrl)
          ..add('reportErrors', reportErrors)
          ..add('plan', plan)
          ..add('planExpires', planExpires)
          ..add('latestVersion', latestVersion)
          ..add('currentVersion', currentVersion)
          ..add('debugEnabled', debugEnabled)
          ..add('isDocker', isDocker)
          ..add('isMigrated', isMigrated)
          ..add('isHosted', isHosted)
          ..add('isSchedulerRunning', isSchedulerRunning)
          ..add('disableAutoUpdate', disableAutoUpdate)
          ..add('defaultCompanyId', defaultCompanyId)
          ..add('hostedClientCount', hostedClientCount)
          ..add('hostedCompanyCount', hostedCompanyCount)
          ..add('setReactAsDefaultAP', setReactAsDefaultAP)
          ..add('accountSmsVerified', accountSmsVerified)
          ..add('trialDaysLeft', trialDaysLeft))
        .toString();
  }
}

class AccountEntityBuilder
    implements Builder<AccountEntity, AccountEntityBuilder> {
  _$AccountEntity _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _trialStarted;
  String get trialStarted => _$this._trialStarted;
  set trialStarted(String trialStarted) => _$this._trialStarted = trialStarted;

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

  bool _isMigrated;
  bool get isMigrated => _$this._isMigrated;
  set isMigrated(bool isMigrated) => _$this._isMigrated = isMigrated;

  bool _isHosted;
  bool get isHosted => _$this._isHosted;
  set isHosted(bool isHosted) => _$this._isHosted = isHosted;

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

  int _hostedClientCount;
  int get hostedClientCount => _$this._hostedClientCount;
  set hostedClientCount(int hostedClientCount) =>
      _$this._hostedClientCount = hostedClientCount;

  int _hostedCompanyCount;
  int get hostedCompanyCount => _$this._hostedCompanyCount;
  set hostedCompanyCount(int hostedCompanyCount) =>
      _$this._hostedCompanyCount = hostedCompanyCount;

  bool _setReactAsDefaultAP;
  bool get setReactAsDefaultAP => _$this._setReactAsDefaultAP;
  set setReactAsDefaultAP(bool setReactAsDefaultAP) =>
      _$this._setReactAsDefaultAP = setReactAsDefaultAP;

  bool _accountSmsVerified;
  bool get accountSmsVerified => _$this._accountSmsVerified;
  set accountSmsVerified(bool accountSmsVerified) =>
      _$this._accountSmsVerified = accountSmsVerified;

  int _trialDaysLeft;
  int get trialDaysLeft => _$this._trialDaysLeft;
  set trialDaysLeft(int trialDaysLeft) => _$this._trialDaysLeft = trialDaysLeft;

  AccountEntityBuilder() {
    AccountEntity._initializeBuilder(this);
  }

  AccountEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _key = $v.key;
      _trialStarted = $v.trialStarted;
      _defaultUrl = $v.defaultUrl;
      _reportErrors = $v.reportErrors;
      _plan = $v.plan;
      _planExpires = $v.planExpires;
      _latestVersion = $v.latestVersion;
      _currentVersion = $v.currentVersion;
      _debugEnabled = $v.debugEnabled;
      _isDocker = $v.isDocker;
      _isMigrated = $v.isMigrated;
      _isHosted = $v.isHosted;
      _isSchedulerRunning = $v.isSchedulerRunning;
      _disableAutoUpdate = $v.disableAutoUpdate;
      _defaultCompanyId = $v.defaultCompanyId;
      _hostedClientCount = $v.hostedClientCount;
      _hostedCompanyCount = $v.hostedCompanyCount;
      _setReactAsDefaultAP = $v.setReactAsDefaultAP;
      _accountSmsVerified = $v.accountSmsVerified;
      _trialDaysLeft = $v.trialDaysLeft;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountEntity other) {
    ArgumentError.checkNotNull(other, 'other');
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
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'AccountEntity', 'id'),
            key: BuiltValueNullFieldError.checkNotNull(
                key, 'AccountEntity', 'key'),
            trialStarted: BuiltValueNullFieldError.checkNotNull(
                trialStarted, 'AccountEntity', 'trialStarted'),
            defaultUrl: BuiltValueNullFieldError.checkNotNull(
                defaultUrl, 'AccountEntity', 'defaultUrl'),
            reportErrors: BuiltValueNullFieldError.checkNotNull(
                reportErrors, 'AccountEntity', 'reportErrors'),
            plan: BuiltValueNullFieldError.checkNotNull(
                plan, 'AccountEntity', 'plan'),
            planExpires: BuiltValueNullFieldError.checkNotNull(
                planExpires, 'AccountEntity', 'planExpires'),
            latestVersion: BuiltValueNullFieldError.checkNotNull(
                latestVersion, 'AccountEntity', 'latestVersion'),
            currentVersion: BuiltValueNullFieldError.checkNotNull(
                currentVersion, 'AccountEntity', 'currentVersion'),
            debugEnabled: BuiltValueNullFieldError.checkNotNull(
                debugEnabled, 'AccountEntity', 'debugEnabled'),
            isDocker: BuiltValueNullFieldError.checkNotNull(isDocker, 'AccountEntity', 'isDocker'),
            isMigrated: BuiltValueNullFieldError.checkNotNull(isMigrated, 'AccountEntity', 'isMigrated'),
            isHosted: BuiltValueNullFieldError.checkNotNull(isHosted, 'AccountEntity', 'isHosted'),
            isSchedulerRunning: BuiltValueNullFieldError.checkNotNull(isSchedulerRunning, 'AccountEntity', 'isSchedulerRunning'),
            disableAutoUpdate: BuiltValueNullFieldError.checkNotNull(disableAutoUpdate, 'AccountEntity', 'disableAutoUpdate'),
            defaultCompanyId: BuiltValueNullFieldError.checkNotNull(defaultCompanyId, 'AccountEntity', 'defaultCompanyId'),
            hostedClientCount: BuiltValueNullFieldError.checkNotNull(hostedClientCount, 'AccountEntity', 'hostedClientCount'),
            hostedCompanyCount: BuiltValueNullFieldError.checkNotNull(hostedCompanyCount, 'AccountEntity', 'hostedCompanyCount'),
            setReactAsDefaultAP: BuiltValueNullFieldError.checkNotNull(setReactAsDefaultAP, 'AccountEntity', 'setReactAsDefaultAP'),
            accountSmsVerified: BuiltValueNullFieldError.checkNotNull(accountSmsVerified, 'AccountEntity', 'accountSmsVerified'),
            trialDaysLeft: BuiltValueNullFieldError.checkNotNull(trialDaysLeft, 'AccountEntity', 'trialDaysLeft'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
