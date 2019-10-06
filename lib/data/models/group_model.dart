import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
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
}

abstract class GroupEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<GroupEntity, GroupEntityBuilder> {
  factory GroupEntity({String id}) {
    return _$GroupEntity._(
      id: id ?? BaseEntity.nextId,
      name: '',
      settings: SettingsEntity(),
    );
  }

  GroupEntity._();

  String get name;

  // TODO remove this
  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  // TODO remove this
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  SettingsEntity get settings;

  int compareTo(GroupEntity group, String sortField, bool sortAscending) {
    int response = 0;
    final GroupEntity groupA = sortAscending ? this : group;
    final GroupEntity groupB = sortAscending ? group : this;

    switch (sortField) {
      /*
      case GroupFields.balance:
        response = groupA.balance.compareTo(groupB.balance);
        break;
      case GroupFields.updatedAt:
        response = groupA.updatedAt.compareTo(groupB.updatedAt);
        break;
       */
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
      bool includeEdit = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
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
