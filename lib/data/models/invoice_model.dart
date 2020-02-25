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

part 'invoice_model.g.dart';

abstract class InvoiceListResponse
    implements Built<InvoiceListResponse, InvoiceListResponseBuilder> {
  factory InvoiceListResponse([void updates(InvoiceListResponseBuilder b)]) =
      _$InvoiceListResponse;

  InvoiceListResponse._();

  BuiltList<InvoiceEntity> get data;

  static Serializer<InvoiceListResponse> get serializer =>
      _$invoiceListResponseSerializer;
}

abstract class InvoiceItemResponse
    implements Built<InvoiceItemResponse, InvoiceItemResponseBuilder> {
  factory InvoiceItemResponse([void updates(InvoiceItemResponseBuilder b)]) =
      _$InvoiceItemResponse;

  InvoiceItemResponse._();

  InvoiceEntity get data;

  static Serializer<InvoiceItemResponse> get serializer =>
      _$invoiceItemResponseSerializer;
}

class InvoiceFields {
  static const String amount = 'amount';
  static const String balance = 'balance';
  static const String clientId = 'clientId';
  static const String client = 'client';
  static const String invoiceStatusId = 'invoiceStatusId';
  static const String invoiceNumber = 'invoiceNumber';
  static const String discount = 'discount';
  static const String poNumber = 'poNumber';
  static const String invoiceDate = 'invoiceDate';
  static const String dueDate = 'dueDate';
  static const String terms = 'terms';
  static const String footer = 'invoiceFooter';
  static const String partial = 'partial';
  static const String partialDueDate = 'partialDueDate';
  static const String publicNotes = 'publicNotes';
  static const String privateNotes = 'privateNotes';
  static const String invoiceTypeId = 'invoiceTypeId';
  static const String isRecurring = 'isRecurring';
  static const String frequencyId = 'frequencyId';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';

  static const String customValue1 = 'customValue1';
  static const String customValue2 = 'customValue2';
  static const String customValue3 = 'customValue3';
  static const String customValue4 = 'customValue4';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class InvoiceEntity extends Object
    with BaseEntity, SelectableEntity, CalculateInvoiceTotal, BelongsToClient
    implements Built<InvoiceEntity, InvoiceEntityBuilder> {
  factory InvoiceEntity(
      {String id, bool isQuote = false, AppState state, ClientEntity client}) {
    final company = state?.company;
    return _$InvoiceEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      amount: 0.0,
      balance: 0.0,
      clientId: client?.id ?? '',
      statusId: '',
      number: '',
      discount: 0.0,
      poNumber: '',
      date: convertDateTimeToSqlDate(),
      dueDate: '',
      publicNotes: '',
      privateNotes: '',
      terms: '',
      footer: '',
      designId: '1',
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
      quoteInvoiceId: '',
      customSurcharge1: 0,
      customSurcharge2: 0,
      customSurcharge3: 0,
      customSurcharge4: 0,
      filename: '',
      lineItems: BuiltList<InvoiceItemEntity>(),
      usesInclusiveTaxes: company?.settings?.enableInclusiveTaxes ?? false,
      invitations: client == null
          ? BuiltList<InvitationEntity>()
          : BuiltList(client.contacts
              .where((contact) => contact.sendEmail)
              .map((contact) => InvitationEntity(contactId: contact.id))
              .toList()),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  InvoiceEntity._();

  InvoiceEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false
    ..statusId = kInvoiceStatusDraft
    ..quoteInvoiceId = null
    ..number = ''
    ..date = convertDateTimeToSqlDate()
    ..dueDate = ''
    ..invitations.replace(
        invitations.map((i) => i.rebuild((b) => b..link = '')).toList()));

  @override
  EntityType get entityType {
    return EntityType.invoice;
  }

  double get amount;

  double get balance;

  @override
  @nullable
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'status_id')
  String get statusId;

  @nullable
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

  @nullable
  @BuiltValueField(wireName: 'design_id')
  String get designId;

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

  @nullable
  @override
  @BuiltValueField(wireName: 'custom_taxes1')
  bool get customTaxes1;

  @nullable
  @override
  @BuiltValueField(wireName: 'custom_taxes2')
  bool get customTaxes2;

