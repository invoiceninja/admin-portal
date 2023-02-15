import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'schedule_model.g.dart';

abstract class ScheduleListResponse
    implements Built<ScheduleListResponse, ScheduleListResponseBuilder> {
  factory ScheduleListResponse([void updates(ScheduleListResponseBuilder b)]) =
      _$ScheduleListResponse;

  ScheduleListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<ScheduleEntity> get data;

  static Serializer<ScheduleListResponse> get serializer =>
      _$scheduleListResponseSerializer;
}

abstract class ScheduleItemResponse
    implements Built<ScheduleItemResponse, ScheduleItemResponseBuilder> {
  factory ScheduleItemResponse([void updates(ScheduleItemResponseBuilder b)]) =
      _$ScheduleItemResponse;

  ScheduleItemResponse._();

  @override
  @memoized
  int get hashCode;

  ScheduleEntity get data;

  static Serializer<ScheduleItemResponse> get serializer =>
      _$scheduleItemResponseSerializer;
}

class ScheduleFields {
  // STARTER: fields - do not remove comment
  static const String name = 'name';
}

abstract class ScheduleEntity extends Object
    with BaseEntity
    implements Built<ScheduleEntity, ScheduleEntityBuilder> {
  factory ScheduleEntity({String id, AppState state}) {
    return _$ScheduleEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      createdAt: 0,
      updatedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      archivedAt: 0,
      frequencyId: '',
      isPaused: false,
      name: '',
      nextRun: '',
      template: '',
      parameters: ScheduleParameters(),
    );
  }

  ScheduleEntity._();

  @override
  @memoized
  int get hashCode;

  String get name;

  @BuiltValueField(wireName: 'frequency_id')
  String get frequencyId;

  @BuiltValueField(wireName: 'next_run')
  String get nextRun;

  String get template;

  @BuiltValueField(wireName: 'is_paused')
  bool get isPaused;

  ScheduleParameters get parameters;

  @override
  EntityType get entityType => EntityType.schedule;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted &&
        !multiselect &&
        includeEdit &&
        userCompany.canEditEntity(this)) {
      actions.add(EntityAction.edit);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(ScheduleEntity schedule, String sortField, bool sortAscending) {
    int response = 0;
    final scheduleA = sortAscending ? this : schedule;
    final scheduleB = sortAscending ? schedule : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      case ScheduleFields.name:
        response = scheduleA.name.compareTo(scheduleB.name);
        break;

      default:
        print('## ERROR: sort by schedule.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return scheduleA.name.compareTo(scheduleB.name);
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String filter) {
    return matchesStrings(
      haystacks: [
        //
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        //
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName => null;

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => null;

  static Serializer<ScheduleEntity> get serializer =>
      _$scheduleEntitySerializer;
}

abstract class ScheduleParameters
    implements Built<ScheduleParameters, ScheduleParametersBuilder> {
  factory ScheduleParameters({String id, bool isEnabled}) {
    return _$ScheduleParameters._(
      clients: BuiltList<String>(),
      dateRange: DateRange.thisQuarter.toString(),
      showAgingTable: true,
      showPaymentsTable: true,
      status: kStatementStatusAll,
    );
  }

  ScheduleParameters._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'date_range')
  String get dateRange;

  @BuiltValueField(wireName: 'show_payments_table')
  bool get showPaymentsTable;

  @BuiltValueField(wireName: 'show_aging_table')
  bool get showAgingTable;

  String get status;

  BuiltList<String> get clients;

  // ignore: unused_element
  //static void _initializeBuilder(ScheduleParametersBuilder builder) =>
  //    builder..isEnabled = false;

  static Serializer<ScheduleParameters> get serializer =>
      _$scheduleParametersSerializer;
}
