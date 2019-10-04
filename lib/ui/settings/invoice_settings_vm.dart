import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/settings/invoice_settings.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoiceSettingsScreen extends StatelessWidget {
  const InvoiceSettingsScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsInvoiceSettings';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceSettingsVM>(
      converter: InvoiceSettingsVM.fromStore,
      builder: (context, viewModel) {
        return InvoiceSettings(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class InvoiceSettingsVM {
  InvoiceSettingsVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static InvoiceSettingsVM fromStore(Store<AppState> store) {
    final state = store.state;

    return InvoiceSettingsVM(
      state: state,
      onSavePressed: null,
      onCancelPressed: null,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
