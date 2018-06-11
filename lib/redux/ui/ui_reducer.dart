import 'package:invoiceninja/redux/client/client_reducer.dart';
import 'package:invoiceninja/redux/ui/ui_state.dart';
import 'package:invoiceninja/redux/product/product_reducer.dart';

UIState uiReducer(UIState state, action) {

  return state.rebuild((b) => b
    ..productUIState.replace(productUIReducer(state.productUIState, action))
    ..clientUIState.replace(clientUIReducer(state.clientUIState, action))
  );
}