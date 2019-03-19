import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'entities.g.dart';

class EntityType extends EnumClass {
  const EntityType._(String name) : super(name);

  static Serializer<EntityType> get serializer => _$entityTypeSerializer;

  static const EntityType invoice = _$invoice;
  static const EntityType recurringInvoice = _$recurringInvoice;
  static const EntityType invoiceItem = _$invoiceItem;
  static const EntityType quote = _$quote;
  static const EntityType product = _$product;
  static const EntityType client = _$client;
  static const EntityType contact = _$contact;
  static const EntityType task = _$task;
  static const EntityType project = _$project;
  static const EntityType expense = _$expense;
  static const EntityType vendor = _$vendor;
  static const EntityType credit = _$credit;
  static const EntityType payment = _$payment;
  static const EntityType country = _$country;
  static const EntityType currency = _$currency;
  static const EntityType language = _$language;
  static const EntityType industry = _$industry;
  static const EntityType size = _$size;
  static const EntityType paymentType = _$paymentType;
  static const EntityType taskStatus = _$taskStatus;

  String get plural {
    return toString() + 's';
  }

  static BuiltSet<EntityType> get values => _$typeValues;

  static EntityType valueOf(String name) => _$typeValueOf(name);
}

class EntityState extends EnumClass {
  const EntityState._(String name) : super(name);

  static Serializer<EntityState> get serializer => _$entityStateSerializer;

  static const EntityState active = _$active;
  static const EntityState archived = _$archived;
  static const EntityState deleted = _$deleted;

  static BuiltSet<EntityState> get values => _$values;

  static EntityState valueOf(String name) => _$valueOf(name);
}

class EmailTemplate extends EnumClass {
  const EmailTemplate._(String name) : super(name);

  static Serializer<EmailTemplate> get serializer => _$emailTemplateSerializer;

  static const EmailTemplate initial = _$initial;
  static const EmailTemplate reminder1 = _$reminder1;
  static const EmailTemplate reminder2 = _$reminder2;
  static const EmailTemplate reminder3 = _$reminder3;

  static BuiltSet<EmailTemplate> get values => _$templateValues;

  static EmailTemplate valueOf(String name) => _$templateValueOf(name);
}

class UserPermission extends EnumClass {
  const UserPermission._(String name) : super(name);

  static Serializer<UserPermission> get serializer =>
      _$userPermissionSerializer;

  static const UserPermission create = _$create;
  static const UserPermission edit = _$edit;
  static const UserPermission view = _$view;

  static BuiltSet<UserPermission> get values => _$permissionValues;

  static UserPermission valueOf(String name) => _$permissionValueOf(name);
}

abstract class EntityStatus {
  int get id;

  String get name;
}

abstract class SelectableEntity {
  @nullable
  int get id;

  bool matchesFilter(String filter) => true;

  String matchesFilterValue(String filter) => null;

  String get listDisplayName => 'Error: listDisplayName not set';

  double get listDisplayAmount => null;

  FormatNumberType get listDisplayAmountType => FormatNumberType.money;
}

abstract class BaseEntity implements SelectableEntity {
  @nullable
  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  @nullable
  @BuiltValueField(wireName: 'updated_at')
  int get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'archived_at')
  int get archivedAt;

  @nullable
  @BuiltValueField(wireName: 'is_deleted')
  bool get isDeleted;

  @nullable
  @BuiltValueField(wireName: 'is_owner')
  bool get isOwner;

  String get entityKey => '__${entityType}__${id}__';

  EntityType get entityType => throw 'EntityType not set: ${this}';

  bool get isNew => id == null || id < 0;

  bool get isActive => archivedAt == null || archivedAt == 0;

  bool get isArchived => archivedAt != null && archivedAt > 0 && !isDeleted;

  List<EntityAction> getBaseActions({UserEntity user}) {
    final actions = <EntityAction>[];

    if (user.canEditEntity(this) && (isArchived || isDeleted)) {
      actions.add(EntityAction.restore);
    }

    if (user.canEditEntity(this) && isActive) {
      actions.add(EntityAction.archive);
    }

    if (user.canEditEntity(this) && (isActive || isArchived)) {
      actions.add(EntityAction.delete);
    }

    return actions;
  }

  bool matchesStatuses(BuiltList<EntityStatus> statuses) {
    return true;
  }

  bool matchesStates(BuiltList<EntityState> states) {
    if (states.isEmpty) {
      return true;
    }

    if (states.contains(EntityState.active) && isActive) {
      return true;
    }

    if (states.contains(EntityState.archived) && isArchived) {
      return true;
    }

    if (states.contains(EntityState.deleted) && isDeleted) {
      return true;
    }

    return false;
  }
}

