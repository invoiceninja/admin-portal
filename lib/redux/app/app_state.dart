import 'package:meta/meta.dart';
import '../../data/models/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<ProductEntity> products;

  AppState(
      {this.isLoading = false,
        this.products = const []});

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<ProductEntity> products,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }

  @override
  int get hashCode =>
      products.hashCode ^
      isLoading.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              products == other.products &&
              isLoading == other.isLoading;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading}';
  }
}