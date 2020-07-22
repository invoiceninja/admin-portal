import 'dart:async';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/user/user_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class UserViewScreen extends StatelessWidget {
  const UserViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/$kSettings/$kSettingsUserManagementView';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserViewVM>(
      converter: (Store<AppState> store) {
        return UserViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return UserView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class UserViewVM {
  UserViewVM({
    @required this.state,
    @required this.user,
    @required this.company,
    @required this.onEntityAction,
    @required this.onBackPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onEntityPressed,
  });

  factory UserViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final user = state.userState.map[state.userUIState.selectedId] ??
        UserEntity(id: state.userUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadUser(completer: completer, userId: user.id));
      return completer.future;
    }

    return UserViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: user.isNew,
      user: user,
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(UserScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context, [user], action, autoPop: true),
      onEntityPressed: (BuildContext context, EntityType entityType,
          [longPress = false]) {
        switch (entityType) {
          case EntityType.invoice:
            if (longPress && user.isActive) {
              handleUserAction(context, [user], EntityAction.newInvoice);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.invoice,
                  filterEntity: user);
            }
            break;
          case EntityType.quote:
            if (longPress && user.isActive) {
              handleUserAction(context, [user], EntityAction.newQuote);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.quote,
                  filterEntity: user);
            }
            break;
          case EntityType.credit:
            if (longPress && user.isActive) {
              handleUserAction(context, [user], EntityAction.newCredit);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.credit,
                  filterEntity: user);
            }
            break;
          case EntityType.payment:
            if (longPress && user.isActive) {
              handleUserAction(context, [user], EntityAction.newPayment);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.payment,
                  filterEntity: user);
            }
            break;
          case EntityType.project:
            if (longPress && user.isActive) {
              handleUserAction(context, [user], EntityAction.newProject);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.project,
                  filterEntity: user);
            }
            break;
          case EntityType.task:
            if (longPress && user.isActive) {
              handleUserAction(context, [user], EntityAction.newTask);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.task,
                  filterEntity: user);
            }
            break;
          case EntityType.expense:
            if (longPress && user.isActive) {
              handleUserAction(context, [user], EntityAction.newExpense);
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.expense,
                  filterEntity: user);
            }
            break;
        }
      },
    );
  }

  final AppState state;
  final UserEntity user;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
