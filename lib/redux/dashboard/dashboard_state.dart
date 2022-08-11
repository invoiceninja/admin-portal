// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/dates.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'dashboard_state.g.dart';

abstract class DashboardUIState
    implements Built<DashboardUIState, DashboardUIStateBuilder> {
  factory DashboardUIState() {
    return _$DashboardUIState._(
      settings: DashboardUISettings(),
      selectedEntities: BuiltMap<EntityType, BuiltList<String>>(),
      selectedEntityType: EntityType.invoice,
      showSidebar: true,
    );
  }

  DashboardUIState._();

  @override
  @memoized
  int get hashCode;

  DashboardUISettings get settings;

  EntityType get selectedEntityType;

  BuiltMap<EntityType, BuiltList<String>> get selectedEntities;

  bool get showSidebar;

  static Serializer<DashboardUIState> get serializer =>
      _$dashboardUIStateSerializer;
}

abstract class DashboardUISettings
    implements Built<DashboardUISettings, DashboardUISettingsBuilder> {
  factory DashboardUISettings() {
    return _$DashboardUISettings._(
      dateRange: DateRange.last30Days,
      customStartDate: '',
      customEndDate: convertDateTimeToSqlDate(),
      enableComparison: true,
      compareDateRange: DateRangeComparison.previousPeriod,
      compareCustomStartDate: '',
      compareCustomEndDate: convertDateTimeToSqlDate(),
      offset: 0,
      currencyId: kCurrencyAll,
      includeTaxes: true,
      groupBy: kReportGroupDay,
      showCurrentPeriod: true,
      showPreviousPeriod: false,
      showTotal: true,
      totalFields: BuiltList<String>(<String>[
        FIELD_COMPLETED_PAYMENTS,
        FIELD_OUTSTANDING_INVOICES,
      ]),
    );
  }

  DashboardUISettings._();

  static const String FIELD_ACTIVE_INVOICES = 'active_invoices';
  static const String FIELD_OUTSTANDING_INVOICES = 'outstanding_invoices';
  static const String FIELD_COMPLETED_PAYMENTS = 'completed_payments';
  static const String FIELD_REFUNDED_PAYMENTS = 'refunded_payments';
  static const String FIELD_ACTIVE_QUOTES = 'active_quotes';
  static const String FIELD_APPROVED_QUOTES = 'approved_quotes';
  static const String FIELD_UNAPPROVED_QUOTES = 'unapproved_quotes';
  static const String FIELD_LOGGED_TASKS = 'logged_tasks';
  static const String FIELD_INVOICED_TASKS = 'invoiced_tasks';
  static const String FIELD_PAID_TASKS = 'paid_tasks';
  static const String FIELD_LOGGED_EXPENSES = 'logged_expenses';
  static const String FIELD_PENDING_EXPENSES = 'pending_expenses';
  static const String FIELD_INVOICED_EXPENSES = 'invoiced_expenses';
  static const String FIELD_INVOICE_PAID_EXPENSES = 'invoice_paid_expenses';

  @override
  @memoized
  int get hashCode;

  DateRange get dateRange;

  String get customStartDate;

  String get customEndDate;

  bool get enableComparison;

  DateRangeComparison get compareDateRange;

  String get compareCustomStartDate;

  String get compareCustomEndDate;

  int get offset;

  String get currencyId;

  bool get includeTaxes;

  String get groupBy;

  bool get showCurrentPeriod;

  bool get showPreviousPeriod;

  bool get showTotal;

  BuiltList<String> get totalFields;

  bool matchesCurrency(String match) {
    if (currencyId == null ||
        currencyId.isEmpty ||
        currencyId == kCurrencyAll) {
      return true;
    }

    return currencyId == match;
  }

  String startDate(CompanyEntity company) {
    return calculateStartDate(
      company: company,
      offset: offset,
      customEndDate: customEndDate,
      customStartDate: customStartDate,
      dateRange: dateRange,
    );
  }

  String endDate(CompanyEntity company) {
    return calculateEndDate(
      company: company,
      offset: offset,
      customEndDate: customEndDate,
      customStartDate: customStartDate,
      dateRange: dateRange,
    );
  }

  // ignore: unused_element
  static void _initializeBuilder(DashboardUISettingsBuilder builder) => builder
    ..groupBy = kReportGroupDay
    ..showTotal = true
    ..showPreviousPeriod = false
    ..showCurrentPeriod = true
    ..totalFields.replace(BuiltList<String>());

  static Serializer<DashboardUISettings> get serializer =>
      _$dashboardUISettingsSerializer;
}
