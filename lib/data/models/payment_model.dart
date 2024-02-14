// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:collection/collection.dart'
    show IterableExtension, compareNatural;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'payment_model.g.dart';

abstract class PaymentListResponse
    implements Built<PaymentListResponse, PaymentListResponseBuilder> {
  factory PaymentListResponse([void updates(PaymentListResponseBuilder b)]) =
      _$PaymentListResponse;

  PaymentListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<PaymentEntity> get data;

  static Serializer<PaymentListResponse> get serializer =>
      _$paymentListResponseSerializer;
}

abstract class PaymentItemResponse
    implements Built<PaymentItemResponse, PaymentItemResponseBuilder> {
  factory PaymentItemResponse([void updates(PaymentItemResponseBuilder b)]) =
      _$PaymentItemResponse;

  PaymentItemResponse._();

  @override
  @memoized
  int get hashCode;

  PaymentEntity get data;

  static Serializer<PaymentItemResponse> get serializer =>
      _$paymentItemResponseSerializer;
}

class PaymentFields {
  static const String number = 'number';
  static const String amount = 'amount';
  static const String refunded = 'refunded';
  static const String transactionReference = 'transaction_reference';
  static const String date = 'date';
  static const String type = 'type';
  static const String typeId = 'type_id';
  static const String client = 'client';
  static const String clientId = 'client_id';
  static const String invoiceId = 'invoice_id';
  static const String invoiceNumber = 'invoice_number';
  static const String creditNumber = 'credit_number';
  static const String privateNotes = 'private_notes';
  static const String exchangeRate = 'exchange_rate';
  static const String convertedAmount = 'converted_amount';
  static const String exchangeCurrencyId = 'exchange_currency_id';
  static const String status = 'status';
  static const String gateway = 'gateway';
  static const String gatewayType = 'gateway_type';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String documents = 'documents';
}

