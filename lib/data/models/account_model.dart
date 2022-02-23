// Package imports:
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:version/version.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

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
      disableAutoUpdate: false,
      isMigrated: false,
      defaultCompanyId: '',
      trialPlan: '',
      trialStarted: '',
      hostedClientCount: 0,
      hostedCompanyCount: 1,
    );
  }

  AccountEntity._();

  @override
  @memoized
  int get hashCode;

  String get id;

  @BuiltValueField(wireName: 'trial_plan')
  String get trialPlan;

  @BuiltValueField(wireName: 'trial_started')
  String get trialStarted;

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

  @BuiltValueField(wireName: 'is_migrated')
  bool get isMigrated;

  @BuiltValueField(wireName: 'is_scheduler_running')
  bool get isSchedulerRunning;

  @BuiltValueField(wireName: 'disable_auto_update')
  bool get disableAutoUpdate;

  @BuiltValueField(wireName: 'default_company_id')
  String get defaultCompanyId;

  @BuiltValueField(wireName: 'hosted_client_count')
  int get hostedClientCount;

  @BuiltValueField(wireName: 'hosted_company_count')
  int get hostedCompanyCount;

  bool get isUpdateAvailable {
    if (!isSchedulerRunning || disableAutoUpdate) {
      return false;
    }

    return Version.parse(currentVersion) < Version.parse(latestVersion);
  }

  bool get isTrial => trialPlan.isNotEmpty;

  bool get isEligibleForTrial => trialStarted.isEmpty && plan == kPlanFree;

  // ignore: unused_element
  static void _initializeBuilder(AccountEntityBuilder builder) => builder
    ..debugEnabled = false
    ..isDocker = false
    ..isSchedulerRunning = false
    ..disableAutoUpdate = false
    ..isMigrated = false
    ..trialPlan = ''
    ..trialStarted = ''
    ..defaultCompanyId = ''
    ..hostedClientCount = 0
    ..hostedCompanyCount = 1;

  static Serializer<AccountEntity> get serializer => _$accountEntitySerializer;
}
