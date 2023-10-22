import 'dart:async';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/schedule/schedule_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/schedule/view/schedule_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ScheduleViewScreen extends StatelessWidget {
  const ScheduleViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  static const String route = '/$kSettings/$kSettingsSchedulesView';

  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ScheduleViewVM>(
      converter: (Store<AppState> store) {
        return ScheduleViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ScheduleView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class ScheduleViewVM {
  ScheduleViewVM({
    required this.state,
    required this.schedule,
    required this.company,
    required this.onEntityAction,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
    required this.onBackPressed,
  });

  factory ScheduleViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final schedule =
        state.scheduleState.map[state.scheduleUIState.selectedId] ??
            ScheduleEntity(ScheduleEntity.TEMPLATE_EMAIL_STATEMENT,
                id: state.scheduleUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(
          LoadSchedule(completer: completer, scheduleId: schedule.id));
      return completer.future;
    }

    return ScheduleViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: schedule.isNew,
      schedule: schedule,
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(ScheduleScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([schedule], action, autoPop: true),
    );
  }

  final AppState state;
  final ScheduleEntity schedule;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final Function onBackPressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
