import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'project_model.g.dart';

abstract class ProjectListResponse
    implements Built<ProjectListResponse, ProjectListResponseBuilder> {
  factory ProjectListResponse([void updates(ProjectListResponseBuilder b)]) =
      _$ProjectListResponse;

  ProjectListResponse._();

  BuiltList<ProjectEntity> get data;

  static Serializer<ProjectListResponse> get serializer =>
      _$projectListResponseSerializer;
}

abstract class ProjectItemResponse
    implements Built<ProjectItemResponse, ProjectItemResponseBuilder> {
  factory ProjectItemResponse([void updates(ProjectItemResponseBuilder b)]) =
      _$ProjectItemResponse;

  ProjectItemResponse._();

  ProjectEntity get data;

  static Serializer<ProjectItemResponse> get serializer =>
      _$projectItemResponseSerializer;
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

abstract class ProjectEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ProjectEntity, ProjectEntityBuilder> {
  factory ProjectEntity({String id}) {
    return _$ProjectEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      name: '',
      clientId: '',
      taskRate: 0.0,
      dueDate: '',
      privateNotes: '',
      budgetedHours: 0.0,
      customValue1: '',
      customValue2: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  ProjectEntity._();

  ProjectEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isDeleted = false);

  @override
  EntityType get entityType {
    return EntityType.project;
  }

  String get name;

  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'task_rate')
  double get taskRate;

  @BuiltValueField(wireName: 'due_date')
  String get dueDate;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'budgeted_hours')
  double get budgetedHours;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany.canCreate(EntityType.task) && isActive) {
        actions.add(EntityAction.newTask);
      }

      if (userCompany.canCreate(EntityType.invoice) && isActive) {
        actions.add(EntityAction.newInvoice);
      }
    }

    if (userCompany.canCreate(EntityType.project)) {
      actions.add(EntityAction.clone);
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(ProjectEntity project, String sortField, bool sortAscending) {
    int response = 0;
    final ProjectEntity projectA = sortAscending ? this : project;
    final ProjectEntity projectB = sortAscending ? project : this;

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

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    return name.toLowerCase().contains(filter);
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double get listDisplayAmount => null;

  bool get hasClient => clientId != null && clientId.isNotEmpty;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static Serializer<ProjectEntity> get serializer => _$projectEntitySerializer;
}
