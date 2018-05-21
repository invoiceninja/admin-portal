import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';

@immutable
class AppState {
  final bool isLoading;
  final AuthState auth;
  final List<ProductEntity> products;

  AppState(
      {this.isLoading = false,
        this.products = const [],
        AuthState auth}):
        auth = auth ?? new AuthState();


  factory AppState.loading() => AppState(isLoading: true);

  /*
  static AppState rehydrationJSON(dynamic json) => new AppState(
      auth: new AuthState.fromJSON(json['auth'])
  );

  Map<String, dynamic> toJson() => {
    'auth': auth.toJSON()
  };
  */

  AppState copyWith({
    bool isLoading,
    AuthState auth,
    List<ProductEntity> products,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      auth: auth ?? this.auth,
      products: products ?? this.products,
    );
  }

  @override
  int get hashCode =>
      products.hashCode ^
      auth.hashCode ^
      isLoading.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              products == other.products &&
              auth == other.auth &&
              isLoading == other.isLoading;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, url: ${auth.url}, token ${auth.token}}';
  }
}