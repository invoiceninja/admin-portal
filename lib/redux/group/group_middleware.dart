// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/repositories/group_repository.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/group/edit/group_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/group/group_screen.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view_vm.dart';

List<Middleware<AppState>> createStoreGroupsMiddleware([
  GroupRepository repository = const GroupRepository(),
]) {
  final viewGroupList = _viewGroupList();
  final viewGroup = _viewGroup();
  final editGroup = _editGroup();
  final loadGroups = _loadGroups(repository);
  final loadGroup = _loadGroup(repository);
  final saveGroup = _saveGroup(repository);
  final archiveGroup = _archiveGroup(repository);
  final deleteGroup = _deleteGroup(repository);
  final restoreGroup = _restoreGroup(repository);
  final saveDocument = _saveDocument(repository);

  return [
    TypedMiddleware<AppState, ViewGroupList>(viewGroupList),
    TypedMiddleware<AppState, ViewGroup>(viewGroup),
    TypedMiddleware<AppState, EditGroup>(editGroup),
    TypedMiddleware<AppState, LoadGroups>(loadGroups),
    TypedMiddleware<AppState, LoadGroup>(loadGroup),
    TypedMiddleware<AppState, SaveGroupRequest>(saveGroup),
    TypedMiddleware<AppState, ArchiveGroupRequest>(archiveGroup),
    TypedMiddleware<AppState, DeleteGroupRequest>(deleteGroup),
    TypedMiddleware<AppState, RestoreGroupRequest>(restoreGroup),
    TypedMiddleware<AppState, SaveGroupDocumentRequest>(saveDocument),
  ];
}

Middleware<AppState> _editGroup() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditGroup?;

    next(action);

    store.dispatch(UpdateCurrentRoute(GroupEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(GroupEditScreen.route);
    }
  };
}

Middleware<AppState> _viewGroup() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewGroup?;

    next(action);

    store.dispatch(UpdateCurrentRoute(GroupViewScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamed(GroupViewScreen.route);
    }
  };
}

Middleware<AppState> _viewGroupList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewGroupList?;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(GroupSettingsScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          GroupSettingsScreen.route, (Route<dynamic> route) => false);
    }
  };
}

Middleware<AppState> _archiveGroup(GroupRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveGroupRequest;
    final prevGroups =
        action.groupIds.map((id) => store.state.groupState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.groupIds, EntityAction.archive)
        .then((List<GroupEntity> groups) {
      store.dispatch(ArchiveGroupSuccess(groups));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveGroupFailure(prevGroups));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _deleteGroup(GroupRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteGroupRequest;
    final prevGroups =
        action.groupIds.map((id) => store.state.groupState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.groupIds, EntityAction.delete)
        .then((List<GroupEntity> groups) {
      store.dispatch(DeleteGroupSuccess(groups));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteGroupFailure(prevGroups));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _restoreGroup(GroupRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreGroupRequest;
    final prevGroups =
        action.groupIds.map((id) => store.state.groupState.map[id]).toList();

    repository
        .bulkAction(
            store.state.credentials, action.groupIds, EntityAction.restore)
        .then((List<GroupEntity> groups) {
      store.dispatch(RestoreGroupSuccess(groups));
      action.completer.complete(null);
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreGroupFailure(prevGroups));
      action.completer.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _saveGroup(GroupRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveGroupRequest;
    repository
        .saveData(store.state.credentials, action.group!)
        .then((GroupEntity group) {
      if (action.group!.isNew) {
        store.dispatch(AddGroupSuccess(group));
      } else {
        store.dispatch(SaveGroupSuccess(group));
      }
      action.completer!.complete(group);
    }).catchError((Object error) {
      print(error);
      store.dispatch(SaveGroupFailure(error));
      action.completer!.completeError(error);
    });

    next(action);
  };
}

Middleware<AppState> _loadGroup(GroupRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadGroup;
    final AppState state = store.state;

    store.dispatch(LoadGroupRequest());
    repository.loadItem(state.credentials, action.groupId).then((group) {
      store.dispatch(LoadGroupSuccess(group));

      if (action.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadGroupFailure(error));
      if (action.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadGroups(GroupRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadGroups?;
    final AppState state = store.state;

    store.dispatch(LoadGroupsRequest());
    repository.loadList(state.credentials).then((data) {
      store.dispatch(LoadGroupsSuccess(data));

      final documents = <DocumentEntity>[];
      data.forEach((group) {
        group.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = group.id
            ..parentType = EntityType.group));
        });
      });
      store.dispatch(LoadDocumentsSuccess(documents));

      if (action!.completer != null) {
        action.completer!.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadGroupsFailure(error));
      if (action!.completer != null) {
        action.completer!.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(GroupRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveGroupDocumentRequest?;
    if (store.state.isEnterprisePlan) {
      repository
          .uploadDocuments(
        store.state.credentials,
        action!.group,
        action.multipartFiles,
        action.isPrivate,
      )
          .then((group) {
        store.dispatch(SaveGroupSuccess(group));

        final documents = <DocumentEntity>[];
        group.documents.forEach((document) {
          documents.add(document.rebuild((b) => b
            ..parentId = group.id
            ..parentType = EntityType.group));
        });
        store.dispatch(LoadDocumentsSuccess(documents));
        action.completer.complete(documents);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveGroupDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveGroupDocumentFailure(error));
      action!.completer.completeError(error);
    }

    next(action);
  };
}
