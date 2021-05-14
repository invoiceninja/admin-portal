import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/mixins/invoice_mixin.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
  static const String statusId = 'status_id';
  static const String status = 'status';
  static const String number = 'number';
  static const String discount = 'discount';
  static const String poNumber = 'po_number';
  static const String date = 'date';
  static const String dueDate = 'due_date';
  static const String terms = 'terms';
  static const String footer = 'footer';
  static const String partial = 'partial_due';
  static const String partialDueDate = 'partial_due_date';
  static const String publicNotes = 'public_notes';
  static const String privateNotes = 'private_notes';
  static const String isRecurring = 'is_recurring';
  static const String frequencyId = 'frequency_id';
  static const String endDate = 'end_date';
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
      statusId: '',
      number: '',
      discount: 0,
      taxAmount: 0,
      poNumber: '',
      date: convertDateTimeToSqlDate(),
      dueDate: '',
      publicNotes: '',
      privateNotes: '',
      terms: '',
      footer: '',
      designId: '',
      taxName1: (company?.numberOfInvoiceTaxRates ?? 0) >= 1
          ? company?.settings?.defaultTaxName1 ?? ''
          : '',
      taxRate1: (company?.numberOfInvoiceTaxRates ?? 0) >= 1
          ? company?.settings?.defaultTaxRate1 ?? 0.0
          : 0,
      taxName2: (company?.numberOfInvoiceTaxRates ?? 0) >= 1
          ? company?.settings?.defaultTaxName2 ?? ''
          : '',
      taxRate2: (company?.numberOfInvoiceTaxRates ?? 0) >= 1
          ? company?.settings?.defaultTaxRate2 ?? 0.0
          : 0,
      taxName3: (company?.numberOfInvoiceTaxRates ?? 0) >= 1
          ? company?.settings?.defaultTaxName3 ?? ''
          : '',
      taxRate3: (company?.numberOfInvoiceTaxRates ?? 0) >= 1
          ? company?.settings?.defaultTaxRate3 ?? 0.0
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
      history: BuiltList<InvoiceHistoryEntity>(),
      usesInclusiveTaxes: company?.settings?.enableInclusiveTaxes ?? false,
      documents: BuiltList<DocumentEntity>(),
      activities: BuiltList<ActivityEntity>(),
      invitations: client == null
          ? BuiltList<InvitationEntity>()
          : BuiltList(client.contacts
              .where((contact) => contact.sendEmail)
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

  double get amount;

  double get balance;

  @BuiltValueField(wireName: 'paid_to_date')
  double get paidToDate;

  double get balanceOrAmount => isSent ? balance : amount;

  @override
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

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

  /*
  @BuiltValueField(wireName: 'end_date')
  String get endDate;

  @BuiltValueField(wireName: 'recurring_invoice_id')
  String get recurringInvoiceId;
  */

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

  @nullable
  @BuiltValueField(wireName: 'auto_bill_enabled')
  bool get autoBillEnabled;

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

  BuiltList<ActivityEntity> get activities;

  @nullable
  BuiltList<InvoiceHistoryEntity> get history;

  bool get isApproved => statusId == kQuoteStatusApproved;

  bool get hasClient => '${clientId ?? ''}'.isNotEmpty;

  bool get hasInvoice => '${invoiceId ?? ''}'.isNotEmpty;

  double get netAmount => amount - taxAmount;

  double get netBalance => balance - (taxAmount * balance / amount);

  double get netBalanceOrAmount =>
      balanceOrAmount - (taxAmount * balanceOrAmount / amount);

  @nullable
  int get loadedAt;

  bool get isLoaded => loadedAt != null && loadedAt > 0;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - loadedAt >
        kMillisecondsToRefreshActivities;
  }

  bool get hasTasks => lineItems.any((item) => item.isTask);

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
        var invoiceANumber = invoiceA.number ?? '';
        var invoiceBNumber = invoiceB.number ?? '';
        invoiceANumber = recurringPrefix.isNotEmpty &&
                (invoiceA.recurringId ?? '').isNotEmpty &&
                invoiceANumber.startsWith(recurringPrefix)
            ? invoiceANumber.replaceFirst(recurringPrefix, '')
            : invoiceANumber;
        invoiceBNumber = recurringPrefix.isNotEmpty &&
                (invoiceB.recurringId ?? '').isNotEmpty &&
                invoiceBNumber.startsWith(recurringPrefix)
            ? invoiceBNumber.replaceFirst(recurringPrefix, '')
            : invoiceBNumber;
        response = invoiceANumber
            .toLowerCase()
            .compareTo(invoiceBNumber.toLowerCase());
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
      case InvoiceFields.balance:
        response = invoiceA.balance.compareTo(invoiceB.balance);
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
        response = invoiceA.statusId.compareTo(invoiceB.statusId);
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
        response = clientA.listDisplayName
            .toLowerCase()
            .compareTo(clientB.listDisplayName.toLowerCase());
        break;
      case InvoiceFields.isViewed:
        response = invoiceB.isViewed ? 1 : -1;
        break;
      default:
        print('## ERROR: sort by invoice.$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesStatuses(BuiltList<EntityStatus> statuses) {
    if (statuses.isEmpty) {
      return true;
    }

    for (final status in statuses) {
      if (status.id == statusId) {
        return true;
      }

      if (status.id == kInvoiceStatusPastDue && isPastDue) {
        return true;
      } else if (status.id == kInvoiceStatusUnpaid && isUnpaid && isSent) {
        return true;
      } else if (status.id == kInvoiceStatusViewed && isViewed) {
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

      if (invitations.isNotEmpty && !multiselect) {
        actions.add(EntityAction.viewPdf);
      }

      if (userCompany.canEditEntity(this)) {
        if (entityType == EntityType.quote) {
          actions.add(EntityAction.emailQuote);
        } else if (entityType == EntityType.credit) {
          actions.add(EntityAction.emailCredit);
        } else if (entityType == EntityType.invoice) {
          actions.add(EntityAction.emailInvoice);
        }

        if (isPayable && userCompany.canCreate(EntityType.payment)) {
          actions.add(EntityAction.newPayment);
        }

        if (!isSent && !isRecurring) {
          actions.add(EntityAction.markSent);
        }

        if (isPayable && isInvoice) {
          actions.add(EntityAction.markPaid);
        }

        if (isQuote && !isApproved && (invoiceId ?? '').isEmpty) {
          actions.add(EntityAction.convertToInvoice);
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

    if (userCompany.canEditEntity(this) && !isDeleted) {
      if (!isQuote && !isCredit && !isRecurringInvoice && isSent) {
        if (!isCancelledOrReversed && !isPaid) {
          actions.add(EntityAction.cancel);
        }

        if (userCompany.canCreate(EntityType.credit) && !isReversed) {
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

  bool get isSent => statusId != kInvoiceStatusDraft;

  bool get isUnpaid => statusId != kInvoiceStatusPaid;

  bool get isPayable =>
      !isPaid && !isQuote && !isRecurringInvoice && !isCancelledOrReversed;

  bool get isViewed =>
      invitations.any((invitation) => invitation.viewedDate.isNotEmpty);

  bool get isPaid => statusId == kInvoiceStatusPaid;

  bool get isReversed => statusId == kInvoiceStatusReversed;

  bool get isCancelled => statusId == kInvoiceStatusCancelled;

  bool get isCancelledOrReversed => isCancelled || isReversed;

  bool get isUpcoming => isActive && !isPaid && !isPastDue && isSent;

  String get calculateRemainingCycles =>
      remainingCycles == -1 ? 'endless' : remainingCycles;

  String get calculatedStatusId {
    if (isPastDue && !isCancelledOrReversed) {
      return kInvoiceStatusPastDue;
    }

    if (isRecurring &&
        statusId == kRecurringInvoiceStatusActive &&
        (lastSentDate ?? '').isEmpty) {
      return kRecurringInvoiceStatusPending;
    }

    /*
    if (subEntityType == EntityType.quote && (invoiceId ?? '').isNotEmpty) {
      return kQuoteStatusApproved;
    }
     */

    return statusId;
  }

  bool get isPastDue {
    if (dueDate.isEmpty) {
      return false;
    }

    return !isDeleted &&
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
    final taxable = calculateTaxes(
        useInclusiveTaxes: usesInclusiveTaxes, precision: precision);

    if (taxRate1 != 0) {
      final invoiceTaxAmount = taxable[taxName1];
      final invoicePaidAmount = (amount * invoiceTaxAmount != 0)
          ? (paidToDate / amount * invoiceTaxAmount)
          : 0.0;
      _calculateTax(
          taxes, taxName1, taxRate1, invoiceTaxAmount, invoicePaidAmount);
    }

    if (taxRate2 != 0) {
      final invoiceTaxAmount = taxable[taxName2];
      final invoicePaidAmount = (amount * invoiceTaxAmount != 0)
          ? (paidToDate / amount * invoiceTaxAmount)
          : 0.0;
      _calculateTax(
          taxes, taxName2, taxRate2, invoiceTaxAmount, invoicePaidAmount);
    }

    if (taxRate3 != 0) {
      final invoiceTaxAmount = taxable[taxName3];
      final invoicePaidAmount = (amount * invoiceTaxAmount != 0)
          ? (paidToDate / amount * invoiceTaxAmount)
          : 0.0;
      _calculateTax(
          taxes, taxName3, taxRate3, invoiceTaxAmount, invoicePaidAmount);
    }

    for (final item in lineItems) {
      if (item.taxRate1 != 0) {
        final itemTaxAmount = taxable[item.taxName1];
        final itemPaidAmount = amount != null &&
                itemTaxAmount != null &&
                amount * itemTaxAmount != 0
            ? (paidToDate / amount * itemTaxAmount)
            : 0.0;
        _calculateTax(
            taxes, item.taxName1, item.taxRate1, itemTaxAmount, itemPaidAmount);
      }

      if (item.taxRate2 != 0) {
        final itemTaxAmount = taxable[item.taxName2];
        final itemPaidAmount = amount != null &&
                itemTaxAmount != null &&
                amount * itemTaxAmount != 0
            ? (paidToDate / amount * itemTaxAmount)
            : 0.0;
        _calculateTax(
            taxes, item.taxName2, item.taxRate2, itemTaxAmount, itemPaidAmount);
      }

      if (item.taxRate3 != 0) {
        final itemTaxAmount = taxable[item.taxName3];
        final itemPaidAmount = amount != null &&
                itemTaxAmount != null &&
                amount * itemTaxAmount != 0
            ? (paidToDate / amount * itemTaxAmount)
            : 0.0;
        _calculateTax(
            taxes, item.taxName3, item.taxRate3, itemTaxAmount, itemPaidAmount);
      }
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
    ..subscriptionId = '';

  static Serializer<InvoiceEntity> get serializer => _$invoiceEntitySerializer;
}

class ProductItemFields {
  static const String item = 'item';
  static const String description = 'description';
  static const String unitCost = 'unit_cost';
  static const String tax = 'tax';
  static const String quantity = 'quantity';
  static const String lineTotal = 'line_total';
  static const String discount = 'discount';
  static const String custom1 = 'product1';
  static const String custom2 = 'product2';
  static const String custom3 = 'product3';
  static const String custom4 = 'product4';
}

class TaskItemFields {
  static const String service = 'service';
  static const String description = 'description';
  static const String rate = 'rate';
  static const String tax = 'tax';
  static const String hours = 'hours';
  static const String lineTotal = 'line_total';
  static const String discount = 'discount';
  static const String custom1 = 'task1';
  static const String custom2 = 'task2';
  static const String custom3 = 'task3';
  static const String custom4 = 'task4';
}

abstract class InvoiceItemEntity
    implements Built<InvoiceItemEntity, InvoiceItemEntityBuilder> {
  factory InvoiceItemEntity({String productKey, double quantity}) {
    return _$InvoiceItemEntity._(
      productKey: productKey ?? '',
      notes: '',
      cost: 0.0,
      quantity: quantity ?? 0.0,
      taxName1: '',
      taxRate1: 0.0,
      taxName2: '',
      taxRate2: 0.0,
      taxName3: '',
      taxRate3: 0.0,
      typeId: '',
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      discount: 0.0,
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

  /*
  double taxAmount(bool useInclusiveTaxes, int precision) {
    double calculateTaxAmount(double rate) {
      double taxAmount;
      if (rate == 0) {
        return 0;
      }
      if (useInclusiveTaxes) {
        taxAmount = total - (total / (1 + (rate / 100)));
      } else {
        taxAmount = total * rate / 100;
      }
      return round(taxAmount, precision);
    }

    return calculateTaxAmount(taxRate1) + calculateTaxAmount(taxRate2) +
        calculateTaxAmount(taxRate3);
  }

  double netTotal(bool useInclusiveTaxes, int precision) =>
      total - taxAmount(useInclusiveTaxes, precision);
  */

  double get total => round(quantity * cost, 2);

  bool get isTask => typeId == TYPE_TASK;

  bool get isExpense => typeId == TYPE_EXPENSE;

  bool get isEmpty =>
      productKey.isEmpty &&
      notes.isEmpty &&
      cost == 0 &&
      quantity == 0 &&
      customValue1.isEmpty &&
      customValue2.isEmpty;

  // TODO add custom 3 and 4

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

  @BuiltValueField(wireName: 'sent_date')
  String get sentDate;

  @BuiltValueField(wireName: 'viewed_date')
  String get viewedDate;

  @BuiltValueField(wireName: 'opened_date')
  String get openedDate;

  @nullable
  @BuiltValueField(wireName: 'email_status')
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
      htmlBackup: '',
      createdAt: 0,
      activityId: '',
      activity: ActivityEntity(),
      amount: 0,
    );
  }

  InvoiceHistoryEntity._();

  @override
  @memoized
  int get hashCode;

  String get id;

  ActivityEntity get activity;

  @BuiltValueField(wireName: 'activity_id')
  String get activityId;

  @BuiltValueField(wireName: 'html_backup')
  String get htmlBackup;

  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  double get amount;

  static Serializer<InvoiceHistoryEntity> get serializer =>
      _$invoiceHistoryEntitySerializer;
}