abstract class PaymentEntity extends Object
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<PaymentEntity, PaymentEntityBuilder> {
  factory PaymentEntity({String? id, AppState? state, ClientEntity? client}) {
    final settings = getClientSettings(state, client);

    return _$PaymentEntity._(
      id: id ?? BaseEntity.nextId,
      idempotencyKey: BaseEntity.nextIdempotencyKey,
      isChanged: false,
      amount: 0.0,
      transactionReference: '',
      date: convertDateTimeToSqlDate(),
      typeId: settings.defaultPaymentTypeId ?? '',
      clientId: client?.id ?? '',
      privateNotes: '',
      exchangeRate: 1,
      exchangeCurrencyId: state?.company.currencyId ?? '',
      refunded: 0.0,
      applied: 0,
      statusId: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      isManual: true,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      paymentables: BuiltList<PaymentableEntity>(),
      invoices: BuiltList<PaymentableEntity>(),
      credits: BuiltList<PaymentableEntity>(),
      assignedUserId: '',
      createdAt: 0,
      createdUserId: '',
      vendorId: '',
      projectId: '',
      number: '',
      sendEmail: settings.clientManualPaymentNotification ?? false,
      companyGatewayId: '',
      clientContactId: '',
      currencyId: '',
      transactionId: '',
      invitationId: '',
      isApplying: false,
      gatewayTypeId: '',
      documents: BuiltList<DocumentEntity>(),
    );
  }

  PaymentEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType {
    return EntityType.payment;
  }

  double get amount;

  double get applied;

  double get refunded;

  String get number;

  @BuiltValueField(wireName: 'idempotency_key')
  String? get idempotencyKey;

  @override
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'status_id')
  String get statusId;

  @BuiltValueField(wireName: 'transaction_reference')
  String get transactionReference;

  String get date;

  @BuiltValueField(wireName: 'type_id')
  String get typeId;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @BuiltValueField(wireName: 'exchange_currency_id')
  String get exchangeCurrencyId;

  @BuiltValueField(wireName: 'is_manual')
  bool get isManual;

  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  @BuiltValueField(wireName: 'invitation_id')
  String get invitationId;

  @BuiltValueField(wireName: 'transaction_id')
  String get transactionId;

  @BuiltValueField(wireName: 'client_contact_id')
  String get clientContactId;

  @BuiltValueField(wireName: 'company_gateway_id')
  String get companyGatewayId;

  @BuiltValueField(wireName: 'currency_id')
  String get currencyId;

  @BuiltValueField(wireName: 'gateway_type_id')
  String get gatewayTypeId;

  bool? get isApplying;

  bool? get sendEmail;

  bool? get gatewayRefund;

  bool get hasExchangeRate => exchangeRate != 1 && exchangeRate != 0;

  String get transactionReferenceOrNumber =>
      transactionReference.isNotEmpty ? transactionReference : number;

  BuiltList<PaymentableEntity> get paymentables;

  BuiltList<PaymentableEntity> get invoices;

  BuiltList<PaymentableEntity> get credits;

  BuiltList<DocumentEntity> get documents;

  bool get canBeAppliedOrRefunded => [
        kPaymentStatusCompleted,
        kPaymentStatusPartiallyRefunded,
      ].contains(statusId);

  String get calculatedStatusId {
    if (applied < amount) {
      return applied == 0
          ? kPaymentStatusUnapplied
          : kPaymentStatusPartiallyUnapplied;
    }

    return statusId;
  }

  int compareTo({
    PaymentEntity? payment,
    String? sortField,
    required bool sortAscending,
    BuiltMap<String, InvoiceEntity>? invoiceMap,
    BuiltMap<String, ClientEntity>? clientMap,
    BuiltMap<String, UserEntity>? userMap,
    BuiltMap<String?, PaymentTypeEntity?>? paymentTypeMap,
  }) {
    int response = 0;
    final PaymentEntity? paymentA = sortAscending ? this : payment;
    final PaymentEntity? paymentB = sortAscending ? payment : this;

    switch (sortField) {
      case PaymentFields.amount:
        response = paymentA!.amount.compareTo(paymentB!.amount);
        break;
      case PaymentFields.exchangeRate:
        response = paymentA!.exchangeRate.compareTo(paymentB!.exchangeRate);
        break;
      case PaymentFields.refunded:
        response = paymentA!.refunded.compareTo(paymentB!.refunded);
        break;
      case PaymentFields.number:
        response = compareNatural(paymentA!.number, paymentB!.number);
        break;
      case PaymentFields.transactionReference:
        response = paymentA!.transactionReference
            .compareTo(paymentB!.transactionReference);
        break;
      case PaymentFields.date:
        response = paymentA!.date.compareTo(paymentB!.date);
        break;
      case PaymentFields.privateNotes:
        response = paymentA!.privateNotes
            .toLowerCase()
            .compareTo(paymentB!.date.toLowerCase());
        break;
      case EntityFields.updatedAt:
        response = paymentA!.updatedAt.compareTo(paymentB!.updatedAt);
        break;
      case EntityFields.createdAt:
        response = paymentA!.createdAt.compareTo(paymentB!.createdAt);
        break;
      case EntityFields.archivedAt:
        response = paymentA!.archivedAt.compareTo(paymentB!.archivedAt);
        break;
      case PaymentFields.status:
        response = paymentA!.statusId.compareTo(paymentB!.statusId);
        break;
      case PaymentFields.customValue1:
        response = paymentA!.customValue1
            .toLowerCase()
            .compareTo(paymentB!.customValue1.toLowerCase());
        break;
      case PaymentFields.customValue2:
        response = paymentA!.customValue2
            .toLowerCase()
            .compareTo(paymentB!.customValue2.toLowerCase());
        break;
      case PaymentFields.customValue3:
        response = paymentA!.customValue3
            .toLowerCase()
            .compareTo(paymentB!.customValue3.toLowerCase());
        break;
      case PaymentFields.customValue4:
        response = paymentA!.customValue4
            .toLowerCase()
            .compareTo(paymentB!.customValue4.toLowerCase());
        break;
      case PaymentFields.invoiceNumber:
        final invoiceA = invoiceMap![paymentA!.invoiceId] ?? InvoiceEntity();
        final invoiceB = invoiceMap[paymentB!.invoiceId] ?? InvoiceEntity();
        response = invoiceA.number
            .toLowerCase()
            .compareTo(invoiceB.number.toLowerCase());
        break;
      case PaymentFields.client:
        final clientA = clientMap![paymentA!.clientId] ?? ClientEntity();
        final clientB = clientMap[paymentB!.clientId] ?? ClientEntity();
        response = clientA.displayName
            .toLowerCase()
            .compareTo(clientB.displayName.toLowerCase());
        break;
      case PaymentFields.type:
        final typeA = paymentTypeMap![paymentA!.typeId] ?? PaymentTypeEntity();
        final typeB = paymentTypeMap[paymentB!.typeId] ?? PaymentTypeEntity();
        response = typeA.name.toLowerCase().compareTo(typeB.name.toLowerCase());
        break;
      case EntityFields.assignedTo:
        final userA = userMap![paymentA!.assignedUserId] ?? UserEntity();
        final userB = userMap[paymentB!.assignedUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdBy:
        final userA = userMap![paymentA!.createdUserId] ?? UserEntity();
        final userB = userMap[paymentB!.createdUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.state:
        final stateA = EntityState.valueOf(paymentA!.entityState);
        final stateB = EntityState.valueOf(paymentB!.entityState);
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case PaymentFields.documents:
        response =
            paymentA!.documents.length.compareTo(paymentB!.documents.length);
        break;
      default:
        print('## ERROR: sort by payment.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      response = payment!.number.toLowerCase().compareTo(number.toLowerCase());
    }

    return response;
  }

  @override
  bool matchesStatuses(BuiltList<EntityStatus> statuses) {
    if (statuses.isEmpty) {
      return true;
    }

    for (final status in statuses) {
      if (status.id == statusId || status.id == calculatedStatusId) {
        return true;
      }
    }

    return false;
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        number,
        transactionReference,
        privateNotes,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        number,
        transactionReference,
        privateNotes,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
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

    if (!isDeleted!) {
      if (userCompany!.canEditEntity(this)) {
        if (!multiselect) {
          if (includeEdit) {
            actions.add(EntityAction.edit);
          }

          if (applied < amount && canBeAppliedOrRefunded) {
            actions.add(EntityAction.applyPayment);
          }

          if (completedAmount > 0 && canBeAppliedOrRefunded) {
            actions.add(EntityAction.refundPayment);
          }
        }

        if (client != null && client.hasEmailAddress) {
          actions.add(EntityAction.sendEmail);
        }
      }
    }

    if (!isDeleted!) {
      final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
      if (hasDesignTemplatesForEntityType(
          store.state.designState.map, entityType)) {
        actions.add(EntityAction.runTemplate);
      }
    }

    if (!isDeleted! && multiselect) {
      actions.add(EntityAction.documents);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    // We're overriding the default behavior to
    // prevent users from restoring deleted payments
    if (userCompany!.canEditEntity(this) && isArchived) {
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

  @override
  String get listDisplayName => number;

  @override
  double get listDisplayAmount => amount;

  List<PaymentableEntity> get invoicePaymentables =>
      paymentables.where((p) => p.entityType == EntityType.invoice).toList();

  List<PaymentableEntity> get creditPaymentables =>
      paymentables.where((p) => p.entityType == EntityType.credit).toList();

  String? get invoiceId {
    final invoicePaymentables = paymentables
        .firstWhereOrNull((p) => p.entityType == EntityType.invoice);

    if (invoicePaymentables == null) {
      return null;
    }

    return invoicePaymentables.isEmpty ? null : invoicePaymentables.invoiceId;
  }

  bool isBetween(String startDate, String? endDate) {
    return startDate.compareTo(date) <= 0 && endDate!.compareTo(date) >= 0;
  }

  bool get isOnline => companyGatewayId.isNotEmpty;

  double get convertedExchangeRate => exchangeRate == 0 ? 1 : exchangeRate;

  double get convertedAmount => completedAmount * convertedExchangeRate;

  bool get isCompletedOrPartiallyRefunded => [
        kPaymentStatusCompleted,
        kPaymentStatusPartiallyRefunded
      ].contains(statusId);

  @override
  bool get isRestorable => false;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  double get completedAmount {
    if (isDeleted!) {
      return 0;
    }

    if ([kPaymentStatusCancelled, kPaymentStatusFailed].contains(statusId)) {
      return 0;
    }

    return amount - refunded;
  }

  // ignore: unused_element
  static void _initializeBuilder(PaymentEntityBuilder builder) => builder
    ..transactionId = ''
    ..gatewayTypeId = '';

  static Serializer<PaymentEntity> get serializer => _$paymentEntitySerializer;
}

abstract class PaymentableEntity extends Object
    with SelectableEntity
    implements Built<PaymentableEntity, PaymentableEntityBuilder> {
  factory PaymentableEntity(
      {String? id, String? invoiceId, String? creditId, double? amount}) {
    return _$PaymentableEntity._(
      id: id ?? BaseEntity.nextId,
      invoiceId: invoiceId ?? '',
      creditId: creditId ?? '',
      amount: amount ?? 0,
    );
  }

  factory PaymentableEntity.fromInvoice(InvoiceEntity invoice) {
    return PaymentableEntity(
      invoiceId: invoice.id,
      amount: invoice.partial != 0 ? invoice.partial : invoice.balanceOrAmount,
    );
  }

  factory PaymentableEntity.fromCredit(InvoiceEntity credit) {
    return PaymentableEntity(
      creditId: credit.id,
      amount: credit.partial != 0 ? credit.partial : credit.balanceOrAmount,
    );
  }

  PaymentableEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'created_at')
  int? get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  int? get updatedAt;

  @BuiltValueField(wireName: 'invoice_id')
  String? get invoiceId;

  @BuiltValueField(wireName: 'credit_id')
  String? get creditId;

  double get amount;

  bool get isEmpty =>
      (invoiceId ?? '').isEmpty && (creditId ?? '').isEmpty && amount == 0;

  EntityType get entityType =>
      (invoiceId ?? '').isEmpty ? EntityType.credit : EntityType.invoice;

  /*
  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double get listDisplayAmount => null;

*/

  static Serializer<PaymentableEntity> get serializer =>
      _$paymentableEntitySerializer;
}
