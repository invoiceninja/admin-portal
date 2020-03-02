import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/mixins/invoice_mixin.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'quote_model.g.dart';

abstract class QuoteListResponse
    implements Built<QuoteListResponse, QuoteListResponseBuilder> {
  factory QuoteListResponse([void updates(QuoteListResponseBuilder b)]) =
      _$QuoteListResponse;

  QuoteListResponse._();

  BuiltList<QuoteEntity> get data;

  static Serializer<QuoteListResponse> get serializer =>
      _$quoteListResponseSerializer;
}

abstract class QuoteItemResponse
    implements Built<QuoteItemResponse, QuoteItemResponseBuilder> {
  factory QuoteItemResponse([void updates(QuoteItemResponseBuilder b)]) =
      _$QuoteItemResponse;

  QuoteItemResponse._();

  QuoteEntity get data;

  static Serializer<QuoteItemResponse> get serializer =>
      _$quoteItemResponseSerializer;
}

class QuoteFields {
  static const String amount = 'amount';
  static const String balance = 'balance';
  static const String clientId = 'clientId';
  static const String client = 'client';
  static const String statusId = 'statusId';
  static const String number = 'number';
  static const String discount = 'discount';
  static const String poNumber = 'poNumber';
  static const String date = 'date';
  static const String validUntil = 'validUntil';
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

abstract class QuoteEntity extends Object
    with BaseEntity, SelectableEntity, CalculateInvoiceTotal
    implements Built<QuoteEntity, QuoteEntityBuilder> {
  factory QuoteEntity(
      {String id, bool isQuote = false, CompanyEntity company}) {
    return _$QuoteEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      amount: 0.0,
      balance: 0.0,
      clientId: '',
      discount: 0.0,
      poNumber: '',
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
      customSurcharge1: 0,
      customSurcharge2: 0,
      customSurcharge3: 0,
      customSurcharge4: 0,
      filename: '',
      lineItems: BuiltList<InvoiceItemEntity>(),
      invitations: BuiltList<InvitationEntity>(),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  QuoteEntity._();

  QuoteEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false
    ..quoteInvoiceId = null
    ..invoiceNumber = ''
    ..invoiceDate = convertDateTimeToSqlDate()
    ..dueDate = ''
    ..statusId = kQuoteStatusDraft);

  @override
  EntityType get entityType {
    return EntityType.quote;
  }

  double get amount;

  double get balance;

  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'status_id')
  String get statusId;

  @nullable
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
  @BuiltValueField(wireName: 'custom_taxes1')
  bool get customTaxes1;

  @override
  @BuiltValueField(wireName: 'custom_taxes2')
  bool get customTaxes2;

  @override
  @BuiltValueField(wireName: 'custom_taxes3')
  bool get customTaxes3;

  @override
  @BuiltValueField(wireName: 'custom_taxes4')
  bool get customTaxes4;

  @BuiltValueField(wireName: 'has_expenses')
  bool get hasExpenses;

  @BuiltValueField(wireName: 'quote_invoice_id')
  String get quoteInvoiceId;

  String get filename;

  @nullable
  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @nullable
  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  @override
  @BuiltValueField(wireName: 'line_items')
  BuiltList<InvoiceItemEntity> get lineItems;

  BuiltList<InvitationEntity> get invitations;

  bool get isApproved => (quoteInvoiceId ?? '').isNotEmpty;

  //String get last_login;
  //String get custom_messages;

  int compareTo(QuoteEntity quote, String sortField, bool sortAscending) {
    int response = 0;
    final QuoteEntity quoteA = sortAscending ? this : quote;
    final QuoteEntity quoteB = sortAscending ? quote : this;

    switch (sortField) {
      case QuoteFields.amount:
        response = quoteA.amount.compareTo(quoteB.amount);
        break;
      case QuoteFields.updatedAt:
        response = quoteA.updatedAt.compareTo(quoteB.updatedAt);
        break;
      case QuoteFields.date:
        response = quoteA.invoiceDate.compareTo(quoteB.invoiceDate);
        break;
    }

    if (response == 0) {
      return quoteA.invoiceNumber.compareTo(quoteB.invoiceNumber);
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

      if (status.id == kQuoteStatusExpired && isPastDue) {
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

    if (invoiceNumber != null && invoiceNumber.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
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

      if (userCompany.canCreate(EntityType.quote)) {
        if (userCompany.canEditEntity(this) && quoteInvoiceId == null) {
          actions.add(EntityAction.convert);
        }
      }

      if (userCompany.canEditEntity(this) && !isSent) {
        actions.add(EntityAction.markSent);
      }

      if (userCompany.canEditEntity(this) && client.hasEmailAddress) {
        actions.add(EntityAction.sendEmail);
      }

      if (userCompany.canEditEntity(this) &&
          userCompany.canCreate(EntityType.payment)) {
        actions.add(EntityAction.newPayment);
      }

      if ((quoteInvoiceId ?? '').isNotEmpty) {
        actions.add(EntityAction.viewQuote);
      }

      if (invitations.isNotEmpty) {
        actions.add(EntityAction.pdf);
        actions.add(EntityAction.clientPortal);
      }
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    if (userCompany.canCreate(EntityType.quote)) {
      actions.add(EntityAction.cloneToQuote);
      actions.add(EntityAction.cloneToQuote);
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  QuoteEntity applyTax(TaxRateEntity taxRate, {bool isSecond = false}) {
    QuoteEntity quote;

    if (isSecond) {
      quote = rebuild((b) => b
        ..taxRate2 = taxRate.rate
        ..taxName2 = taxRate.name);
    } else {
      quote = rebuild((b) => b
        ..taxRate1 = taxRate.rate
        ..taxName1 = taxRate.name);
    }

    return quote;
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

  bool get isSent => statusId != kQuoteStatusDraft;

  bool get isPastDue {
    if (dueDate.isEmpty) {
      return false;
    }

    return !isDeleted &&
        isSent &&
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

  static Serializer<QuoteEntity> get serializer => _$quoteEntitySerializer;
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

  @BuiltValueField(wireName: 'client_contact_id')
  int get contactId;

  @BuiltValueField(wireName: 'sent_date')
  String get sentDate;

  @BuiltValueField(wireName: 'viewed_date')
  String get viewedDate;

  String get silentLink => link + '?silent=true';

  String get borderlessLink => silentLink + '&borderless=true';

  String get downloadLink => link.replaceFirst('/client/', '/') + '/download';

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
