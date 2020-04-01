import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'group_model.g.dart';

abstract class GroupListResponse
    implements Built<GroupListResponse, GroupListResponseBuilder> {
  factory GroupListResponse([void updates(GroupListResponseBuilder b)]) =
      _$GroupListResponse;

  GroupListResponse._();

  BuiltList<GroupEntity> get data;

  static Serializer<GroupListResponse> get serializer =>
      _$groupListResponseSerializer;
}

abstract class GroupItemResponse
    implements Built<GroupItemResponse, GroupItemResponseBuilder> {
  factory GroupItemResponse([void updates(GroupItemResponseBuilder b)]) =
      _$GroupItemResponse;

  GroupItemResponse._();

  GroupEntity get data;

  static Serializer<GroupItemResponse> get serializer =>
      _$groupItemResponseSerializer;
}

class GroupFields {
  static const String name = 'name';
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
}

abstract class GroupEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<GroupEntity, GroupEntityBuilder> {
  factory GroupEntity({String id, AppState state}) {
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
    );
  }

  GroupEntity._();

  @override
  EntityType get entityType {
    return EntityType.group;
  }

  String get name;

  SettingsEntity get settings;

  @override
  String get listDisplayName {
    return name;
  }

  bool get hasCurrency =>
      settings.currencyId != null && settings.currencyId.isNotEmpty;

  String get currencyId => settings.currencyId;

  bool get hasLanguage =>
      settings.languageId != null && settings.languageId.isNotEmpty;

  String get languageId => settings.languageId;

  int compareTo(GroupEntity group, String sortField, bool sortAscending) {
    const int response = 0;
    final GroupEntity groupA = sortAscending ? this : group;
    final GroupEntity groupB = sortAscending ? group : this;

    switch (sortField) {
      case GroupFields.name:
      //response = groupA.balance.compareTo(groupB.balance);
      //break;
    }

    if (response == 0) {
      return groupA.name.toLowerCase().compareTo(groupB.name.toLowerCase());
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }
    filter = filter.toLowerCase();

    if (name.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    return null;
  }

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    // TODO remove ??
    if (!(isDeleted ?? false)) {
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany.canEditEntity(this)) {
        actions.add(EntityAction.settings);
      }

      if (userCompany.canCreate(EntityType.client)) {
        actions.add(EntityAction.newClient);
      }
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => null;

  static Serializer<GroupEntity> get serializer => _$groupEntitySerializer;
}
