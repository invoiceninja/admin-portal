// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
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

class InvoiceListBuilder extends StatelessWidget {
  const InvoiceListBuilder({Key? key}) : super(key: key);

  static const String route = '/invoices/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceListVM>(
      converter: InvoiceListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultiselect,
            entityType: EntityType.invoice,
            presenter: InvoicePresenter(),
            state: viewModel.state,
            entityList: viewModel.invoiceList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final invoiceId = viewModel.invoiceList[index];
              final invoice = viewModel.invoiceMap[invoiceId]!;
              final invoiceListState = viewModel.state.invoiceListState;

              return InvoiceListItem(
                filter: viewModel.filter,
                invoice: invoice,
                showCheckbox: invoiceListState.isInMultiselect(),
                isChecked: invoiceListState.isSelected(invoice.id),
              );
            });
      },
    );
  }
}

class EntityListVM {
  EntityListVM({
    required this.state,
    required this.entityType,
    required this.invoiceList,
    required this.invoiceMap,
    required this.clientMap,
    required this.isLoading,
    required this.filter,
    required this.onRefreshed,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultiselect,
  });

  final AppState state;
  final EntityType entityType;
  final List<String> invoiceList;
  final BuiltMap<String, InvoiceEntity> invoiceMap;
  final BuiltMap<String, ClientEntity> clientMap;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultiselect;
}

class InvoiceListVM extends EntityListVM {
  InvoiceListVM({
    required AppState state,
    required List<String> invoiceList,
    required BuiltMap<String, InvoiceEntity> invoiceMap,
    required BuiltMap<String, ClientEntity> clientMap,
    required String? filter,
    required bool isLoading,
    required Function(BuildContext) onRefreshed,
    required Function(BuildContext, List<InvoiceEntity>, EntityAction)
        onEntityAction,
    required List<String> tableColumns,
    required EntityType entityType,
    required Function(String) onSortColumn,
    required Function onClearMultiselect,
  }) : super(
          state: state,
          invoiceList: invoiceList,
          invoiceMap: invoiceMap,
          clientMap: clientMap,
          filter: filter,
          isLoading: isLoading,
          onRefreshed: onRefreshed,
          tableColumns: tableColumns,
          entityType: entityType,
          onSortColumn: onSortColumn,
          onClearMultiselect: onClearMultiselect,
        );

  static InvoiceListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return InvoiceListVM(
      state: state,
      invoiceList: memoizedFilteredInvoiceList(
        state.getUISelection(EntityType.invoice),
        state.invoiceState.map,
        state.invoiceState.list,
        state.clientState.map,
        state.vendorState.map,
        state.paymentState.map,
        state.invoiceListState,
        state.userState.map,
        state.company.settings.recurringNumberPrefix,
      ),
      invoiceMap: state.invoiceState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.invoiceListState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, List<BaseEntity> invoices,
              EntityAction action) =>
          handleInvoiceAction(context, invoices, action),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.invoice) ??
              InvoicePresenter.getDefaultTableFields(state.userCompany),
      entityType: EntityType.invoice,
      onSortColumn: (field) => store.dispatch(SortInvoices(field)),
      onClearMultiselect: () => store.dispatch(ClearInvoiceMultiselect()),
    );
  }
}
