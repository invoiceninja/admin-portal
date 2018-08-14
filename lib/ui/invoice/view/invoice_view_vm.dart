import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';

class InvoiceViewScreen extends StatelessWidget {
  static const String route = '/invoice/view';

  const InvoiceViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceViewVM>(
      converter: (Store<AppState> store) {
        return InvoiceViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoiceView(
          viewModel: vm,
        );
      },
    );
  }
}

class InvoiceViewVM {
  final CompanyEntity company;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext, [InvoiceItemEntity]) onEditPressed;
  final Function(BuildContext) onClientPressed;
  final Function(BuildContext) onRefreshed;
  final Function onBackPressed;
  final bool isSaving;
  final bool isDirty;

  InvoiceViewVM({
    @required this.company,
    @required this.invoice,
    @required this.client,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onClientPressed,
    @required this.isSaving,
    @required this.isDirty,
    @required this.onRefreshed,
  });

  factory InvoiceViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoice = state.invoiceState.map[state.invoiceUIState.selectedId];
    final client = store.state.clientState.map[invoice.clientId];

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadInvoices(completer: completer, force: true));
      return completer.future;
    }

    return InvoiceViewVM(
        company: state.selectedCompany,
        isSaving: state.isSaving,
        isDirty: invoice.isNew,
        invoice: invoice,
        client: client,
        onEditPressed: (BuildContext context, [InvoiceItemEntity invoiceItem]) {
          final Completer<InvoiceEntity> completer =
              new Completer<InvoiceEntity>();
          store.dispatch(EditInvoice(
              invoice: invoice,
              context: context,
              completer: completer,
              invoiceItem: invoiceItem));
          completer.future.then((invoice) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
              message: AppLocalization.of(context).successfullyUpdatedInvoice,
            )));
          });
        },
        onRefreshed: (context) => _handleRefresh(context),
        onBackPressed: () =>
            store.dispatch(UpdateCurrentRoute(InvoiceScreen.route)),
        onClientPressed: (BuildContext context) {
          store.dispatch(ViewClient(clientId: client.id, context: context));
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.pdf:
              viewPdf(invoice, context);
              break;
            case EntityAction.markSent:
              store.dispatch(MarkSentInvoiceRequest(
                  snackBarCompleter(
                      context, localization.successfullyMarkedInvoiceAsSent),
                  invoice.id));
              break;
            case EntityAction.emailInvoice:
              store.dispatch(ShowEmailInvoice(
                  completer: snackBarCompleter(
                      context, localization.successfullyEmailedInvoice),
                  invoice: invoice,
                  context: context));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveInvoiceRequest(
                  popCompleter(
                      context, localization.successfullyArchivedInvoice),
                  invoice.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteInvoiceRequest(
                  popCompleter(
                      context, localization.successfullyDeletedInvoice),
                  invoice.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreInvoiceRequest(
                  snackBarCompleter(
                      context, localization.successfullyRestoredInvoice),
                  invoice.id));
              break;
            case EntityAction.clone:
              Navigator.of(context).pop();
              store.dispatch(
                  EditInvoice(context: context, invoice: invoice.clone));
              break;
          }
        });
  }
}
