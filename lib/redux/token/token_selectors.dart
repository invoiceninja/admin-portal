import 'package:invoiceninja_flutter/data/models/token_model.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownTokenList = memo3((BuiltMap<String, TokenEntity> tokenMap,
        BuiltList<String> tokenList, String clientId) =>
    dropdownTokensSelector(tokenMap, tokenList, clientId));

List<String> dropdownTokensSelector(BuiltMap<String, TokenEntity> tokenMap,
    BuiltList<String> tokenList, String clientId) {
  final list = tokenList.where((tokenId) {
    final token = tokenMap[tokenId];
    return token.isActive;
  }).toList();

  list.sort((tokenAId, tokenBId) {
    final tokenA = tokenMap[tokenAId];
    final tokenB = tokenMap[tokenBId];
    return tokenA.compareTo(tokenB, TokenFields.name, true);
  });

  return list;
}

var memoizedFilteredTokenList = memo3((BuiltMap<String, TokenEntity> tokenMap,
        BuiltList<String> tokenList, ListUIState tokenListState) =>
    filteredTokensSelector(tokenMap, tokenList, tokenListState));

List<String> filteredTokensSelector(BuiltMap<String, TokenEntity> tokenMap,
    BuiltList<String> tokenList, ListUIState tokenListState) {
  final list = tokenList.where((tokenId) {
    final token = tokenMap[tokenId];
    if (tokenListState.filterEntityId != null &&
        token.id != tokenListState.filterEntityId) {
      return false;
    } else {
      //
    }

    if (!token.matchesStates(tokenListState.stateFilters)) {
      return false;
    }
    return token.matchesFilter(tokenListState.filter);
  }).toList();

  list.sort((tokenAId, tokenBId) {
    final tokenA = tokenMap[tokenAId];
    final tokenB = tokenMap[tokenBId];
    return tokenA.compareTo(
        tokenB, tokenListState.sortField, tokenListState.sortAscending);
  });

  return list;
}

bool hasTokenChanges(
        TokenEntity token, BuiltMap<String, TokenEntity> tokenMap) =>
    token.isNew ? token.isChanged : token != tokenMap[token.id];
