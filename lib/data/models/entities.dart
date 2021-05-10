import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'entities.g.dart';

class EntityType extends EnumClass {
  const EntityType._(String name) : super(name);

  static Serializer<EntityType> get serializer => _$entityTypeSerializer;

  static const EntityType dashboard = _$dashboard;
  static const EntityType reports = _$reports;
  static const EntityType settings = _$settings;
  static const EntityType taxRate = _$taxRate;
  static const EntityType companyGateway = _$companyGateway;
  static const EntityType invoice = _$invoice;
  static const EntityType recurringInvoice = _$recurringInvoice;
  static const EntityType quote = _$quote;
  static const EntityType product = _$product;
  static const EntityType client = _$client;
  static const EntityType task = _$task;
  static const EntityType project = _$project;
  static const EntityType expense = _$expense;
  static const EntityType expenseCategory = _$expenseCategory;
  static const EntityType vendor = _$vendor;
  static const EntityType credit = _$credit;
  static const EntityType payment = _$payment;
  static const EntityType group = _$group;
  static const EntityType user = _$user;
  static const EntityType company = _$company;
  static const EntityType gateway = _$gateway;
  static const EntityType gatewayToken = _$gatewayToken;
  static const EntityType invoiceItem = _$invoiceItem;
  static const EntityType design = _$design;
  // STARTER: entity type - do not remove comment
  static const EntityType subscription = _$subscription;
  static const EntityType webhook = _$webhook;
  static const EntityType token = _$token;
  static const EntityType paymentTerm = _$paymentTerm;
  static const EntityType quoteItem = _$quoteItem;
  static const EntityType contact = _$contact;
  static const EntityType vendorContact = _$vendorContact;
  static const EntityType country = _$country;
  static const EntityType currency = _$currency;
  static const EntityType language = _$language;
  static const EntityType industry = _$industry;
  static const EntityType size = _$size;
  static const EntityType paymentType = _$paymentType;
  static const EntityType taskStatus = _$taskStatus;
  static const EntityType document = _$document;
  static const EntityType timezone = _$timezone;
  static const EntityType dateFormat = _$dateFormat;
  static const EntityType font = _$font;

  String get plural {
    if (this == EntityType.expenseCategory) {
      return 'expenseCategories';
    } else if (this == EntityType.taskStatus) {
      return 'taskStatuses';
    }

    return toString() + 's';
  }

  bool get isSetting => [
        EntityType.paymentTerm,
        EntityType.taxRate,
        EntityType.companyGateway,
        EntityType.user,
        EntityType.group,
        EntityType.design,
        EntityType.token,
        EntityType.webhook,
        EntityType.expenseCategory,
        EntityType.taskStatus,
        EntityType.subscription,
      ].contains(this);

  List<EntityType> get relatedTypes {
    switch (this) {
      case EntityType.client:
        return [
          EntityType.invoice,
          EntityType.payment,
          EntityType.quote,
          EntityType.credit,
          EntityType.task,
          EntityType.project,
          EntityType.expense,
          EntityType.recurringInvoice,
        ];
      case EntityType.invoice:
        return [
          EntityType.payment,
        ];
      case EntityType.recurringInvoice:
        return [
          EntityType.invoice,
        ];
      case EntityType.payment:
        return [
          EntityType.invoice,
        ];
      case EntityType.project:
        return [
          EntityType.task,
          EntityType.expense,
        ];
      case EntityType.group:
        return [
          EntityType.client,
        ];
      case EntityType.user:
        return [
          EntityType.client,
          EntityType.invoice,
          EntityType.quote,
          EntityType.credit,
          EntityType.task,
          EntityType.project,
          EntityType.expense,
          EntityType.vendor,
          EntityType.recurringInvoice,
        ];
      case EntityType.companyGateway:
        return [
          EntityType.client,
          EntityType.payment,
        ];
      case EntityType.vendor:
        return [
          EntityType.expense,
        ];
      case EntityType.task:
        return [
          EntityType.project,
        ];
      case EntityType.expense:
        return [
          EntityType.vendor,
          EntityType.project,
          EntityType.expenseCategory,
        ];
      case EntityType.expenseCategory:
        return [
          EntityType.expense,
        ];
      case EntityType.design:
        return [
          EntityType.invoice,
          EntityType.quote,
          EntityType.credit,
          EntityType.recurringInvoice,
        ];
      default:
        return [];
    }
  }

