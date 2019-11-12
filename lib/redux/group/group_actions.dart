import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewGroupList implements PersistUI {
  ViewGroupList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewGroup implements PersistUI {
  ViewGroup({
    @required this.groupId,
    @required this.context,
    this.force = false,
  });

  final String groupId;
  final BuildContext context;
  final bool force;
}

class EditGroup implements PersistUI {
  EditGroup(
      {@required this.group,
      @required this.context,
      this.completer,
      this.force = false});

  final GroupEntity group;
  final BuildContext context;
  final Completer completer;
  final bool force;
}

class UpdateGroup implements PersistUI {
  UpdateGroup(this.group);

  final GroupEntity group;
}

class LoadGroup {
  LoadGroup({this.completer, this.groupId, this.loadActivities = false});

  final Completer completer;
  final String groupId;
  final bool loadActivities;
}

class LoadGroupActivity {
  LoadGroupActivity({this.completer, this.groupId});

  final Completer completer;
  final String groupId;
}

class LoadGroups {
  LoadGroups({this.completer, this.force = false});

  final Completer completer;
  final bool force;
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

class LoadGroupsSuccess implements StopLoading, PersistData {
  LoadGroupsSuccess(this.groups);

  final BuiltList<GroupEntity> groups;

  @override
  String toString() {
    return 'LoadGroupsSuccess{groups: $groups}';
  }
}

class SaveGroupRequest implements StartSaving {
  SaveGroupRequest({this.completer, this.group});

  final Completer completer;
  final GroupEntity group;
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

  final List<GroupEntity> groups;
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

  final List<GroupEntity> groups;
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

  final List<GroupEntity> groups;
}

class FilterGroups {
  FilterGroups(this.filter);

  final String filter;
}

class SortGroups implements PersistUI {
  SortGroups(this.field);

  final String field;
}

class FilterGroupsByState implements PersistUI {
  FilterGroupsByState(this.state);

  final EntityState state;
}

class FilterGroupsByCustom1 implements PersistUI {
  FilterGroupsByCustom1(this.value);

  final String value;
}

class FilterGroupsByCustom2 implements PersistUI {
  FilterGroupsByCustom2(this.value);

  final String value;
}

class FilterGroupsByEntity implements PersistUI {
  FilterGroupsByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

void handleGroupAction(
    BuildContext context, List<BaseEntity> groups, EntityAction action) {

  if (groups.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final group = groups.first;
  final groupIds = groups.map((group) => group.id).toList();

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditGroup(context: context, group: group));
      break;
    case EntityAction.settings:
      store.dispatch(ViewSettings(
          context: context, group: group, section: kSettingsCompanyDetails));
      break;
    case EntityAction.newClient:
      store.dispatch(EditClient(
          context: context,
          client: ClientEntity().rebuild((b) => b..groupId = group.id)));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreGroupRequest(
          snackBarCompleter<Null>(context, localization.restoredGroup), groupIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveGroupRequest(
          snackBarCompleter<Null>(context, localization.archivedGroup), groupIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteGroupRequest(
          snackBarCompleter<Null>(context, localization.deletedGroup), groupIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.groupListState.isInMultiselect()) {
        store.dispatch(StartGroupMultiselect(context: context));
      }

      if (groups.isEmpty) {
        break;
      }

      for (final group in groups) {
        if (!store.state.groupListState.isSelected(group.id)) {
          store
              .dispatch(AddToGroupMultiselect(context: context, entity: group));
        } else {
          store.dispatch(
              RemoveFromGroupMultiselect(context: context, entity: group));
        }
      }
      break;
  }
}

class StartGroupMultiselect {
  StartGroupMultiselect({@required this.context});

  final BuildContext context;
}

class AddToGroupMultiselect {
  AddToGroupMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromGroupMultiselect {
  RemoveFromGroupMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearGroupMultiselect {
  ClearGroupMultiselect({@required this.context});

  final BuildContext context;
}
