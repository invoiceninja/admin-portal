import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'reports_state.g.dart';

abstract class ReportsUIState
    implements Built<ReportsUIState, ReportsUIStateBuilder> {
  factory ReportsUIState() {
    return _$ReportsUIState._(
      dateRange: DateRange.last30Days,
      customStartDate: '',
      customEndDate: convertDateTimeToSqlDate(),
      currencyId: kCurrencyAll,
    );
  }

  ReportsUIState._();

  DateRange get dateRange;

  String get customStartDate;

  String get customEndDate;

  String get currencyId;

  static Serializer<ReportsUIState> get serializer =>
      _$reportsUIStateSerializer;

  bool matchesCurrency(String match) {
    if (currencyId == null ||
        currencyId.isEmpty ||
        currencyId == kCurrencyAll) {
      return true;
    }

    return currencyId == match;
  }
}