abstract class BelongsToClient {
  int get clientId;
}

abstract class ErrorMessage
    implements Built<ErrorMessage, ErrorMessageBuilder> {
  factory ErrorMessage([void updates(ErrorMessageBuilder b)]) = _$ErrorMessage;

  ErrorMessage._();

  String get message;

  static Serializer<ErrorMessage> get serializer => _$errorMessageSerializer;
}

abstract class LoginResponse
    implements Built<LoginResponse, LoginResponseBuilder> {
  factory LoginResponse([void updates(LoginResponseBuilder b)]) =
      _$LoginResponse;

  LoginResponse._();

  LoginResponseData get data;

  @nullable
  ErrorMessage get error;

  static Serializer<LoginResponse> get serializer => _$loginResponseSerializer;
}

abstract class LoginResponseData
    implements Built<LoginResponseData, LoginResponseDataBuilder> {
  factory LoginResponseData([void updates(LoginResponseDataBuilder b)]) =
      _$LoginResponseData;

  LoginResponseData._();

  BuiltList<CompanyEntity> get accounts;

  String get version;

  StaticData get static;

  static Serializer<LoginResponseData> get serializer =>
      _$loginResponseDataSerializer;
}

abstract class StaticData implements Built<StaticData, StaticDataBuilder> {
  factory StaticData([void updates(StaticDataBuilder b)]) = _$StaticData;

  StaticData._();

  BuiltList<CurrencyEntity> get currencies;

  BuiltList<SizeEntity> get sizes;

  BuiltList<IndustryEntity> get industries;

  BuiltList<TimezoneEntity> get timezones;

  BuiltList<DateFormatEntity> get dateFormats;

  BuiltList<DatetimeFormatEntity> get datetimeFormats;

  BuiltList<LanguageEntity> get languages;

  BuiltList<PaymentTypeEntity> get paymentTypes;

  BuiltList<CountryEntity> get countries;

  BuiltList<InvoiceStatusEntity> get invoiceStatus;

  BuiltList<FrequencyEntity> get frequencies;

  static Serializer<StaticData> get serializer => _$staticDataSerializer;
}

abstract class DashboardResponse
    implements Built<DashboardResponse, DashboardResponseBuilder> {
  factory DashboardResponse([void updates(DashboardResponseBuilder b)]) =
      _$DashboardResponse;

  DashboardResponse._();

  DashboardEntity get data;

  static Serializer<DashboardResponse> get serializer =>
      _$dashboardResponseSerializer;
}

class CustomFieldType {
  static const String product1 = 'product1';
  static const String product2 = 'product2';
  static const String client1 = 'client1';
  static const String client2 = 'client2';
  static const String contact1 = 'contact1';
  static const String contact2 = 'contact2';
  static const String task1 = 'task1';
  static const String task2 = 'task2';
  static const String project1 = 'project1';
  static const String project2 = 'project2';
  static const String expense1 = 'expense1';
  static const String expense2 = 'expense2';
  static const String vendor1 = 'vendor1';
  static const String vendor2 = 'vendor2';
  static const String invoice1 = 'invoice_text1';
  static const String invoice2 = 'invoice_text2';
  static const String surcharge1 = 'invoice1';
  static const String surcharge2 = 'invoice2';
}

