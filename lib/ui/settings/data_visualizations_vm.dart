import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/data_visualizations.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class DataVisualizationsBuilder extends StatelessWidget {
  const DataVisualizationsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DataVisualizationsVM>(
      converter: DataVisualizationsVM.fromStore,
      builder: (context, viewModel) {
        return DataVisualizations(viewModel: viewModel);
      },
    );
  }
}

class DataVisualizationsVM {
  DataVisualizationsVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static DataVisualizationsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return DataVisualizationsVM(
      state: state,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
