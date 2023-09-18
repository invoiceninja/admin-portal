// Package imports:
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_check_model.g.dart';

abstract class HealthCheckResponse
    implements Built<HealthCheckResponse, HealthCheckResponseBuilder> {
  factory HealthCheckResponse() {
    return _$HealthCheckResponse._(
      cacheEnabled: false,
      dbCheck: false,
      emailDriver: '',
      envWritable: false,
      exchangeRateApiNotConfigured: false,
      execEnabled: false,
      filePermissions: '',
      openBasedir: false,
      pdfEngine: '',
      pendingJobs: 0,
      phantomEnabled: false,
      phpVersion: HealthCheckPHPResponse(),
      queue: '',
      systemHealth: false,
      trailingSlash: false,
    );
  }

  HealthCheckResponse._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'system_health')
  bool get systemHealth;

  @BuiltValueField(wireName: 'php_version')
  HealthCheckPHPResponse get phpVersion;

  @BuiltValueField(wireName: 'env_writable')
  bool get envWritable;

  @BuiltValueField(wireName: 'simple_db_check')
  bool get dbCheck;

  @BuiltValueField(wireName: 'cache_enabled')
  bool get cacheEnabled;

  @BuiltValueField(wireName: 'phantom_enabled')
  bool get phantomEnabled;

  @BuiltValueField(wireName: 'open_basedir')
  bool get openBasedir;

  @BuiltValueField(wireName: 'file_permissions')
  String get filePermissions;

  @BuiltValueField(wireName: 'exec')
  bool get execEnabled;

  @BuiltValueField(wireName: 'mail_mailer')
  String get emailDriver;

  @BuiltValueField(wireName: 'jobs_pending')
  int get pendingJobs;

  @BuiltValueField(wireName: 'pdf_engine')
  String get pdfEngine;

  @BuiltValueField(wireName: 'trailing_slash')
  bool get trailingSlash;

  @BuiltValueField(wireName: 'exchange_rate_api_not_configured')
  bool get exchangeRateApiNotConfigured;

  String get queue;

  // ignore: unused_element
  static void _initializeBuilder(HealthCheckResponseBuilder builder) => builder
    ..trailingSlash = false
    ..filePermissions = '';

  static Serializer<HealthCheckResponse> get serializer =>
      _$healthCheckResponseSerializer;
}

abstract class HealthCheckPHPResponse
    implements Built<HealthCheckPHPResponse, HealthCheckPHPResponseBuilder> {
  factory HealthCheckPHPResponse() {
    return _$HealthCheckPHPResponse._(
      currentPHPCLIVersion: '',
      currentPHPVersion: '',
      isOkay: false,
      memoryLimit: '',
      minimumPHPVersion: '',
    );
  }

  HealthCheckPHPResponse._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'minimum_php_version')
  String get minimumPHPVersion;

  @BuiltValueField(wireName: 'current_php_version')
  String get currentPHPVersion;

  @BuiltValueField(wireName: 'current_php_cli_version')
  String get currentPHPCLIVersion;

  @BuiltValueField(wireName: 'is_okay')
  bool get isOkay;

  @BuiltValueField(wireName: 'memory_limit')
  String get memoryLimit;

  static void _initializeBuilder(HealthCheckPHPResponseBuilder builder) =>
      builder..memoryLimit = '';

  static Serializer<HealthCheckPHPResponse> get serializer =>
      _$healthCheckPHPResponseSerializer;
}
