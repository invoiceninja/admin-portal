import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja/ui/client/client_screen.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/client/view/client_view.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';

class ClientViewScreen extends StatelessWidget {
  static const String route = '/client/view';
  const ClientViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientViewVM>(
      converter: (Store<AppState> store) {
        return ClientViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ClientView(
          viewModel: vm,
        );
      },
    );
  }
}

class ClientViewVM {
  final ClientEntity client;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext) onEditPressed;
  final Function onBackPressed;
  final Function(BuildContext) onInvoicesPressed;
  final bool isSaving;
  final bool isDirty;

  ClientViewVM({
    @required this.client,
    @required this.company,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.onInvoicesPressed,
    @required this.onBackPressed,
    @required this.isSaving,
    @required this.isDirty,
  });

  factory ClientViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final client = state.clientState.map[state.clientUIState.selectedId];

    return ClientViewVM(
        isSaving: state.isSaving,
        isDirty: client.isNew,
        client: client,
        company: state.selectedCompany,
        onEditPressed: (BuildContext context) {
          store.dispatch(EditClient(client: client, context: context));
        },
        onInvoicesPressed: (BuildContext context) {
          store.dispatch(FilterInvoicesByClient(client.id));
          store.dispatch(ViewInvoiceList(context));
        },
        onBackPressed: () =>
            store.dispatch(UpdateCurrentRoute(ClientScreen.route)),
        onActionSelected: (BuildContext context, EntityAction action) {
          final Completer<Null> completer = new Completer<Null>();
          var message = '';
          switch (action) {
            case EntityAction.archive:
              store.dispatch(ArchiveClientRequest(completer, client.id));
              message = AppLocalization.of(context).successfullyArchivedClient;
              break;
            case EntityAction.delete:
              store.dispatch(DeleteClientRequest(completer, client.id));
              message = AppLocalization.of(context).successfullyDeletedClient;
              break;
            case EntityAction.restore:
              store.dispatch(RestoreClientRequest(completer, client.id));
              message = AppLocalization.of(context).successfullyRestoredClient;
              break;
          }
          return completer.future.then((_) {
            if ([EntityAction.archive, EntityAction.delete].contains(action)) {
              Navigator.of(context).pop(message);
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: SnackBarRow(
                    message: message,
                  )
              ));
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
  }
}
