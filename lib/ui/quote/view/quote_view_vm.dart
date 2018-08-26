import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';

class QuoteViewScreen extends StatelessWidget {
  static const String route = '/quote/view';

  const QuoteViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteViewVM>(
      distinct: true,
      converter: (Store<AppState> store) {
        return QuoteViewVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceView(
          viewModel: viewModel,
        );
      },
    );
  }
}

class QuoteViewVM extends EntityViewVM {

  QuoteViewVM({
    CompanyEntity company,
    InvoiceEntity invoice,
    ClientEntity client,
    bool isSaving,
    bool isDirty,
    Function(BuildContext, EntityAction) onActionSelected,
    Function(BuildContext, [InvoiceItemEntity]) onEditPressed,
    Function(BuildContext) onClientPressed,
    Function(BuildContext) onRefreshed,
    Function onBackPressed,
  }) : super(
          company: company,
          invoice: invoice,
          client: client,
          isSaving: isSaving,
          isDirty: isDirty,
          onActionSelected: onActionSelected,
          onEditPressed: onEditPressed,
          onClientPressed: onClientPressed,
          onRefreshed: onRefreshed,
          onBackPressed: onBackPressed,
        );

  factory QuoteViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final quote = state.quoteState.map[state.quoteUIState.selectedId];
    final client = store.state.clientState.map[quote.clientId];

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadQuote(completer: completer, quoteId: quote.id));
      return completer.future;
    }

    return QuoteViewVM(
        company: state.selectedCompany,
        isSaving: state.isSaving,
        isDirty: quote.isNew,
        invoice: quote,
        client: client,
        onEditPressed: (BuildContext context, [InvoiceItemEntity invoiceItem]) {
          final Completer<InvoiceEntity> completer =
              new Completer<InvoiceEntity>();
          store.dispatch(EditQuote(
              quote: quote,
              context: context,
              completer: completer,
              quoteItem: invoiceItem));
          completer.future.then((invoice) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
              message: AppLocalization.of(context).updatedQuote,
            )));
          });
        },
        onRefreshed: (context) => _handleRefresh(context),
        onBackPressed: () =>
            store.dispatch(UpdateCurrentRoute(QuoteScreen.route)),
        onClientPressed: (BuildContext context) {
          store.dispatch(ViewClient(clientId: client.id, context: context));
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.pdf:
              viewPdf(quote, context);
              break;
            case EntityAction.markSent:
              store.dispatch(MarkSentQuoteRequest(
                  snackBarCompleter(context, localization.markedQuoteAsSent),
                  quote.id));
              break;
            case EntityAction.email:
              store.dispatch(ShowEmailQuote(
                  completer:
                      snackBarCompleter(context, localization.emailedQuote),
                  quote: quote,
                  context: context));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveQuoteRequest(
                  popCompleter(context, localization.archivedQuote), quote.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteQuoteRequest(
                  popCompleter(context, localization.deletedQuote), quote.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreQuoteRequest(
                  snackBarCompleter(context, localization.restoredQuote),
                  quote.id));
              break;
            case EntityAction.clone:
              Navigator.of(context).pop();
              store.dispatch(EditQuote(context: context, quote: quote.clone));
              break;
          }
        });
  }
}
