import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';

class QuoteListBuilder extends StatelessWidget {
  const QuoteListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteListVM>(
      converter: QuoteListVM.fromStore,
      builder: (context, viewModel) {
        return QuoteList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class QuoteListVM {
  final UserEntity user;
  final List<int> quoteList;
  final BuiltMap<int, QuoteEntity> quoteMap;
  final BuiltMap<int, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, QuoteEntity) onQuoteTap;
  final Function(BuildContext, QuoteEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, QuoteEntity, EntityAction) onEntityAction;

  QuoteListVM({
    @required this.user,
    @required this.quoteList,
    @required this.quoteMap,
    @required this.clientMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onQuoteTap,
    @required this.onDismissed,
    @required this.onRefreshed,
    @required this.onEntityAction,
  });

  static QuoteListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadQuotes(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return QuoteListVM(
        user: state.user,
        quoteList: memoizedFilteredQuoteList(state.quoteState.map,
            state.quoteState.list, state.quoteListState),
        quoteMap: state.quoteState.map,
        clientMap: state.clientState.map,
        isLoading: state.isLoading,
        isLoaded: state.quoteState.isLoaded,
        filter: state.quoteUIState.listUIState.filter,
        onQuoteTap: (context, quote) {
          store.dispatch(EditQuote(quote: quote, context: context));
        },
        onEntityAction: (context, quote, action) {
          switch (action) {
            case EntityAction.clone:
              Navigator.of(context).pop();
              store.dispatch(
                  EditQuote(context: context, quote: quote.clone));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreQuoteRequest(
                  popCompleter(
                      context, AppLocalization.of(context).restoredQuote),
                  quote.id));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveQuoteRequest(
                  popCompleter(
                      context, AppLocalization.of(context).archivedQuote),
                  quote.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteQuoteRequest(
                  popCompleter(
                      context, AppLocalization.of(context).deletedQuote),
                  quote.id));
              break;
          }
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, QuoteEntity quote,
            DismissDirection direction) {
          final localization = AppLocalization.of(context);
          if (direction == DismissDirection.endToStart) {
            if (quote.isDeleted || quote.isArchived) {
              store.dispatch(RestoreQuoteRequest(
                  snackBarCompleter(context, localization.restoredQuote),
                  quote.id));
            } else {
              store.dispatch(ArchiveQuoteRequest(
                  snackBarCompleter(context, localization.archivedQuote),
                  quote.id));
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (quote.isDeleted) {
              store.dispatch(RestoreQuoteRequest(
                  snackBarCompleter(context, localization.restoredQuote),
                  quote.id));
            } else {
              store.dispatch(DeleteQuoteRequest(
                  snackBarCompleter(context, localization.deletedQuote),
                  quote.id));
            }
          }
        });
  }
}
