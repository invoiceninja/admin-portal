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
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/client/client_list_item.dart';
import 'package:invoiceninja_flutter/ui/client/client_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientListBuilder extends StatelessWidget {
  const ClientListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientListVM>(
      converter: ClientListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.client,
            presenter: ClientPresenter(),
            state: viewModel.state,
            entityList: viewModel.clientList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            onClearMultiselect: viewModel.onClearMultielsect,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final clientId = viewModel.clientList[index];
              final client = viewModel.clientMap[clientId]!;
              final listState = state.getListState(EntityType.client);
              final isInMultiselect = listState.isInMultiselect();

              return ClientListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                client: client as ClientEntity,
                isChecked: isInMultiselect && listState.isSelected(client.id),
              );
            });
      },
    );
  }
}

class ClientListVM {
  ClientListVM({
    required this.state,
    required this.clientList,
    required this.clientMap,
    required this.isLoading,
    required this.filter,
    required this.onRefreshed,
    required this.tableColumns,
    required this.onEntityAction,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  final AppState state;
  final List<String> clientList;
  final BuiltMap<String?, BaseEntity?> clientMap;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;

  static ClientListVM fromStore(Store<AppState> store) {
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

    return ClientListVM(
      state: state,
      clientList: memoizedFilteredClientList(
          state.getUISelection(EntityType.client),
          state.clientState.map,
          state.clientState.list,
          state.groupState.map,
          state.clientListState,
          state.userState.map,
          state.staticState),
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.clientListState.filter,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, List<BaseEntity> client,
              EntityAction action) =>
          handleClientAction(context, client, action),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.client) ??
              ClientPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortClients(field)),
      onClearMultielsect: () => store.dispatch(ClearClientMultiselect()),
    );
  } //
}
