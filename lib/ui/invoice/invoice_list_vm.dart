import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class InvoiceListBuilder extends StatelessWidget {
  const InvoiceListBuilder({Key key}) : super(key: key);

  static const String route = '/invoices/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceListVM>(
      converter: InvoiceListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.invoice,
            presenter: InvoicePresenter(),
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

              return InvoiceListItem(
                filter: viewModel.filter,
                invoice: invoice,
              );
            });
      },
    );
  }
}

class EntityListVM {
  EntityListVM({
    @required this.state,
    @required this.entityType,
    @required this.invoiceList,
    @required this.invoiceMap,
    @required this.clientMap,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.filter,
    @required this.onRefreshed,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.tableColumns,
    @required this.onSortColumn,
  });

  final AppState state;
  final EntityType entityType;
  final List<String> invoiceList;
  final BuiltMap<String, InvoiceEntity> invoiceMap;
  final BuiltMap<String, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
}

class InvoiceListVM extends EntityListVM {
  InvoiceListVM({
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

  static InvoiceListVM fromStore(Store<AppState> store) {
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

    return InvoiceListVM(
      state: state,
      invoiceList: memoizedFilteredInvoiceList(
          state.invoiceState.map,
          state.invoiceState.list,
          state.clientState.map,
          state.paymentState.map,
          state.invoiceListState,
          state.staticState,
          state.userState.map),
      invoiceMap: state.invoiceState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.invoiceListState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onClearEntityFilterPressed: () => store.dispatch(FilterByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.invoiceListState.filterEntityId,
          entityType: state.invoiceListState.filterEntityType),
      onEntityAction: (BuildContext context, List<BaseEntity> invoices,
              EntityAction action) =>
          handleInvoiceAction(context, invoices, action),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.invoice) ??
              InvoicePresenter.getAllTableFields(state.userCompany),
      entityType: EntityType.invoice,
      onSortColumn: (field) => store.dispatch(SortInvoices(field)),
    );
  }
}
