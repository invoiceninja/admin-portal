import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

@immutable
class ProductState {
  final bool isLoading;
  final int lastUpdated;
  final Map<int, ProductEntity> map;
  final List<int> list;

  ProductState(
      {this.isLoading = false,
        this.lastUpdated = 0,
        Map<int, ProductEntity> map,
        List<int> list}) :
        map = map ?? Map<int, ProductEntity>(),
        list = list ?? List<int>();

  //factory AppState.loading() => AppState(isLoading: true);

  ProductState copyWith({
    bool isLoading,
    int lastUpdated,
    Map<int, ProductEntity> map,
    List<int> list,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      map: map ?? this.map,
      list: list ?? this.list,
    );
  }

  @override
  int get hashCode =>
      list.hashCode ^
      map.hashCode ^
      lastUpdated.hashCode ^
      isLoading.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ProductState &&
              runtimeType == other.runtimeType &&
              map == other.map &&
              list == other.list &&
              lastUpdated == other.lastUpdated &&
              isLoading == other.isLoading;

  @override
  String toString() {
    return 'ProductState {isLoading: $isLoading}';
  }
}