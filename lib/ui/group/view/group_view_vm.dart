import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/group/group_screen.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class GroupViewScreen extends StatelessWidget {
  const GroupViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/$kSettings/$kSettingsGroupSettingsView';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupViewVM>(
      converter: (Store<AppState> store) {
        return GroupViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return GroupView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class GroupViewVM {
  GroupViewVM({
    @required this.state,
    @required this.group,
    @required this.company,
    @required this.onEntityAction,
    @required this.onBackPressed,
    @required this.onClientsPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory GroupViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final group = state.groupState.map[state.groupUIState.selectedId] ??
        GroupEntity(id: state.groupUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadGroup(completer: completer, groupId: group.id));
      return completer.future;
    }

    return GroupViewVM(
        state: state,
        company: state.company,
        isSaving: state.isSaving,
        isLoading: state.isLoading,
        isDirty: group.isNew,
        group: group,
        onRefreshed: (context) => _handleRefresh(context),
        onBackPressed: () {
          store.dispatch(UpdateCurrentRoute(GroupSettingsScreen.route));
        },
        onEntityAction: (BuildContext context, EntityAction action) =>
            handleGroupAction(context, [group], action),
        onClientsPressed: (context, [longPress = false]) {
          if (longPress) {
            handleGroupAction(context, [group], EntityAction.newClient);
          } else {
            viewEntitiesByType(
                context: context,
                entityType: EntityType.client,
                filterEntity: group);
          }
        });
  }

  final AppState state;
  final GroupEntity group;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext, [bool]) onClientsPressed;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
