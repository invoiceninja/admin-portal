import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_state.g.dart';

abstract class DashboardState implements Built<DashboardState, DashboardStateBuilder> {

  bool get isLoading;
  int get lastUpdated;

  @nullable
  DashboardEntity get data;

  factory DashboardState() {
    return _$DashboardState._(
      isLoading: false,
      lastUpdated: 0,
      data: null,
    );
  }

  DashboardState._();
  //factory DashboardState([updates(DashboardStateBuilder b)]) = _$DashboardState;
  static Serializer<DashboardState> get serializer => _$dashboardStateSerializer;
}
