// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_check_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HealthCheckResponse> _$healthCheckResponseSerializer =
    new _$HealthCheckResponseSerializer();
Serializer<HealthCheckPHPResponse> _$healthCheckPHPResponseSerializer =
    new _$HealthCheckPHPResponseSerializer();

class _$HealthCheckResponseSerializer
    implements StructuredSerializer<HealthCheckResponse> {
  @override
  final Iterable<Type> types = const [
    HealthCheckResponse,
    _$HealthCheckResponse
  ];
  @override
  final String wireName = 'HealthCheckResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, HealthCheckResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'system_health',
      serializers.serialize(object.systemHealth,
          specifiedType: const FullType(bool)),
      'php_version',
      serializers.serialize(object.phpVersion,
          specifiedType: const FullType(HealthCheckPHPResponse)),
      'env_writable',
      serializers.serialize(object.envWritable,
          specifiedType: const FullType(bool)),
      'simple_db_check',
      serializers.serialize(object.dbCheck,
          specifiedType: const FullType(bool)),
      'cache_enabled',
      serializers.serialize(object.cacheEnabled,
          specifiedType: const FullType(bool)),
      'phantom_enabled',
      serializers.serialize(object.phantomEnabled,
          specifiedType: const FullType(bool)),
      'open_basedir',
      serializers.serialize(object.openBasedir,
          specifiedType: const FullType(bool)),
      'file_permissions',
      serializers.serialize(object.filePermissions,
          specifiedType: const FullType(String)),
      'exec',
      serializers.serialize(object.execEnabled,
          specifiedType: const FullType(bool)),
      'mail_mailer',
      serializers.serialize(object.emailDriver,
          specifiedType: const FullType(String)),
      'jobs_pending',
      serializers.serialize(object.pendingJobs,
          specifiedType: const FullType(int)),
      'pdf_engine',
      serializers.serialize(object.pdfEngine,
          specifiedType: const FullType(String)),
      'trailing_slash',
      serializers.serialize(object.trailingSlash,
          specifiedType: const FullType(bool)),
      'exchange_rate_api_not_configured',
      serializers.serialize(object.exchangeRateApiNotConfigured,
          specifiedType: const FullType(bool)),
      'queue',
      serializers.serialize(object.queue,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  HealthCheckResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HealthCheckResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'system_health':
          result.systemHealth = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'php_version':
          result.phpVersion.replace(serializers.deserialize(value,
                  specifiedType: const FullType(HealthCheckPHPResponse))!
              as HealthCheckPHPResponse);
          break;
        case 'env_writable':
          result.envWritable = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'simple_db_check':
          result.dbCheck = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'cache_enabled':
          result.cacheEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'phantom_enabled':
          result.phantomEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'open_basedir':
          result.openBasedir = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'file_permissions':
          result.filePermissions = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'exec':
          result.execEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'mail_mailer':
          result.emailDriver = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'jobs_pending':
          result.pendingJobs = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'pdf_engine':
          result.pdfEngine = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'trailing_slash':
          result.trailingSlash = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'exchange_rate_api_not_configured':
          result.exchangeRateApiNotConfigured = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'queue':
          result.queue = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$HealthCheckPHPResponseSerializer
    implements StructuredSerializer<HealthCheckPHPResponse> {
  @override
  final Iterable<Type> types = const [
    HealthCheckPHPResponse,
    _$HealthCheckPHPResponse
  ];
  @override
  final String wireName = 'HealthCheckPHPResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, HealthCheckPHPResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'minimum_php_version',
      serializers.serialize(object.minimumPHPVersion,
          specifiedType: const FullType(String)),
      'current_php_version',
      serializers.serialize(object.currentPHPVersion,
          specifiedType: const FullType(String)),
      'current_php_cli_version',
      serializers.serialize(object.currentPHPCLIVersion,
          specifiedType: const FullType(String)),
      'is_okay',
      serializers.serialize(object.isOkay, specifiedType: const FullType(bool)),
      'memory_limit',
      serializers.serialize(object.memoryLimit,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  HealthCheckPHPResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HealthCheckPHPResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'minimum_php_version':
          result.minimumPHPVersion = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'current_php_version':
          result.currentPHPVersion = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'current_php_cli_version':
          result.currentPHPCLIVersion = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'is_okay':
          result.isOkay = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'memory_limit':
          result.memoryLimit = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$HealthCheckResponse extends HealthCheckResponse {
  @override
  final bool systemHealth;
  @override
  final HealthCheckPHPResponse phpVersion;
  @override
  final bool envWritable;
  @override
  final bool dbCheck;
  @override
  final bool cacheEnabled;
  @override
  final bool phantomEnabled;
  @override
  final bool openBasedir;
  @override
  final String filePermissions;
  @override
  final bool execEnabled;
  @override
  final String emailDriver;
  @override
  final int pendingJobs;
  @override
  final String pdfEngine;
  @override
  final bool trailingSlash;
  @override
  final bool exchangeRateApiNotConfigured;
  @override
  final String queue;

  factory _$HealthCheckResponse(
          [void Function(HealthCheckResponseBuilder)? updates]) =>
      (new HealthCheckResponseBuilder()..update(updates))._build();

  _$HealthCheckResponse._(
      {required this.systemHealth,
      required this.phpVersion,
      required this.envWritable,
      required this.dbCheck,
      required this.cacheEnabled,
      required this.phantomEnabled,
      required this.openBasedir,
      required this.filePermissions,
      required this.execEnabled,
      required this.emailDriver,
      required this.pendingJobs,
      required this.pdfEngine,
      required this.trailingSlash,
      required this.exchangeRateApiNotConfigured,
      required this.queue})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        systemHealth, r'HealthCheckResponse', 'systemHealth');
    BuiltValueNullFieldError.checkNotNull(
        phpVersion, r'HealthCheckResponse', 'phpVersion');
    BuiltValueNullFieldError.checkNotNull(
        envWritable, r'HealthCheckResponse', 'envWritable');
    BuiltValueNullFieldError.checkNotNull(
        dbCheck, r'HealthCheckResponse', 'dbCheck');
    BuiltValueNullFieldError.checkNotNull(
        cacheEnabled, r'HealthCheckResponse', 'cacheEnabled');
    BuiltValueNullFieldError.checkNotNull(
        phantomEnabled, r'HealthCheckResponse', 'phantomEnabled');
    BuiltValueNullFieldError.checkNotNull(
        openBasedir, r'HealthCheckResponse', 'openBasedir');
    BuiltValueNullFieldError.checkNotNull(
        filePermissions, r'HealthCheckResponse', 'filePermissions');
    BuiltValueNullFieldError.checkNotNull(
        execEnabled, r'HealthCheckResponse', 'execEnabled');
    BuiltValueNullFieldError.checkNotNull(
        emailDriver, r'HealthCheckResponse', 'emailDriver');
    BuiltValueNullFieldError.checkNotNull(
        pendingJobs, r'HealthCheckResponse', 'pendingJobs');
    BuiltValueNullFieldError.checkNotNull(
        pdfEngine, r'HealthCheckResponse', 'pdfEngine');
    BuiltValueNullFieldError.checkNotNull(
        trailingSlash, r'HealthCheckResponse', 'trailingSlash');
    BuiltValueNullFieldError.checkNotNull(exchangeRateApiNotConfigured,
        r'HealthCheckResponse', 'exchangeRateApiNotConfigured');
    BuiltValueNullFieldError.checkNotNull(
        queue, r'HealthCheckResponse', 'queue');
  }

  @override
  HealthCheckResponse rebuild(
          void Function(HealthCheckResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealthCheckResponseBuilder toBuilder() =>
      new HealthCheckResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthCheckResponse &&
        systemHealth == other.systemHealth &&
        phpVersion == other.phpVersion &&
        envWritable == other.envWritable &&
        dbCheck == other.dbCheck &&
        cacheEnabled == other.cacheEnabled &&
        phantomEnabled == other.phantomEnabled &&
        openBasedir == other.openBasedir &&
        filePermissions == other.filePermissions &&
        execEnabled == other.execEnabled &&
        emailDriver == other.emailDriver &&
        pendingJobs == other.pendingJobs &&
        pdfEngine == other.pdfEngine &&
        trailingSlash == other.trailingSlash &&
        exchangeRateApiNotConfigured == other.exchangeRateApiNotConfigured &&
        queue == other.queue;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, systemHealth.hashCode);
    _$hash = $jc(_$hash, phpVersion.hashCode);
    _$hash = $jc(_$hash, envWritable.hashCode);
    _$hash = $jc(_$hash, dbCheck.hashCode);
    _$hash = $jc(_$hash, cacheEnabled.hashCode);
    _$hash = $jc(_$hash, phantomEnabled.hashCode);
    _$hash = $jc(_$hash, openBasedir.hashCode);
    _$hash = $jc(_$hash, filePermissions.hashCode);
    _$hash = $jc(_$hash, execEnabled.hashCode);
    _$hash = $jc(_$hash, emailDriver.hashCode);
    _$hash = $jc(_$hash, pendingJobs.hashCode);
    _$hash = $jc(_$hash, pdfEngine.hashCode);
    _$hash = $jc(_$hash, trailingSlash.hashCode);
    _$hash = $jc(_$hash, exchangeRateApiNotConfigured.hashCode);
    _$hash = $jc(_$hash, queue.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealthCheckResponse')
          ..add('systemHealth', systemHealth)
          ..add('phpVersion', phpVersion)
          ..add('envWritable', envWritable)
          ..add('dbCheck', dbCheck)
          ..add('cacheEnabled', cacheEnabled)
          ..add('phantomEnabled', phantomEnabled)
          ..add('openBasedir', openBasedir)
          ..add('filePermissions', filePermissions)
          ..add('execEnabled', execEnabled)
          ..add('emailDriver', emailDriver)
          ..add('pendingJobs', pendingJobs)
          ..add('pdfEngine', pdfEngine)
          ..add('trailingSlash', trailingSlash)
          ..add('exchangeRateApiNotConfigured', exchangeRateApiNotConfigured)
          ..add('queue', queue))
        .toString();
  }
}

class HealthCheckResponseBuilder
    implements Builder<HealthCheckResponse, HealthCheckResponseBuilder> {
  _$HealthCheckResponse? _$v;

  bool? _systemHealth;
  bool? get systemHealth => _$this._systemHealth;
  set systemHealth(bool? systemHealth) => _$this._systemHealth = systemHealth;

  HealthCheckPHPResponseBuilder? _phpVersion;
  HealthCheckPHPResponseBuilder get phpVersion =>
      _$this._phpVersion ??= new HealthCheckPHPResponseBuilder();
  set phpVersion(HealthCheckPHPResponseBuilder? phpVersion) =>
      _$this._phpVersion = phpVersion;

  bool? _envWritable;
  bool? get envWritable => _$this._envWritable;
  set envWritable(bool? envWritable) => _$this._envWritable = envWritable;

  bool? _dbCheck;
  bool? get dbCheck => _$this._dbCheck;
  set dbCheck(bool? dbCheck) => _$this._dbCheck = dbCheck;

  bool? _cacheEnabled;
  bool? get cacheEnabled => _$this._cacheEnabled;
  set cacheEnabled(bool? cacheEnabled) => _$this._cacheEnabled = cacheEnabled;

  bool? _phantomEnabled;
  bool? get phantomEnabled => _$this._phantomEnabled;
  set phantomEnabled(bool? phantomEnabled) =>
      _$this._phantomEnabled = phantomEnabled;

  bool? _openBasedir;
  bool? get openBasedir => _$this._openBasedir;
  set openBasedir(bool? openBasedir) => _$this._openBasedir = openBasedir;

  String? _filePermissions;
  String? get filePermissions => _$this._filePermissions;
  set filePermissions(String? filePermissions) =>
      _$this._filePermissions = filePermissions;

  bool? _execEnabled;
  bool? get execEnabled => _$this._execEnabled;
  set execEnabled(bool? execEnabled) => _$this._execEnabled = execEnabled;

  String? _emailDriver;
  String? get emailDriver => _$this._emailDriver;
  set emailDriver(String? emailDriver) => _$this._emailDriver = emailDriver;

  int? _pendingJobs;
  int? get pendingJobs => _$this._pendingJobs;
  set pendingJobs(int? pendingJobs) => _$this._pendingJobs = pendingJobs;

  String? _pdfEngine;
  String? get pdfEngine => _$this._pdfEngine;
  set pdfEngine(String? pdfEngine) => _$this._pdfEngine = pdfEngine;

  bool? _trailingSlash;
  bool? get trailingSlash => _$this._trailingSlash;
  set trailingSlash(bool? trailingSlash) =>
      _$this._trailingSlash = trailingSlash;

  bool? _exchangeRateApiNotConfigured;
  bool? get exchangeRateApiNotConfigured =>
      _$this._exchangeRateApiNotConfigured;
  set exchangeRateApiNotConfigured(bool? exchangeRateApiNotConfigured) =>
      _$this._exchangeRateApiNotConfigured = exchangeRateApiNotConfigured;

  String? _queue;
  String? get queue => _$this._queue;
  set queue(String? queue) => _$this._queue = queue;

  HealthCheckResponseBuilder() {
    HealthCheckResponse._initializeBuilder(this);
  }

  HealthCheckResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _systemHealth = $v.systemHealth;
      _phpVersion = $v.phpVersion.toBuilder();
      _envWritable = $v.envWritable;
      _dbCheck = $v.dbCheck;
      _cacheEnabled = $v.cacheEnabled;
      _phantomEnabled = $v.phantomEnabled;
      _openBasedir = $v.openBasedir;
      _filePermissions = $v.filePermissions;
      _execEnabled = $v.execEnabled;
      _emailDriver = $v.emailDriver;
      _pendingJobs = $v.pendingJobs;
      _pdfEngine = $v.pdfEngine;
      _trailingSlash = $v.trailingSlash;
      _exchangeRateApiNotConfigured = $v.exchangeRateApiNotConfigured;
      _queue = $v.queue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthCheckResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HealthCheckResponse;
  }

  @override
  void update(void Function(HealthCheckResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealthCheckResponse build() => _build();

  _$HealthCheckResponse _build() {
    _$HealthCheckResponse _$result;
    try {
      _$result = _$v ??
          new _$HealthCheckResponse._(
              systemHealth: BuiltValueNullFieldError.checkNotNull(
                  systemHealth, r'HealthCheckResponse', 'systemHealth'),
              phpVersion: phpVersion.build(),
              envWritable: BuiltValueNullFieldError.checkNotNull(
                  envWritable, r'HealthCheckResponse', 'envWritable'),
              dbCheck: BuiltValueNullFieldError.checkNotNull(
                  dbCheck, r'HealthCheckResponse', 'dbCheck'),
              cacheEnabled: BuiltValueNullFieldError.checkNotNull(
                  cacheEnabled, r'HealthCheckResponse', 'cacheEnabled'),
              phantomEnabled: BuiltValueNullFieldError.checkNotNull(
                  phantomEnabled, r'HealthCheckResponse', 'phantomEnabled'),
              openBasedir: BuiltValueNullFieldError.checkNotNull(
                  openBasedir, r'HealthCheckResponse', 'openBasedir'),
              filePermissions: BuiltValueNullFieldError.checkNotNull(
                  filePermissions, r'HealthCheckResponse', 'filePermissions'),
              execEnabled: BuiltValueNullFieldError.checkNotNull(
                  execEnabled, r'HealthCheckResponse', 'execEnabled'),
              emailDriver: BuiltValueNullFieldError.checkNotNull(emailDriver, r'HealthCheckResponse', 'emailDriver'),
              pendingJobs: BuiltValueNullFieldError.checkNotNull(pendingJobs, r'HealthCheckResponse', 'pendingJobs'),
              pdfEngine: BuiltValueNullFieldError.checkNotNull(pdfEngine, r'HealthCheckResponse', 'pdfEngine'),
              trailingSlash: BuiltValueNullFieldError.checkNotNull(trailingSlash, r'HealthCheckResponse', 'trailingSlash'),
              exchangeRateApiNotConfigured: BuiltValueNullFieldError.checkNotNull(exchangeRateApiNotConfigured, r'HealthCheckResponse', 'exchangeRateApiNotConfigured'),
              queue: BuiltValueNullFieldError.checkNotNull(queue, r'HealthCheckResponse', 'queue'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'phpVersion';
        phpVersion.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HealthCheckResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$HealthCheckPHPResponse extends HealthCheckPHPResponse {
  @override
  final String minimumPHPVersion;
  @override
  final String currentPHPVersion;
  @override
  final String currentPHPCLIVersion;
  @override
  final bool isOkay;
  @override
  final String memoryLimit;

  factory _$HealthCheckPHPResponse(
          [void Function(HealthCheckPHPResponseBuilder)? updates]) =>
      (new HealthCheckPHPResponseBuilder()..update(updates))._build();

  _$HealthCheckPHPResponse._(
      {required this.minimumPHPVersion,
      required this.currentPHPVersion,
      required this.currentPHPCLIVersion,
      required this.isOkay,
      required this.memoryLimit})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        minimumPHPVersion, r'HealthCheckPHPResponse', 'minimumPHPVersion');
    BuiltValueNullFieldError.checkNotNull(
        currentPHPVersion, r'HealthCheckPHPResponse', 'currentPHPVersion');
    BuiltValueNullFieldError.checkNotNull(currentPHPCLIVersion,
        r'HealthCheckPHPResponse', 'currentPHPCLIVersion');
    BuiltValueNullFieldError.checkNotNull(
        isOkay, r'HealthCheckPHPResponse', 'isOkay');
    BuiltValueNullFieldError.checkNotNull(
        memoryLimit, r'HealthCheckPHPResponse', 'memoryLimit');
  }

  @override
  HealthCheckPHPResponse rebuild(
          void Function(HealthCheckPHPResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealthCheckPHPResponseBuilder toBuilder() =>
      new HealthCheckPHPResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthCheckPHPResponse &&
        minimumPHPVersion == other.minimumPHPVersion &&
        currentPHPVersion == other.currentPHPVersion &&
        currentPHPCLIVersion == other.currentPHPCLIVersion &&
        isOkay == other.isOkay &&
        memoryLimit == other.memoryLimit;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, minimumPHPVersion.hashCode);
    _$hash = $jc(_$hash, currentPHPVersion.hashCode);
    _$hash = $jc(_$hash, currentPHPCLIVersion.hashCode);
    _$hash = $jc(_$hash, isOkay.hashCode);
    _$hash = $jc(_$hash, memoryLimit.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealthCheckPHPResponse')
          ..add('minimumPHPVersion', minimumPHPVersion)
          ..add('currentPHPVersion', currentPHPVersion)
          ..add('currentPHPCLIVersion', currentPHPCLIVersion)
          ..add('isOkay', isOkay)
          ..add('memoryLimit', memoryLimit))
        .toString();
  }
}

class HealthCheckPHPResponseBuilder
    implements Builder<HealthCheckPHPResponse, HealthCheckPHPResponseBuilder> {
  _$HealthCheckPHPResponse? _$v;

  String? _minimumPHPVersion;
  String? get minimumPHPVersion => _$this._minimumPHPVersion;
  set minimumPHPVersion(String? minimumPHPVersion) =>
      _$this._minimumPHPVersion = minimumPHPVersion;

  String? _currentPHPVersion;
  String? get currentPHPVersion => _$this._currentPHPVersion;
  set currentPHPVersion(String? currentPHPVersion) =>
      _$this._currentPHPVersion = currentPHPVersion;

  String? _currentPHPCLIVersion;
  String? get currentPHPCLIVersion => _$this._currentPHPCLIVersion;
  set currentPHPCLIVersion(String? currentPHPCLIVersion) =>
      _$this._currentPHPCLIVersion = currentPHPCLIVersion;

  bool? _isOkay;
  bool? get isOkay => _$this._isOkay;
  set isOkay(bool? isOkay) => _$this._isOkay = isOkay;

  String? _memoryLimit;
  String? get memoryLimit => _$this._memoryLimit;
  set memoryLimit(String? memoryLimit) => _$this._memoryLimit = memoryLimit;

  HealthCheckPHPResponseBuilder() {
    HealthCheckPHPResponse._initializeBuilder(this);
  }

  HealthCheckPHPResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _minimumPHPVersion = $v.minimumPHPVersion;
      _currentPHPVersion = $v.currentPHPVersion;
      _currentPHPCLIVersion = $v.currentPHPCLIVersion;
      _isOkay = $v.isOkay;
      _memoryLimit = $v.memoryLimit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthCheckPHPResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HealthCheckPHPResponse;
  }

  @override
  void update(void Function(HealthCheckPHPResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealthCheckPHPResponse build() => _build();

  _$HealthCheckPHPResponse _build() {
    final _$result = _$v ??
        new _$HealthCheckPHPResponse._(
            minimumPHPVersion: BuiltValueNullFieldError.checkNotNull(
                minimumPHPVersion,
                r'HealthCheckPHPResponse',
                'minimumPHPVersion'),
            currentPHPVersion: BuiltValueNullFieldError.checkNotNull(
                currentPHPVersion,
                r'HealthCheckPHPResponse',
                'currentPHPVersion'),
            currentPHPCLIVersion:
                BuiltValueNullFieldError
                    .checkNotNull(currentPHPCLIVersion,
                        r'HealthCheckPHPResponse', 'currentPHPCLIVersion'),
            isOkay: BuiltValueNullFieldError.checkNotNull(
                isOkay, r'HealthCheckPHPResponse', 'isOkay'),
            memoryLimit: BuiltValueNullFieldError.checkNotNull(
                memoryLimit, r'HealthCheckPHPResponse', 'memoryLimit'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
