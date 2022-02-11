// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/mixins/invoice_mixin.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/data/models/recurring_invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
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
  static const String nextSendDate = 'next_send_date';
  static const String lastSentDate = 'last_sent_date';
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
    with BaseEntity, SelectableEntity, CalculateInvoiceTotal, BelongsToClient
    implements Built<InvoiceEntity, InvoiceEntityBuilder> {
  factory InvoiceEntity({
    String id,
    AppState state,
    ClientEntity client,
    UserEntity user,
    EntityType entityType,
  }) {
    final company = state?.company;
    final settings = getClientSettings(state, client);

    double exchangeRate = 1;
    if ((client?.currencyId ?? '').isNotEmpty) {
      exchangeRate = getExchangeRate(
        state.staticState.currencyMap,
        fromCurrencyId: state.company.currencyId,
        toCurrencyId: client.currencyId,
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
      vendorId: '',
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
      autoBillEnabled: false,
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
      filename: '',
      subscriptionId: '',
      recurringDates: BuiltList<InvoiceScheduleEntity>(),
      lineItems: BuiltList<InvoiceItemEntity>(),
      usesInclusiveTaxes: company?.settings?.enableInclusiveTaxes ?? false,
      documents: BuiltList<DocumentEntity>(),
      activities: BuiltList<ActivityEntity>(),
      invitations: client == null
          ? BuiltList<InvitationEntity>()
          : BuiltList(client.emailContacts
              .map((contact) => InvitationEntity(contactId: contact.id))
              .toList()),
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
      frequencyId: kFrequencyMonthly,
      remainingCycles: -1,
      dueDateDays: 'terms',
    );
  }

  InvoiceEntity._();

  @override
  @memoized
  int get hashCode;

  InvoiceEntity moveLineItem(int oldIndex, int newIndex) {
    final lineItem = lineItems[oldIndex];
    InvoiceEntity invoice = rebuild((b) => b..lineItems.removeAt(oldIndex));
    invoice = invoice.rebuild((b) => b
      ..lineItems.replace(<InvoiceItemEntity>[
        ...invoice.lineItems.sublist(0, newIndex),
        lineItem,
        ...invoice.lineItems.sublist(
          newIndex,
          invoice.lineItems.length,
        )
      ])
      ..isChanged = true);
    return invoice;
  }

  InvoiceEntity get clone => rebuild((b) => b
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
    ..vendorId = ''
    ..subscriptionId = ''
    ..number = ''
    ..date = convertDateTimeToSqlDate()
    ..dueDate = ''
    ..documents.clear()
    ..lineItems.replace(lineItems
        .where(
            (lineItem) => lineItem.typeId != InvoiceItemEntity.TYPE_UNPAID_FEE)
        .toList())
    ..invitations.replace(invitations
        .map((invitation) => InvitationEntity(contactId: invitation.contactId))
        .toList()));

  InvoiceEntity applyClient(AppState state, ClientEntity client) {
    client ??= ClientEntity();

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

  @nullable
  @BuiltValueField(wireName: 'auto_bill')
  String get autoBill;

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

  @nullable
  @BuiltValueField(wireName: 'reminder1_sent')
  String get reminder1Sent;

  @nullable
  @BuiltValueField(wireName: 'reminder2_sent')
  String get reminder2Sent;

  @nullable
  @BuiltValueField(wireName: 'reminder3_sent')
  String get reminder3Sent;

  @nullable
  @BuiltValueField(wireName: 'reminder_last_sent')
  String get reminderLastSent;

  @nullable
  @BuiltValueField(wireName: 'frequency_id')
  String get frequencyId;

  @BuiltValueField(wireName: 'last_sent_date')
  String get lastSentDate;

  @BuiltValueField(wireName: 'next_send_date')
  String get nextSendDate;

  @nullable
  @BuiltValueField(wireName: 'remaining_cycles')
  int get remainingCycles;

  @nullable
  @BuiltValueField(wireName: 'due_date_days')
  String get dueDateDays;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'recurring_id')
  String get recurringId;

  @BuiltValueField(wireName: 'auto_bill_enabled')
  bool get autoBillEnabled;

  @nullable
  String get filename;

  @nullable
  @BuiltValueField(wireName: 'recurring_dates')
  BuiltList<InvoiceScheduleEntity> get recurringDates;

  @override
  @BuiltValueField(wireName: 'line_items')
  BuiltList<InvoiceItemEntity> get lineItems;

  BuiltList<InvitationEntity> get invitations;

  BuiltList<DocumentEntity> get documents;

  @BuiltValueField(compare: false)
  BuiltList<ActivityEntity> get activities;

  bool get isApproved =>
      isQuote &&
      [kQuoteStatusApproved, kQuoteStatusConverted].contains(statusId);

  bool get hasClient => '${clientId ?? ''}'.isNotEmpty;

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

  @nullable
  @BuiltValueField(compare: false)
  int get loadedAt;

  List<InvoiceHistoryEntity> get history => activities
      .where((activity) =>
          activity.history != null && (activity.history.id ?? '').isNotEmpty)
      .map((activity) => activity.history)
      .toList();

  bool get isLoaded => loadedAt != null && loadedAt > 0;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - loadedAt >
        kMillisecondsToRefreshActivities;
  }

  bool get hasTasks => lineItems.any((item) => item.isTask);

  bool get hasProducts => lineItems.any((item) => !item.isTask);

  bool get hasExpenses => lineItems.any((item) => item.isExpense);

  @override
  bool get isEditable {
    if (isDeleted) {
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
          partialDueDate == null || partialDueDate.isEmpty
              ? this.dueDate
              : partialDueDate);

      if (dueDate != null) {
        ageInDays = now.difference(dueDate).inDays;
      }
    }

    return ageInDays;
  }

  //String get last_login;
  //String get custom_messages;

  int compareTo({
    InvoiceEntity invoice,
    String sortField,
    bool sortAscending,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltMap<String, UserEntity> userMap,
    String recurringPrefix = '',
  }) {
    int response = 0;
    final InvoiceEntity invoiceA = sortAscending ? this : invoice;
    final InvoiceEntity invoiceB = sortAscending ? invoice : this;
    switch (sortField) {
      case InvoiceFields.number:
        var invoiceANumber =
            (invoiceA.number ?? '').isEmpty ? 'ZZZZZZZZZZ' : invoiceA.number;
        var invoiceBNumber =
            (invoiceB.number ?? '').isEmpty ? 'ZZZZZZZZZZ' : invoiceB.number;
        invoiceANumber = recurringPrefix.isNotEmpty &&
                //(invoiceA.recurringId ?? '').isNotEmpty &&
                invoiceANumber.startsWith(recurringPrefix)
            ? invoiceANumber.replaceFirst(recurringPrefix, '')
            : invoiceANumber;
        invoiceBNumber = recurringPrefix.isNotEmpty &&
                //(invoiceB.recurringId ?? '').isNotEmpty &&
                invoiceBNumber.startsWith(recurringPrefix)
            ? invoiceBNumber.replaceFirst(recurringPrefix, '')
            : invoiceBNumber;
        response = compareNatural(
            invoiceANumber.toLowerCase(), invoiceBNumber.toLowerCase());
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
        response = invoiceA.reminder1Sent.compareTo(invoiceB.reminder1Sent);
        break;
      case InvoiceFields.reminder2Sent:
        response = invoiceA.reminder2Sent.compareTo(invoiceB.reminder2Sent);
        break;
      case InvoiceFields.reminder3Sent:
        response = invoiceA.reminder3Sent.compareTo(invoiceB.reminder3Sent);
        break;
      case InvoiceFields.reminderLastSent:
        response =
            invoiceA.reminderLastSent.compareTo(invoiceB.reminderLastSent);
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
        final stateA =
            EntityState.valueOf(invoiceA.entityState) ?? EntityState.active;
        final stateB =
            EntityState.valueOf(invoiceB.entityState) ?? EntityState.active;
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case InvoiceFields.dueDate:
      case QuoteFields.validUntil:
        response = invoiceA.dueDate.compareTo(invoiceB.dueDate);
        break;
      case InvoiceFields.nextSendDate:
        response = invoiceA.nextSendDate.compareTo(invoiceB.nextSendDate);
        break;
      case EntityFields.assignedTo:
        final userA = userMap[invoiceA.assignedUserId] ?? UserEntity();
        final userB = userMap[invoiceB.assignedUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdBy:
        final userA = userMap[invoiceA.createdUserId] ?? UserEntity();
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
        final clientA = clientMap[invoiceA.clientId] ?? ClientEntity();
        final clientB = clientMap[invoiceB.clientId] ?? ClientEntity();
        response = removeDiacritics(clientA.listDisplayName)
            .toLowerCase()
            .compareTo(removeDiacritics(clientB.listDisplayName).toLowerCase());
        break;
      case InvoiceFields.isViewed:
        response = invoiceB.isViewed ? 1 : -1;
        break;
      case RecurringInvoiceFields.remainingCycles:
        response = invoiceA.remainingCycles.compareTo(invoiceB.remainingCycles);
        break;
      case RecurringInvoiceFields.frequency:
        response = invoiceA.frequencyId.compareTo(invoiceB.frequencyId);
        break;
      case RecurringInvoiceFields.autoBill:
        response = invoiceA.autoBill.compareTo(invoiceB.autoBill);
        break;
      default:
        print('## ERROR: sort by invoice.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      response = invoice.number.toLowerCase().compareTo(number.toLowerCase());
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
      } else if (status.id == kInvoiceStatusUnpaid && isUnpaid && isSent) {
        return true;
      }
    }

    return false;
  }

  @override
  bool matchesFilter(String filter) {
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
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        poNumber,
        publicNotes,
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
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (userCompany.canEditEntity(this)) {
        if (includeEdit && !multiselect) {
          actions.add(EntityAction.edit);
        }

        if (isRecurringInvoice) {
          if ([kRecurringInvoiceStatusDraft, kRecurringInvoiceStatusPaused]
              .contains(statusId)) {
            actions.add(EntityAction.start);
          } else if ([
            kRecurringInvoiceStatusPending,
            kRecurringInvoiceStatusActive
          ].contains(statusId)) {
            actions.add(EntityAction.stop);
          }
        }
      }

      if (invitations.isNotEmpty) {
        if (multiselect) {
          actions.add(EntityAction.bulkDownload);
        } else {
          actions.add(EntityAction.viewPdf);
          if (!isRecurring) {
            actions.add(EntityAction.download);
            //actions.add(EntityAction.printPdf);
          }
        }
      }

      if (userCompany.canEditEntity(this) && !isCancelledOrReversed) {
        if (multiselect) {
          if (entityType == EntityType.quote) {
            actions.add(EntityAction.bulkEmailQuote);
          } else if (entityType == EntityType.credit) {
            actions.add(EntityAction.bulkEmailCredit);
          } else if (entityType == EntityType.invoice) {
            actions.add(EntityAction.bulkEmailInvoice);
          }
        } else {
          if (entityType == EntityType.quote) {
            actions.add(EntityAction.emailQuote);
          } else if (entityType == EntityType.credit) {
            actions.add(EntityAction.emailCredit);
          } else if (entityType == EntityType.invoice) {
            actions.add(EntityAction.emailInvoice);
          }
        }

        if (!isSent && !isRecurring) {
          actions.add(EntityAction.markSent);
        }

        if (userCompany.canCreate(EntityType.payment)) {
          if (isPayable && isInvoice) {
            actions.addAll([EntityAction.markPaid, EntityAction.newPayment]);
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
            actions.add(EntityAction.convertToInvoice);
          } else {
            actions.add(EntityAction.viewInvoice);
          }
        }
      }

      if (invitations.isNotEmpty && !multiselect) {
        actions.add(EntityAction.clientPortal);
      }
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    if (!multiselect) {
      int countOtherTypes = 0;
      if (userCompany.canCreate(EntityType.invoice)) {
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

    if (userCompany.canEditEntity(this) &&
        !isDeleted &&
        !isCancelledOrReversed) {
      if (!isQuote && !isCredit && !isRecurringInvoice && isSent) {
        if (!isPaid) {
          actions.add(EntityAction.cancel);
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
    return number ?? id;
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

  bool isBetween(String startDate, String endDate) {
    return startDate.compareTo(date) <= 0 && endDate.compareTo(date) >= 0;
  }

  bool get isInvoice => entityType == EntityType.invoice;

  bool get isQuote => entityType == EntityType.quote;

  bool get isCredit => entityType == EntityType.credit;

  bool get isRecurringInvoice => entityType == EntityType.recurringInvoice;

  bool get isRecurring => [EntityType.recurringInvoice].contains(entityType);

  bool get hasExchangeRate => exchangeRate != 1 && exchangeRate != 0;

  EmailTemplate get emailTemplate => isQuote
      ? EmailTemplate.quote
      : isCredit
          ? EmailTemplate.credit
          : EmailTemplate.invoice;

  double get requestedAmount => partial > 0 ? partial : amount;

  bool get isRunning =>
      isRecurring && statusId == kRecurringInvoiceStatusActive;

  bool get isDraft => statusId == kInvoiceStatusDraft;

  bool get isSent => statusId != kInvoiceStatusDraft;

  bool get isUnpaid {
    if (isQuote) {
      return !isApproved;
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

  bool get isCancelled => isInvoice && statusId == kInvoiceStatusCancelled;

  bool get isCancelledOrReversed => isInvoice && (isCancelled || isReversed);

  bool get isUpcoming => isActive && !isPaid && !isPastDue && isSent;

  bool get isPending =>
      isRecurring &&
      statusId == kRecurringInvoiceStatusActive &&
      (lastSentDate ?? '').isEmpty;

  String get calculateRemainingCycles =>
      remainingCycles == -1 ? 'endless' : remainingCycles;

  String get calculatedStatusId {
    if (isRecurring) {
      if (isPending) {
        return kRecurringInvoiceStatusPending;
      }
    } else {
      if (isPastDue && !isCancelledOrReversed) {
        return kInvoiceStatusPastDue;
      }
      if (isViewed &&
          isUnpaid &&
          !isPartial &&
          !isCancelledOrReversed &&
          !isApproved) {
        return isInvoice ? kInvoiceStatusViewed : kQuoteStatusViewed;
      }
    }

    return statusId;
  }

  bool get isPastDue {
    if (dueDate.isEmpty || balance == 0) {
      return false;
    }

    return !isDeleted &&
        !isRecurring &&
        isSent &&
        isUnpaid &&
        DateTime.tryParse(dueDate)
            .isBefore(DateTime.now().subtract(Duration(days: 1)));
  }

  InvitationEntity getInvitationForContact(ContactEntity contact) {
    return invitations.firstWhere(
        (invitation) => invitation.contactId == contact.id,
        orElse: () => null);
  }

  /// Gets taxes in the form { taxName1: { amount: 0, paid: 0} , ... }
  Map<String, Map<String, dynamic>> getTaxes(int precision) {
    final taxes = <String, Map<String, dynamic>>{};
    final taxable = getTaxable();

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
        final itemPaidAmount = amount != null &&
                itemTaxAmount != null &&
                amount * itemTaxAmount != 0
            ? (paidToDate / amount * itemTaxAmount)
            : 0.0;

        _calculateTax(
            taxes, item.taxName1, item.taxRate1, itemTaxAmount, itemPaidAmount);
      }

      if (item.taxName2.isNotEmpty) {
        final itemTaxAmount = calculateAmount(itemTaxable, item.taxRate2);
        final itemPaidAmount = amount != null &&
                itemTaxAmount != null &&
                amount * itemTaxAmount != 0
            ? (paidToDate / amount * itemTaxAmount)
            : 0.0;
        _calculateTax(
            taxes, item.taxName2, item.taxRate2, itemTaxAmount, itemPaidAmount);
      }

      if (item.taxName3.isNotEmpty) {
        final itemTaxAmount = calculateAmount(itemTaxable, item.taxRate3);
        final itemPaidAmount = amount != null &&
                itemTaxAmount != null &&
                amount * itemTaxAmount != 0
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

  void _calculateTax(Map<String, Map<String, dynamic>> map, String name,
      double rate, double amount, double paid) {
    if (amount == null) {
      return;
    }

    final key = rate.toString() + ' ' + name;

    map.putIfAbsent(
        key,
        () => <String, dynamic>{
              'name': name,
              'rate': rate,
              'amount': 0.0,
              'paid': 0.0
            });

    map[key]['amount'] += amount;
    map[key]['paid'] += paid;
  }

  String get invitationLink =>
      invitations.isEmpty ? '' : invitations.first.link;

  String get invitationBorderlessLink =>
      invitations.isEmpty ? '' : invitations.first.borderlessLink;

  String get invitationSilentLink =>
      invitations.isEmpty ? '' : invitations.first.silentLink;

  String get invitationDownloadLink =>
      invitations.isEmpty ? '' : invitations.first.downloadLink;

  // ignore: unused_element
  static void _initializeBuilder(InvoiceEntityBuilder builder) => builder
    ..activities.replace(BuiltList<ActivityEntity>())
    ..paidToDate = 0
    ..projectId = ''
    ..vendorId = ''
    ..autoBillEnabled = false
    ..subscriptionId = '';

  static Serializer<InvoiceEntity> get serializer => _$invoiceEntitySerializer;
}

class ProductItemFields {
  static const String item = 'item';
  static const String description = 'description';
  static const String unitCost = 'unit_cost';
  static const String productCost = 'product_cost';
  static const String tax = 'tax';
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
  factory InvoiceItemEntity({String productKey, double quantity}) {
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
      typeId: TYPE_STANDARD,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      discount: 0,
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

  @nullable
  @BuiltValueField(wireName: 'type_id')
  String get typeId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  double get discount;

  @nullable
  @BuiltValueField(wireName: 'task_id')
  String get taskId;

  @nullable
  @BuiltValueField(wireName: 'expense_id')
  String get expenseId;

  @nullable
  int get createdAt;

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
        calculateTaxAmount(taxRate3);
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

  InvoiceItemEntity applyTax(TaxRateEntity taxRate,
      {bool isSecond = false, bool isThird = false}) {
    InvoiceItemEntity item;

    if (isThird) {
      item = rebuild((b) => b
        ..taxRate3 = taxRate.rate
        ..taxName3 = taxRate.name);
    } else if (isSecond) {
      item = rebuild((b) => b
        ..taxRate2 = taxRate.rate
        ..taxName2 = taxRate.name);
    } else {
      item = rebuild((b) => b
        ..taxRate1 = taxRate.rate
        ..taxName1 = taxRate.name);
    }

    return item;
  }

  // ignore: unused_element
  static void _initializeBuilder(InvoiceItemEntityBuilder builder) =>
      builder..productCost = 0;

  static Serializer<InvoiceItemEntity> get serializer =>
      _$invoiceItemEntitySerializer;
}

abstract class InvitationEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<InvitationEntity, InvitationEntityBuilder> {
  factory InvitationEntity({String contactId}) {
    return _$InvitationEntity._(
      id: BaseEntity.nextId,
      isChanged: false,
      contactId: contactId ?? '',
      createdAt: 0,
      key: '',
      link: '',
      sentDate: '',
      viewedDate: '',
      openedDate: '',
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
  String get contactId;

  @BuiltValueField(wireName: 'sent_date', compare: false)
  String get sentDate;

  @BuiltValueField(wireName: 'viewed_date', compare: false)
  String get viewedDate;

  @BuiltValueField(wireName: 'opened_date', compare: false)
  String get openedDate;

  @nullable
  @BuiltValueField(wireName: 'email_status', compare: false)
  String get emailStatus;

  String get downloadLink =>
      '$link/download?t=${DateTime.now().millisecondsSinceEpoch}';

  String get silentLink => '$link?silent=true';

  String get borderlessLink => '$silentLink&borderless=true';

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
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
  String get listDisplayName {
    return '';
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

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
  factory InvoiceHistoryEntity({String contactId}) {
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
