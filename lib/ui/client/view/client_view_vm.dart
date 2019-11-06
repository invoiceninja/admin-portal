import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/client/client_screen.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class ClientViewScreen extends StatelessWidget {
  const ClientViewScreen({Key key}) : super(key: key);

  static const String route = '/client/view';

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
  ClientViewVM({
    @required this.state,
    @required this.client,
    @required this.company,
    @required this.onEntityAction,
    @required this.onEntityPressed,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onRefreshed,
  });

  factory ClientViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final client = state.clientState.map[state.clientUIState.selectedId] ??
        ClientEntity(id: state.clientUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context, bool loadActivities) {
      final completer = snackBarCompleter(
          context, AppLocalization
          .of(context)
          .refreshComplete);
      store.dispatch(LoadClient(
          completer: completer,
          clientId: client.id,
          loadActivities: loadActivities));
      return completer.future;
    }

    return ClientViewVM(
      state: state,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: client.isNew,
      client: client,
      company: state.selectedCompany,
      onEditPressed: (BuildContext context) {
        final Completer<ClientEntity> completer = Completer<ClientEntity>();
        store.dispatch(
            EditClient(client: client, context: context, completer: completer));
        completer.future.then((client) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
                message: AppLocalization
                    .of(context)
                    .updatedClient,
              )));
        });
      },
      onEntityPressed: (BuildContext context, EntityType entityType,
          [longPress = false]) {
        switch (entityType) {
          case EntityType.invoice:
            if (longPress && client.isActive) {
              store.dispatch(EditInvoice(
                  context: context,
                  invoice: InvoiceEntity(company: state.selectedCompany)));
              store.dispatch(UpdateInvoiceClient(client: client));
            } else {
              store.dispatch(FilterInvoicesByEntity(
                  entityId: client.id, entityType: EntityType.client));
              store.dispatch(ViewInvoiceList(context: context));
            }
            break;
          case EntityType.quote:
            if (longPress && client.isActive) {
              store.dispatch(EditQuote(
                  context: context,
                  quote: InvoiceEntity(
                      company: state.selectedCompany, isQuote: true)));
              store.dispatch(UpdateQuoteClient(client: client));
            } else {
              store.dispatch(FilterQuotesByEntity(
                  entityId: client.id, entityType: EntityType.client));
              store.dispatch(ViewQuoteList(context: context));
            }
            break;
          case EntityType.payment:
            if (longPress && client.isActive) {
              store.dispatch(EditPayment(
                  context: context,
                  payment: PaymentEntity(company: state.selectedCompany)
                      .rebuild((b) => b..clientId = client.id)));
            } else {
              store.dispatch(FilterPaymentsByEntity(
                  entityId: client.id, entityType: EntityType.client));
              store.dispatch(ViewPaymentList(context: context));
            }
            break;
          case EntityType.project:
            if (longPress && client.isActive) {
              store.dispatch(EditProject(
                  context: context,
                  project:
                  ProjectEntity().rebuild((b) => b..clientId = client.id)));
            } else {
              store.dispatch(FilterProjectsByEntity(
                  entityId: client.id, entityType: EntityType.client));
              store.dispatch(ViewProjectList(context: context));
            }
            break;
          case EntityType.task:
            if (longPress && client.isActive) {
              store.dispatch(EditTask(
                  context: context,
                  task: TaskEntity(isRunning: state.uiState.autoStartTasks)
                      .rebuild((b) => b..clientId = client.id)));
            } else {
              store.dispatch(FilterTasksByEntity(
                  entityId: client.id, entityType: EntityType.client));
              store.dispatch(ViewTaskList(context: context));
            }
            break;
          case EntityType.expense:
            if (longPress && client.isActive) {
              store.dispatch(EditExpense(
                  context: context,
                  expense: ExpenseEntity(
                      company: state.selectedCompany,
                      client: client,
                      uiState: state.uiState)));
            } else {
              store.dispatch(FilterExpensesByEntity(
                  entityId: client.id, entityType: EntityType.client));
              store.dispatch(ViewExpenseList(context: context));
            }
            break;
        }
      },
      onRefreshed: (context, loadActivities) =>
          _handleRefresh(context, loadActivities),
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(ClientScreen.route)) {
          store.dispatch(UpdateCurrentRoute(ClientScreen.route));
        }
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleClientAction(context, [client], action),
    );
  }

  final AppState state;
  final ClientEntity client;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onEditPressed;
  final Function onBackPressed;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function(BuildContext, bool) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;

  @override
  bool operator ==(dynamic other) =>
      client == other.client && company == other.company;

  @override
  int get hashCode => client.hashCode ^ company.hashCode;
}
