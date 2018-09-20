import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'dashboard_state.g.dart';

abstract class DashboardState implements Built<DashboardState, DashboardStateBuilder> {

  factory DashboardState() {
    return _$DashboardState._(
      data: null,
    );
  }
  DashboardState._();

  @nullable
  int get lastUpdated;

  @nullable
  DashboardEntity get data;


  bool get isStale {
    if (! isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated > kMillisecondsToRefreshData;
  }

  bool get isLoaded {
    return lastUpdated != null && lastUpdated > 0;
  }

  static Serializer<DashboardState> get serializer => _$dashboardStateSerializer;
}


abstract class DashboardUIState implements Built<DashboardUIState, DashboardUIStateBuilder> {

  factory DashboardUIState() {
    return _$DashboardUIState._(
      dateRange: DateRange.last30Days,
      startDate: '',
      endDate: convertDateTimeToSqlDate(),
      enableComparison: true,
      compareDateRange: DateRangeComparison.previousPeriod,
      compareStartDate: '',
      compareEndDate: convertDateTimeToSqlDate(),
    );
  }
  DashboardUIState._();

  DateRange get dateRange;
  String get startDate;
  String get endDate;
  bool get enableComparison;
  DateRangeComparison get compareDateRange;
  String get compareStartDate;
  String get compareEndDate;

  static Serializer<DashboardUIState> get serializer => _$dashboardUIStateSerializer;
}

