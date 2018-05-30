import 'package:invoiceninja/redux/app/ui_state.dart';
import 'package:invoiceninja/redux/product/product_reducer.dart';

UIState uiReducer(UIState state, action) {

  return state.rebuild((b) => b
    ..productUIState.replace(productUIReducer(state.productUIState, action))
  );
}