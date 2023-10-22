// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewGroupList implements PersistUI {
  ViewGroupList({this.force = false});

  final bool force;
}

class ViewGroup implements PersistUI, PersistPrefs {
  ViewGroup({
    required this.groupId,
    this.force = false,
  });

  final String? groupId;
  final bool force;
}

class EditGroup implements PersistUI, PersistPrefs {
  EditGroup({required this.group, this.completer, this.force = false});

  final GroupEntity group;
  final Completer? completer;
  final bool force;
}

class UpdateGroup implements PersistUI {
  UpdateGroup(this.group);

  final GroupEntity group;
}

class LoadGroup {
  LoadGroup({this.completer, this.groupId});

  final Completer? completer;
  final String? groupId;
}

class LoadGroupActivity {
  LoadGroupActivity({this.completer, this.groupId});

  final Completer? completer;
  final String? groupId;
}

class LoadGroups {
  LoadGroups({this.completer});

  final Completer? completer;
}

class LoadGroupRequest implements StartLoading {}

class LoadGroupFailure implements StopLoading {
  LoadGroupFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadGroupFailure{error: $error}';
  }
}

class LoadGroupSuccess implements StopLoading, PersistData {
  LoadGroupSuccess(this.group);

  final GroupEntity group;

  @override
  String toString() {
    return 'LoadGroupSuccess{group: $group}';
  }
}

class LoadGroupsRequest implements StartLoading {}

class LoadGroupsFailure implements StopLoading {
  LoadGroupsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadGroupsFailure{error: $error}';
  }
}

class LoadGroupsSuccess implements StopLoading {
  LoadGroupsSuccess(this.groups);

  final BuiltList<GroupEntity> groups;

  @override
  String toString() {
    return 'LoadGroupsSuccess{groups: $groups}';
  }
}

class SaveGroupRequest implements StartSaving {
  SaveGroupRequest({this.completer, this.group});

  final Completer? completer;
  final GroupEntity? group;
}

class SaveGroupSuccess implements StopSaving, PersistData, PersistUI {
  SaveGroupSuccess(this.group);

  final GroupEntity group;
}

class AddGroupSuccess implements StopSaving, PersistData, PersistUI {
  AddGroupSuccess(this.group);

  final GroupEntity group;
}

class SaveGroupFailure implements StopSaving {
  SaveGroupFailure(this.error);

  final Object error;
}

class ArchiveGroupRequest implements StartSaving {
  ArchiveGroupRequest(this.completer, this.groupIds);

  final Completer completer;
  final List<String> groupIds;
}

class ArchiveGroupSuccess implements StopSaving, PersistData {
  ArchiveGroupSuccess(this.groups);

  final List<GroupEntity> groups;
}

class ArchiveGroupFailure implements StopSaving {
  ArchiveGroupFailure(this.groups);

  final List<GroupEntity?> groups;
}

class DeleteGroupRequest implements StartSaving {
  DeleteGroupRequest(this.completer, this.groupIds);

  final Completer completer;
  final List<String> groupIds;
}

class DeleteGroupSuccess implements StopSaving, PersistData {
  DeleteGroupSuccess(this.groups);

  final List<GroupEntity> groups;
}

class DeleteGroupFailure implements StopSaving {
  DeleteGroupFailure(this.groups);

  final List<GroupEntity?> groups;
}

class RestoreGroupRequest implements StartSaving {
  RestoreGroupRequest(this.completer, this.groupIds);

  final Completer completer;
  final List<String> groupIds;
}

class RestoreGroupSuccess implements StopSaving, PersistData {
  RestoreGroupSuccess(this.groups);

  final List<GroupEntity> groups;
}

class RestoreGroupFailure implements StopSaving {
  RestoreGroupFailure(this.groups);

  final List<GroupEntity?> groups;
}

class FilterGroups implements PersistUI {
  FilterGroups(this.filter);

  final String? filter;
}

class SortGroups implements PersistUI, PersistPrefs {
  SortGroups(this.field);

  final String field;
}

class FilterGroupsByState implements PersistUI {
  FilterGroupsByState(this.state);

  final EntityState state;
}

void handleGroupAction(
    BuildContext? context, List<BaseEntity> groups, EntityAction? action) {
  if (groups.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final group = groups.first;
  final groupIds = groups.map((group) => group.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(entity: group);
      break;
    case EntityAction.settings:
      store.dispatch(ViewSettings(
        company: store.state.company,
        user: store.state.user,
        group: group as GroupEntity?,
        section: state.prefState.isDesktop ? kSettingsLocalization : null,
        clearFilter: true,
      ));
      break;
    case EntityAction.newClient:
      createEntity(
          entity: ClientEntity().rebuild((b) => b..groupId = group.id));
      break;
    case EntityAction.restore:
      final message = groupIds.length > 1
          ? localization!.restoredGroups
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', groupIds.length.toString())
          : localization!.restoredGroup;
      store.dispatch(
          RestoreGroupRequest(snackBarCompleter<Null>(message), groupIds));
      break;
    case EntityAction.archive:
      final message = groupIds.length > 1
          ? localization!.archivedGroups
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', groupIds.length.toString())
          : localization!.archivedGroup;
      store.dispatch(
          ArchiveGroupRequest(snackBarCompleter<Null>(message), groupIds));
      break;
    case EntityAction.delete:
      final message = groupIds.length > 1
          ? localization!.deletedGroups
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', groupIds.length.toString())
          : localization!.deletedGroup;
      store.dispatch(
          DeleteGroupRequest(snackBarCompleter<Null>(message), groupIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.groupListState.isInMultiselect()) {
        store.dispatch(StartGroupMultiselect());
      }

      if (groups.isEmpty) {
        break;
      }

      for (final group in groups) {
        if (!store.state.groupListState.isSelected(group.id)) {
          store.dispatch(AddToGroupMultiselect(entity: group));
        } else {
          store.dispatch(RemoveFromGroupMultiselect(entity: group));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [group],
      );
      break;
  }
}

class StartGroupMultiselect {}

class AddToGroupMultiselect {
  AddToGroupMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromGroupMultiselect {
  RemoveFromGroupMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearGroupMultiselect {}

class SaveGroupDocumentRequest implements StartSaving {
  SaveGroupDocumentRequest({
    required this.isPrivate,
    required this.completer,
    required this.multipartFiles,
    required this.group,
  });

  final bool isPrivate;
  final Completer completer;
  final List<MultipartFile> multipartFiles;
  final GroupEntity group;
}

class SaveGroupDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveGroupDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveGroupDocumentFailure implements StopSaving {
  SaveGroupDocumentFailure(this.error);

  final Object error;
}
