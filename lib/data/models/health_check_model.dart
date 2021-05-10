import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_check_model.g.dart';

abstract class HealthCheckResponse
    implements Built<HealthCheckResponse, HealthCheckResponseBuilder> {
  factory HealthCheckResponse() {
    return _$HealthCheckResponse._();
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

  @BuiltValueField(wireName: 'exec')
  bool get execEnabled;

  @BuiltValueField(wireName: 'mail_mailer')
  String get emailDriver;

  @BuiltValueField(wireName: 'jobs_pending')
  int get pendingJobs;

  static Serializer<HealthCheckResponse> get serializer =>
      _$healthCheckResponseSerializer;
}

abstract class HealthCheckPHPResponse
    implements Built<HealthCheckPHPResponse, HealthCheckPHPResponseBuilder> {
  factory HealthCheckPHPResponse() {
    return _$HealthCheckPHPResponse._();
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

  static Serializer<HealthCheckPHPResponse> get serializer =>
      _$healthCheckPHPResponseSerializer;
}
