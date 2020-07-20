import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
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
        final state = viewModel.state;
        return EntityList(
            entityType: EntityType.quote,
            presenter: QuotePresenter(),
            state: viewModel.state,
            entityList: viewModel.invoiceList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final invoiceId = viewModel.invoiceList[index];
              final invoice = viewModel.invoiceMap[invoiceId];
              final client =
                  viewModel.clientMap[invoice.clientId] ?? ClientEntity();
              final listState = state.getListState(EntityType.quote);
              final isInMultiselect = listState.isInMultiselect();

              void showDialog() => showEntityActionsDialog(
                    entities: [invoice],
                    context: context,
                    client: client,
                  );

              return QuoteListItem(
                user: state.user,
                filter: viewModel.filter,
                quote: invoice,
                client: viewModel.clientMap[invoice.clientId] ?? ClientEntity(),
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handleInvoiceAction(context, [invoice], action);
                  }
                },
                isChecked: isInMultiselect && listState.isSelected(invoice.id),
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
    Function onClearEntityFilterPressed,
    Function(BuildContext) onViewEntityFilterPressed,
    Function(BuildContext, List<InvoiceEntity>, EntityAction) onEntityAction,
    List<String> tableColumns,
    EntityType entityType,
    Function(String) onSortColumn,
  }) : super(
          state: state,
          invoiceList: invoiceList,
          invoiceMap: invoiceMap,
          clientMap: clientMap,
          filter: filter,
          isLoading: isLoading,
          isLoaded: isLoaded,
          onRefreshed: onRefreshed,
          onClearEntityFilterPressed: onClearEntityFilterPressed,
          onViewEntityFilterPressed: onViewEntityFilterPressed,
          tableColumns: tableColumns,
          entityType: entityType,
          onSortColumn: onSortColumn,
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
      onClearEntityFilterPressed: () => store.dispatch(ClearEntityFilter()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.quoteListState.filterEntityId,
          entityType: state.quoteListState.filterEntityType),
      onEntityAction: (BuildContext context, List<BaseEntity> quotes,
              EntityAction action) =>
          handleQuoteAction(context, quotes, action),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.quote) ??
              QuotePresenter.getAllTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortQuotes(field)),
      entityType: EntityType.quote,
    );
  }
}
