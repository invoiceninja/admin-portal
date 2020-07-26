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
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

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
  static const String amount = 'invoice_amount';
  static const String balance = 'balance_due';
  static const String clientId = 'client_id';
  static const String client = 'client';
  static const String statusId = 'status_id';
  static const String status = 'status';
  static const String invoiceNumber = 'invoice_number';
  static const String discount = 'discount';
  static const String poNumber = 'po_number';
  static const String date = 'invoice_date';
  static const String dueDate = 'due_date';
  static const String terms = 'terms';
  static const String footer = 'footer';
  static const String partial = 'partial';
  static const String partialDueDate = 'partial_due_date';
  static const String publicNotes = 'public_notes';
  static const String privateNotes = 'private_notes';
  static const String isRecurring = 'is_recurring';
  static const String frequencyId = 'frequency_id';
  static const String startDate = 'start_date';
  static const String endDate = 'end_date';
  static const String documents = 'documents';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String taxAmount = 'tax_amount';
}

abstract class InvoiceEntity extends Object
    with BaseEntity, SelectableEntity, CalculateInvoiceTotal, BelongsToClient
    implements Built<InvoiceEntity, InvoiceEntityBuilder> {
  factory InvoiceEntity({
    String id,
    AppState state,
    ClientEntity client,
    EntityType entityType,
  }) {
    final company = state?.company;
    return _$InvoiceEntity._(
      id: id ?? BaseEntity.nextId,
      entityType: entityType ?? EntityType.invoice,
      isChanged: false,
      amount: 0,
      balance: 0,
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
      taxName1: company?.settings?.defaultTaxName1 ?? '',
      taxRate1: company?.settings?.defaultTaxRate1 ?? 0.0,
      taxName2: company?.settings?.defaultTaxName2 ?? '',
      taxRate2: company?.settings?.defaultTaxRate2 ?? 0.0,
      taxName3: company?.settings?.defaultTaxName3 ?? '',
      taxRate3: company?.settings?.defaultTaxRate3 ?? 0.0,
      isAmountDiscount: false,
      partial: 0.0,
      partialDueDate: '',
      hasTasks: false,
      autoBill: false,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      customTaxes1: false,
      customTaxes2: false,
      customTaxes3: false,
      customTaxes4: false,
      hasExpenses: false,
      invoiceId: '',
      customSurcharge1: 0,
      customSurcharge2: 0,
      customSurcharge3: 0,
      customSurcharge4: 0,
      filename: '',
      lineItems: BuiltList<InvoiceItemEntity>(),
      usesInclusiveTaxes: company?.settings?.enableInclusiveTaxes ?? false,
      documents: BuiltList<DocumentEntity>(),
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
      assignedUserId: '',
      createdAt: 0,
    );
  }

  InvoiceEntity._();

  @override
  @memoized
  int get hashCode;

  InvoiceEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false
    ..statusId = kInvoiceStatusDraft
    ..invoiceId = ''
    ..number = ''
    ..date = convertDateTimeToSqlDate()
    ..dueDate = ''
    ..invitations.clear());

  double get amount;

  double get balance;

  @override
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

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
  @BuiltValueField(wireName: 'frequency_id')
  int get frequencyId;

  @BuiltValueField(wireName: 'start_date')
  String get startDate;

  @BuiltValueField(wireName: 'end_date')
  String get endDate;

  @BuiltValueField(wireName: 'last_sent_date')
  String get lastSentDate;

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

  @BuiltValueField(wireName: 'has_tasks')
  bool get hasTasks;

  @nullable
  @BuiltValueField(wireName: 'auto_bill')
  bool get autoBill;

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
  @nullable
  @BuiltValueField(wireName: 'custom_taxes1')
  bool get customTaxes1;

  @override
  @nullable
  @BuiltValueField(wireName: 'custom_taxes2')
  bool get customTaxes2;

  @override
  @nullable
  @BuiltValueField(wireName: 'custom_taxes3')
  bool get customTaxes3;

  @override
  @nullable
  @BuiltValueField(wireName: 'custom_taxes4')
  bool get customTaxes4;

  @BuiltValueField(wireName: 'has_expenses')
  bool get hasExpenses;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @nullable
  String get filename;

  @override
  @BuiltValueField(wireName: 'line_items')
  BuiltList<InvoiceItemEntity> get lineItems;

  BuiltList<InvitationEntity> get invitations;

  BuiltList<DocumentEntity> get documents;

  bool get isApproved => statusId == kQuoteStatusApproved;

  bool get hasClient => '${clientId ?? ''}'.isNotEmpty;

  bool get hasInvoice => '${invoiceId ?? ''}'.isNotEmpty;

  double get netAmount => amount - taxAmount;

  double get netBalance => balance - (taxAmount * balance / amount);

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

  int compareTo(
      {InvoiceEntity invoice,
      String sortField,
      bool sortAscending,
      BuiltMap<String, ClientEntity> clientMap,
      StaticState staticState,
      BuiltMap<String, UserEntity> userMap}) {
    int response = 0;
    final InvoiceEntity invoiceA = sortAscending ? this : invoice;
    final InvoiceEntity invoiceB = sortAscending ? invoice : this;

    switch (sortField) {
      case InvoiceFields.invoiceNumber:
      case QuoteFields.quoteNumber:
      case CreditFields.creditNumber:
        response = (invoiceA.number ?? '')
            .toLowerCase()
            .compareTo((invoiceB.number ?? '').toLowerCase());
        break;
      case InvoiceFields.amount:
      case QuoteFields.amount:
      case CreditFields.amount:
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
      case QuoteFields.date:
      case CreditFields.date:
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
      case InvoiceFields.statusId:
        response = invoiceA.statusId.compareTo(invoiceB.statusId);
        break;
      case InvoiceFields.status:
        response = (staticState.invoiceStatusMap[invoiceA.statusId]?.name ?? '')
            .toLowerCase()
            .compareTo(
                staticState.invoiceStatusMap[invoiceB.statusId]?.name ?? '');
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
      }
    }

    return false;
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (number != null && number.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue3.isNotEmpty &&
        customValue3.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue4.isNotEmpty &&
        customValue4.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();
    if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return customValue1;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return customValue2;
    } else if (customValue3.isNotEmpty &&
        customValue3.toLowerCase().contains(filter)) {
      return customValue3;
    } else if (customValue4.isNotEmpty &&
        customValue4.toLowerCase().contains(filter)) {
      return customValue4;
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

    if (!isDeleted) {
      if (userCompany.canEditEntity(this)) {
        if (includeEdit && !multiselect) {
          actions.add(EntityAction.edit);
        }
      }

      if (invitations.isNotEmpty && !multiselect) {
        actions.add(EntityAction.viewPdf);
      }

      if (userCompany.canEditEntity(this)) {
        if (!multiselect) {
          if (entityType == EntityType.quote) {
            actions.add(EntityAction.emailQuote);
          } else if (entityType == EntityType.credit) {
            actions.add(EntityAction.emailCredit);
          } else {
            actions.add(EntityAction.emailInvoice);
          }
        }

        if (!isQuote &&
            userCompany.canCreate(EntityType.payment) &&
            isUnpaid &&
            !isCancelledOrReversed) {
          actions.add(EntityAction.newPayment);
        }

        if (!isSent) {
          actions.add(EntityAction.markSent);
        }

        if (!isQuote && !isPaid && !isCancelledOrReversed) {
          actions.add(EntityAction.markPaid);
        }

        if (isQuote && !isApproved && (invoiceId ?? '').isEmpty) {
          actions.add(EntityAction.convert);
        }
      }

      if (invitations.isNotEmpty && !multiselect) {
        actions.add(EntityAction.clientPortal);
      }
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    if (userCompany.canCreate(EntityType.invoice) && !multiselect) {
      actions.add(EntityAction.cloneToInvoice);
      if (userCompany.canCreate(EntityType.quote)) {
        actions.add(EntityAction.cloneToQuote);
      }
      if (userCompany.canCreate(EntityType.credit)) {
        actions.add(EntityAction.cloneToCredit);
      }
      actions.add(null);
    }

    if (userCompany.canEditEntity(this)) {
      if (!isQuote && !isCredit && isSent) {
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
  double get listDisplayAmount => balance;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  bool isBetween(String startDate, String endDate) {
    return startDate.compareTo(date) <= 0 && endDate.compareTo(date) >= 0;
  }

  bool get isInvoice => entityType == EntityType.invoice;

  bool get isQuote => entityType == EntityType.quote;

  bool get isCredit => entityType == EntityType.credit;

  EmailTemplate get emailTemplate => isQuote
      ? EmailTemplate.quote
      : isCredit ? EmailTemplate.credit : EmailTemplate.invoice;

  double get requestedAmount => partial > 0 ? partial : amount;

  bool get isSent => statusId != kInvoiceStatusDraft;

  bool get isUnpaid => statusId != kInvoiceStatusPaid;

  bool get isPaid => statusId == kInvoiceStatusPaid;

  bool get isReversed => statusId == kInvoiceStatusReversed;

  bool get isCancelled => statusId == kInvoiceStatusCancelled;

  bool get isCancelledOrReversed => isCancelled || isReversed;

  bool get isUpcoming => isActive && !isPaid && !isPastDue && isSent;

  String get calculatedStatusId {
    if (isPastDue && !isCancelledOrReversed) {
      return kInvoiceStatusPastDue;
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
  Map<String, Map<String, dynamic>> getTaxes() {
    final taxes = <String, Map<String, dynamic>>{};
    final taxable = calculateTaxes(usesInclusiveTaxes);
    final paidAmount = amount - balance;

    if (taxRate1 != 0) {
      final invoiceTaxAmount = taxable[taxName1];
      final invoicePaidAmount = (amount * invoiceTaxAmount != 0)
          ? (paidAmount / amount * invoiceTaxAmount)
          : 0.0;
      _calculateTax(
          taxes, taxName1, taxRate1, invoiceTaxAmount, invoicePaidAmount);
    }

    if (taxRate2 != 0) {
      final invoiceTaxAmount = taxable[taxName2];
      final invoicePaidAmount = (amount * invoiceTaxAmount != 0)
          ? (paidAmount / amount * invoiceTaxAmount)
          : 0.0;
      _calculateTax(
          taxes, taxName2, taxRate2, invoiceTaxAmount, invoicePaidAmount);
    }

    if (taxRate3 != 0) {
      final invoiceTaxAmount = taxable[taxName3];
      final invoicePaidAmount = (amount * invoiceTaxAmount != 0)
          ? (paidAmount / amount * invoiceTaxAmount)
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
            ? (paidAmount / amount * itemTaxAmount)
            : 0.0;
        _calculateTax(
            taxes, item.taxName1, item.taxRate1, itemTaxAmount, itemPaidAmount);
      }

      if (item.taxRate2 != 0) {
        final itemTaxAmount = taxable[item.taxName2];
        final itemPaidAmount = amount != null &&
                itemTaxAmount != null &&
                amount * itemTaxAmount != 0
            ? (paidAmount / amount * itemTaxAmount)
            : 0.0;
        _calculateTax(
            taxes, item.taxName2, item.taxRate2, itemTaxAmount, itemPaidAmount);
      }

      if (item.taxRate3 != 0) {
        final itemTaxAmount = taxable[item.taxName3];
        final itemPaidAmount = amount != null &&
                itemTaxAmount != null &&
                amount * itemTaxAmount != 0
            ? (paidAmount / amount * itemTaxAmount)
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

  static Serializer<InvoiceEntity> get serializer => _$invoiceEntitySerializer;
}

class ProductItemFields {
  static const String productKey = 'product_key';
  static const String notes = 'notes';
  static const String cost = 'cost';
  static const String quantity = 'quantity';
  static const String lineTotal = 'line_total';
  static const String discount = 'discount';
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
  static const String custom3 = 'custom3';
  static const String custom4 = 'custom4';
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
  @BuiltValueField(wireName: 'task_public_id')
  String get taskId;

  @nullable
  @BuiltValueField(wireName: 'expense_public_id')
  String get expenseId;

  @nullable
  int get createdAt;

  double get total => round(quantity * cost, 2);

  bool get isTask => taskId != null && taskId.isNotEmpty;

  bool get isExpense => expenseId != null && expenseId.isNotEmpty;

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
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  InvitationEntity._();

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

  String get downloadLink => '$link/download';

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