  String get snakeCase => toSnakeCase(toString());

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

  static const EmailTemplate invoice = _$invoice_email;
  static const EmailTemplate quote = _$quote_email;
  static const EmailTemplate payment = _$payment_email;
  static const EmailTemplate payment_partial = _$payment_partial_email;
  static const EmailTemplate credit = _$credit_email;
  static const EmailTemplate statement = _$statement_email;
  static const EmailTemplate reminder1 = _$reminder1_email;
  static const EmailTemplate reminder2 = _$reminder2_email;
  static const EmailTemplate reminder3 = _$reminder3_email;
  static const EmailTemplate reminder_endless = _$reminder_endless_email;
  static const EmailTemplate custom1 = _$custom1_email;
  static const EmailTemplate custom2 = _$custom2_email;
  static const EmailTemplate custom3 = _$custom3_email;

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
  String get id;

  String get name;
}

class EntityStats {
  const EntityStats({this.countActive, this.countArchived});

  final int countActive;

  final int countArchived;

  String present(String activeLabel, String archivedLabel) {
    String str = '';
    if (countActive > 0) {
      str = '$countActive $activeLabel';
      if (countArchived > 0) {
        str += ' • ';
      }
    }
    if (countArchived > 0) {
      str += '$countArchived $archivedLabel';
    }
    return str;
  }
}

abstract class SelectableEntity {
  String get id;

  bool matchesFilter(String filter) => true;

  String matchesFilterValue(String filter) => null;

  String get listDisplayName => 'Error: listDisplayName not set';

  double get listDisplayAmount => null;

  FormatNumberType get listDisplayAmountType => FormatNumberType.money;
}

class EntityFields {
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String assignedTo = 'assigned_to';
  static const String createdBy = 'created_by';
  static const String state = 'entity_state';
  static const String isDeleted = 'is_deleted';
}

abstract class BaseEntity implements SelectableEntity {
  static int counter = 0;

  static String get nextId => '${--counter}';

  @nullable
  bool get isChanged;

  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  int get updatedAt;

  @BuiltValueField(wireName: 'archived_at')
  int get archivedAt;

  @nullable
  @BuiltValueField(wireName: 'is_deleted')
  bool get isDeleted;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  String get createdUserId;

  @nullable
  @BuiltValueField(wireName: 'assigned_user_id')
  String get assignedUserId;

  @nullable
  @BuiltValueField(wireName: 'entity_type')
  EntityType get entityType;

  String get entityKey => '__${entityType}__${id}__';

  bool get isNew => (id ?? '').isEmpty || (int.tryParse(id) ?? 0) < 0;

  bool get isOld => !isNew;

  bool get isActive => archivedAt == null || archivedAt == 0;

  bool get isNotActive => !isActive;

  bool get isArchived => archivedAt != null && archivedAt > 0 && !isDeleted;

  bool get isEditable => !isDeleted;

  bool userCanAccess(String userId) =>
      createdUserId == userId || assignedUserId == userId;

  String get entityState => isActive
      ? kEntityStateActive
      : (isArchived ? kEntityStateArchived : kEntityStateDeleted);

  ReportStringValue getReportString({String value}) =>
      ReportStringValue(entityId: id, entityType: entityType, value: value);

  ReportEntityTypeValue getReportEntityType() => ReportEntityTypeValue(
      entityId: id, entityType: entityType, value: entityType);

