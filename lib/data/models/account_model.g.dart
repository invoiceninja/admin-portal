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
  Iterable<Object?> serialize(Serializers serializers, AccountEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
      'has_iap_plan',
      serializers.serialize(object.hasIapPlan,
          specifiedType: const FullType(bool)),
      'payment_id',
      serializers.serialize(object.paymentId,
          specifiedType: const FullType(String)),
      'tax_api_enabled',
      serializers.serialize(object.taxApiEnabled,
          specifiedType: const FullType(bool)),
      'nordigen_enabled',
      serializers.serialize(object.nordigenEnabled,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  AccountEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AccountEntityBuilder();

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
        case 'key':
          result.key = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'trial_started':
          result.trialStarted = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'default_url':
          result.defaultUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'report_errors':
          result.reportErrors = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'plan':
          result.plan = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'plan_expires':
          result.planExpires = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'latest_version':
          result.latestVersion = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'current_version':
          result.currentVersion = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'debug_enabled':
          result.debugEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'is_docker':
          result.isDocker = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'is_migrated':
          result.isMigrated = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'is_hosted':
          result.isHosted = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'is_scheduler_running':
          result.isSchedulerRunning = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'disable_auto_update':
          result.disableAutoUpdate = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'default_company_id':
          result.defaultCompanyId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'hosted_client_count':
          result.hostedClientCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'hosted_company_count':
          result.hostedCompanyCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'set_react_as_default_ap':
          result.setReactAsDefaultAP = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'account_sms_verified':
          result.accountSmsVerified = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'trial_days_left':
          result.trialDaysLeft = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'has_iap_plan':
          result.hasIapPlan = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'payment_id':
          result.paymentId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_api_enabled':
          result.taxApiEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'nordigen_enabled':
          result.nordigenEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
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
  @override
  final bool hasIapPlan;
  @override
  final String paymentId;
  @override
  final bool taxApiEnabled;
  @override
  final bool nordigenEnabled;

  factory _$AccountEntity([void Function(AccountEntityBuilder)? updates]) =>
      (new AccountEntityBuilder()..update(updates))._build();

  _$AccountEntity._(
      {required this.id,
      required this.key,
      required this.trialStarted,
      required this.defaultUrl,
      required this.reportErrors,
      required this.plan,
      required this.planExpires,
      required this.latestVersion,
      required this.currentVersion,
      required this.debugEnabled,
      required this.isDocker,
      required this.isMigrated,
      required this.isHosted,
      required this.isSchedulerRunning,
      required this.disableAutoUpdate,
      required this.defaultCompanyId,
      required this.hostedClientCount,
      required this.hostedCompanyCount,
      required this.setReactAsDefaultAP,
      required this.accountSmsVerified,
      required this.trialDaysLeft,
      required this.hasIapPlan,
      required this.paymentId,
      required this.taxApiEnabled,
      required this.nordigenEnabled})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'AccountEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(key, r'AccountEntity', 'key');
    BuiltValueNullFieldError.checkNotNull(
        trialStarted, r'AccountEntity', 'trialStarted');
    BuiltValueNullFieldError.checkNotNull(
        defaultUrl, r'AccountEntity', 'defaultUrl');
    BuiltValueNullFieldError.checkNotNull(
        reportErrors, r'AccountEntity', 'reportErrors');
    BuiltValueNullFieldError.checkNotNull(plan, r'AccountEntity', 'plan');
    BuiltValueNullFieldError.checkNotNull(
        planExpires, r'AccountEntity', 'planExpires');
    BuiltValueNullFieldError.checkNotNull(
        latestVersion, r'AccountEntity', 'latestVersion');
    BuiltValueNullFieldError.checkNotNull(
        currentVersion, r'AccountEntity', 'currentVersion');
    BuiltValueNullFieldError.checkNotNull(
        debugEnabled, r'AccountEntity', 'debugEnabled');
    BuiltValueNullFieldError.checkNotNull(
        isDocker, r'AccountEntity', 'isDocker');
    BuiltValueNullFieldError.checkNotNull(
        isMigrated, r'AccountEntity', 'isMigrated');
    BuiltValueNullFieldError.checkNotNull(
        isHosted, r'AccountEntity', 'isHosted');
    BuiltValueNullFieldError.checkNotNull(
        isSchedulerRunning, r'AccountEntity', 'isSchedulerRunning');
    BuiltValueNullFieldError.checkNotNull(
        disableAutoUpdate, r'AccountEntity', 'disableAutoUpdate');
    BuiltValueNullFieldError.checkNotNull(
        defaultCompanyId, r'AccountEntity', 'defaultCompanyId');
    BuiltValueNullFieldError.checkNotNull(
        hostedClientCount, r'AccountEntity', 'hostedClientCount');
    BuiltValueNullFieldError.checkNotNull(
        hostedCompanyCount, r'AccountEntity', 'hostedCompanyCount');
    BuiltValueNullFieldError.checkNotNull(
        setReactAsDefaultAP, r'AccountEntity', 'setReactAsDefaultAP');
    BuiltValueNullFieldError.checkNotNull(
        accountSmsVerified, r'AccountEntity', 'accountSmsVerified');
    BuiltValueNullFieldError.checkNotNull(
        trialDaysLeft, r'AccountEntity', 'trialDaysLeft');
    BuiltValueNullFieldError.checkNotNull(
        hasIapPlan, r'AccountEntity', 'hasIapPlan');
    BuiltValueNullFieldError.checkNotNull(
        paymentId, r'AccountEntity', 'paymentId');
    BuiltValueNullFieldError.checkNotNull(
        taxApiEnabled, r'AccountEntity', 'taxApiEnabled');
    BuiltValueNullFieldError.checkNotNull(
        nordigenEnabled, r'AccountEntity', 'nordigenEnabled');
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
        trialDaysLeft == other.trialDaysLeft &&
        hasIapPlan == other.hasIapPlan &&
        paymentId == other.paymentId &&
        taxApiEnabled == other.taxApiEnabled &&
        nordigenEnabled == other.nordigenEnabled;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, trialStarted.hashCode);
    _$hash = $jc(_$hash, defaultUrl.hashCode);
    _$hash = $jc(_$hash, reportErrors.hashCode);
    _$hash = $jc(_$hash, plan.hashCode);
    _$hash = $jc(_$hash, planExpires.hashCode);
    _$hash = $jc(_$hash, latestVersion.hashCode);
    _$hash = $jc(_$hash, currentVersion.hashCode);
    _$hash = $jc(_$hash, debugEnabled.hashCode);
    _$hash = $jc(_$hash, isDocker.hashCode);
    _$hash = $jc(_$hash, isMigrated.hashCode);
    _$hash = $jc(_$hash, isHosted.hashCode);
    _$hash = $jc(_$hash, isSchedulerRunning.hashCode);
    _$hash = $jc(_$hash, disableAutoUpdate.hashCode);
    _$hash = $jc(_$hash, defaultCompanyId.hashCode);
    _$hash = $jc(_$hash, hostedClientCount.hashCode);
    _$hash = $jc(_$hash, hostedCompanyCount.hashCode);
    _$hash = $jc(_$hash, setReactAsDefaultAP.hashCode);
    _$hash = $jc(_$hash, accountSmsVerified.hashCode);
    _$hash = $jc(_$hash, trialDaysLeft.hashCode);
    _$hash = $jc(_$hash, hasIapPlan.hashCode);
    _$hash = $jc(_$hash, paymentId.hashCode);
    _$hash = $jc(_$hash, taxApiEnabled.hashCode);
    _$hash = $jc(_$hash, nordigenEnabled.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountEntity')
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
          ..add('trialDaysLeft', trialDaysLeft)
          ..add('hasIapPlan', hasIapPlan)
          ..add('paymentId', paymentId)
          ..add('taxApiEnabled', taxApiEnabled)
          ..add('nordigenEnabled', nordigenEnabled))
        .toString();
  }
}

