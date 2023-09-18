// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_selectors.dart';
import 'token_screen.dart';

class TokenScreenBuilder extends StatelessWidget {
  const TokenScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokenScreenVM>(
      converter: TokenScreenVM.fromStore,
      builder: (context, vm) {
        return TokenScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class TokenScreenVM {
  TokenScreenVM({
    required this.isInMultiselect,
    required this.tokenList,
    required this.userCompany,
    required this.onEntityAction,
    required this.tokenMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> tokenList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String?, TokenEntity?> tokenMap;

  static TokenScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return TokenScreenVM(
      tokenMap: state.tokenState.map,
      tokenList: memoizedFilteredTokenList(
          state.getUISelection(EntityType.token),
          state.tokenState.map,
          state.tokenState.list,
          state.tokenListState),
      userCompany: state.userCompany,
      isInMultiselect: state.tokenListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> tokens,
              EntityAction action) =>
          handleTokenAction(context, tokens, action),
    );
  }
}
