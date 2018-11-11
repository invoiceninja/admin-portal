import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_email_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class InvoiceEmailScreen extends StatelessWidget {
  const InvoiceEmailScreen({Key key}) : super(key: key);

  static const String route = '/invoice/email';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailInvoiceVM>(
      onInit: (Store<AppState> store) {
        final state = store.state;
        final invoiceId = state.uiState.invoiceUIState.selectedId;
        final invoice = state.invoiceState.map[invoiceId];
        final client = state.clientState.map[invoice.clientId] ??
            ClientEntity(id: invoice.clientId);
        if (client.areActivitiesStale) {
          store.dispatch(LoadClient(clientId: client.id, loadActivities: true));
        }
      },
      converter: (Store<AppState> store) {
        final state = store.state;
        final invoiceId = state.uiState.invoiceUIState.selectedId;
        final invoice = state.invoiceState.map[invoiceId];
        return EmailInvoiceVM.fromStore(store, invoice);
      },
      builder: (context, vm) {
        return InvoiceEmailView(
          viewModel: vm,
        );
      },
    );
  }
}

abstract class EmailEntityVM {
  EmailEntityVM({
    @required this.isLoading,
    @required this.isSaving,
    @required this.company,
    @required this.invoice,
    @required this.client,
    @required this.onSendPressed,
  });

  final bool isLoading;
  final bool isSaving;
  final CompanyEntity company;
  final InvoiceEntity invoice;
  final ClientEntity client;
  final Function(BuildContext, EmailTemplate, String, String) onSendPressed;
}

class EmailInvoiceVM extends EmailEntityVM {
  EmailInvoiceVM({
    bool isLoading,
    bool isSaving,
    CompanyEntity company,
    InvoiceEntity invoice,
    ClientEntity client,
    Function(BuildContext, EmailTemplate, String, String) onSendPressed,
  }) : super(
          isLoading: isLoading,
          isSaving: isSaving,
          company: company,
          invoice: invoice,
          client: client,
          onSendPressed: onSendPressed,
        );

  factory EmailInvoiceVM.fromStore(
      Store<AppState> store, InvoiceEntity invoice) {
    final state = store.state;

    return EmailInvoiceVM(
        isLoading: state.isLoading,
        isSaving: state.isSaving,
        company: state.selectedCompany,
        invoice: invoice,
        client: state.clientState.map[invoice.clientId] ??
            ClientEntity(id: invoice.clientId),
        onSendPressed: (context, template, subject, body) =>
            store.dispatch(EmailInvoiceRequest(
              completer: popCompleter(context, true),
              invoiceId: invoice.id,
              template: template,
              subject: subject,
              body: body,
            )));
  }
}
