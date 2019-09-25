import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/mixins/invoice_mixin.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
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

class QuoteFields {
  static const String quoteNumber = 'quoteNumber';
  static const String quoteDate = 'quoteDate';
  static const String validUntil = 'validUntil';
  static const String quoteStatusId = 'quoteStatusId';

  static String convertField(String field) {
    if (field == InvoiceFields.invoiceStatusId) {
      return QuoteFields.quoteStatusId;
    } else if (field == InvoiceFields.invoiceNumber) {
      return QuoteFields.quoteNumber;
    } else if (field == InvoiceFields.invoiceDate) {
      return QuoteFields.quoteDate;
    } else if (field == InvoiceFields.dueDate) {
      return QuoteFields.validUntil;
    } else {
      return field;
    }
  }
}

class InvoiceFields {
  static const String amount = 'amount';
  static const String balance = 'balance';
  static const String clientId = 'clientId';
  static const String invoiceStatusId = 'invoiceStatusId';
  static const String invoiceNumber = 'invoiceNumber';
  static const String discount = 'discount';
  static const String poNumber = 'poNumber';
  static const String invoiceDate = 'invoiceDate';
  static const String dueDate = 'dueDate';
  static const String terms = 'terms';
  static const String partial = 'partial';
  static const String partialDueDate = 'partialDueDate';
  static const String publicNotes = 'publicNotes';
  static const String privateNotes = 'privateNotes';
  static const String invoiceTypeId = 'invoiceTypeId';
  static const String isRecurring = 'isRecurring';
  static const String frequencyId = 'frequencyId';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class InvoiceEntity extends Object
    with BaseEntity, SelectableEntity, CalculateInvoiceTotal
    implements Built<InvoiceEntity, InvoiceEntityBuilder> {
  factory InvoiceEntity(
      {String id, bool isQuote = false, CompanyEntity company}) {
    return _$InvoiceEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      amount: 0.0,
      balance: 0.0,
      clientId: '',
      invoiceStatusId: '',
      invoiceNumber: '',
      discount: 0.0,
      poNumber: '',
      invoiceDate: convertDateTimeToSqlDate(),
      dueDate: '',
      terms: '',
      publicNotes: '',
      privateNotes: '',
      invoiceTypeId: isQuote ? kInvoiceTypeQuote : kInvoiceTypeStandard,
      isQuote: isQuote,
      isRecurring: false,
      frequencyId: 0,
      startDate: '',
      endDate: '',
      lastSentDate: '',
      recurringInvoiceId: '',
      taxName1: company?.settings?.defaultTaxName1 ?? '',
      taxRate1: company?.settings?.defaultTaxRate1 ?? 0.0,
      taxName2: company?.settings?.defaultTaxName2 ?? '',
      taxRate2: company?.settings?.defaultTaxRate2 ?? 0.0,
      isAmountDiscount: false,
      invoiceFooter: '',
      partial: 0.0,
      partialDueDate: '',
      hasTasks: false,
      autoBill: false,
      customValue1: 0.0,
      customValue2: 0.0,
      customTaxes1: false,
      customTaxes2: false,
      hasExpenses: false,
      quoteInvoiceId: '',
      customTextValue1: '',
      customTextValue2: '',
      isPublic: false,
      filename: '',
      invoiceItems: BuiltList<InvoiceItemEntity>(),
      invitations: BuiltList<InvitationEntity>(),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      designId: company != null
          ? (isQuote
              ? company.settings.defaultQuoteDesignId
              : company.settings.defaultInvoiceDesignId)
          : '1',
    );
  }

  InvoiceEntity._();

  InvoiceEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isDeleted = false
    ..invoiceStatusId = kInvoiceStatusDraft
    ..quoteInvoiceId = null
    ..invoiceNumber = ''
    ..invoiceDate = convertDateTimeToSqlDate()
    ..dueDate = ''
    ..isPublic = false);

  InvoiceEntity get cloneToInvoice => clone.rebuild((b) => b
    ..isQuote = false
    ..invoiceTypeId = kInvoiceTypeStandard);

  InvoiceEntity get cloneToQuote => clone.rebuild((b) => b
    ..isQuote = true
    ..invoiceTypeId = kInvoiceTypeQuote);

  @override
  EntityType get entityType {
    return EntityType.invoice;
  }

  double get amount;

  double get balance;

  @BuiltValueField(wireName: 'is_quote')
  bool get isQuote;

  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'invoice_status_id')
  String get invoiceStatusId;

  @BuiltValueField(wireName: 'invoice_number')
  String get invoiceNumber;

  @override
  double get discount;

  @BuiltValueField(wireName: 'po_number')
  String get poNumber;

  @BuiltValueField(wireName: 'invoice_date')
  String get invoiceDate;

  @BuiltValueField(wireName: 'due_date')
  String get dueDate;

  String get terms;

  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'invoice_type_id')
  int get invoiceTypeId;

  @BuiltValueField(wireName: 'is_recurring')
  bool get isRecurring;

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
  @BuiltValueField(wireName: 'is_amount_discount')
  bool get isAmountDiscount;

  @BuiltValueField(wireName: 'invoice_footer')
  String get invoiceFooter;

  double get partial;

  @BuiltValueField(wireName: 'partial_due_date')
  String get partialDueDate;

  @BuiltValueField(wireName: 'has_tasks')
  bool get hasTasks;

  @BuiltValueField(wireName: 'auto_bill')
  bool get autoBill;

  @override
  @BuiltValueField(wireName: 'custom_value1')
  double get customValue1;

  @override
  @BuiltValueField(wireName: 'custom_value2')
  double get customValue2;

  @override
  @BuiltValueField(wireName: 'custom_taxes1')
  bool get customTaxes1;

  @override
  @BuiltValueField(wireName: 'custom_taxes2')
  bool get customTaxes2;

  @BuiltValueField(wireName: 'has_expenses')
  bool get hasExpenses;

  @BuiltValueField(wireName: 'quote_invoice_id')
  String get quoteInvoiceId;

  @BuiltValueField(wireName: 'custom_text_value1')
  String get customTextValue1;

  @BuiltValueField(wireName: 'custom_text_value2')
  String get customTextValue2;

  @BuiltValueField(wireName: 'is_public')
  bool get isPublic;

  String get filename;

  @override
  @BuiltValueField(wireName: 'invoice_items')
  BuiltList<InvoiceItemEntity> get invoiceItems;

  BuiltList<InvitationEntity> get invitations;

  @nullable
  @BuiltValueField(wireName: 'invoice_design_id')
  String get designId;

  bool get isApproved =>
      invoiceStatusId == kInvoiceStatusApproved ||
      (quoteInvoiceId ?? '').isNotEmpty;

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
        response = invoiceA.invoiceDate.compareTo(invoiceB.invoiceDate);
        break;
    }

    if (response == 0) {
      return invoiceA.invoiceNumber.compareTo(invoiceB.invoiceNumber);
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
      if (status.id == invoiceStatusId) {
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

    if (invoiceNumber.toLowerCase().contains(filter)) {
      return true;
    } else if (customTextValue1.isNotEmpty &&
        customTextValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customTextValue2.isNotEmpty &&
        customTextValue2.toLowerCase().contains(filter)) {
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
    if (customTextValue1.isNotEmpty &&
        customTextValue1.toLowerCase().contains(filter)) {
      return customTextValue1;
    } else if (customTextValue2.isNotEmpty &&
        customTextValue2.toLowerCase().contains(filter)) {
      return customTextValue2;
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
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany.canCreate(EntityType.invoice)) {
        if (isQuote &&
            userCompany.canEditEntity(this) &&
            quoteInvoiceId == null) {
          actions.add(EntityAction.convert);
        }
      }

      if (userCompany.canEditEntity(this) && !isPublic) {
        actions.add(EntityAction.markSent);
      }

      if (userCompany.canEditEntity(this) && client.hasEmailAddress) {
        actions.add(EntityAction.sendEmail);
      }

      if (userCompany.canEditEntity(this) &&
          userCompany.canCreate(EntityType.payment) &&
          isUnpaid &&
          !isQuote) {
        actions.add(EntityAction.enterPayment);
      }

      if (isQuote && (quoteInvoiceId ?? '').isNotEmpty) {
        actions.add(EntityAction.viewInvoice);
      }

      if (invitations.isNotEmpty) {
        actions.add(EntityAction.pdf);
        actions.add(EntityAction.clientPortal);
      }
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    if (userCompany.canCreate(EntityType.invoice)) {
      actions.add(EntityAction.cloneToInvoice);
      actions.add(EntityAction.cloneToQuote);
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  InvoiceEntity applyTax(TaxRateEntity taxRate, {bool isSecond = false}) {
    InvoiceEntity invoice;

    if (isSecond) {
      invoice = rebuild((b) => b
        ..taxRate2 = taxRate.rate
        ..taxName2 = taxRate.name);
    } else {
      invoice = rebuild((b) => b
        ..taxRate1 = taxRate.rate
        ..taxName1 = taxRate.name);
    }

    if (taxRate.isInclusive) {
      invoice = invoice.rebuild((b) => b
        ..invoiceItems.replace(invoiceItems
            .map((item) => item.rebuild(
                (b) => b.cost = round(b.cost / (100 + taxRate.rate) * 100, 2)))
            .toList()));
    }

    return invoice;
  }

  @override
  String get listDisplayName {
    return invoiceNumber;
  }

  @override
  double get listDisplayAmount => balance;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  bool isBetween(String startDate, String endDate) {
    return startDate.compareTo(invoiceDate) <= 0 &&
        endDate.compareTo(invoiceDate) >= 0;
  }

  double get requestedAmount => partial > 0 ? partial : amount;

  bool get isUnpaid => invoiceStatusId != kInvoiceStatusPaid;

  bool get isPaid => invoiceStatusId == kInvoiceStatusPaid;

  bool get isPastDue {
    if (dueDate.isEmpty) {
      return false;
    }

    return !isDeleted &&
        isPublic &&
        isUnpaid &&
        DateTime.tryParse(dueDate)
            .isBefore(DateTime.now().subtract(Duration(days: 1)));
  }

  String get invitationLink =>
      invitations.isEmpty ? '' : invitations.first.link;

  String get invitationBorderlessLink =>
      invitations.isEmpty ? '' : invitations.first.borderlessLink;

  String get invitationSilentLink =>
      invitations.isEmpty ? '' : invitations.first.silentLink;

  String get invitationDownloadLink =>
      invitations.isEmpty ? '' : invitations.first.downloadLink;

  PaymentEntity createPayment(CompanyEntity company) {
    return PaymentEntity(company: company).rebuild((b) => b
      ..invoiceId = id
      ..clientId = clientId
      ..amount = balance);
  }

  static Serializer<InvoiceEntity> get serializer => _$invoiceEntitySerializer;
}

abstract class InvoiceItemEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<InvoiceItemEntity, InvoiceItemEntityBuilder> {
  factory InvoiceItemEntity() {
    return _$InvoiceItemEntity._(
      id: BaseEntity.nextId,
      isChanged: false,
      productKey: '',
      notes: '',
      cost: 0.0,
      qty: 0.0,
      taxName1: '',
      taxRate1: 0.0,
      taxName2: '',
      taxRate2: 0.0,
      invoiceItemTypeId: '',
      customValue1: '',
      customValue2: '',
      discount: 0.0,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  InvoiceItemEntity._();

  @override
  EntityType get entityType {
    return EntityType.invoiceItem;
  }

  @BuiltValueField(wireName: 'product_key')
  String get productKey;

  String get notes;

  double get cost;

  double get qty;

  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;

  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;

  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;

  @BuiltValueField(wireName: 'invoice_item_type_id')
  String get invoiceItemTypeId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  double get discount;

  @nullable
  @BuiltValueField(wireName: 'task_public_id')
  String get taskId;

  @nullable
  @BuiltValueField(wireName: 'expense_public_id')
  String get expenseId;

  double get total => round(qty * cost, 2);

  bool get isTask => taskId != null && taskId.isNotEmpty;

  bool get isExpense => expenseId != null && expenseId.isNotEmpty;

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

  InvoiceItemEntity applyTax(TaxRateEntity taxRate, {bool isSecond = false}) {
    InvoiceItemEntity item;

    if (isSecond) {
      item = rebuild((b) => b
        ..taxRate2 = taxRate.rate
        ..taxName2 = taxRate.name);
    } else {
      item = rebuild((b) => b
        ..taxRate1 = taxRate.rate
        ..taxName1 = taxRate.name);
    }

    if (taxRate.isInclusive) {
      item = item.rebuild(
          (b) => b..cost = round(b.cost / (100 + taxRate.rate) * 100, 2));
    }

    return item;
  }

  @override
  String get listDisplayName {
    return '';
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static Serializer<InvoiceItemEntity> get serializer =>
      _$invoiceItemEntitySerializer;
}

abstract class InvitationEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<InvitationEntity, InvitationEntityBuilder> {
  factory InvitationEntity() {
    return _$InvitationEntity._(
      id: BaseEntity.nextId,
      isChanged: false,
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

  //@BuiltValueField(wireName: 'contact_id')
  //int get contactId;

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
