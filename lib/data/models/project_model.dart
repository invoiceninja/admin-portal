import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
  static const String clientId = 'client_id';
  static const String client = 'client';
  static const String taskRate = 'task_rate';
  static const String dueDate = 'due_date';
  static const String privateNotes = 'private_notes';
  static const String budgetedHours = 'budgeted_hours';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
}

abstract class ProjectEntity extends Object
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<ProjectEntity, ProjectEntityBuilder> {
  factory ProjectEntity({String id, AppState state}) {
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
      customValue3: '',
      customValue4: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      createdUserId: '',
      createdAt: 0,
      assignedUserId: '',
    );
  }

  ProjectEntity._();

  ProjectEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false);

  @override
  EntityType get entityType {
    return EntityType.project;
  }

  String get name;

  @override
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

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

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
        break;
      default:
        print('## ERROR: sort by project.$sortField is not implemented');
        break;
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
    } else if (customValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue2.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue3.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue4.toLowerCase().contains(filter)) {
      return true;
    }

    return name.toLowerCase().contains(filter);
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    } else if (customValue1.toLowerCase().contains(filter)) {
      return customValue1;
    } else if (customValue2.toLowerCase().contains(filter)) {
      return customValue2;
    } else if (customValue3.toLowerCase().contains(filter)) {
      return customValue3;
    } else if (customValue4.toLowerCase().contains(filter)) {
      return customValue4;
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
