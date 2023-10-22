// Dart imports:
import 'dart:async';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';

part 'project_state.g.dart';

abstract class ProjectState
    implements Built<ProjectState, ProjectStateBuilder> {
  factory ProjectState() {
    return _$ProjectState._(
      map: BuiltMap<String, ProjectEntity>(),
      list: BuiltList<String>(),
    );
  }

  ProjectState._();

  @override
  @memoized
  int get hashCode;

  BuiltMap<String, ProjectEntity> get map;

  ProjectEntity get(String projectId) {
    if (map.containsKey(projectId)) {
      return map[projectId]!;
    } else {
      return ProjectEntity(id: projectId);
    }
  }

  BuiltList<String> get list;

  ProjectState loadProjects(BuiltList<ProjectEntity> clients) {
    final map = Map<String, ProjectEntity>.fromIterable(
      clients,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    );

    return rebuild((b) => b
      ..map.addAll(map)
      ..list.replace((map.keys.toList() + list.toList()).toSet().toList()));
  }

  static Serializer<ProjectState> get serializer => _$projectStateSerializer;
}

abstract class ProjectUIState extends Object
    with EntityUIState
    implements Built<ProjectUIState, ProjectUIStateBuilder> {
  factory ProjectUIState(PrefStateSortField? sortField) {
    return _$ProjectUIState._(
      listUIState: ListUIState(sortField?.field ?? ProjectFields.number,
          sortAscending: sortField?.ascending ?? false),
      editing: ProjectEntity(),
      selectedId: '',
      tabIndex: 0,
    );
  }

  ProjectUIState._();

  @override
  @memoized
  int get hashCode;

  ProjectEntity? get editing;

  @override
  bool get isCreatingNew => editing!.isNew;

  @override
  String get editingId => editing!.id;

  static Serializer<ProjectUIState> get serializer =>
      _$projectUIStateSerializer;
}
