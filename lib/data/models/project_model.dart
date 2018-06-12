import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'project_model.g.dart';

abstract class ProjectListResponse implements Built<ProjectListResponse, ProjectListResponseBuilder> {

  BuiltList<ProjectEntity> get data;

  ProjectListResponse._();
  factory ProjectListResponse([updates(ProjectListResponseBuilder b)]) = _$ProjectListResponse;
  static Serializer<ProjectListResponse> get serializer => _$projectListResponseSerializer;
}

abstract class ProjectItemResponse implements Built<ProjectItemResponse, ProjectItemResponseBuilder> {

  ProjectEntity get data;

  ProjectItemResponse._();
  factory ProjectItemResponse([updates(ProjectItemResponseBuilder b)]) = _$ProjectItemResponse;
  static Serializer<ProjectItemResponse> get serializer => _$projectItemResponseSerializer;
}

class ProjectFields {
  static const String name = 'name';
  static const String clientId = 'clientAt';
  static const String taskRate = 'taskRate';
  static const String dueDate = 'due_date';
  static const String privateNotes = 'privateNotes';
  static const String budgetedHours = 'budgetedHours';
  static const String customValue1 = 'customValue1';
  static const String customValue2 = 'customValue2';
  
  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class ProjectEntity extends Object with BaseEntity implements Built<ProjectEntity, ProjectEntityBuilder> {

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: 'client_id')
  int get clientId;
  
  @nullable
  @BuiltValueField(wireName: 'task_rate')
  double get taskRate;

  @nullable
  @BuiltValueField(wireName: 'due_date')
  String get dueDate;

  @nullable
  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @nullable
  @BuiltValueField(wireName: 'budgeted_hours')
  double get budgetedHours;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  int compareTo(ProjectEntity project, String sortField, bool sortAscending) {
    int response = 0;
    ProjectEntity projectA = sortAscending ? this : project;
    ProjectEntity projectB = sortAscending ? project: this;

    switch (sortField) {
      case ProjectFields.taskRate:
        response = projectA.taskRate.compareTo(projectB.taskRate);
    }

    if (response == 0) {
      return projectA.name.compareTo(projectB.name);
    } else {
      return response;
    }
  }

  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return name.contains(search);
  }

  ProjectEntity._();
  factory ProjectEntity([updates(ProjectEntityBuilder b)]) = _$ProjectEntity;
  static Serializer<ProjectEntity> get serializer => _$projectEntitySerializer;
}
