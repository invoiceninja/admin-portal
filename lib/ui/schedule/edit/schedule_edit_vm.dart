import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/schedule/view/schedule_view_vm.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_actions.dart';
import 'package:invoiceninja_flutter/ui/schedule/edit/schedule_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ScheduleEditScreen extends StatelessWidget {
  const ScheduleEditScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsSchedulesEdit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ScheduleEditVM>(
      converter: (Store<AppState> store) {
        return ScheduleEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return ScheduleEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.schedule.updatedAt),
        );
      },
    );
  }
}

class ScheduleEditVM {
  ScheduleEditVM({
    required this.state,
    required this.schedule,
    required this.company,
    required this.onChanged,
    required this.isSaving,
    required this.origSchedule,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isLoading,
  });

  factory ScheduleEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final schedule = state.scheduleUIState.editing!;

    return ScheduleEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origSchedule: state.scheduleState.map[schedule.id],
      schedule: schedule,
      company: state.company,
      onChanged: (ScheduleEntity schedule) {
        store.dispatch(UpdateSchedule(schedule));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(
            entity: ScheduleEntity(ScheduleEntity.TEMPLATE_EMAIL_STATEMENT),
            force: true);
        if (state.scheduleUIState.cancelCompleter != null) {
          state.scheduleUIState.cancelCompleter!.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final schedule = store.state.scheduleUIState.editing;
          final localization = AppLocalization.of(context);
          final Completer<ScheduleEntity> completer =
              new Completer<ScheduleEntity>();
          store.dispatch(
              SaveScheduleRequest(completer: completer, schedule: schedule));
          return completer.future.then((savedSchedule) {
            showToast(schedule!.isNew
                ? localization!.createdSchedule
                : localization!.updatedSchedule);
            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(ScheduleViewScreen.route));
              if (schedule.isNew) {
                Navigator.of(context)
                    .pushReplacementNamed(ScheduleViewScreen.route);
              } else {
                Navigator.of(context).pop(savedSchedule);
              }
            } else {
              viewEntity(entity: savedSchedule, force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final ScheduleEntity schedule;
  final CompanyEntity? company;
  final Function(ScheduleEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final ScheduleEntity? origSchedule;
  final AppState state;
}