abstract class DashboardEntity
    implements Built<DashboardEntity, DashboardEntityBuilder> {
  factory DashboardEntity([void updates(DashboardEntityBuilder b)]) =
      _$DashboardEntity;

  DashboardEntity._();

  BuiltList<ActivityEntity> get activities;

  static Serializer<DashboardEntity> get serializer =>
      _$dashboardEntitySerializer;
}

abstract class ActivityEntity
    implements Built<ActivityEntity, ActivityEntityBuilder> {
  factory ActivityEntity([void updates(ActivityEntityBuilder b)]) =
      _$ActivityEntity;

  ActivityEntity._();

  String get notes;

  @BuiltValueField(wireName: 'id')
  String get key;

  @BuiltValueField(wireName: 'activity_type_id')
  int get activityTypeId;

  @nullable
  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  @BuiltValueField(wireName: 'user_id')
  int get userId;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  int get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'payment_id')
  int get paymentId;

  @nullable
  @BuiltValueField(wireName: 'credit_id')
  int get creditId;

  @BuiltValueField(wireName: 'updated_at')
  int get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'expense_id')
  int get expenseId;

  @nullable
  @BuiltValueField(wireName: 'is_system')
  bool get isSystem;

  @nullable
  @BuiltValueField(wireName: 'contact_id')
  int get contactId;

  @nullable
  @BuiltValueField(wireName: 'task_id')
  int get taskId;

  EntityType get entityType {
    if ([1, 2, 3, 26].contains(activityTypeId)) {
      return EntityType.client;
    } else if ([4, 5, 6, 7, 8, 9, 25].contains(activityTypeId)) {
      return EntityType.invoice;
    } else if ([10, 11, 12, 13, 27].contains(activityTypeId)) {
      return EntityType.payment;
    } else if ([14, 15, 16, 17, 28, 39, 40, 41].contains(activityTypeId)) {
      return EntityType.credit;
    } else if ([18, 19, 20, 21, 22, 23, 24, 29].contains(activityTypeId)) {
      return EntityType.quote;
    } else if ([30, 31, 32, 33].contains(activityTypeId)) {
      return EntityType.vendor;
    } else if ([34, 35, 36, 37, 47].contains(activityTypeId)) {
      return EntityType.expense;
    } else if ([42, 43, 44, 45, 46].contains(activityTypeId)) {
      return EntityType.task;
    } else {
      return null;
    }
  }

  String getDescription(
    String activity, {
    UserEntity user,
    ClientEntity client,
    InvoiceEntity invoice,
    //ContactEntity contact,
    PaymentEntity payment,
    CreditEntity credit,
    InvoiceEntity quote,
    TaskEntity task,
    ExpenseEntity expense,
    VendorEntity vendor,
  }) {
    activity = activity.replaceFirst(':user', user?.fullName ?? '');
    activity = activity.replaceFirst(':client', client?.displayName ?? '');
    activity = activity.replaceFirst(':invoice', invoice?.invoiceNumber ?? '');
    activity = activity.replaceFirst(':quote', quote?.invoiceNumber ?? '');
    activity = activity.replaceFirst(':contact', client?.displayName ?? '');
    activity =
        activity.replaceFirst(':payment', payment?.transactionReference ?? '');
    activity = activity.replaceFirst(':credit', credit?.privateNotes ?? '');
    activity = activity.replaceFirst(':task', task?.description ?? '');
    activity = activity.replaceFirst(':expense', expense?.privateNotes ?? '');
    activity = activity.replaceFirst(':vendor', vendor?.name ?? '');
    activity = activity.replaceAll('  ', ' ');

    return activity;
  }

  static Serializer<ActivityEntity> get serializer =>
      _$activityEntitySerializer;
}
