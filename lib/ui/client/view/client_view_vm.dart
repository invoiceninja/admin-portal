import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/client/client_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';

class ClientViewScreen extends StatelessWidget {
  static const String route = '/client/view';

  const ClientViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientViewVM>(
      distinct: true,
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
  final Function(BuildContext) onQuotesPressed;
  final Function(BuildContext, bool) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;

  ClientViewVM({
    @required this.client,
    @required this.company,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.onInvoicesPressed,
    @required this.onQuotesPressed,
    @required this.onBackPressed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onRefreshed,
  });

  factory ClientViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final client = state.clientState.map[state.clientUIState.selectedId];

    Future<Null> _handleRefresh(BuildContext context, bool loadActivities) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadClient(
          completer: completer,
          clientId: client.id,
          loadActivities: loadActivities));
      return completer.future;
    }

    return ClientViewVM(
        isSaving: state.isSaving,
        isLoading: state.isLoading,
        isDirty: client.isNew,
        client: client,
        company: state.selectedCompany,
        onEditPressed: (BuildContext context) {
          final Completer<ClientEntity> completer = Completer<ClientEntity>();
          store.dispatch(EditClient(
              client: client, context: context, completer: completer));
          completer.future.then((client) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
              message: AppLocalization.of(context).updatedClient,
            )));
          });
        },
        onInvoicesPressed: (BuildContext context) {
          store.dispatch(FilterInvoicesByClient(client.id));
          store.dispatch(ViewInvoiceList(context));
        },
        onQuotesPressed: (BuildContext context) {
          store.dispatch(FilterQuotesByClient(client.id));
          store.dispatch(ViewQuoteList(context));
        },
        onRefreshed: (context, loadActivities) =>
            _handleRefresh(context, loadActivities),
        onBackPressed: () =>
            store.dispatch(UpdateCurrentRoute(ClientScreen.route)),
        onActionSelected: (BuildContext context, EntityAction action) {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.archive:
              store.dispatch(ArchiveClientRequest(
                  popCompleter(context, localization.archivedClient),
                  client.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteClientRequest(
                  popCompleter(context, localization.deletedClient),
                  client.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreClientRequest(
                  snackBarCompleter(context, localization.restoredClient),
                  client.id));
              break;
          }
        });
  }

  @override
  bool operator ==(dynamic other) =>
      client == other.client && company == other.company;

  @override
  int get hashCode => client.hashCode ^ company.hashCode;
}
