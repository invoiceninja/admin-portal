import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list.dart';
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
      builder: (context, vm) {
        return InvoiceList(
          viewModel: vm,
        );
      },
    );
  }
}

class EntityListVM {
  EntityListVM({
    @required this.state,
    @required this.user,
    @required this.listState,
    @required this.invoiceList,
    @required this.invoiceMap,
    @required this.clientMap,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.filter,
    @required this.onInvoiceTap,
    @required this.onRefreshed,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onEntityAction,
  });

  final AppState state;
  final UserEntity user;
  final ListUIState listState;
  final List<String> invoiceList;
  final BuiltMap<String, InvoiceEntity> invoiceMap;
  final BuiltMap<String, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, InvoiceEntity) onInvoiceTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final Function(BuildContext, List<InvoiceEntity>, EntityAction)
      onEntityAction;
}

class InvoiceListVM extends EntityListVM {
  InvoiceListVM({
    AppState state,
    UserEntity user,
    ListUIState listState,
    List<String> invoiceList,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ClientEntity> clientMap,
    String filter,
    bool isLoading,
    bool isLoaded,
    Function(BuildContext, InvoiceEntity) onInvoiceTap,
    Function(BuildContext) onRefreshed,
    Function onClearEntityFilterPressed,
    Function(BuildContext) onViewEntityFilterPressed,
    Function(BuildContext, List<InvoiceEntity>, EntityAction) onEntityAction,
  }) : super(
          state: state,
          user: user,
          listState: listState,
          invoiceList: invoiceList,
          invoiceMap: invoiceMap,
          clientMap: clientMap,
          filter: filter,
          isLoading: isLoading,
          isLoaded: isLoaded,
          onInvoiceTap: onInvoiceTap,
          onRefreshed: onRefreshed,
          onClearEntityFilterPressed: onClearEntityFilterPressed,
          onViewEntityFilterPressed: onViewEntityFilterPressed,
          onEntityAction: onEntityAction,
        );

  static InvoiceListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadInvoices(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return InvoiceListVM(
      state: state,
      user: state.user,
      listState: state.invoiceListState,
      invoiceList: memoizedFilteredInvoiceList(
          state.invoiceState.map,
          state.invoiceState.list,
          state.clientState.map,
          state.invoiceListState),
      invoiceMap: state.invoiceState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      isLoaded: state.invoiceState.isLoaded && state.clientState.isLoaded,
      filter: state.invoiceListState.filter,
      onInvoiceTap: (context, invoice) {
        store.dispatch(ViewInvoice(invoiceId: invoice.id, context: context));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onClearEntityFilterPressed: () =>
          store.dispatch(FilterInvoicesByEntity()),
      onViewEntityFilterPressed: (BuildContext context) {
        if (state.invoiceListState.filterEntityType == EntityType.client) {
          store.dispatch(ViewClient(
              clientId: state.invoiceListState.filterEntityId,
              context: context));
        } else if (state.invoiceListState.filterEntityType == EntityType.user) {
          store.dispatch(ViewUser(
              userId: state.invoiceListState.filterEntityId, context: context));
        }
      },
      onEntityAction: (BuildContext context, List<BaseEntity> invoices,
              EntityAction action) =>
          handleInvoiceAction(context, invoices, action),
    );
  }
}
