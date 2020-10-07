import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
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
    );
  }

  DashboardUISettings._();

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

  static Serializer<DashboardUISettings> get serializer =>
      _$dashboardUISettingsSerializer;

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
}
