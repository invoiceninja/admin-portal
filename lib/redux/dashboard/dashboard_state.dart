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

  BuiltMap<EntityType?, BuiltList<String>> get selectedEntities;

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
    );
  }

  DashboardUISettings._();

  static const String FIELD_ACTIVE_INVOICES = 'total_active_invoices';
  static const String FIELD_OUTSTANDING_INVOICES = 'total_outstanding_invoices';
  static const String FIELD_COMPLETED_PAYMENTS = 'total_completed_payments';
  static const String FIELD_REFUNDED_PAYMENTS = 'total_refunded_payments';
  static const String FIELD_ACTIVE_QUOTES = 'total_active_quotes';
  static const String FIELD_APPROVED_QUOTES = 'total_approved_quotes';
  static const String FIELD_UNAPPROVED_QUOTES = 'total_unapproved_quotes';
  static const String FIELD_INVOICED_QUOTES = 'total_invoiced_quotes';
  static const String FIELD_INVOICE_PAID_QUOTES = 'total_invoice_paid_quotes';
  static const String FIELD_LOGGED_TASKS = 'total_logged_tasks';
  static const String FIELD_INVOICED_TASKS = 'total_invoiced_tasks';
  static const String FIELD_PAID_TASKS = 'total_paid_tasks';
  static const String FIELD_LOGGED_EXPENSES = 'total_logged_expenses';
  static const String FIELD_PENDING_EXPENSES = 'total_pending_expenses';
  static const String FIELD_INVOICED_EXPENSES = 'total_invoiced_expenses';
  static const String FIELD_INVOICE_PAID_EXPENSES =
      'total_invoice_paid_expenses';

  static const String PERIOD_CURRENT = 'current_period';
  static const String PERIOD_PREVIOUS = 'previous_period';
  static const String PERIOD_TOTAL = 'total';

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

  bool matchesCurrency(String? match) {
    if (currencyId.isEmpty || currencyId == kCurrencyAll) {
      return true;
    }

    return currencyId == match;
  }

  String? startDate(CompanyEntity company) {
    return calculateStartDate(
      company: company,
      offset: offset,
      customEndDate: customEndDate,
      customStartDate: customStartDate,
      dateRange: dateRange,
    );
  }

  String? endDate(CompanyEntity company) {
    return calculateEndDate(
      company: company,
      offset: offset,
      customEndDate: customEndDate,
      customStartDate: customStartDate,
      dateRange: dateRange,
    );
  }

  // ignore: unused_element
  static void _initializeBuilder(DashboardUISettingsBuilder builder) =>
      builder..groupBy = kReportGroupDay;

  static Serializer<DashboardUISettings> get serializer =>
      _$dashboardUISettingsSerializer;
}
