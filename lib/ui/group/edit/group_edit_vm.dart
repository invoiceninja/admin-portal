import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
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
          key: ValueKey(viewModel.group.id),
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
      company: state.company,
      onChanged: (GroupEntity group) {
        store.dispatch(UpdateGroup(group));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: GroupEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        final localization = AppLocalization.of(context);
        final Completer<GroupEntity> completer = Completer<GroupEntity>();
        store.dispatch(SaveGroupRequest(completer: completer, group: group));
        return completer.future.then((savedGroup) {
          showToast(group.isNew
              ? localization.createdGroup
              : localization.updatedGroup);

          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(GroupViewScreen.route));
            if (group.isNew) {
              Navigator.of(context).pushReplacementNamed(GroupViewScreen.route);
            } else {
              Navigator.of(context).pop(savedGroup);
            }
          } else {
            viewEntity(context: context, entity: savedGroup, force: true);
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
  final bool isLoading;
  final bool isSaving;
  final GroupEntity origGroup;
  final AppState state;
}
