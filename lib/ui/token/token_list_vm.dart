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
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/token/token_list_item.dart';
import 'package:invoiceninja_flutter/ui/token/token_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TokenListBuilder extends StatelessWidget {
  const TokenListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokenListVM>(
      converter: TokenListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.token,
            presenter: TokenPresenter(),
            state: viewModel.state,
            entityList: viewModel.tokenList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final tokenId = viewModel.tokenList[index];
              final token = viewModel.tokenMap[tokenId]!;
              final listState = state.getListState(EntityType.token);
              final isInMultiselect = listState.isInMultiselect();

              return TokenListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                token: token,
                isChecked: isInMultiselect && listState.isSelected(token.id),
              );
            });
      },
    );
  }
}

class TokenListVM {
  TokenListVM({
    required this.state,
    required this.userCompany,
    required this.tokenList,
    required this.tokenMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static TokenListVM fromStore(Store<AppState> store) {
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

    return TokenListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.tokenListState,
      tokenList: memoizedFilteredTokenList(
          state.getUISelection(EntityType.token),
          state.tokenState.map,
          state.tokenState.list,
          state.tokenListState),
      tokenMap: state.tokenState.map,
      isLoading: state.isLoading,
      filter: state.tokenUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> tokens,
              EntityAction action) =>
          handleTokenAction(context, tokens, action),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.token) ??
              TokenPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortTokens(field)),
      onClearMultielsect: () => store.dispatch(ClearTokenMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> tokenList;
  final BuiltMap<String?, TokenEntity?> tokenMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
