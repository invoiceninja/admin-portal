// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/mixins/invoice_mixin.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/data/models/recurring_invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/tax_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/money.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'invoice_model.g.dart';

abstract class InvoiceListResponse
    implements Built<InvoiceListResponse, InvoiceListResponseBuilder> {
  factory InvoiceListResponse([void updates(InvoiceListResponseBuilder b)]) =
      _$InvoiceListResponse;

  InvoiceListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<InvoiceEntity> get data;

  static Serializer<InvoiceListResponse> get serializer =>
      _$invoiceListResponseSerializer;
}

abstract class InvoiceItemResponse
    implements Built<InvoiceItemResponse, InvoiceItemResponseBuilder> {
  factory InvoiceItemResponse([void updates(InvoiceItemResponseBuilder b)]) =
      _$InvoiceItemResponse;

  InvoiceItemResponse._();

  @override
  @memoized
  int get hashCode;

  InvoiceEntity get data;

  static Serializer<InvoiceItemResponse> get serializer =>
      _$invoiceItemResponseSerializer;
}

class InvoiceFields {
  static const String total = 'total';
  static const String amount = 'amount';
  static const String balance = 'balance';
  static const String balanceDue = 'balance_due';
  static const String clientId = 'client_id';
  static const String client = 'client';
  static const String project = 'project';
  static const String vendor = 'vendor';
  static const String statusId = 'status_id';
  static const String status = 'status';
  static const String number = 'number';
  static const String discount = 'discount';
  static const String poNumber = 'po_number';
  static const String date = 'date';
  static const String dueDate = 'due_date';
  static const String dueDateDays = 'due_date_days';
  static const String nextSendDate = 'next_send_date';
  static const String lastSentDate = 'last_sent_date';
  static const String lastSentTemplate = 'last_sent_template';
  static const String terms = 'terms';
  static const String footer = 'footer';
  static const String partial = 'partial_due';
  static const String partialDueDate = 'partial_due_date';
  static const String publicNotes = 'public_notes';
  static const String privateNotes = 'private_notes';
  static const String isRecurring = 'is_recurring';
  static const String frequencyId = 'frequency_id';
  static const String documents = 'documents';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String customSurcharge1 = 'custom_surcharge1';
  static const String customSurcharge2 = 'custom_surcharge2';
  static const String customSurcharge3 = 'custom_surcharge3';
  static const String customSurcharge4 = 'custom_surcharge4';
  static const String taxAmount = 'tax_amount';
  static const String reminder1Sent = 'reminder1_sent';
  static const String reminder2Sent = 'reminder2_sent';
  static const String reminder3Sent = 'reminder3_sent';
  static const String reminderLastSent = 'reminder_last_sent';
  static const String exchangeRate = 'exchange_rate';
  static const String isViewed = 'is_viewed';
  static const String autoBillEnabled = 'auto_bill_enabled';
  static const String contactName = 'contact_name';
  static const String contactEmail = 'contact_email';
  static const String clientCity = 'client_city';
  static const String clientState = 'client_state';
  static const String clientPostalCode = 'client_postal_code';
  static const String clientCountry = 'client_country';
  static const String quote = 'quote';
  static const String recurringInvoice = 'recurring_invoice';
}

class InvoiceTotalFields {
  static const String totalTaxes = 'total_taxes';
  static const String lineTaxes = 'line_taxes';
  static const String subtotal = 'subtotal';
  static const String total = 'total';
  static const String discount = 'discount';
  static const String customSurcharge1 = 'custom_surcharge1';
  static const String customSurcharge2 = 'custom_surcharge2';
  static const String customSurcharge3 = 'custom_surcharge3';
  static const String customSurcharge4 = 'custom_surcharge4';
  static const String paidToDate = 'paid_to_date';
  static const String outstanding = 'outstanding';
  static const String netSubtotal = 'net_subtotal';
}

