import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/schedule/schedule_screen.dart';
import 'package:invoiceninja_flutter/ui/schedule/edit/schedule_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/schedule/view/schedule_view_vm.dart';
import 'package:invoiceninja_flutter/redux/schedule/schedule_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/schedule_repository.dart';

List<Middleware<AppState>> createStoreSchedulesMiddleware([
  ScheduleRepository repository = const ScheduleRepository(),
]) {
  final viewScheduleList = _viewScheduleList();
  final viewSchedule = _viewSchedule();
  final editSchedule = _editSchedule();
  final loadSchedules = _loadSchedules(repository);
  final loadSchedule = _loadSchedule(repository);
  final saveSchedule = _saveSchedule(repository);
  final archiveSchedule = _archiveSchedule(repository);
  final deleteSchedule = _deleteSchedule(repository);
  final restoreSchedule = _restoreSchedule(repository);

  return [
    TypedMiddleware<AppState, ViewScheduleList>(viewScheduleList),
    TypedMiddleware<AppState, ViewSchedule>(viewSchedule),
    TypedMiddleware<AppState, EditSchedule>(editSchedule),
    TypedMiddleware<AppState, LoadSchedules>(loadSchedules),
    TypedMiddleware<AppState, LoadSchedule>(loadSchedule),
    TypedMiddleware<AppState, SaveScheduleRequest>(saveSchedule),
    TypedMiddleware<AppState, ArchiveSchedulesRequest>(archiveSchedule),
    TypedMiddleware<AppState, DeleteSchedulesRequest>(deleteSchedule),
    TypedMiddleware<AppState, RestoreSchedulesRequest>(restoreSchedule),
  ];
}

Middleware<AppState> _editSchedule() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditSchedule?;

    next(action);

    store.dispatch(UpdateCurrentRoute(ScheduleEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(ScheduleEditScreen.route);
    }
  };
}

Middleware<AppState> _viewSchedule() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewSchedule?;

    next(action);

    store.dispatch(UpdateCurrentRoute(ScheduleViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(ScheduleViewScreen.route);
    }
  };
}

Middleware<AppState> _viewScheduleList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewScheduleList?;

    next(action);

    if (store.state.staticState.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(ScheduleScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          ScheduleScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveSchedule(ScheduleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveSchedulesRequest;
    final prevSchedules = action.scheduleIds
        .map((id) => store.state.scheduleState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.scheduleIds, EntityAction.archive)
        .then((List<ScheduleEntity> schedules) {
      store.dispatch(ArchiveSchedulesSuccess(schedules));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveSchedulesFailure(prevSchedules));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteSchedule(ScheduleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteSchedulesRequest;
    final prevSchedules = action.scheduleIds
        .map((id) => store.state.scheduleState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.scheduleIds, EntityAction.delete)
        .then((List<ScheduleEntity> schedules) {
      store.dispatch(DeleteSchedulesSuccess(schedules));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteSchedulesFailure(prevSchedules));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreSchedule(ScheduleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreSchedulesRequest;
    final prevSchedules = action.scheduleIds
        .map((id) => store.state.scheduleState.map[id])
        .toList();
    repository
        .bulkAction(
            store.state.credentials, action.scheduleIds, EntityAction.restore)
        .then((List<ScheduleEntity> schedules) {
      store.dispatch(RestoreSchedulesSuccess(schedules));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreSchedulesFailure(prevSchedules));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveSchedule(ScheduleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveScheduleRequest;
    repository
        .saveData(store.state.credentials, action.schedule!)
        .then((ScheduleEntity schedule) {
      if (action.schedule!.isNew) {
        store.dispatch(AddScheduleSuccess(schedule));
      } else {
        store.dispatch(SaveScheduleSuccess(schedule));
      }

      action.completer!.complete(schedule);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveScheduleFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadSchedule(ScheduleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadSchedule;
    final AppState state = store.state;

    store.dispatch(LoadScheduleRequest());
    repository.loadItem(state.credentials, action.scheduleId).then((schedule) {
      store.dispatch(LoadScheduleSuccess(schedule));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadScheduleFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadSchedules(ScheduleRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadSchedules?;
    final AppState state = store.state;

    store.dispatch(LoadSchedulesRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadSchedulesSuccess(data));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadSchedulesFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}
