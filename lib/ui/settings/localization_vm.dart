import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/settings/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class LocalizationBuilder extends StatelessWidget {
  const LocalizationBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LocalizationVM>(
      converter: LocalizationVM.fromStore,
      builder: (context, viewModel) {
        return Localization(viewModel: viewModel);
      },
    );
  }
}

class LocalizationVM {
  LocalizationVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static LocalizationVM fromStore(Store<AppState> store) {
    final state = store.state;

    return LocalizationVM(
      state: state,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
