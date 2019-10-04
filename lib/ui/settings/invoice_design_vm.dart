import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/settings/invoice_design.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoiceDesignScreen extends StatelessWidget {
  const InvoiceDesignScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsInvoiceDesign';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceDesignVM>(
      converter: InvoiceDesignVM.fromStore,
      builder: (context, viewModel) {
        return InvoiceDesign(
          viewModel: viewModel,
          key: ValueKey(viewModel.state.settingsUIState.updatedAt),
        );
      },
    );
  }
}

class InvoiceDesignVM {
  InvoiceDesignVM({
    @required this.state,
    @required this.onSavePressed,
    @required this.onCancelPressed,
  });

  static InvoiceDesignVM fromStore(Store<AppState> store) {
    final state = store.state;

    return InvoiceDesignVM(
      state: state,
      onSavePressed: null,
      onCancelPressed: null,
    );
  }

  final AppState state;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
}
