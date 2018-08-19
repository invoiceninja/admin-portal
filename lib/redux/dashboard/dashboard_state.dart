import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

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
