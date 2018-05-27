import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

@immutable
class DashboardState {
  bool isLoading;
  int lastUpdated;
  DashboardEntity data;

  DashboardState(
      {this.isLoading = false,
        this.lastUpdated = 0,
        DashboardEntity data}) :
        data = data ?? DashboardEntity();

  //factory AppState.loading() => AppState(isLoading: true);

  DashboardState copyWith({
    bool isLoading,
    int lastUpdated,
    DashboardEntity data,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      data: data ?? this.data,
    );
  }

  @override
  int get hashCode =>
      data.hashCode ^
      lastUpdated.hashCode ^
      isLoading.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is DashboardState &&
              runtimeType == other.runtimeType &&
              data == other.data &&
              lastUpdated == other.lastUpdated &&
              isLoading == other.isLoading;

  @override
  String toString() {
    return 'DashboardState {isLoading: $isLoading}';
  }
}