abstract class InvoiceEntity extends Object
    with
        BaseEntity,
        SelectableEntity,
        CalculateInvoiceTotal,
        BelongsToClient,
        BelongsToVendor
    implements Built<InvoiceEntity, InvoiceEntityBuilder> {
  factory InvoiceEntity({
    String? id,
    AppState? state,
    ClientEntity? client,
    VendorEntity? vendor,
    UserEntity? user,
    EntityType? entityType,
  }) {
    final company = state?.company;
    final settings = getClientSettings(state, client);

    double exchangeRate = 1;
    if (state != null && (client?.currencyId ?? '').isNotEmpty) {
      exchangeRate = getExchangeRate(
        state.staticState.currencyMap,
        fromCurrencyId: state.company.currencyId,
        toCurrencyId: client!.currencyId,
      );
    }
    return _$InvoiceEntity._(
      id: id ?? BaseEntity.nextId,
      entityType: entityType ?? EntityType.invoice,
      isChanged: false,
      amount: 0,
      balance: 0,
      paidToDate: 0,
      clientId: client?.id ?? '',
      statusId: kInvoiceStatusDraft,
      number: '',
      discount: 0,
      taxAmount: 0,
      poNumber: '',
      projectId: '',
      expenseId: '',
      vendorId: vendor?.id ?? '',
      date: convertDateTimeToSqlDate(),
      dueDate: '',
      publicNotes: '',
      privateNotes: '',
      terms: '',
      footer: '',
      designId: '',
      taxName1: (company?.numberOfInvoiceTaxRates ?? 0) >= 1
          ? settings.defaultTaxName1 ?? ''
          : '',
      taxRate1: (company?.numberOfInvoiceTaxRates ?? 0) >= 1
          ? settings.defaultTaxRate1 ?? 0.0
          : 0,
      taxName2: (company?.numberOfInvoiceTaxRates ?? 0) >= 2
          ? settings.defaultTaxName2 ?? ''
          : '',
      taxRate2: (company?.numberOfInvoiceTaxRates ?? 0) >= 2
          ? settings.defaultTaxRate2 ?? 0.0
          : 0,
      taxName3: (company?.numberOfInvoiceTaxRates ?? 0) >= 3
          ? settings.defaultTaxName3 ?? ''
          : '',
      taxRate3: (company?.numberOfInvoiceTaxRates ?? 0) >= 3
          ? settings.defaultTaxRate3 ?? 0.0
          : 0,
      isAmountDiscount: false,
      partial: 0.0,
      partialDueDate: '',
      autoBillEnabled:
          ((entityType ?? EntityType.invoice) == EntityType.invoice)
              ? settings.autoBillStandardInvoices ?? false
              : false,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      customTaxes1: company?.enableCustomSurchargeTaxes1 ?? false,
      customTaxes2: company?.enableCustomSurchargeTaxes2 ?? false,
      customTaxes3: company?.enableCustomSurchargeTaxes3 ?? false,
      customTaxes4: company?.enableCustomSurchargeTaxes4 ?? false,
      invoiceId: '',
      customSurcharge1: 0,
      customSurcharge2: 0,
      customSurcharge3: 0,
      customSurcharge4: 0,
      subscriptionId: '',
      recurringDates: BuiltList<InvoiceScheduleEntity>(),
      lineItems: BuiltList<InvoiceItemEntity>(),
      usesInclusiveTaxes: company?.settings.enableInclusiveTaxes ?? false,
      documents: BuiltList<DocumentEntity>(),
      activities: BuiltList<ActivityEntity>(),
      invitations: client != null
          ? BuiltList(client.emailContacts
              .map((contact) => InvitationEntity(clientContactId: contact.id))
              .toList())
          : vendor != null
              ? BuiltList(vendor.emailContacts
                  .map((contact) =>
                      InvitationEntity(vendorContactId: contact.id))
                  .toList())
              : BuiltList(<InvitationEntity>[InvitationEntity()]),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      createdUserId: '',
      assignedUserId: user?.id ?? '',
      createdAt: 0,
      loadedAt: 0,
      reminder1Sent: '',
      reminder2Sent: '',
      reminder3Sent: '',
      reminderLastSent: '',
      exchangeRate: exchangeRate,
      lastSentDate: '',
      nextSendDate: convertDateTimeToSqlDate(),
      nextSendDatetime: '',
      frequencyId: kFrequencyMonthly,
      remainingCycles: -1,
      dueDateDays: 'terms',
      saveDefaultTerms: false,
      saveDefaultFooter: false,
      taxData: TaxDataEntity(),
    );
  }

  InvoiceEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'idempotency_key')
  String? get idempotencyKey;

  InvoiceEntity moveLineItem(int oldIndex, int? newIndex) {
    final lineItem = lineItems[oldIndex];
    InvoiceEntity invoice = rebuild((b) => b..lineItems.removeAt(oldIndex));
    invoice = invoice.rebuild((b) => b
      ..lineItems.replace(<InvoiceItemEntity?>[
        ...invoice.lineItems.sublist(0, newIndex),
        lineItem,
        ...invoice.lineItems.sublist(
          newIndex!,
          invoice.lineItems.length,
        )
      ])
      ..isChanged = true);
    return invoice;
  }

  InvoiceEntity recreateInvitations(AppState state) {
    if (entityType == EntityType.purchaseOrder) {
      final vendor = state.vendorState.get(vendorId);
      final BuiltList<InvitationEntity> invitations = vendor.contacts
          .map((contact) => InvitationEntity(vendorContactId: contact.id))
          .toBuiltList();
      return rebuild((b) => b..invitations.replace(invitations));
    } else {
      final client = state.clientState.get(clientId);
      final BuiltList<InvitationEntity> invitations = client.contacts
          .map((contact) => InvitationEntity(clientContactId: contact.id))
          .toBuiltList();
      return rebuild((b) => b..invitations.replace(invitations));
    }
  }

  InvoiceEntity get clone {
    return rebuild(
      (b) => b
        ..id = BaseEntity.nextId
        ..isChanged = false
        ..isDeleted = false
        ..statusId = kInvoiceStatusDraft
        ..balance = 0
        ..amount = 0
        ..paidToDate = 0
        ..remainingCycles = -1
        ..invoiceId = ''
        ..projectId = ''
        ..expenseId = ''
        ..subscriptionId = ''
        ..number = ''
        ..date = convertDateTimeToSqlDate()
        ..dueDate = ''
        ..partialDueDate = ''
        ..documents.clear()
        ..lineItems.replace(lineItems
            .where((lineItem) =>
                lineItem.typeId != InvoiceItemEntity.TYPE_UNPAID_FEE)
            .map((lineItem) => lineItem
                .rebuild((b) => b..typeId = InvoiceItemEntity.TYPE_STANDARD))
            .toList())
        ..invitations.replace(
          invitations
              .map((invitation) => InvitationEntity(
                    clientContactId: invitation.clientContactId,
                    vendorContactId: invitation.vendorContactId,
                  ))
              .toList(),
        ),
    );
  }

  InvoiceEntity applyClient(AppState state, ClientEntity client) {
    final exchangeRate = getExchangeRate(state.staticState.currencyMap,
        fromCurrencyId: state.company.currencyId,
        toCurrencyId: client.currencyId);
    final settings = getClientSettings(state, client);

    return rebuild((b) => b
      ..exchangeRate = exchangeRate
      ..taxName1 = state.company.numberOfInvoiceTaxRates >= 1 &&
              (settings.defaultTaxName1 ?? '').isNotEmpty
          ? settings.defaultTaxName1
          : taxName1
      ..taxRate1 = state.company.numberOfInvoiceTaxRates >= 1 &&
              (settings.defaultTaxName1 ?? '').isNotEmpty
          ? settings.defaultTaxRate1
          : taxRate1
      ..taxName2 = state.company.numberOfInvoiceTaxRates >= 2 &&
              (settings.defaultTaxName2 ?? '').isNotEmpty
          ? settings.defaultTaxName2
          : taxName2
      ..taxRate2 = state.company.numberOfInvoiceTaxRates >= 2 &&
              (settings.defaultTaxName2 ?? '').isNotEmpty
          ? settings.defaultTaxRate2
          : taxRate2
      ..taxName3 = state.company.numberOfInvoiceTaxRates >= 3 &&
              (settings.defaultTaxName3 ?? '').isNotEmpty
          ? settings.defaultTaxName3
          : taxName3
      ..taxRate3 = state.company.numberOfInvoiceTaxRates >= 3 &&
              (settings.defaultTaxName3 ?? '').isNotEmpty
          ? settings.defaultTaxRate3
          : taxRate3);
  }

  double get amount;

  double get balance;

  @BuiltValueField(wireName: 'paid_to_date')
  double get paidToDate;

  double get balanceOrAmount => isSent ? balance : amount;

  @override
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @BuiltValueField(wireName: 'expense_id')
  String get expenseId;

  @override
  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  @BuiltValueField(wireName: 'subscription_id')
  String get subscriptionId;

  @BuiltValueField(wireName: 'status_id')
  String get statusId;

  @BuiltValueField(wireName: 'number')
  String get number;

  @override
  double get discount;

  @BuiltValueField(wireName: 'po_number')
  String get poNumber;

  @BuiltValueField(wireName: 'date')
  String get date;

  @BuiltValueField(wireName: 'due_date')
  String get dueDate;

  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  String get terms;

  @BuiltValueField(wireName: 'footer')
  String get footer;

  @BuiltValueField(wireName: 'design_id')
  String get designId;

  @override
  @BuiltValueField(wireName: 'uses_inclusive_taxes')
  bool get usesInclusiveTaxes;

  @override
  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @override
  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;

  @override
  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;

  @override
  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;

  @override
  @BuiltValueField(wireName: 'tax_name3')
  String get taxName3;

  @override
  @BuiltValueField(wireName: 'tax_rate3')
  double get taxRate3;

  @override
  @BuiltValueField(wireName: 'is_amount_discount')
  bool get isAmountDiscount;

  double get partial;

  @BuiltValueField(wireName: 'total_taxes')
  double get taxAmount;

  @BuiltValueField(wireName: 'partial_due_date')
  String get partialDueDate;

  @BuiltValueField(wireName: 'auto_bill')
  String? get autoBill;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @override
  @BuiltValueField(wireName: 'custom_surcharge1')
  double get customSurcharge1;

  @override
  @BuiltValueField(wireName: 'custom_surcharge2')
  double get customSurcharge2;

  @override
  @BuiltValueField(wireName: 'custom_surcharge3')
  double get customSurcharge3;

  @override
  @BuiltValueField(wireName: 'custom_surcharge4')
  double get customSurcharge4;

  @override
  @BuiltValueField(wireName: 'custom_surcharge_tax1')
  bool get customTaxes1;

  @override
  @BuiltValueField(wireName: 'custom_surcharge_tax2')
  bool get customTaxes2;

  @override
  @BuiltValueField(wireName: 'custom_surcharge_tax3')
  bool get customTaxes3;

  @override
  @BuiltValueField(wireName: 'custom_surcharge_tax4')
  bool get customTaxes4;

  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @BuiltValueField(wireName: 'reminder1_sent')
  String? get reminder1Sent;

  @BuiltValueField(wireName: 'reminder2_sent')
  String? get reminder2Sent;

  @BuiltValueField(wireName: 'reminder3_sent')
  String? get reminder3Sent;

  @BuiltValueField(wireName: 'reminder_last_sent')
  String? get reminderLastSent;

  @BuiltValueField(wireName: 'frequency_id')
  String? get frequencyId;

  @BuiltValueField(wireName: 'last_sent_date')
  String get lastSentDate;

  @BuiltValueField(wireName: 'next_send_date')
  String get nextSendDate;

  @BuiltValueField(wireName: 'next_send_datetime')
  String get nextSendDatetime;

  @BuiltValueField(wireName: 'remaining_cycles')
  int? get remainingCycles;

  @BuiltValueField(wireName: 'due_date_days')
  String? get dueDateDays;

  @BuiltValueField(wireName: 'invoice_id')
  String? get invoiceId;

  @BuiltValueField(wireName: 'recurring_id')
  String? get recurringId;

  @BuiltValueField(wireName: 'auto_bill_enabled')
  bool get autoBillEnabled;

  @BuiltValueField(wireName: 'recurring_dates')
  BuiltList<InvoiceScheduleEntity>? get recurringDates;

  @override
  @BuiltValueField(wireName: 'line_items')
  BuiltList<InvoiceItemEntity> get lineItems;

  BuiltList<InvitationEntity> get invitations;

  BuiltList<DocumentEntity> get documents;

  @BuiltValueField(compare: false)
  BuiltList<ActivityEntity> get activities;

  @BuiltValueField(serialize: false)
  bool get saveDefaultTerms;

  @BuiltValueField(serialize: false)
  bool get saveDefaultFooter;

  @BuiltValueField(wireName: 'tax_info')
  TaxDataEntity get taxData;

  bool get isApproved {
    if (isQuote &&
        [
          kQuoteStatusApproved,
          kQuoteStatusConverted,
        ].contains(statusId)) {
      return true;
    }

    if (isPurchaseOrder &&
        [
          kPurchaseOrderStatusAccepted,
          kPurchaseOrderStatusReceived,
        ].contains(statusId)) {
      return true;
    }

    return false;
  }

  bool get hasClient => clientId.isNotEmpty;

  bool get hasVendor => vendorId.isNotEmpty;

  bool get hasInvoice => '${invoiceId ?? ''}'.isNotEmpty;

  double get netAmount => amount - taxAmount;

  double get netBalance {
    if (amount == 0) {
      return 0;
    }

    return balance - (taxAmount * balance / amount);
  }

  double get netBalanceOrAmount {
    if (amount == 0) {
      return 0;
    }

    return balanceOrAmount - (taxAmount * balanceOrAmount / amount);
  }

  @BuiltValueField(compare: false)
  int? get loadedAt;

  List<InvoiceHistoryEntity> get history => activities
      .where((activity) =>
          activity.history != null &&
          activity.history!.id.isNotEmpty &&
          activity.history!.createdAt > 0)
      .map((activity) => activity.history)
      .whereType<InvoiceHistoryEntity>()
      .toList();

  List<InvoiceHistoryEntity> get balanceHistory => activities
      .where((activity) =>
          activity.history != null &&
          activity.history!.id.isNotEmpty &&
          activity.history!.createdAt > 0 &&
          ![
            kActivityViewInvoice,
            kActivityViewQuote,
            kActivityViewCredit,
            kActivityViewPurchaseOrder,
          ].contains(activity.activityTypeId))
      .map((activity) => activity.history)
      .whereType<InvoiceHistoryEntity>()
      .toList();

  bool get isLoaded => loadedAt != null && loadedAt! > 0;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - loadedAt! >
        kMillisecondsToRefreshActivities;
  }

  bool get hasTasks => lineItems.any((item) => item.isTask);

  bool get hasProducts => lineItems.any((item) => !item.isTask);

  bool get hasExpenses => lineItems.any((item) => item.isExpense);

  @override
  bool get isEditable {
    if (isDeleted!) {
      return false;
    }

    if (entityType == EntityType.invoice) {
      if (isCancelledOrReversed) {
        return false;
      }
    }

    return true;
  }

  int get age {
    int ageInDays = 0;
    if (isPastDue) {
      final now = DateTime.now();
      final dueDate = DateTime.tryParse(
          partialDueDate.isEmpty ? this.dueDate : partialDueDate);

      if (dueDate != null) {
        ageInDays = now.difference(dueDate).inDays;
      }
    }

    return ageInDays;
  }

  //String get last_login;
  //String get custom_messages;

  int compareTo({
    InvoiceEntity? invoice,
    String? sortField,
    required bool sortAscending,
    required BuiltMap<String, ClientEntity> clientMap,
    required BuiltMap<String, VendorEntity> vendorMap,
    BuiltMap<String, UserEntity>? userMap,
    String? recurringPrefix = '',
  }) {
    int response = 0;
    final InvoiceEntity invoiceA = sortAscending ? this : invoice!;
    final InvoiceEntity invoiceB = sortAscending ? invoice! : this;
    final clientA = clientMap[invoiceA.clientId] ?? ClientEntity();
    final clientB = clientMap[invoiceB.clientId] ?? ClientEntity();
    final vendorA = vendorMap[invoiceA.vendorId] ?? VendorEntity();
    final vendorB = vendorMap[invoiceB.vendorId] ?? VendorEntity();
    switch (sortField) {
      case InvoiceFields.number:
        var invoiceANumber =
            invoiceA.number.isEmpty ? 'ZZZZZZZZZZ' : invoiceA.number;
        var invoiceBNumber =
            invoiceB.number.isEmpty ? 'ZZZZZZZZZZ' : invoiceB.number;
        invoiceANumber = (recurringPrefix ?? '').isNotEmpty &&
                invoiceANumber.startsWith(recurringPrefix!)
            ? invoiceANumber.replaceFirst(recurringPrefix, '')
            : invoiceANumber;
        invoiceBNumber = (recurringPrefix ?? '').isNotEmpty &&
                invoiceBNumber.startsWith(recurringPrefix!)
            ? invoiceBNumber.replaceFirst(recurringPrefix, '')
            : invoiceBNumber;
        response = compareNatural(invoiceANumber, invoiceBNumber);
        break;
      case InvoiceFields.amount:
        response = invoiceA.amount.compareTo(invoiceB.amount);
        break;
      case EntityFields.createdAt:
        response = invoiceA.createdAt.compareTo(invoiceB.createdAt);
        break;
      case EntityFields.updatedAt:
        response = invoiceA.updatedAt.compareTo(invoiceB.updatedAt);
        break;
      case EntityFields.archivedAt:
        response = invoiceA.archivedAt.compareTo(invoiceB.archivedAt);
        break;
      case InvoiceFields.date:
        response = invoiceA.date.compareTo(invoiceB.date);
        break;
      case InvoiceFields.lastSentDate:
        response = invoiceA.lastSentDate.compareTo(invoiceB.lastSentDate);
        break;
      case InvoiceFields.reminder1Sent:
        response = invoiceA.reminder1Sent!.compareTo(invoiceB.reminder1Sent!);
        break;
      case InvoiceFields.reminder2Sent:
        response = invoiceA.reminder2Sent!.compareTo(invoiceB.reminder2Sent!);
        break;
      case InvoiceFields.reminder3Sent:
        response = invoiceA.reminder3Sent!.compareTo(invoiceB.reminder3Sent!);
        break;
      case InvoiceFields.reminderLastSent:
        response =
            invoiceA.reminderLastSent!.compareTo(invoiceB.reminderLastSent!);
        break;
      case InvoiceFields.balance:
        response = invoiceA.balanceOrAmount.compareTo(invoiceB.balanceOrAmount);
        break;
      case InvoiceFields.discount:
        response = invoiceA.discount.compareTo(invoiceB.discount);
        break;
      case InvoiceFields.documents:
        response =
            invoiceA.documents.length.compareTo(invoiceB.documents.length);
        break;
      case InvoiceFields.poNumber:
        response = invoiceA.poNumber.compareTo(invoiceB.poNumber);
        break;
      case InvoiceFields.status:
        response =
            invoiceA.calculatedStatusId.compareTo(invoiceB.calculatedStatusId);
        break;
      case EntityFields.state:
        final stateA = EntityState.valueOf(invoiceA.entityState);
        final stateB = EntityState.valueOf(invoiceB.entityState);
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case InvoiceFields.dueDate:
      case QuoteFields.validUntil:
        response = invoiceA.dueDate.compareTo(invoiceB.dueDate);
        break;
      case InvoiceFields.nextSendDate:
        if (invoiceA.nextSendDatetime.isNotEmpty &&
            invoiceB.nextSendDatetime.isNotEmpty) {
          response =
              invoiceA.nextSendDatetime.compareTo(invoiceB.nextSendDatetime);
        } else {
          response = invoiceA.nextSendDate.compareTo(invoiceB.nextSendDate);
        }
        break;
      case EntityFields.assignedTo:
        final userA = userMap![invoiceA.assignedUserId] ?? UserEntity();
        final userB = userMap[invoiceB.assignedUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdBy:
        final userA = userMap![invoiceA.createdUserId] ?? UserEntity();
        final userB = userMap[invoiceB.createdUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case InvoiceFields.publicNotes:
        response = invoiceA.publicNotes
            .toLowerCase()
            .compareTo(invoiceB.publicNotes.toLowerCase());
        break;
      case InvoiceFields.privateNotes:
        response = invoiceA.privateNotes
            .toLowerCase()
            .compareTo(invoiceB.privateNotes.toLowerCase());
        break;
      case InvoiceFields.customValue1:
        response = invoiceA.customValue1
            .toLowerCase()
            .compareTo(invoiceB.customValue1.toLowerCase());
        break;
      case InvoiceFields.customValue2:
        response = invoiceA.customValue2
            .toLowerCase()
            .compareTo(invoiceB.customValue2.toLowerCase());
        break;
      case InvoiceFields.customValue3:
        response = invoiceA.customValue3
            .toLowerCase()
            .compareTo(invoiceB.customValue3.toLowerCase());
        break;
      case InvoiceFields.customValue4:
        response = invoiceA.customValue4
            .toLowerCase()
            .compareTo(invoiceB.customValue4.toLowerCase());
        break;
      case InvoiceFields.client:
        response = removeDiacritics(clientA.listDisplayName)
            .toLowerCase()
            .compareTo(removeDiacritics(clientB.listDisplayName).toLowerCase());
        break;
      case InvoiceFields.isViewed:
        response = invoiceB.isViewed ? 1 : -1;
        break;
      case RecurringInvoiceFields.remainingCycles:
        response =
            invoiceA.remainingCycles!.compareTo(invoiceB.remainingCycles!);
        break;
      case RecurringInvoiceFields.frequency:
        response = invoiceA.frequencyId!.compareTo(invoiceB.frequencyId!);
        break;
      case RecurringInvoiceFields.autoBill:
        response = invoiceA.autoBill!.compareTo(invoiceB.autoBill!);
        break;
      case InvoiceFields.clientCity:
        response = clientA.city.compareTo(clientB.city);
        break;
      case InvoiceFields.clientState:
        response = clientA.state.compareTo(clientB.state);
        break;
      case InvoiceFields.clientPostalCode:
        response = clientA.postalCode.compareTo(clientB.postalCode);
        break;
      case InvoiceFields.clientCountry:
        response = clientA.countryId.compareTo(clientB.countryId);
        break;
      case InvoiceFields.partial:
        response = invoiceA.partial.compareTo(invoiceB.partial);
        break;
      case InvoiceFields.partialDueDate:
        response = invoiceA.partialDueDate.compareTo(invoiceB.partialDueDate);
        break;
      case InvoiceFields.vendor:
        response =
            vendorA.name.toLowerCase().compareTo(vendorB.name.toLowerCase());
        break;
      case InvoiceFields.dueDateDays:
        response = invoiceA.dueDateDays!.compareTo(invoiceB.dueDateDays!);
        break;
      default:
        print('## ERROR: sort by invoice.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      response = invoice!.number.toLowerCase().compareTo(number.toLowerCase());
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
        // Handle pending recurring invoices which are active
        if (isRecurring &&
            status.id == kRecurringInvoiceStatusActive &&
            statusId == kRecurringInvoiceStatusActive &&
            calculatedStatusId == kRecurringInvoiceStatusPending) {
          // skip
        } else {
          return true;
        }
      } else if (status.id == kInvoiceStatusUnpaid &&
          isInvoice &&
          isUnpaid &&
          isSent &&
          !isCancelledOrReversed) {
        return true;
      }
    }

    return false;
  }

  @override
  bool matchesFilter(String? filter) {
    for (var i = 0; i < lineItems.length; i++) {
      final lineItem = lineItems[i];
      final isMatch = matchesStrings(
        haystacks: [
          lineItem.productKey,
          lineItem.notes,
          lineItem.customValue1,
          lineItem.customValue2,
          lineItem.customValue3,
          lineItem.customValue4,
        ],
        needle: filter,
      );

      if (isMatch) {
        return true;
      }
    }

    return matchesStrings(
      haystacks: [
        number,
        poNumber,
        publicNotes,
        privateNotes,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
        formatNumber(amount, navigatorKey.currentContext),
        formatDate(date, navigatorKey.currentContext)
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        poNumber,
        publicNotes,
        privateNotes,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
        formatNumber(amount, navigatorKey.currentContext),
        formatDate(date, navigatorKey.currentContext)
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
    final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
    final state = store.state;
    final actions = <EntityAction?>[];

    if (!isDeleted!) {
      if (userCompany!.canEditEntity(this)) {
        if (includeEdit && !multiselect) {
          actions.add(EntityAction.edit);
        }

        if (isRecurringInvoice) {
          if ([
            kRecurringInvoiceStatusDraft,
            kRecurringInvoiceStatusPending,
          ].contains(calculatedStatusId)) {
            actions.add(EntityAction.sendNow);
          }

          if ([
            kRecurringInvoiceStatusDraft,
            kRecurringInvoiceStatusPaused,
            kRecurringInvoiceStatusCompleted,
          ].contains(statusId)) {
            actions.add(EntityAction.start);
          } else if ([
            kRecurringInvoiceStatusPending,
            kRecurringInvoiceStatusActive
          ].contains(calculatedStatusId)) {
            actions.add(EntityAction.stop);
          }

          actions.add(EntityAction.updatePrices);
          actions.add(EntityAction.increasePrices);
        } else {
          if (!isCancelledOrReversed) {
            if (multiselect) {
              actions.add(EntityAction.bulkSendEmail);
            } else {
              actions.add(EntityAction.sendEmail);
              if (isUnpaid) {
                actions.add(EntityAction.schedule);
              }
            }
          }
        }
      }

      if (multiselect) {
        if (!isRecurring) {
          actions.add(EntityAction.bulkPrint);
          actions.add(EntityAction.bulkDownload);
        }
      } else {
        actions.add(EntityAction.viewPdf);
        if (!isRecurring) {
          actions.add(EntityAction.printPdf);
          actions.add(EntityAction.download);
          if (isInvoice && state.company.settings.enableEInvoice == true) {
            actions.add(EntityAction.eInvoice);
          }
        }
      }

      if (!isDeleted!) {
        if (hasDesignTemplatesForEntityType(
            store.state.designState.map, entityType!)) {
          actions.add(EntityAction.runTemplate);
        }
      }

      if (userCompany.canEditEntity(this) && !isCancelledOrReversed) {
        if (!isSent && !isRecurring) {
          actions.add(EntityAction.markSent);
        }

        if (isPurchaseOrder) {
          if (expenseId.isEmpty) {
            if (userCompany.canCreate(EntityType.expense)) {
              actions.add(EntityAction.convertToExpense);
            }
          } else {
            actions.add(EntityAction.viewExpense);
          }
          if (statusId == kPurchaseOrderStatusAccepted) {
            actions.add(EntityAction.addToInventory);
          }
        }

        if (userCompany.canCreate(EntityType.payment)) {
          if (isPayable && isInvoice) {
            actions.addAll([
              EntityAction.newPayment,
              EntityAction.markPaid,
              EntityAction.autoBill,
            ]);
          } else if (isCredit) {
            if (balanceOrAmount < 0) {
              actions.add(EntityAction.markPaid);
            } else if (balanceOrAmount > 0) {
              actions.add(EntityAction.applyCredit);
            }
          }
        }

        if (isQuote) {
          if ((invoiceId ?? '').isEmpty) {
            if (!isApproved) {
              actions.add(EntityAction.approve);
            }
            actions.add(EntityAction.convertToInvoice);
          } else {
            actions.add(EntityAction.viewInvoice);
          }

          if (projectId.isEmpty) {
            actions.add(EntityAction.convertToProject);
          }
        } else if (isPurchaseOrder) {
          if (!isCancelled) {
            //actions.add(EntityAction.accept);
          }
        }
      }

      if (!multiselect) {
        if (isPurchaseOrder) {
          actions.add(EntityAction.vendorPortal);
        } else {
          actions.add(EntityAction.clientPortal);
        }
      }
    }

    if (!isDeleted! && multiselect) {
      actions.add(EntityAction.documents);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    if (!multiselect && isOld) {
      int countOtherTypes = 0;
      if (userCompany!.canCreate(EntityType.invoice)) {
        countOtherTypes++;
        if (isInvoice) {
          actions.add(EntityAction.cloneToInvoice);
        }
      }
      if (userCompany.canCreate(EntityType.quote)) {
        countOtherTypes++;
        if (isQuote) {
          actions.add(EntityAction.cloneToQuote);
        }
      }
      if (userCompany.canCreate(EntityType.credit)) {
        countOtherTypes++;
        if (isCredit) {
          actions.add(EntityAction.cloneToCredit);
        }
      }
      if (userCompany.canCreate(EntityType.recurringInvoice)) {
        countOtherTypes++;
        if (isRecurringInvoice) {
          actions.add(EntityAction.cloneToRecurring);
        }
      }
      if (userCompany.canCreate(EntityType.purchaseOrder)) {
        countOtherTypes++;
        if (isPurchaseOrder) {
          actions.add(EntityAction.cloneToPurchaseOrder);
        }
      }
      if (countOtherTypes == 2) {
        if (userCompany.canCreate(EntityType.invoice) && !isInvoice) {
          actions.add(EntityAction.cloneToInvoice);
        }
        if (userCompany.canCreate(EntityType.quote) && !isQuote) {
          actions.add(EntityAction.cloneToQuote);
        }
        if (userCompany.canCreate(EntityType.credit) && !isCredit) {
          actions.add(EntityAction.cloneToCredit);
        }
        if (userCompany.canCreate(EntityType.recurringInvoice) &&
            !isRecurringInvoice) {
          actions.add(EntityAction.cloneToRecurring);
        }
      } else if (countOtherTypes > 2) {
        actions.add(EntityAction.cloneToOther);
      }

      if (actions.isNotEmpty && actions.last != null) {
        actions.add(null);
      }
    }

    if (userCompany!.canEditEntity(this) &&
        !isDeleted! &&
        !isCancelledOrReversed) {
      if (isInvoice && isSent) {
        if (!isPaid) {
          actions.add(EntityAction.cancelInvoice);
        }

        if ((isPaid || isPartial) && userCompany.canCreate(EntityType.credit)) {
          actions.add(EntityAction.reverse);
        }
      }
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  InvoiceEntity applyTax(TaxRateEntity taxRate,
      {bool isSecond = false, bool isThird = false}) {
    InvoiceEntity invoice;

    if (isThird) {
      invoice = rebuild((b) => b
        ..taxRate3 = taxRate.rate
        ..taxName3 = taxRate.name);
    } else if (isSecond) {
      invoice = rebuild((b) => b
        ..taxRate2 = taxRate.rate
        ..taxName2 = taxRate.name);
    } else {
      invoice = rebuild((b) => b
        ..taxRate1 = taxRate.rate
        ..taxName1 = taxRate.name);
    }

    return invoice;
  }

  @override
  String get listDisplayName {
    return number;
  }

  @override
  double get listDisplayAmount => balanceOrAmount;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  String get primaryDate {
    if (partialDueDate.isNotEmpty && partial != 0) {
      return partialDueDate;
    } else if (dueDate.isNotEmpty && !isPaid) {
      return dueDate;
    } else {
      return date;
    }
  }

  bool isBetween(String startDate, String? endDate) {
    return startDate.compareTo(date) <= 0 && endDate!.compareTo(date) >= 0;
  }

  bool get isInvoice => entityType == EntityType.invoice;

  bool get isPurchaseOrder => entityType == EntityType.purchaseOrder;

  bool get isQuote => entityType == EntityType.quote;

  bool get isCredit => entityType == EntityType.credit;

  bool get isRecurringInvoice => entityType == EntityType.recurringInvoice;

  bool get isInvoiced => (invoiceId ?? '').isNotEmpty;

  bool get isRecurring => [EntityType.recurringInvoice].contains(entityType);

  bool get isLinkedToRecurring => (recurringId ?? '').isNotEmpty;

  bool get hasExchangeRate => exchangeRate != 1 && exchangeRate != 0;

  EmailTemplate get emailTemplate => isPurchaseOrder
      ? EmailTemplate.purchase_order
      : isQuote
          ? EmailTemplate.quote
          : isCredit
              ? EmailTemplate.credit
              : EmailTemplate.invoice;

  double get requestedAmount => partial > 0 ? partial : amount;

  bool get isRunning =>
      isRecurring && statusId == kRecurringInvoiceStatusActive;

  bool get isDraft => statusId == kInvoiceStatusDraft;

  bool get isSent => statusId != kInvoiceStatusDraft;

  bool get isApplied => isCredit && statusId == kCreditStatusApplied;

  bool get isUnpaid {
    if (isPurchaseOrder) {
      return !isApproved;
    } else if (isQuote) {
      return !isApproved;
    } else if (isCredit) {
      return !isApplied;
    } else {
      return !isPaid;
    }
  }

  bool get isPayable =>
      !isPaid && !isQuote && !isRecurringInvoice && !isCancelledOrReversed;

  bool get isViewed =>
      invitations.any((invitation) => invitation.viewedDate.isNotEmpty);

  bool get isPaid => isInvoice && statusId == kInvoiceStatusPaid;

  bool get isPartial => isInvoice && statusId == kInvoiceStatusPartial;

  bool get isReversed => isInvoice && statusId == kInvoiceStatusReversed;

  bool get isCancelled =>
      (isInvoice && statusId == kInvoiceStatusCancelled) ||
      (isPurchaseOrder && statusId == kPurchaseOrderStatusCancelled);

  bool get isCancelledOrReversed =>
      (isInvoice || isPurchaseOrder) && (isCancelled || isReversed);

  bool get isUpcoming => isActive && !isPaid && !isPastDue && isSent;

  bool get isPending =>
      isRecurring &&
      statusId == kRecurringInvoiceStatusActive &&
      lastSentDate.isEmpty;

  String? get calculateRemainingCycles =>
      remainingCycles == -1 ? 'endless' : remainingCycles as String?;

  String get calculatedStatusId {
    if (isRecurring) {
      if (!isDraft && remainingCycles == 0) {
        return kRecurringInvoiceStatusCompleted;
      } else if (isPending) {
        return kRecurringInvoiceStatusPending;
      }
    } else {
      if (isPastDue && !isCancelledOrReversed) {
        if (isInvoice) {
          return kInvoiceStatusPastDue;
        } else if (isQuote) {
          return kQuoteStatusExpired;
        }
      }

      if (isViewed &&
          isUnpaid &&
          !isPartial &&
          !isCancelledOrReversed &&
          !isApproved) {
        if (isInvoice) {
          return kInvoiceStatusViewed;
        } else if (isQuote) {
          return kQuoteStatusViewed;
        } else if (isCredit) {
          return kCreditStatusViewed;
        } else if (isPurchaseOrder) {
          return kPurchaseOrderStatusViewed;
        }
      }
    }

    return statusId;
  }

  bool get isPastDue {
    final date =
        (partial != 0 && partialDueDate.isNotEmpty) ? partialDueDate : dueDate;

    if (date.isEmpty || balance == 0) {
      return false;
    }

    return !isDeleted! &&
        !isRecurring &&
        isSent &&
        isUnpaid &&
        DateTime.tryParse(date)!
            .isBefore(DateTime.now().subtract(Duration(days: 1)));
  }

  InvitationEntity? getInvitationForClientContact(
      ClientContactEntity? contact) {
    return invitations.firstWhereOrNull(
        (invitation) => invitation.clientContactId == contact!.id);
  }

  InvitationEntity? getInvitationForVendorContact(
      VendorContactEntity? contact) {
    return invitations.firstWhereOrNull(
        (invitation) => invitation.vendorContactId == contact!.id);
  }

  /// Gets taxes in the form { taxName1: { amount: 0, paid: 0} , ... }
  Map<String, Map<String, dynamic>> getTaxes(int precision) {
    final taxes = <String, Map<String, dynamic>>{};
    final taxable = getTaxable(precision);

    double calculateAmount(double taxable, double rate) {
      if (usesInclusiveTaxes) {
        return round(taxable - (taxable / (1 + (rate / 100))), 2);
      } else {
        return round(taxable * (rate / 100), 2);
      }
    }

    if (taxName1.isNotEmpty) {
      final invoiceTaxAmount = calculateAmount(taxable, taxRate1);
      final invoicePaidAmount = (amount * invoiceTaxAmount != 0)
          ? (paidToDate / amount * invoiceTaxAmount)
          : 0.0;
      _calculateTax(
          taxes, taxName1, taxRate1, invoiceTaxAmount, invoicePaidAmount);
    }

    if (taxName2.isNotEmpty) {
      final invoiceTaxAmount = calculateAmount(taxable, taxRate2);
      final invoicePaidAmount = (amount * invoiceTaxAmount != 0)
          ? (paidToDate / amount * invoiceTaxAmount)
          : 0.0;
      _calculateTax(
          taxes, taxName2, taxRate2, invoiceTaxAmount, invoicePaidAmount);
    }

    if (taxName3.isNotEmpty) {
      final invoiceTaxAmount = calculateAmount(taxable, taxRate3);
      final invoicePaidAmount = (amount * invoiceTaxAmount != 0)
          ? (paidToDate / amount * invoiceTaxAmount)
          : 0.0;
      _calculateTax(
          taxes, taxName3, taxRate3, invoiceTaxAmount, invoicePaidAmount);
    }

    for (final item in lineItems) {
      final itemTaxable = getItemTaxable(item, amount, precision);

      if (item.taxName1.isNotEmpty) {
        final itemTaxAmount = calculateAmount(itemTaxable, item.taxRate1);
        final itemPaidAmount = amount * itemTaxAmount != 0
            ? (paidToDate / amount * itemTaxAmount)
            : 0.0;

        _calculateTax(
            taxes, item.taxName1, item.taxRate1, itemTaxAmount, itemPaidAmount);
      }

      if (item.taxName2.isNotEmpty) {
        final itemTaxAmount = calculateAmount(itemTaxable, item.taxRate2);
        final itemPaidAmount = amount * itemTaxAmount != 0
            ? (paidToDate / amount * itemTaxAmount)
            : 0.0;
        _calculateTax(
            taxes, item.taxName2, item.taxRate2, itemTaxAmount, itemPaidAmount);
      }

      if (item.taxName3.isNotEmpty) {
        final itemTaxAmount = calculateAmount(itemTaxable, item.taxRate3);
        final itemPaidAmount = amount * itemTaxAmount != 0
            ? (paidToDate / amount * itemTaxAmount)
            : 0.0;
        _calculateTax(
            taxes, item.taxName3, item.taxRate3, itemTaxAmount, itemPaidAmount);
      }
    }

    if (taxes.isEmpty) {
      _calculateTax(taxes, '', 0, 0, 0);
    }

    return taxes;
  }

  void _calculateTax(
    Map<String, Map<String, dynamic>> map,
    String name,
    double rate,
    double amount,
    double paid,
  ) {
    final key = rate.toString() + ' ' + name;

    map.putIfAbsent(
        key,
        () => <String, dynamic>{
              'name': name,
              'rate': rate,
              'amount': 0.0,
              'paid': 0.0
            });

    map[key]!['amount'] += amount;
    map[key]!['paid'] += paid;
  }

  String get invitationLink =>
      invitations.isEmpty ? '' : invitations.first.link;

  String get invitationBorderlessLink =>
      invitations.isEmpty ? '' : invitations.first.borderlessLink;

  String get invitationSilentLink =>
      invitations.isEmpty ? '' : invitations.first.silentLink;

  String get invitationDownloadLink =>
      invitations.isEmpty ? '' : invitations.first.downloadLink;

  String get invitationEInvoiceDownloadLink =>
      invitations.isEmpty ? '' : invitations.first.eInvoiceDownloadLink;

  // ignore: unused_element
  static void _initializeBuilder(InvoiceEntityBuilder builder) => builder
    ..activities.replace(BuiltList<ActivityEntity>())
    ..paidToDate = 0
    ..projectId = ''
    ..expenseId = ''
    ..vendorId = ''
    ..saveDefaultTerms = false
    ..saveDefaultFooter = false
    ..autoBillEnabled = false
    ..nextSendDatetime = ''
    ..taxData.replace(TaxDataEntity())
    ..subscriptionId = '';

  static Serializer<InvoiceEntity> get serializer => _$invoiceEntitySerializer;
}

class ProductItemFields {
  static const String item = 'item';
  static const String description = 'description';
  static const String unitCost = 'unit_cost';
  static const String productCost = 'product_cost';
  static const String tax = 'tax';
  static const String taxAmount = 'tax_amount';
  static const String quantity = 'quantity';
  static const String lineTotal = 'line_total';
  static const String grossLineTotal = 'gross_line_total';
  static const String discount = 'discount';
  static const String custom1 = 'product1';
  static const String custom2 = 'product2';
  static const String custom3 = 'product3';
  static const String custom4 = 'product4';
  /*
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
  static const String custom3 = 'custom3';
  static const String custom4 = 'custom4';
  */
}

class TaskItemFields {
  static const String service = 'service';
  static const String description = 'description';
  static const String rate = 'rate';
  static const String serviceCost = 'service_cost';
  static const String tax = 'tax';
  static const String taxAmount = 'tax_amount';
  static const String hours = 'hours';
  static const String lineTotal = 'line_total';
  static const String grossLineTotal = 'gross_line_total';
  static const String discount = 'discount';
  static const String custom1 = 'task1';
  static const String custom2 = 'task2';
  static const String custom3 = 'task3';
  static const String custom4 = 'task4';
  /*
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
  static const String custom3 = 'custom3';
  static const String custom4 = 'custom4';
  */
}

abstract class InvoiceItemEntity
    implements Built<InvoiceItemEntity, InvoiceItemEntityBuilder> {
  factory InvoiceItemEntity(
      {String? productKey, double? quantity, String? typeId}) {
    return _$InvoiceItemEntity._(
      productKey: productKey ?? '',
      notes: '',
      cost: 0,
      productCost: 0,
      quantity: quantity ?? 1,
      taxName1: '',
      taxRate1: 0,
      taxName2: '',
      taxRate2: 0,
      taxName3: '',
      taxRate3: 0,
      typeId: typeId ?? TYPE_STANDARD,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      discount: 0,
      taxCategoryId: '',
      createdAt: DateTime.now().microsecondsSinceEpoch,
    );
  }

  InvoiceItemEntity._();

  static const TYPE_STANDARD = '1';
  static const TYPE_TASK = '2';
  static const TYPE_UNPAID_FEE = '3';
  static const TYPE_PAID_FEE = '4';
  static const TYPE_LATE_FEE = '5';
  static const TYPE_EXPENSE = '6';

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'product_key')
  String get productKey;

  String get notes;

  double get cost;

  @BuiltValueField(wireName: 'product_cost')
  double get productCost;

  double get quantity;

  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;

  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;

  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;

  @BuiltValueField(wireName: 'tax_name3')
  String get taxName3;

  @BuiltValueField(wireName: 'tax_rate3')
  double get taxRate3;

  @BuiltValueField(wireName: 'type_id')
  String? get typeId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  double get discount;

  @BuiltValueField(wireName: 'task_id')
  String? get taskId;

  @BuiltValueField(wireName: 'expense_id')
  String? get expenseId;

  int? get createdAt;

  @BuiltValueField(wireName: 'tax_id')
  String get taxCategoryId;

  double taxAmount(InvoiceEntity invoice, int precision) {
    double calculateTaxAmount(double rate) {
      double taxAmount;
      if (rate == 0) {
        return 0;
      }
      final lineTotal = total(invoice, precision);
      if (invoice.usesInclusiveTaxes) {
        taxAmount = lineTotal - (lineTotal / (1 + (rate / 100)));
      } else {
        taxAmount = lineTotal * rate / 100;
      }
      return round(taxAmount, precision);
    }

    return calculateTaxAmount(taxRate1) +
        calculateTaxAmount(taxRate2) +
        calculateTaxAmount(taxRate3) +
        calculateTaxAmount(invoice.taxRate1) +
        calculateTaxAmount(invoice.taxRate2) +
        calculateTaxAmount(invoice.taxRate3);
  }

  double netTotal(InvoiceEntity invoice, int precision) =>
      total(invoice, precision) - taxAmount(invoice, precision);

  double total(InvoiceEntity invoice, int precision) {
    var total = quantity * cost;

    if (discount != 0) {
      if (invoice.isAmountDiscount) {
        total = total - discount;
      } else {
        total = total - (discount / 100 * total);
      }
    }

    return round(total, precision);
  }

  bool get isTask => typeId == TYPE_TASK;

  bool get isExpense => typeId == TYPE_EXPENSE;

  bool get hasOverrideTax => taxCategoryId == kTaxCategoryOverrideTax;

  bool get isEmpty =>
      productKey.isEmpty &&
      notes.isEmpty &&
      cost == 0 &&
      (quantity == 0 || quantity == 1) &&
      taxName1.isEmpty &&
      taxRate1 == 0 &&
      taxName2.isEmpty &&
      taxRate2 == 0 &&
      taxName3.isEmpty &&
      taxRate3 == 0 &&
      customValue1.isEmpty &&
      customValue2.isEmpty &&
      customValue3.isEmpty &&
      customValue4.isEmpty;

  bool get hasTaxes =>
      taxRate1 != 0 ||
      taxRate2 != 0 ||
      taxRate3 != 0 ||
      taxName1.isNotEmpty ||
      taxName2.isNotEmpty ||
      taxName3.isNotEmpty;

  String get taxRates {
    final parts = <String>[];
    if (taxName1.isNotEmpty) {
      parts.add(taxName1);
    }
    if (taxName2.isNotEmpty) {
      parts.add(taxName2);
    }
    if (taxName3.isNotEmpty) {
      parts.add(taxName3);
    }
    return parts.join(', ');
  }

  InvoiceItemEntity applyTax(TaxRateEntity? taxRate,
      {bool isSecond = false, bool isThird = false}) {
    InvoiceItemEntity item;

    if (isThird) {
      item = rebuild((b) => b
        ..taxRate3 = taxRate!.rate
        ..taxName3 = taxRate.name);
    } else if (isSecond) {
      item = rebuild((b) => b
        ..taxRate2 = taxRate!.rate
        ..taxName2 = taxRate.name);
    } else {
      item = rebuild((b) => b
        ..taxRate1 = taxRate!.rate
        ..taxName1 = taxRate.name);
    }

    return item;
  }

  // ignore: unused_element
  static void _initializeBuilder(InvoiceItemEntityBuilder builder) => builder
    ..productCost = 0
    ..taxCategoryId = '';

  static Serializer<InvoiceItemEntity> get serializer =>
      _$invoiceItemEntitySerializer;
}

abstract class InvitationEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<InvitationEntity, InvitationEntityBuilder> {
  factory InvitationEntity({
    String? clientContactId,
    String? vendorContactId,
  }) {
    return _$InvitationEntity._(
      id: BaseEntity.nextId,
      isChanged: false,
      clientContactId: clientContactId ?? '',
      vendorContactId: vendorContactId ?? '',
      createdAt: 0,
      emailStatus: '',
      emailError: '',
      key: '',
      link: '',
      sentDate: '',
      viewedDate: '',
      openedDate: '',
      messageId: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  InvitationEntity._();

  static const EMAIL_STATUS_DELIVERED = 'delivered';
  static const EMAIL_STATUS_BOUNCED = 'bounced';
  static const EMAIL_STATUS_SPAM = 'spam';

  @override
  @memoized
  int get hashCode;

  String get key;

  String get link;

  @BuiltValueField(wireName: 'client_contact_id')
  String get clientContactId;

  @BuiltValueField(wireName: 'vendor_contact_id')
  String get vendorContactId;

  @BuiltValueField(wireName: 'sent_date', compare: false)
  String get sentDate;

  @BuiltValueField(wireName: 'viewed_date', compare: false)
  String get viewedDate;

  @BuiltValueField(wireName: 'opened_date', compare: false)
  String get openedDate;

  @BuiltValueField(wireName: 'email_status', compare: false)
  String get emailStatus;

  @BuiltValueField(wireName: 'email_error', compare: false)
  String get emailError;

  @BuiltValueField(wireName: 'message_id', compare: false)
  String get messageId;

  String get downloadLink =>
      '$link/download?t=${DateTime.now().millisecondsSinceEpoch}';

  String get silentLink => '$link?silent=true';

  String get eInvoiceDownloadLink =>
      '$link/download_e_invoice?t=${DateTime.now().millisecondsSinceEpoch}';

  String get borderlessLink => '$silentLink&borderless=true';

  String get latestEmailStatus {
    if (viewedDate.isNotEmpty) {
      return 'viewed';
    } else if (openedDate.isNotEmpty) {
      return 'opened';
    } else if (sentDate.isNotEmpty) {
      return emailStatus;
    } else {
      return '';
    }
  }

  String get latestEmailStatusDate {
    if (viewedDate.isNotEmpty) {
      return viewedDate;
    } else if (openedDate.isNotEmpty) {
      return openedDate;
    } else if (sentDate.isNotEmpty) {
      return sentDate;
    } else {
      return '';
    }
  }

  @override
  bool matchesFilter(String? filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    return false;
  }

  @override
  String? matchesFilterValue(String? filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return '';
  }

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  // ignore: unused_element
  static void _initializeBuilder(InvitationEntityBuilder builder) => builder
    ..clientContactId = ''
    ..vendorContactId = ''
    ..emailError = ''
    ..emailStatus = ''
    ..messageId = '';

  static Serializer<InvitationEntity> get serializer =>
      _$invitationEntitySerializer;
}

abstract class InvoiceScheduleEntity
    implements Built<InvoiceScheduleEntity, InvoiceScheduleEntityBuilder> {
  factory InvoiceScheduleEntity() {
    return _$InvoiceScheduleEntity._(
      sendDate: '',
      dueDate: '',
    );
  }

  InvoiceScheduleEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'send_date')
  String get sendDate;

  @BuiltValueField(wireName: 'due_date')
  String get dueDate;

  static Serializer<InvoiceScheduleEntity> get serializer =>
      _$invoiceScheduleEntitySerializer;
}

abstract class InvoiceHistoryEntity
    implements Built<InvoiceHistoryEntity, InvoiceHistoryEntityBuilder> {
  factory InvoiceHistoryEntity({String? contactId}) {
    return _$InvoiceHistoryEntity._(
      id: '',
      createdAt: 0,
      activityId: '',
      amount: 0,
    );
  }

  InvoiceHistoryEntity._();

  @override
  @memoized
  int get hashCode;

  String get id;

  @BuiltValueField(wireName: 'activity_id')
  String get activityId;

  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  double get amount;

  static Serializer<InvoiceHistoryEntity> get serializer =>
      _$invoiceHistoryEntitySerializer;
}
