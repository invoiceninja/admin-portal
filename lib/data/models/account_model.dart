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
  factory AccountEntity(bool reportErrors, {String? id, AppState? state}) {
    return _$AccountEntity._(
      id: '',
      key: '',
      defaultUrl: '',
      plan: '',
      planExpires: '',
      latestVersion: '',
      currentVersion: '',
      reportErrors: reportErrors,
      debugEnabled: false,
      isDocker: false,
      isHosted: false,
      accountSmsVerified: true,
      isSchedulerRunning: false,
      disableAutoUpdate: false,
      isMigrated: false,
      defaultCompanyId: '',
      trialStarted: '',
      hostedClientCount: 0,
      hostedCompanyCount: 1,
      setReactAsDefaultAP: false,
      trialDaysLeft: 0,
      hasIapPlan: false,
      paymentId: '',
      taxApiEnabled: false,
      nordigenEnabled: false,
    );
  }

  AccountEntity._();

  @override
  @memoized
  int get hashCode;

  String get id;

  String get key;

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

  @BuiltValueField(wireName: 'is_hosted')
  bool get isHosted;

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

  @BuiltValueField(wireName: 'set_react_as_default_ap')
  bool get setReactAsDefaultAP;

  @BuiltValueField(wireName: 'account_sms_verified')
  bool get accountSmsVerified;

  @BuiltValueField(wireName: 'trial_days_left')
  int get trialDaysLeft;

  @BuiltValueField(wireName: 'has_iap_plan')
  bool get hasIapPlan;

  @BuiltValueField(wireName: 'payment_id')
  String get paymentId;

  @BuiltValueField(wireName: 'tax_api_enabled')
  bool get taxApiEnabled;

  @BuiltValueField(wireName: 'nordigen_enabled')
  bool get nordigenEnabled;

  bool get isUpdateAvailable {
    if (disableAutoUpdate) {
      return false;
    }

    if (currentVersion.isEmpty || latestVersion.isEmpty) {
      return false;
    }

    return Version.parse(currentVersion) < Version.parse(latestVersion);
  }

  bool get isOld => id.isNotEmpty;

  bool get isTrial => trialDaysLeft > 0;

  bool get isEligibleForTrial => trialStarted.isEmpty && plan == kPlanFree;

  // ignore: unused_element
  static void _initializeBuilder(AccountEntityBuilder builder) => builder
    ..key = ''
    ..currentVersion = ''
    ..debugEnabled = false
    ..isDocker = false
    ..isSchedulerRunning = true
    ..disableAutoUpdate = false
    ..isMigrated = false
    ..isHosted = false
    ..hasIapPlan = false
    ..trialStarted = ''
    ..defaultCompanyId = ''
    ..trialDaysLeft = 0
    ..hostedClientCount = 0
    ..hostedCompanyCount = 1
    ..accountSmsVerified = true
    ..setReactAsDefaultAP = false
    ..paymentId = ''
    ..taxApiEnabled = false
    ..nordigenEnabled = false;

  static Serializer<AccountEntity> get serializer => _$accountEntitySerializer;
}
