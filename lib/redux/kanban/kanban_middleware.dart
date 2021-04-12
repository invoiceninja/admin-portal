import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/kanban/kanban_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/kanban_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

List<Middleware<AppState>> createStoreKabanMiddleware() {
  final viewKanban = _viewKanban();

  return [
    TypedMiddleware<AppState, ViewKanban>(viewKanban),
  ];
}

Middleware<AppState> _viewKanban() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewKanban;

    checkForChanges(
        store: store,
        context: action.context,
        force: action.force,
        callback: () {
          const route = KanbanScreenBuilder.route;

          next(action);

          store.dispatch(UpdateCurrentRoute(route));

          if (isMobile(action.context)) {
            Navigator.of(action.context).pushNamed(route);
          }
        });
  };
}