  ReportBoolValue getReportBool({bool value}) =>
      ReportBoolValue(entityId: id, entityType: entityType, value: value);

  ReportAgeValue getReportAge({int value, String currencyId}) => ReportAgeValue(
      entityType: entityType,
      entityId: id,
      value: value,
      currencyId: currencyId);

  ReportDurationValue getReportDuration({int value, String currencyId}) =>
      ReportDurationValue(
        entityType: entityType,
        entityId: id,
        value: value,
        currencyId: currencyId,
      );

  ReportNumberValue getReportDouble(
          {double value,
          String currencyId,
          double exchangeRate,
          FormatNumberType formatNumberType}) =>
      ReportNumberValue(
          entityId: id,
          entityType: entityType,
          value: value,
          currencyId: currencyId,
          exchangeRate: exchangeRate,
          formatNumberType: formatNumberType);

  ReportIntValue getReportInt(
          {int value, String currencyId, FormatNumberType formatNumberType}) =>
      ReportIntValue(
        entityId: id,
        entityType: entityType,
        value: value,
      );

  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (userCompany.canEditEntity(this) && (isArchived || isDeleted)) {
      actions.add(EntityAction.restore);
    }

    if (userCompany.canEditEntity(this) && isActive) {
      actions.add(EntityAction.archive);
    }

    if (userCompany.canEditEntity(this) && (isActive || isArchived)) {
      actions.add(EntityAction.delete);
    }

    return actions;
  }

  bool matchesEntityFilter(EntityType filterEntityType, String filterEntityId) {
    return id == filterEntityId && entityType == filterEntityType;
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
  String get clientId;
}

abstract class ErrorMessage
    implements Built<ErrorMessage, ErrorMessageBuilder> {
  factory ErrorMessage([void updates(ErrorMessageBuilder b)]) = _$ErrorMessage;

  ErrorMessage._();

  @override
  @memoized
  int get hashCode;

  String get message;

  static Serializer<ErrorMessage> get serializer => _$errorMessageSerializer;
}

abstract class LoginResponse
    implements Built<LoginResponse, LoginResponseBuilder> {
  factory LoginResponse([void updates(LoginResponseBuilder b)]) =
      _$LoginResponse;

  LoginResponse._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'data')
  BuiltList<UserCompanyEntity> get userCompanies;

  StaticDataEntity get static;

  static Serializer<LoginResponse> get serializer => _$loginResponseSerializer;
}

class CustomFieldType {
  static const String company = 'company';
  static const String company1 = 'company1';
  static const String company2 = 'company2';
  static const String company3 = 'company3';
  static const String company4 = 'company4';

  static const String product = 'product';
  static const String product1 = 'product1';
  static const String product2 = 'product2';
  static const String product3 = 'product3';
  static const String product4 = 'product4';

  static const String client = 'client';
  static const String client1 = 'client1';
  static const String client2 = 'client2';
  static const String client3 = 'client3';
  static const String client4 = 'client4';

  static const String contact = 'contact';
  static const String contact1 = 'contact1';
  static const String contact2 = 'contact2';
  static const String contact3 = 'contact3';
  static const String contact4 = 'contact4';

  static const String task = 'task';
  static const String task1 = 'task1';
  static const String task2 = 'task2';
  static const String task3 = 'task3';
  static const String task4 = 'task4';

  static const String project = 'project';
  static const String project1 = 'project1';
  static const String project2 = 'project2';
  static const String project3 = 'project3';
  static const String project4 = 'project4';

  static const String expense = 'expense';
  static const String expense1 = 'expense1';
  static const String expense2 = 'expense2';
  static const String expense3 = 'expense3';
  static const String expense4 = 'expense4';

  static const String vendor = 'vendor';
  static const String vendor1 = 'vendor1';
  static const String vendor2 = 'vendor2';
  static const String vendor3 = 'vendor3';
  static const String vendor4 = 'vendor4';

