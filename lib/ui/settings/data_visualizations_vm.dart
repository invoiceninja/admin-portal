// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/settings/data_visualizations.dart';

class DataVisualizationsScreen extends StatelessWidget {
  const DataVisualizationsScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsDataVisualizations';

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
    required this.state,
    required this.onSavePressed,
    required this.onCancelPressed,
  });

  static DataVisualizationsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return DataVisualizationsVM(
      state: state,
      onSavePressed: null,
      onCancelPressed: null,
    );
  }

  final AppState state;
  final Function(BuildContext)? onSavePressed;
  final Function(BuildContext)? onCancelPressed;
}
