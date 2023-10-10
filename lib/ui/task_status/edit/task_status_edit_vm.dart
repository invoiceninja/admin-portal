// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/task_status/edit/task_status_edit.dart';
import 'package:invoiceninja_flutter/ui/task_status/view/task_status_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class TaskStatusEditScreen extends StatelessWidget {
  const TaskStatusEditScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsTaskStatusEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskStatusEditVM>(
      converter: (Store<AppState> store) {
        return TaskStatusEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return TaskStatusEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.taskStatus.updatedAt),
        );
      },
    );
  }
}

class TaskStatusEditVM {
  TaskStatusEditVM({
    required this.state,
    required this.taskStatus,
    required this.company,
    required this.onChanged,
    required this.isSaving,
    required this.origTaskStatus,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isLoading,
  });

  factory TaskStatusEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final taskStatus = state.taskStatusUIState.editing!;

    return TaskStatusEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origTaskStatus: state.taskStatusState.map[taskStatus.id],
      taskStatus: taskStatus,
      company: state.company,
      onChanged: (TaskStatusEntity taskStatus) {
        store.dispatch(UpdateTaskStatus(taskStatus));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(entity: TaskStatusEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final taskStatus = store.state.taskStatusUIState.editing;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          final Completer<TaskStatusEntity> completer =
              new Completer<TaskStatusEntity>();
          store.dispatch(SaveTaskStatusRequest(
              completer: completer, taskStatus: taskStatus));
          return completer.future.then((savedTaskStatus) {
            showToast(taskStatus!.isNew
                ? localization!.createdTaskStatus
                : localization!.updatedTaskStatus);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(TaskStatusViewScreen.route));
              if (taskStatus.isNew) {
                navigator!.pushReplacementNamed(TaskStatusViewScreen.route);
              } else {
                navigator!.pop(savedTaskStatus);
              }
            } else {
              viewEntity(entity: savedTaskStatus, force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final TaskStatusEntity taskStatus;
  final CompanyEntity? company;
  final Function(TaskStatusEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final TaskStatusEntity? origTaskStatus;
  final AppState state;
}