class AccountEntityBuilder
    implements Builder<AccountEntity, AccountEntityBuilder> {
  _$AccountEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _trialStarted;
  String? get trialStarted => _$this._trialStarted;
  set trialStarted(String? trialStarted) => _$this._trialStarted = trialStarted;

  String? _defaultUrl;
  String? get defaultUrl => _$this._defaultUrl;
  set defaultUrl(String? defaultUrl) => _$this._defaultUrl = defaultUrl;

  bool? _reportErrors;
  bool? get reportErrors => _$this._reportErrors;
  set reportErrors(bool? reportErrors) => _$this._reportErrors = reportErrors;

  String? _plan;
  String? get plan => _$this._plan;
  set plan(String? plan) => _$this._plan = plan;

  String? _planExpires;
  String? get planExpires => _$this._planExpires;
  set planExpires(String? planExpires) => _$this._planExpires = planExpires;

  String? _latestVersion;
  String? get latestVersion => _$this._latestVersion;
  set latestVersion(String? latestVersion) =>
      _$this._latestVersion = latestVersion;

  String? _currentVersion;
  String? get currentVersion => _$this._currentVersion;
  set currentVersion(String? currentVersion) =>
      _$this._currentVersion = currentVersion;

  bool? _debugEnabled;
  bool? get debugEnabled => _$this._debugEnabled;
  set debugEnabled(bool? debugEnabled) => _$this._debugEnabled = debugEnabled;

  bool? _isDocker;
  bool? get isDocker => _$this._isDocker;
  set isDocker(bool? isDocker) => _$this._isDocker = isDocker;

  bool? _isMigrated;
  bool? get isMigrated => _$this._isMigrated;
  set isMigrated(bool? isMigrated) => _$this._isMigrated = isMigrated;

  bool? _isHosted;
  bool? get isHosted => _$this._isHosted;
  set isHosted(bool? isHosted) => _$this._isHosted = isHosted;

  bool? _isSchedulerRunning;
  bool? get isSchedulerRunning => _$this._isSchedulerRunning;
  set isSchedulerRunning(bool? isSchedulerRunning) =>
      _$this._isSchedulerRunning = isSchedulerRunning;

  bool? _disableAutoUpdate;
  bool? get disableAutoUpdate => _$this._disableAutoUpdate;
  set disableAutoUpdate(bool? disableAutoUpdate) =>
      _$this._disableAutoUpdate = disableAutoUpdate;

  String? _defaultCompanyId;
  String? get defaultCompanyId => _$this._defaultCompanyId;
  set defaultCompanyId(String? defaultCompanyId) =>
      _$this._defaultCompanyId = defaultCompanyId;

  int? _hostedClientCount;
  int? get hostedClientCount => _$this._hostedClientCount;
  set hostedClientCount(int? hostedClientCount) =>
      _$this._hostedClientCount = hostedClientCount;

  int? _hostedCompanyCount;
  int? get hostedCompanyCount => _$this._hostedCompanyCount;
  set hostedCompanyCount(int? hostedCompanyCount) =>
      _$this._hostedCompanyCount = hostedCompanyCount;

  bool? _setReactAsDefaultAP;
  bool? get setReactAsDefaultAP => _$this._setReactAsDefaultAP;
  set setReactAsDefaultAP(bool? setReactAsDefaultAP) =>
      _$this._setReactAsDefaultAP = setReactAsDefaultAP;

  bool? _accountSmsVerified;
  bool? get accountSmsVerified => _$this._accountSmsVerified;
  set accountSmsVerified(bool? accountSmsVerified) =>
      _$this._accountSmsVerified = accountSmsVerified;

  int? _trialDaysLeft;
  int? get trialDaysLeft => _$this._trialDaysLeft;
  set trialDaysLeft(int? trialDaysLeft) =>
      _$this._trialDaysLeft = trialDaysLeft;

  bool? _hasIapPlan;
  bool? get hasIapPlan => _$this._hasIapPlan;
  set hasIapPlan(bool? hasIapPlan) => _$this._hasIapPlan = hasIapPlan;

  String? _paymentId;
  String? get paymentId => _$this._paymentId;
  set paymentId(String? paymentId) => _$this._paymentId = paymentId;

  bool? _taxApiEnabled;
  bool? get taxApiEnabled => _$this._taxApiEnabled;
  set taxApiEnabled(bool? taxApiEnabled) =>
      _$this._taxApiEnabled = taxApiEnabled;

  bool? _nordigenEnabled;
  bool? get nordigenEnabled => _$this._nordigenEnabled;
  set nordigenEnabled(bool? nordigenEnabled) =>
      _$this._nordigenEnabled = nordigenEnabled;

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
      _hasIapPlan = $v.hasIapPlan;
      _paymentId = $v.paymentId;
      _taxApiEnabled = $v.taxApiEnabled;
      _nordigenEnabled = $v.nordigenEnabled;
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
  void update(void Function(AccountEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountEntity build() => _build();

  _$AccountEntity _build() {
    final _$result = _$v ??
        new _$AccountEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'AccountEntity', 'id'),
            key: BuiltValueNullFieldError.checkNotNull(
                key, r'AccountEntity', 'key'),
            trialStarted: BuiltValueNullFieldError.checkNotNull(
                trialStarted, r'AccountEntity', 'trialStarted'),
            defaultUrl: BuiltValueNullFieldError.checkNotNull(
                defaultUrl, r'AccountEntity', 'defaultUrl'),
            reportErrors: BuiltValueNullFieldError.checkNotNull(
                reportErrors, r'AccountEntity', 'reportErrors'),
            plan: BuiltValueNullFieldError.checkNotNull(
                plan, r'AccountEntity', 'plan'),
            planExpires: BuiltValueNullFieldError.checkNotNull(
                planExpires, r'AccountEntity', 'planExpires'),
            latestVersion: BuiltValueNullFieldError.checkNotNull(
                latestVersion, r'AccountEntity', 'latestVersion'),
            currentVersion: BuiltValueNullFieldError.checkNotNull(
                currentVersion, r'AccountEntity', 'currentVersion'),
            debugEnabled:
                BuiltValueNullFieldError.checkNotNull(debugEnabled, r'AccountEntity', 'debugEnabled'),
            isDocker: BuiltValueNullFieldError.checkNotNull(isDocker, r'AccountEntity', 'isDocker'),
            isMigrated: BuiltValueNullFieldError.checkNotNull(isMigrated, r'AccountEntity', 'isMigrated'),
            isHosted: BuiltValueNullFieldError.checkNotNull(isHosted, r'AccountEntity', 'isHosted'),
            isSchedulerRunning: BuiltValueNullFieldError.checkNotNull(isSchedulerRunning, r'AccountEntity', 'isSchedulerRunning'),
            disableAutoUpdate: BuiltValueNullFieldError.checkNotNull(disableAutoUpdate, r'AccountEntity', 'disableAutoUpdate'),
            defaultCompanyId: BuiltValueNullFieldError.checkNotNull(defaultCompanyId, r'AccountEntity', 'defaultCompanyId'),
            hostedClientCount: BuiltValueNullFieldError.checkNotNull(hostedClientCount, r'AccountEntity', 'hostedClientCount'),
            hostedCompanyCount: BuiltValueNullFieldError.checkNotNull(hostedCompanyCount, r'AccountEntity', 'hostedCompanyCount'),
            setReactAsDefaultAP: BuiltValueNullFieldError.checkNotNull(setReactAsDefaultAP, r'AccountEntity', 'setReactAsDefaultAP'),
            accountSmsVerified: BuiltValueNullFieldError.checkNotNull(accountSmsVerified, r'AccountEntity', 'accountSmsVerified'),
            trialDaysLeft: BuiltValueNullFieldError.checkNotNull(trialDaysLeft, r'AccountEntity', 'trialDaysLeft'),
            hasIapPlan: BuiltValueNullFieldError.checkNotNull(hasIapPlan, r'AccountEntity', 'hasIapPlan'),
            paymentId: BuiltValueNullFieldError.checkNotNull(paymentId, r'AccountEntity', 'paymentId'),
            taxApiEnabled: BuiltValueNullFieldError.checkNotNull(taxApiEnabled, r'AccountEntity', 'taxApiEnabled'),
            nordigenEnabled: BuiltValueNullFieldError.checkNotNull(nordigenEnabled, r'AccountEntity', 'nordigenEnabled'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
