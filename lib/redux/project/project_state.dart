import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/project_model.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

part 'project_state.g.dart';

abstract class ProjectState implements Built<ProjectState, ProjectStateBuilder> {

  factory ProjectState() {
    return _$ProjectState._(
      lastUpdated: 0,
      map: BuiltMap<int, ProjectEntity>(),
      list: BuiltList<int>(),
    );
  }
  ProjectState._();

  @nullable
  int get lastUpdated;

  BuiltMap<int, ProjectEntity> get map;
  BuiltList<int> get list;

  bool get isStale {
    if (! isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated > kMillisecondsToRefreshData;
  }

  bool get isLoaded => lastUpdated != null && lastUpdated > 0;

  static Serializer<ProjectState> get serializer => _$projectStateSerializer;
}

abstract class ProjectUIState extends Object with EntityUIState implements Built<ProjectUIState, ProjectUIStateBuilder> {

  factory ProjectUIState() {
    return _$ProjectUIState._(
      listUIState: ListUIState(ProjectFields.name),
      editing: ProjectEntity(),
      selectedId: 0,
    );
  }
  ProjectUIState._();

  @nullable
  ProjectEntity get editing;

  @override
  bool get isCreatingNew => editing.isNew;

  static Serializer<ProjectUIState> get serializer => _$projectUIStateSerializer;
}