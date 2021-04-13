import 'dart:async';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/token/token_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/data/models/token_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/token/view/token_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class TokenViewScreen extends StatelessWidget {
  const TokenViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  static const String route = '/$kSettings/$kSettingsTokenView';
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokenViewVM>(
      converter: (Store<AppState> store) {
        return TokenViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return TokenView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class TokenViewVM {
  TokenViewVM({
    @required this.state,
    @required this.token,
    @required this.company,
    @required this.onEntityAction,
    @required this.onBackPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory TokenViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final token = state.tokenState.map[state.tokenUIState.selectedId] ??
        TokenEntity(id: state.tokenUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadToken(completer: completer, tokenId: token.id));
      return completer.future;
    }

    return TokenViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: token.isNew,
      token: token,
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(TokenScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context.getAppContext(), [token], action,
              autoPop: true),
    );
  }

  final AppState state;
  final TokenEntity token;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final Function onBackPressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
