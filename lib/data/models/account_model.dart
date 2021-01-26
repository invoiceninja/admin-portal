import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:version/version.dart';

part 'account_model.g.dart';

abstract class AccountEntity
    implements Built<AccountEntity, AccountEntityBuilder> {
  factory AccountEntity(bool reportErrors, {String id, AppState state}) {
    return _$AccountEntity._(
      id: '',
      defaultUrl: '',
      plan: '',
      planExpires: '',
      latestVersion: '',
      currentVersion: '',
      reportErrors: reportErrors,
      debugEnabled: false,
      isDocker: false,
      isSchedulerRunning: false,
    );
  }

  AccountEntity._();

  @override
  @memoized
  int get hashCode;

  String get id;

  @BuiltValueField(wireName: 'default_url')
  String get defaultUrl;

  @BuiltValueField(wireName: 'report_errors')
  bool get reportErrors;

  String get plan;

  @BuiltValueField(wireName: 'plan_expires')
  String get planExpires;

  @BuiltValueField(wireName: 'latest_version')
  String get latestVersion;

  @BuiltValueField(wireName: 'current_version')
  String get currentVersion;

  @BuiltValueField(wireName: 'debug_enabled')
  bool get debugEnabled;

  @BuiltValueField(wireName: 'is_docker')
  bool get isDocker;

  @BuiltValueField(wireName: 'is_scheduler_running')
  bool get isSchedulerRunning;

  bool get isUpdateAvailable =>
      Version.parse(currentVersion) < Version.parse(latestVersion) &&
      isSchedulerRunning;

  // ignore: unused_element
  static void _initializeBuilder(AccountEntityBuilder builder) => builder
    ..debugEnabled = false
    ..isDocker = false
    ..isSchedulerRunning = false;

  static Serializer<AccountEntity> get serializer => _$accountEntitySerializer;
}
