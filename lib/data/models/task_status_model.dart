// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'task_status_model.g.dart';

abstract class TaskStatusListResponse
    implements Built<TaskStatusListResponse, TaskStatusListResponseBuilder> {
  factory TaskStatusListResponse(
          [void updates(TaskStatusListResponseBuilder b)]) =
      _$TaskStatusListResponse;

  TaskStatusListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<TaskStatusEntity> get data;

  static Serializer<TaskStatusListResponse> get serializer =>
      _$taskStatusListResponseSerializer;
}

abstract class TaskStatusItemResponse
    implements Built<TaskStatusItemResponse, TaskStatusItemResponseBuilder> {
  factory TaskStatusItemResponse(
          [void updates(TaskStatusItemResponseBuilder b)]) =
      _$TaskStatusItemResponse;

  TaskStatusItemResponse._();

  @override
  @memoized
  int get hashCode;

  TaskStatusEntity get data;

  static Serializer<TaskStatusItemResponse> get serializer =>
      _$taskStatusItemResponseSerializer;
}

class TaskStatusFields {
  static const String name = 'name';
  static const String color = 'color';
  static const String order = 'order';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
}

abstract class TaskStatusEntity extends Object
    with BaseEntity, SelectableEntity, EntityStatus
    implements Built<TaskStatusEntity, TaskStatusEntityBuilder> {
  factory TaskStatusEntity({String? id, AppState? state}) {
    return _$TaskStatusEntity._(
      id: id ?? BaseEntity.nextId,
      name: '',
      color: '',
      createdUserId: '',
      isDeleted: false,
      isChanged: false,
      assignedUserId: '',
      archivedAt: 0,
      updatedAt: 0,
      createdAt: 0,
    );
  }

  TaskStatusEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType {
    return EntityType.taskStatus;
  }

  @override
  String get name;

  String get color;

  @BuiltValueField(wireName: 'status_order')
  int? get statusOrder;

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted! &&
        !multiselect &&
        includeEdit &&
        userCompany!.canEditEntity(this)) {
      actions.add(EntityAction.edit);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo({
    TaskStatusEntity? taskStatus,
    String? sortField,
    required bool sortAscending,
  }) {
    int response = 0;
    final TaskStatusEntity? taskStatusA = sortAscending ? this : taskStatus;
    final TaskStatusEntity? taskStatusB = sortAscending ? taskStatus : this;

    switch (sortField) {
      case TaskStatusFields.name:
        response = taskStatusA!.name.compareTo(taskStatusB!.name);
        break;
      case TaskStatusFields.order:
        response = (taskStatusA!.statusOrder ?? 99999)
            .compareTo(taskStatusB!.statusOrder ?? 99999);
        break;
      case TaskStatusFields.updatedAt:
        response = taskStatusA!.updatedAt.compareTo(taskStatusB!.updatedAt);
        break;
      default:
        print('## ERROR: sort by taskStatus.$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        name,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        name,
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName {
    return name;
  }

  // ignore: unused_element
  static void _initializeBuilder(TaskStatusEntityBuilder builder) =>
      builder..color = '';

  static Serializer<TaskStatusEntity> get serializer =>
      _$taskStatusEntitySerializer;
}
