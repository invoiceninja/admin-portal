import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/settings/products.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ProductSettingsScreen extends StatelessWidget {
  const ProductSettingsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsProducts';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductSettingsVM>(
      converter: ProductSettingsVM.fromStore,
      builder: (context, viewModel) {
        return ProductSettings(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
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
      onSavePressed: null,
      onCancelPressed: null,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
