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
      dateRange: DateRange.last30Days,
      customStartDate: '',
      customEndDate: convertDateTimeToSqlDate(),
      enableComparison: true,
      compareDateRange: DateRangeComparison.previousPeriod,
      compareCustomStartDate: '',
      compareCustomEndDate: convertDateTimeToSqlDate(),
      offset: 0,
      currencyId: kCurrencyAll,
    );
  }

  DashboardUIState._();

  DateRange get dateRange;

  String get customStartDate;

  String get customEndDate;

  bool get enableComparison;

  DateRangeComparison get compareDateRange;

  String get compareCustomStartDate;

  String get compareCustomEndDate;

  int get offset;

  String get currencyId;

  static Serializer<DashboardUIState> get serializer =>
      _$dashboardUIStateSerializer;

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
