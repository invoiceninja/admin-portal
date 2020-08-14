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
  Iterable<Object> serialize(
      Serializers serializers, HealthCheckResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
      'npm_status',
      serializers.serialize(object.npmStatus,
          specifiedType: const FullType(String)),
      'node_status',
      serializers.serialize(object.nodeStatus,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  HealthCheckResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HealthCheckResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'system_health':
          result.systemHealth = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'php_version':
          result.phpVersion.replace(serializers.deserialize(value,
                  specifiedType: const FullType(HealthCheckPHPResponse))
              as HealthCheckPHPResponse);
          break;
        case 'env_writable':
          result.envWritable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'simple_db_check':
          result.dbCheck = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'npm_status':
          result.npmStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'node_status':
          result.nodeStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
  Iterable<Object> serialize(
      Serializers serializers, HealthCheckPHPResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'minimum_php_version',
      serializers.serialize(object.minimumPHPVersion,
          specifiedType: const FullType(String)),
      'current_php_version',
      serializers.serialize(object.currentPHPVersion,
          specifiedType: const FullType(String)),
      'is_okay',
      serializers.serialize(object.isOkay, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  HealthCheckPHPResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HealthCheckPHPResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'minimum_php_version':
          result.minimumPHPVersion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'current_php_version':
          result.currentPHPVersion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_okay':
          result.isOkay = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
  final String npmStatus;
  @override
  final String nodeStatus;

  factory _$HealthCheckResponse(
          [void Function(HealthCheckResponseBuilder) updates]) =>
      (new HealthCheckResponseBuilder()..update(updates)).build();

  _$HealthCheckResponse._(
      {this.systemHealth,
      this.phpVersion,
      this.envWritable,
      this.dbCheck,
      this.npmStatus,
      this.nodeStatus})
      : super._() {
    if (systemHealth == null) {
      throw new BuiltValueNullFieldError('HealthCheckResponse', 'systemHealth');
    }
    if (phpVersion == null) {
      throw new BuiltValueNullFieldError('HealthCheckResponse', 'phpVersion');
    }
    if (envWritable == null) {
      throw new BuiltValueNullFieldError('HealthCheckResponse', 'envWritable');
    }
    if (dbCheck == null) {
      throw new BuiltValueNullFieldError('HealthCheckResponse', 'dbCheck');
    }
    if (npmStatus == null) {
      throw new BuiltValueNullFieldError('HealthCheckResponse', 'npmStatus');
    }
    if (nodeStatus == null) {
      throw new BuiltValueNullFieldError('HealthCheckResponse', 'nodeStatus');
    }
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
        npmStatus == other.npmStatus &&
        nodeStatus == other.nodeStatus;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, systemHealth.hashCode), phpVersion.hashCode),
                    envWritable.hashCode),
                dbCheck.hashCode),
            npmStatus.hashCode),
        nodeStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HealthCheckResponse')
          ..add('systemHealth', systemHealth)
          ..add('phpVersion', phpVersion)
          ..add('envWritable', envWritable)
          ..add('dbCheck', dbCheck)
          ..add('npmStatus', npmStatus)
          ..add('nodeStatus', nodeStatus))
        .toString();
  }
}

