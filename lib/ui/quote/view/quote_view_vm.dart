import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/pdf.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';

class QuoteViewScreen extends StatelessWidget {
  static const String route = '/invoice/view';

  const QuoteViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteViewVM>(
      distinct: true,
      converter: (Store<AppState> store) {
        return QuoteViewVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return QuoteView(
          viewModel: viewModel,
        );
      },
    );
  }
}

class QuoteViewVM {
  final CompanyEntity company;
  final QuoteEntity quote;
  final ClientEntity client;
  final bool isSaving;
  final bool isDirty;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext, [InvoiceItemEntity]) onEditPressed;
  final Function(BuildContext) onClientPressed;
  final Function(BuildContext) onRefreshed;
  final Function onBackPressed;

  QuoteViewVM({
    @required this.company,
    @required this.quote,
    @required this.client,
    @required this.isSaving,
    @required this.isDirty,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onClientPressed,
    @required this.onRefreshed,
  });

  factory QuoteViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final quote = state.quoteState.map[state.quoteUIState.selectedId];
    final client = store.state.clientState.map[quote.clientId];

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadQuotes(completer: completer, force: true));
      return completer.future;
    }

    return QuoteViewVM(
        company: state.selectedCompany,
        isSaving: state.isSaving,
        isDirty: quote.isNew,
        quote: quote,
        client: client,
        onEditPressed: (BuildContext context, [InvoiceItemEntity invoiceItem]) {
          final Completer<QuoteEntity> completer =
          new Completer<QuoteEntity>();
          store.dispatch(EditQuote(
              quote: quote,
              context: context,
              completer: completer,
              invoiceItem: invoiceItem));
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
              viewPdf(invoice, context);
              break;
            case EntityAction.markSent:
              store.dispatch(MarkSentQuoteRequest(
                  snackBarCompleter(context, localization.markedQuoteAsSent),
                  invoice.id));
              break;
            case EntityAction.emailQuote:
              store.dispatch(ShowEmailQuote(
                  completer:
                  snackBarCompleter(context, localization.emailedQuote),
                  invoice: invoice,
                  context: context));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveQuoteRequest(
                  popCompleter(context, localization.archivedQuote),
                  invoice.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteQuoteRequest(
                  popCompleter(context, localization.deletedQuote),
                  invoice.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreQuoteRequest(
                  snackBarCompleter(context, localization.restoredQuote),
                  invoice.id));
              break;
            case EntityAction.clone:
              Navigator.of(context).pop();
              store.dispatch(
                  EditQuote(context: context, invoice: invoice.clone));
              break;
          }
        });
  }

  @override
  bool operator ==(dynamic other) =>
      client == other.client &&
          company == other.company &&
          invoice == other.invoice &&
          isSaving == other.isSaving &&
          isDirty == other.isDirty;

  @override
  int get hashCode =>
      client.hashCode ^
      company.hashCode ^
      invoice.hashCode ^
      isSaving.hashCode ^
      isDirty.hashCode;
}