  static const String invoice = 'invoice';
  static const String invoice1 = 'invoice1';
  static const String invoice2 = 'invoice2';
  static const String invoice3 = 'invoice3';
  static const String invoice4 = 'invoice4';

  static const String payment = 'payment';
  static const String payment1 = 'payment1';
  static const String payment2 = 'payment2';
  static const String payment3 = 'payment3';
  static const String payment4 = 'payment4';

  static const String surcharge = 'surcharge';
  static const String surcharge1 = 'surcharge1';
  static const String surcharge2 = 'surcharge2';
  static const String surcharge3 = 'surcharge3';
  static const String surcharge4 = 'surcharge4';

  static const String user = 'user';
  static const String user1 = 'user1';
  static const String user2 = 'user2';
  static const String user3 = 'user3';
  static const String user4 = 'user4';
}

abstract class ActivityEntity
    implements Built<ActivityEntity, ActivityEntityBuilder> {
  factory ActivityEntity([void updates(ActivityEntityBuilder b)]) =
      _$ActivityEntity;

  ActivityEntity._();

  @override
  @memoized
  int get hashCode;

  String get notes;

  @BuiltValueField(wireName: 'id')
  String get key;

  @BuiltValueField(wireName: 'activity_type_id')
  String get activityTypeId;

  @nullable
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'user_id')
  String get userId;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'quote_id')
  String get quoteId;

  @nullable
  @BuiltValueField(wireName: 'payment_id')
  String get paymentId;

  @nullable
  @BuiltValueField(wireName: 'credit_id')
  String get creditId;

  @BuiltValueField(wireName: 'updated_at')
  int get updatedAt;

  @nullable
  @BuiltValueField(wireName: 'expense_id')
  String get expenseId;

  @nullable
  @BuiltValueField(wireName: 'is_system')
  bool get isSystem;

  @nullable
  String get ip;

  @nullable
  @BuiltValueField(wireName: 'contact_id')
  String get contactId;

  @nullable
  @BuiltValueField(wireName: 'task_id')
  String get taskId;

  @nullable
  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @nullable
  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  @nullable
  @BuiltValueField(wireName: 'token_id')
  String get tokenId;

  EntityType get entityType {
    if ([
      kActivityCreateClient,
      kActivityUpdateClient,
      kActivityArchiveClient,
      kActivityDeleteClient,
      kActivityRestoreClient
    ].contains(activityTypeId)) {
      return EntityType.client;
    } else if ([
      kActivityCreateInvoice,
      kActivityUpdateInvoice,
      kActivityEmailInvoice,
      kActivityViewInvoice,
      kActivityArchiveInvoice,
      kActivityDeleteInvoice,
      kActivityRestoreInvoice,
      kActivityMarkSentInvoice,
      kActivityReversedInvoice,
      kActivityCancelledInvoice,
      kActivityEmailReminder1,
      kActivityEmailReminder2,
      kActivityEmailReminder3,
      kActivityEmailReminderEndless,
    ].contains(activityTypeId)) {
      return EntityType.invoice;
    } else if ([
      kActivityCreatePayment,
      kActivityUpdatePayment,
      kActivityArchivePayment,
      kActivityDeletePayment,
      kActivityRestorePayment,
      kActivityFailedPayment,
      kActivityPaidInvoice,
    ].contains(activityTypeId)) {
      return EntityType.payment;
    } else if ([
      kActivityCreateCredit,
      kActivityUpdateCredit,
      kActivityArchiveCredit,
      kActivityDeleteCredit,
      kActivityRestoreCredit,
      kActivityVoidedPayment,
      kActivityRefundedPayment,
      kActivityViewCredit,
    ].contains(activityTypeId)) {
      return EntityType.credit;
    } else if ([
      kActivityCreateQuote,
      kActivityUpdateQuote,
      kActivityEmailQuote,
      kActivityViewQuote,
      kActivityArchiveQuote,
      kActivityDeleteQuote,
      kActivityRestoreQuote,
      kActivityApproveQuote,
    ].contains(activityTypeId)) {
      return EntityType.quote;
    } else if ([
      kActivityCreateVendor,
      kActivityArchiveVendor,
      kActivityUpdateVendor,
      kActivityDeleteVendor,
      kActivityRestoreVendor,
    ].contains(activityTypeId)) {
      return EntityType.vendor;
    } else if ([
      kActivityCreateExpense,
      kActivityArchiveExpense,
      kActivityDeleteExpense,
      kActivityRestoreExpense,
      kActivityUpdateExpense,
    ].contains(activityTypeId)) {
      return EntityType.expense;
    } else if ([
      kActivityCreateTask,
      kActivityUpdateTask,
      kActivityArchiveTask,
      kActivityDeleteTask,
      kActivityRestoreTask,
    ].contains(activityTypeId)) {
      return EntityType.task;
    } else if ([
      kActivityCreateUser,
      kActivityUpdateUser,
      kActivityArchiveUser,
      kActivityDeleteUser,
      kActivityRestoreUser,
    ].contains(activityTypeId)) {
      return EntityType.user;
    } else if ([
      kActivityCreateSubscription,
      kActivityUpdateSubscription,
      kActivityArchiveSubscription,
      kActivityDeleteSubscription,
      kActivityRestoreSubscription,
    ].contains(activityTypeId)) {
      return EntityType.subscription;
    } else if ([
      kActivityCreateRecurringInvoice,
      kActivityUpdateRecurringInvoice,
      kActivityArchiveRecurringInvoice,
      kActivityDeleteRecurringInvoice,
      kActivityRestoreRecurringInvoice,
    ].contains(activityTypeId)) {
      return EntityType.recurringInvoice;
    } else {
      print(
          '## ERROR: failed to resolve entity type - activity_type_id: $activityTypeId');
      return null;
    }
  }

  String getDescription(
    String activity, {
    UserEntity user,
    ClientEntity client,
    InvoiceEntity invoice,
    PaymentEntity payment,
    InvoiceEntity credit,
    InvoiceEntity quote,
    TaskEntity task,
    ExpenseEntity expense,
    VendorEntity vendor,
  }) {
    ContactEntity contact;
    if (client != null && contactId != null && contactId.isNotEmpty) {
      contact = client.contacts
          .firstWhere((contact) => contact.id == contactId, orElse: () => null);
    }

    activity = activity.replaceFirst(':user', user?.listDisplayName ?? '');
    activity = activity.replaceFirst(':client', client?.displayName ?? '');
    activity = activity.replaceFirst(':invoice', invoice?.number ?? '');
    activity = activity.replaceFirst(':quote', quote?.number ?? '');
    activity = activity.replaceFirst(':contact',
        contact?.fullName ?? client?.displayName ?? user?.fullName ?? '');
    activity = activity.replaceFirst(
        ':payment', payment?.transactionReferenceOrNumber ?? '');
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

abstract class LedgerEntity
    implements Built<LedgerEntity, LedgerEntityBuilder> {
  factory LedgerEntity([void updates(LedgerEntityBuilder b)]) = _$LedgerEntity;

  LedgerEntity._();

  @override
  @memoized
  int get hashCode;

  String get notes;

  double get balance;

  double get adjustment;

  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'credit_id')
  String get creditId;

  @nullable
  @BuiltValueField(wireName: 'payment_id')
  String get paymentId;

  EntityType get entityType {
    if (creditId != null) {
      return EntityType.credit;
    } else if (paymentId != null) {
      return EntityType.payment;
    } else {
      return EntityType.invoice;
    }
  }

  String get entityId {
    if (creditId != null) {
      return creditId;
    } else if (paymentId != null) {
      return paymentId;
    } else {
      return invoiceId;
    }
  }

  static Serializer<LedgerEntity> get serializer => _$ledgerEntitySerializer;
}
