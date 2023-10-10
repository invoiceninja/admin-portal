// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_email_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class QuoteEmailScreen extends StatelessWidget {
  const QuoteEmailScreen({Key? key}) : super(key: key);

  static const String route = '/quote/email';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EmailQuoteVM>(
      onInit: (Store<AppState> store) {
        final state = store.state;
        final quoteId = state.uiState.quoteUIState.selectedId;
        final quote = state.quoteState.map[quoteId]!;
        final client = state.clientState.map[quote.clientId]!;
        if (client.isStale) {
          store.dispatch(LoadClient(clientId: client.id));
        }
      },
      converter: (Store<AppState> store) {
        final state = store.state;
        final quoteId = state.uiState.quoteUIState.selectedId;
        final quote = state.quoteState.map[quoteId]!;
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

class EmailQuoteVM extends EmailEntityVM {
  EmailQuoteVM({
    required AppState state,
    required bool isLoading,
    required bool isSaving,
    required CompanyEntity? company,
    required InvoiceEntity invoice,
    required ClientEntity? client,
    required VendorEntity? vendor,
    required Function(BuildContext, EmailTemplate, String, String, String)
        onSendPressed,
  }) : super(
          state: state,
          isLoading: isLoading,
          isSaving: isSaving,
          company: company,
          invoice: invoice,
          client: client,
          vendor: vendor,
          onSendPressed: onSendPressed,
        );

  factory EmailQuoteVM.fromStore(Store<AppState> store, InvoiceEntity quote) {
    final state = store.state;

    return EmailQuoteVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      company: state.company,
      invoice: quote,
      client: state.clientState.map[quote.clientId],
      vendor: state.vendorState.map[quote.vendorId],
      onSendPressed: (context, template, subject, body, ccEmail) {
        final completer = snackBarCompleter<Null>(
            AppLocalization.of(context)!.emailedQuote,
            shouldPop: isMobile(context));
        if (!isMobile(context)) {
          completer.future.then<Null>((_) {
            viewEntity(entity: quote);
          });
        }
        store.dispatch(EmailQuoteRequest(
          completer: completer,
          quoteId: quote.id,
          template: template,
          subject: subject,
          body: body,
          ccEmail: ccEmail,
        ));
      },
    );
  }
}
