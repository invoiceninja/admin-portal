// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/token_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownTokenList = memo3((BuiltMap<String, TokenEntity> tokenMap,
        BuiltList<String> tokenList, String clientId) =>
    dropdownTokensSelector(tokenMap, tokenList, clientId));

List<String> dropdownTokensSelector(BuiltMap<String, TokenEntity> tokenMap,
    BuiltList<String> tokenList, String clientId) {
  final list = tokenList.where((tokenId) {
    final token = tokenMap[tokenId]!;
    return token.isActive;
  }).toList();

  list.sort((tokenAId, tokenBId) {
    final tokenA = tokenMap[tokenAId]!;
    final tokenB = tokenMap[tokenBId];
    return tokenA.compareTo(tokenB, TokenFields.name, true);
  });

  return list;
}

var memoizedFilteredTokenList = memo4((
  SelectionState selectionState,
  BuiltMap<String?, TokenEntity?> tokenMap,
  BuiltList<String> tokenList,
  ListUIState tokenListState,
) =>
    filteredTokensSelector(
      selectionState,
      tokenMap,
      tokenList,
      tokenListState,
    ));

List<String> filteredTokensSelector(
  SelectionState selectionState,
  BuiltMap<String?, TokenEntity?> tokenMap,
  BuiltList<String> tokenList,
  ListUIState tokenListState,
) {
  //final filterEntityId = selectionState.filterEntityId;

  final list = tokenList.where((tokenId) {
    final token = tokenMap[tokenId]!;

    if (token.id == selectionState.selectedId) {
      return true;
    }

    if (token.isSystem) {
      return false;
    }

    if (!token.matchesStates(tokenListState.stateFilters)) {
      return false;
    }

    return token.matchesFilter(tokenListState.filter);
  }).toList();

  list.sort((tokenAId, tokenBId) {
    final tokenA = tokenMap[tokenAId]!;
    final tokenB = tokenMap[tokenBId];
    return tokenA.compareTo(
        tokenB, tokenListState.sortField, tokenListState.sortAscending);
  });

  return list;
}
