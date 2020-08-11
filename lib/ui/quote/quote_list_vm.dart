import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_list_item.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_presenter.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class QuoteListBuilder extends StatelessWidget {
  const QuoteListBuilder({Key key}) : super(key: key);

  static const String route = '/quotes/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteListVM>(
      converter: QuoteListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultiselect,
            entityType: EntityType.quote,
            presenter: QuotePresenter(),
            state: viewModel.state,
            entityList: viewModel.invoiceList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final invoiceId = viewModel.invoiceList[index];
              final invoice = viewModel.invoiceMap[invoiceId];

              return QuoteListItem(
                filter: viewModel.filter,
                quote: invoice,
              );
            });
      },
    );
  }
}

class QuoteListVM extends EntityListVM {
  QuoteListVM({
    AppState state,
    List<String> invoiceList,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ClientEntity> clientMap,
    String filter,
    bool isLoading,
    bool isLoaded,
    Function(BuildContext) onRefreshed,
    Function(BuildContext, List<InvoiceEntity>, EntityAction) onEntityAction,
    List<String> tableColumns,
    EntityType entityType,
    Function(String) onSortColumn,
    Function onClearMultiselect,
  }) : super(
          state: state,
          invoiceList: invoiceList,
          invoiceMap: invoiceMap,
          clientMap: clientMap,
          filter: filter,
          isLoading: isLoading,
          isLoaded: isLoaded,
          onRefreshed: onRefreshed,
          tableColumns: tableColumns,
          entityType: entityType,
          onSortColumn: onSortColumn,
          onClearMultiselect: onClearMultiselect,
        );

  static QuoteListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return QuoteListVM(
      state: state,
      invoiceList: memoizedFilteredQuoteList(
          state.uiState.filterEntityId,
          state.uiState.filterEntityType,
          state.quoteState.map,
          state.quoteState.list,
          state.clientState.map,
          state.quoteListState,
          state.staticState,
          state.userState.map),
      invoiceMap: state.quoteState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.quoteListState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, List<BaseEntity> quotes,
              EntityAction action) =>
          handleQuoteAction(context, quotes, action),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.quote) ??
              QuotePresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortQuotes(field)),
      entityType: EntityType.quote,
    );
  }
}