class HealthCheckResponseBuilder
    implements Builder<HealthCheckResponse, HealthCheckResponseBuilder> {
  _$HealthCheckResponse _$v;

  bool _systemHealth;
  bool get systemHealth => _$this._systemHealth;
  set systemHealth(bool systemHealth) => _$this._systemHealth = systemHealth;

  HealthCheckPHPResponseBuilder _phpVersion;
  HealthCheckPHPResponseBuilder get phpVersion =>
      _$this._phpVersion ??= new HealthCheckPHPResponseBuilder();
  set phpVersion(HealthCheckPHPResponseBuilder phpVersion) =>
      _$this._phpVersion = phpVersion;

  bool _envWritable;
  bool get envWritable => _$this._envWritable;
  set envWritable(bool envWritable) => _$this._envWritable = envWritable;

  bool _dbCheck;
  bool get dbCheck => _$this._dbCheck;
  set dbCheck(bool dbCheck) => _$this._dbCheck = dbCheck;

  String _npmStatus;
  String get npmStatus => _$this._npmStatus;
  set npmStatus(String npmStatus) => _$this._npmStatus = npmStatus;

  String _nodeStatus;
  String get nodeStatus => _$this._nodeStatus;
  set nodeStatus(String nodeStatus) => _$this._nodeStatus = nodeStatus;

  HealthCheckResponseBuilder();

  HealthCheckResponseBuilder get _$this {
    if (_$v != null) {
      _systemHealth = _$v.systemHealth;
      _phpVersion = _$v.phpVersion?.toBuilder();
      _envWritable = _$v.envWritable;
      _dbCheck = _$v.dbCheck;
      _npmStatus = _$v.npmStatus;
      _nodeStatus = _$v.nodeStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthCheckResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HealthCheckResponse;
  }

  @override
  void update(void Function(HealthCheckResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HealthCheckResponse build() {
    _$HealthCheckResponse _$result;
    try {
      _$result = _$v ??
          new _$HealthCheckResponse._(
              systemHealth: systemHealth,
              phpVersion: phpVersion.build(),
              envWritable: envWritable,
              dbCheck: dbCheck,
              npmStatus: npmStatus,
              nodeStatus: nodeStatus);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'phpVersion';
        phpVersion.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HealthCheckResponse', _$failedField, e.toString());
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
  final bool isOkay;

  factory _$HealthCheckPHPResponse(
          [void Function(HealthCheckPHPResponseBuilder) updates]) =>
      (new HealthCheckPHPResponseBuilder()..update(updates)).build();

  _$HealthCheckPHPResponse._(
      {this.minimumPHPVersion, this.currentPHPVersion, this.isOkay})
      : super._() {
    if (minimumPHPVersion == null) {
      throw new BuiltValueNullFieldError(
          'HealthCheckPHPResponse', 'minimumPHPVersion');
    }
    if (currentPHPVersion == null) {
      throw new BuiltValueNullFieldError(
          'HealthCheckPHPResponse', 'currentPHPVersion');
    }
    if (isOkay == null) {
      throw new BuiltValueNullFieldError('HealthCheckPHPResponse', 'isOkay');
    }
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
        isOkay == other.isOkay;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc($jc(0, minimumPHPVersion.hashCode), currentPHPVersion.hashCode),
        isOkay.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HealthCheckPHPResponse')
          ..add('minimumPHPVersion', minimumPHPVersion)
          ..add('currentPHPVersion', currentPHPVersion)
          ..add('isOkay', isOkay))
        .toString();
  }
}

class HealthCheckPHPResponseBuilder
    implements Builder<HealthCheckPHPResponse, HealthCheckPHPResponseBuilder> {
  _$HealthCheckPHPResponse _$v;

  String _minimumPHPVersion;
  String get minimumPHPVersion => _$this._minimumPHPVersion;
  set minimumPHPVersion(String minimumPHPVersion) =>
      _$this._minimumPHPVersion = minimumPHPVersion;

  String _currentPHPVersion;
  String get currentPHPVersion => _$this._currentPHPVersion;
  set currentPHPVersion(String currentPHPVersion) =>
      _$this._currentPHPVersion = currentPHPVersion;

  bool _isOkay;
  bool get isOkay => _$this._isOkay;
  set isOkay(bool isOkay) => _$this._isOkay = isOkay;

  HealthCheckPHPResponseBuilder();

  HealthCheckPHPResponseBuilder get _$this {
    if (_$v != null) {
      _minimumPHPVersion = _$v.minimumPHPVersion;
      _currentPHPVersion = _$v.currentPHPVersion;
      _isOkay = _$v.isOkay;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthCheckPHPResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HealthCheckPHPResponse;
  }

  @override
  void update(void Function(HealthCheckPHPResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HealthCheckPHPResponse build() {
    final _$result = _$v ??
        new _$HealthCheckPHPResponse._(
            minimumPHPVersion: minimumPHPVersion,
            currentPHPVersion: currentPHPVersion,
            isOkay: isOkay);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
