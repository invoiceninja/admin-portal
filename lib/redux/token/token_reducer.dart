// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState tokenUIReducer(TokenUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(tokenListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewToken>((completer, action) => true),
  TypedReducer<bool?, ViewTokenList>((completer, action) => false),
  TypedReducer<bool?, FilterTokensByState>((completer, action) => false),
  TypedReducer<bool?, FilterTokens>((completer, action) => false),
  TypedReducer<bool?, FilterTokensByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterTokensByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterTokensByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterTokensByCustom4>((completer, action) => false),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveTokensSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteTokensSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.token ? action.entityId : selectedId),
  TypedReducer<String?, ViewToken>(
      (String? selectedId, dynamic action) => action.tokenId),
  TypedReducer<String?, AddTokenSuccess>(
      (String? selectedId, dynamic action) => action.token.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortTokens>((selectedId, action) => ''),
  TypedReducer<String?, FilterTokens>((selectedId, action) => ''),
  TypedReducer<String?, FilterTokensByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterTokensByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterTokensByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterTokensByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterTokensByCustom4>((selectedId, action) => ''),
  TypedReducer<String?, FilterByEntity>(
      (selectedId, action) => action.clearSelection
          ? ''
          : action.entityType == EntityType.token
              ? action.entityId
              : selectedId),
]);

final editingReducer = combineReducers<TokenEntity?>([
  TypedReducer<TokenEntity?, SaveTokenSuccess>(_updateEditing),
  TypedReducer<TokenEntity?, AddTokenSuccess>(_updateEditing),
  TypedReducer<TokenEntity?, RestoreTokensSuccess>((tokens, action) {
    return action.tokens[0];
  }),
  TypedReducer<TokenEntity?, ArchiveTokensSuccess>((tokens, action) {
    return action.tokens[0];
  }),
  TypedReducer<TokenEntity?, DeleteTokensSuccess>((tokens, action) {
    return action.tokens[0];
  }),
  TypedReducer<TokenEntity?, EditToken>(_updateEditing),
  TypedReducer<TokenEntity?, UpdateToken>((token, action) {
    return action.token.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<TokenEntity?, DiscardChanges>(_clearEditing),
]);

TokenEntity _clearEditing(TokenEntity? token, dynamic action) {
  return TokenEntity();
}

TokenEntity? _updateEditing(TokenEntity? token, dynamic action) {
  return action.token;
}

final tokenListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortTokens>(_sortTokens),
  TypedReducer<ListUIState, FilterTokensByState>(_filterTokensByState),
  TypedReducer<ListUIState, FilterTokens>(_filterTokens),
  TypedReducer<ListUIState, FilterTokensByCustom1>(_filterTokensByCustom1),
  TypedReducer<ListUIState, FilterTokensByCustom2>(_filterTokensByCustom2),
  TypedReducer<ListUIState, StartTokenMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToTokenMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromTokenMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearTokenMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewTokenList>(_viewTokenList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewTokenList(ListUIState tokenListState, ViewTokenList action) {
  return tokenListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
}

ListUIState _filterTokensByCustom1(
    ListUIState tokenListState, FilterTokensByCustom1 action) {
  if (tokenListState.custom1Filters.contains(action.value)) {
    return tokenListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return tokenListState.rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterTokensByCustom2(
    ListUIState tokenListState, FilterTokensByCustom2 action) {
  if (tokenListState.custom2Filters.contains(action.value)) {
    return tokenListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return tokenListState.rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterTokensByState(
    ListUIState tokenListState, FilterTokensByState action) {
  if (tokenListState.stateFilters.contains(action.state)) {
    return tokenListState.rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return tokenListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterTokens(ListUIState tokenListState, FilterTokens action) {
  return tokenListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : tokenListState.filterClearedAt);
}

ListUIState _sortTokens(ListUIState tokenListState, SortTokens action) {
  return tokenListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState productListState, StartTokenMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState productListState, AddToTokenMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState productListState, RemoveFromTokenMultiselect action) {
  return productListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState productListState, ClearTokenMultiselect action) {
  return productListState.rebuild((b) => b..selectedIds = null);
}

final tokensReducer = combineReducers<TokenState>([
  TypedReducer<TokenState, SaveTokenSuccess>(_updateToken),
  TypedReducer<TokenState, AddTokenSuccess>(_addToken),
  TypedReducer<TokenState, LoadTokensSuccess>(_setLoadedTokens),
  TypedReducer<TokenState, LoadTokenSuccess>(_setLoadedToken),
  TypedReducer<TokenState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<TokenState, ArchiveTokensSuccess>(_archiveTokenSuccess),
  TypedReducer<TokenState, DeleteTokensSuccess>(_deleteTokenSuccess),
  TypedReducer<TokenState, RestoreTokensSuccess>(_restoreTokenSuccess),
]);

TokenState _archiveTokenSuccess(
    TokenState tokenState, ArchiveTokensSuccess action) {
  return tokenState.rebuild((b) {
    for (final token in action.tokens) {
      b.map[token.id] = token;
    }
  });
}

TokenState _deleteTokenSuccess(
    TokenState tokenState, DeleteTokensSuccess action) {
  return tokenState.rebuild((b) {
    for (final token in action.tokens) {
      b.map[token.id] = token;
    }
  });
}

TokenState _restoreTokenSuccess(
    TokenState tokenState, RestoreTokensSuccess action) {
  return tokenState.rebuild((b) {
    for (final token in action.tokens) {
      b.map[token.id] = token;
    }
  });
}

TokenState _addToken(TokenState tokenState, AddTokenSuccess action) {
  return tokenState.rebuild((b) => b
    ..map[action.token.id] = action.token
    ..list.add(action.token.id));
}

TokenState _updateToken(TokenState tokenState, SaveTokenSuccess action) {
  return tokenState.rebuild((b) => b..map[action.token.id] = action.token);
}

TokenState _setLoadedToken(TokenState tokenState, LoadTokenSuccess action) {
  return tokenState.rebuild((b) => b..map[action.token.id] = action.token);
}

TokenState _setLoadedTokens(TokenState tokenState, LoadTokensSuccess action) =>
    tokenState.loadTokens(action.tokens);

TokenState _setLoadedCompany(TokenState tokenState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  return tokenState.loadTokens(company.tokens);
}
