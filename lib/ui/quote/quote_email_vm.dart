import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_email_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class QuoteEmailScreen extends StatelessWidget {
  const QuoteEmailScreen({Key key}) : super(key: key);

  static const String route = '/quote/email';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailQuoteVM>(
      onInit: (Store<AppState> store) {
        final state = store.state;
        final quoteId = state.uiState.quoteUIState.selectedId;
        final quote = state.quoteState.map[quoteId];
        final client = state.clientState.map[quote.clientId];
        if (client.areActivitiesStale) {
          store.dispatch(LoadClient(clientId: client.id, loadActivities: true));
        }
      },
      converter: (Store<AppState> store) {
        final state = store.state;
        final quoteId = state.uiState.quoteUIState.selectedId;
        final quote = state.quoteState.map[quoteId];
        return EmailQuoteVM.fromStore(store, quote);
      },
      builder: (context, viewModel) {
        return InvoiceEmailView(
          viewModel: viewModel,
        );
      },
    );
  }
}

class EmailQuoteVM extends EmailEntityVM{

  EmailQuoteVM({
    bool isLoading,
    bool isSaving,
    CompanyEntity company,
    InvoiceEntity invoice,
    ClientEntity client,
    Function(BuildContext, EmailTemplate, String, String) onSendPressed,
  }): super(
    isLoading: isLoading,
    isSaving: isSaving,
    company: company,
    invoice: invoice,
    client: client,
    onSendPressed: onSendPressed,
  );

  factory EmailQuoteVM.fromStore(
      Store<AppState> store, InvoiceEntity quote) {
    final state = store.state;

    return EmailQuoteVM(
        isLoading: state.isLoading,
        isSaving: state.isSaving,
        company: state.selectedCompany,
        invoice: quote,
        client: state.clientState.map[quote.clientId],
        onSendPressed: (context, template, subject, body) =>
            store.dispatch(EmailQuoteRequest(
              completer: popCompleter(context, true),
              quoteId: quote.id,
              template: template,
              subject: subject,
              body: body,
            )));
  }
}
