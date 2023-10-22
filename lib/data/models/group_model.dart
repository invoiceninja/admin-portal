// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'group_model.g.dart';

abstract class GroupListResponse
    implements Built<GroupListResponse, GroupListResponseBuilder> {
  factory GroupListResponse([void updates(GroupListResponseBuilder b)]) =
      _$GroupListResponse;

  GroupListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<GroupEntity> get data;

  static Serializer<GroupListResponse> get serializer =>
      _$groupListResponseSerializer;
}

abstract class GroupItemResponse
    implements Built<GroupItemResponse, GroupItemResponseBuilder> {
  factory GroupItemResponse([void updates(GroupItemResponseBuilder b)]) =
      _$GroupItemResponse;

  GroupItemResponse._();

  @override
  @memoized
  int get hashCode;

  GroupEntity get data;

  static Serializer<GroupItemResponse> get serializer =>
      _$groupItemResponseSerializer;
}

class GroupFields {
  static const String name = 'name';
  static const String documents = 'documents';
}

abstract class GroupEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<GroupEntity, GroupEntityBuilder> {
  factory GroupEntity({String? id, AppState? state}) {
    return _$GroupEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      name: '',
      settings: SettingsEntity(),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      createdAt: 0,
      assignedUserId: '',
      createdUserId: '',
      documents: BuiltList<DocumentEntity>(),
    );
  }

  GroupEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType {
    return EntityType.group;
  }

  String get name;

  SettingsEntity get settings;

  BuiltList<DocumentEntity> get documents;

  @override
  String get listDisplayName {
    return name;
  }

  bool get hasCurrency =>
      settings.currencyId != null && settings.currencyId!.isNotEmpty;

  String? get currencyId => settings.currencyId;

  bool get hasLanguage =>
      settings.languageId != null && settings.languageId!.isNotEmpty;

  String? get languageId => settings.languageId;

  int compareTo(GroupEntity? group, String sortField, bool sortAscending) {
    int response = 0;
    final GroupEntity? groupA = sortAscending ? this : group;
    final GroupEntity? groupB = sortAscending ? group : this;

    switch (sortField) {
      case GroupFields.name:
        response =
            groupA!.name.toLowerCase().compareTo(groupB!.name.toLowerCase());
        break;
      default:
        print('## ERROR: sort by group.$sortField is not implemented');
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
      haystacks: [],
      needle: filter,
    );
  }

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted! && !multiselect) {
      if (includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.settings);
      }

      if (userCompany.canCreate(EntityType.client)) {
        actions.add(EntityAction.newClient);
      }
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType? get listDisplayAmountType => null;

  // ignore: unused_element
  static void _initializeBuilder(GroupEntityBuilder builder) =>
      builder..documents.replace(BuiltList<DocumentEntity>());

  static Serializer<GroupEntity> get serializer => _$groupEntitySerializer;
}
