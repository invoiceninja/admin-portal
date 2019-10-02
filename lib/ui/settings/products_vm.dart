import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/products.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ProductSettingsBuilder extends StatelessWidget {
  const ProductSettingsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductSettingsVM>(
      converter: ProductSettingsVM.fromStore,
      builder: (context, viewModel) {
        return ProductSettings(viewModel: viewModel);
      },
    );
  }
}

class ProductSettingsVM {
  ProductSettingsVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static ProductSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ProductSettingsVM(
      state: state,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