  @nullable
  @override
  @BuiltValueField(wireName: 'custom_taxes3')
  bool get customTaxes3;

  @nullable
  @override
  @BuiltValueField(wireName: 'custom_taxes4')
  bool get customTaxes4;

  @BuiltValueField(wireName: 'has_expenses')
  bool get hasExpenses;

  @nullable
  @BuiltValueField(wireName: 'quote_invoice_id')
  String get quoteInvoiceId;

  @nullable
  String get filename;

  @override
  @BuiltValueField(wireName: 'line_items')
  BuiltList<InvoiceItemEntity> get lineItems;

  BuiltList<InvitationEntity> get invitations;

  bool get isApproved =>
      statusId == kQuoteStatusApproved || (quoteInvoiceId ?? '').isNotEmpty;

  bool get hasClient => '${clientId ?? ''}'.isNotEmpty;

  //String get last_login;
  //String get custom_messages;

  int compareTo(InvoiceEntity invoice, String sortField, bool sortAscending) {
    int response = 0;
    final InvoiceEntity invoiceA = sortAscending ? this : invoice;
    final InvoiceEntity invoiceB = sortAscending ? invoice : this;

    switch (sortField) {
      case InvoiceFields.amount:
        response = invoiceA.amount.compareTo(invoiceB.amount);
        break;
      case InvoiceFields.updatedAt:
        response = invoiceA.updatedAt.compareTo(invoiceB.updatedAt);
        break;
      case InvoiceFields.invoiceDate:
      case QuoteFields.quoteDate:
        response = invoiceA.date.compareTo(invoiceB.date);
        break;
      case InvoiceFields.balance:
        response = invoiceA.balance.compareTo(invoiceB.balance);
        break;
      case InvoiceFields.dueDate:
      case QuoteFields.validUntil:
        response = invoiceA.dueDate.compareTo(invoiceB.dueDate);
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
    }

    if (response == 0) {
      return (invoiceA.number ?? '').compareTo(invoiceB.number ?? '');
    } else {
      return response;
    }
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

        if (client != null && client.hasEmailAddress) {
          actions.add(EntityAction.sendEmail);
        }

        if (userCompany.canCreate(EntityType.payment) && isUnpaid) {
          actions.add(EntityAction.newPayment);
        }

        if (!isSent) {
          actions.add(EntityAction.markSent);
        }

        if (!isPaid) {
          actions.add(EntityAction.markPaid);
        }
      }

      if (invitations.isNotEmpty && !multiselect) {
        if (includeEdit) {
          actions.add(EntityAction.pdf);
        }
        actions.add(EntityAction.clientPortal);
      }
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    if (userCompany.canCreate(EntityType.invoice) && !multiselect) {
      actions.add(EntityAction.cloneToInvoice);
      actions.add(EntityAction.cloneToQuote);
      actions.add(null);
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

  bool get isQuote => entityType == EntityType.quote;

  bool get isCredit => entityType == EntityType.credit;

  EmailTemplate get emailTemplate => isQuote
      ? EmailTemplate.quoteEmail
      : isCredit ? EmailTemplate.creditEmail : EmailTemplate.invoiceEmail;

  double get requestedAmount => partial > 0 ? partial : amount;

  bool get isSent => statusId != kInvoiceStatusDraft;

  bool get isUnpaid => statusId != kInvoiceStatusPaid;

  bool get isPaid => statusId == kInvoiceStatusPaid;

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
      lineItemTypeId: '',
      customValue1: '',
      customValue2: '',
      discount: 0.0,
      createdAt: DateTime.now().microsecondsSinceEpoch,
    );
  }

  InvoiceItemEntity._();

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

  @BuiltValueField(wireName: 'line_item_type_id')
  String get lineItemTypeId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @nullable
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

  String get key;

  String get link;

  @BuiltValueField(wireName: 'client_contact_id')
  String get contactId;

  @BuiltValueField(wireName: 'sent_date')
  String get sentDate;

  @BuiltValueField(wireName: 'viewed_date')
  String get viewedDate;

  String get silentLink => link + '?silent=true';

  String get borderlessLink => silentLink + '&borderless=true';

  String get downloadLink => link.replaceFirst('/view/', '/download/');

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
