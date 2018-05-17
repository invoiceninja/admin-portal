import '../../redux/app/app_state.dart';
import '../../redux/app/loading_reducer.dart';
import '../../redux/product/product_reducer.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    products: productsReducer(state.products, action),
  );
}
