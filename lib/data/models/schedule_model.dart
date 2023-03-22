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
  static const String name = 'name';
  static const String template = 'template';
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
      remainingCycles: -1,
      createdUserId: '',
      assignedUserId: '',
      archivedAt: 0,
      frequencyId: kFrequencyMonthly,
      isPaused: false,
      name: '',
      nextRun: '',
      template: TEMPLATE_EMAIL_STATEMENT,
      parameters: ScheduleParameters(),
    );
  }

  ScheduleEntity._();

  static const TEMPLATE_EMAIL_STATEMENT = 'email_statement';
  static const TEMPLATE_EMAIL_RECORD = 'email_record';

  static const TEMPLATES = [
    TEMPLATE_EMAIL_STATEMENT,
    TEMPLATE_EMAIL_RECORD,
  ];

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

  @BuiltValueField(wireName: 'remaining_cycles')
  int get remainingCycles;

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
      case ScheduleFields.name:
        response = scheduleA.name.compareTo(scheduleB.name);
        break;
      case ScheduleFields.template:
        response = scheduleA.template.compareTo(scheduleB.template);
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
        name,
        template,
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        template,
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName => name;

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
      dateRange: DateRange.thisQuarter.snakeCase,
      showAgingTable: true,
      showPaymentsTable: true,
      status: kStatementStatusAll,
      entityType: EntityType.invoice.toString(),
      entityId: '',
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

  @BuiltValueField(wireName: 'entity')
  String get entityType;

  @BuiltValueField(wireName: 'entity_id')
  String get entityId;

  // ignore: unused_element
  static void _initializeBuilder(ScheduleParametersBuilder builder) => builder
    ..dateRange = ''
    ..showPaymentsTable = false
    ..showAgingTable = false
    ..status = ''
    ..clients.replace(BuiltList<String>())
    ..entityType = ''
    ..entityId = '';

  static Serializer<ScheduleParameters> get serializer =>
      _$scheduleParametersSerializer;
}
