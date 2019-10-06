import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/group/group_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view_vm.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/ui/group/edit/group_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class GroupEditScreen extends StatelessWidget {
  const GroupEditScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsGroupSettingsEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupEditVM>(
      converter: (Store<AppState> store) {
        return GroupEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return GroupEdit(
          viewModel: viewModel,
        );
      },
    );
  }
}

class GroupEditVM {
  GroupEditVM({
    @required this.state,
    @required this.group,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origGroup,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.onBackPressed,
    @required this.isLoading,
  });

  factory GroupEditVM.fromStore(Store<AppState> store) {
    final group = store.state.groupUIState.editing;
    final state = store.state;

    return GroupEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origGroup: state.groupState.map[group.id],
      group: group,
      company: state.selectedCompany,
      onChanged: (GroupEntity group) {
        store.dispatch(UpdateGroup(group));
      },
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(GroupSettingsScreen.route)) {
          store.dispatch(UpdateCurrentRoute(
              group.isNew ? GroupSettingsScreen.route : GroupViewScreen.route));
        }
      },
      onCancelPressed: (BuildContext context) {
        store.dispatch(
            EditGroup(group: GroupEntity(), context: context, force: true));
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        final Completer<GroupEntity> completer = new Completer<GroupEntity>();
        store.dispatch(SaveGroupRequest(completer: completer, group: group));
        return completer.future.then((savedGroup) {
          store.dispatch(UpdateCurrentRoute(GroupViewScreen.route));
          if (isMobile(context)) {
            if (group.isNew) {
              Navigator.of(context).pushReplacementNamed(GroupViewScreen.route);
            } else {
              Navigator.of(context).pop(savedGroup);
            }
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final GroupEntity group;
  final CompanyEntity company;
  final Function(GroupEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Function onBackPressed;
  final bool isLoading;
  final bool isSaving;
  final GroupEntity origGroup;
  final AppState state;
}
