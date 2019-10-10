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
  static const String quoteStatusId = 'quoteStatusId';
  static const String quoteNumber = 'quoteNumber';
  static const String discount = 'discount';
  static const String poNumber = 'poNumber';
  static const String quoteDate = 'quoteDate';
  static const String dueDate = 'dueDate';
  static const String terms = 'terms';
  static const String partial = 'partial';
  static const String partialDueDate = 'partialDueDate';
  static const String publicNotes = 'publicNotes';
  static const String privateNotes = 'privateNotes';
  static const String quoteTypeId = 'quoteTypeId';
  static const String isRecurring = 'isRecurring';
  static const String frequencyId = 'frequencyId';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String validUntil = 'validUntil';

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
      quoteStatusId: '',
      quoteNumber: '',
      discount: 0.0,
      poNumber: '',
      quoteDate: convertDateTimeToSqlDate(),
      dueDate: '',
      terms: '',
      publicNotes: '',
      privateNotes: '',
      isQuote: isQuote,
      isRecurring: false,
      frequencyId: 0,
      startDate: '',
      endDate: '',
      lastSentDate: '',
      recurringQuoteId: '',
      taxName1: company?.settings?.defaultTaxName1 ?? '',
      taxRate1: company?.settings?.defaultTaxRate1 ?? 0.0,
      taxName2: company?.settings?.defaultTaxName2 ?? '',
      taxRate2: company?.settings?.defaultTaxRate2 ?? 0.0,
      isAmountDiscount: false,
      quoteFooter: '',
      partial: 0.0,
      partialDueDate: '',
      hasTasks: false,
      autoBill: false,
      customValue1: 0.0,
      customValue2: 0.0,
      customTaxes1: false,
      customTaxes2: false,
      hasExpenses: false,
      quoteQuoteId: '',
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
              : company.settings.defaultQuoteDesignId)
          : '1',
    );
  }

  QuoteEntity._();

  QuoteEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isDeleted = false
    ..quoteQuoteId = null
    ..quoteNumber = ''
    ..quoteDate = convertDateTimeToSqlDate()
    ..dueDate = ''
    ..isPublic = false);

  QuoteEntity get cloneToQuote => clone.rebuild((b) => b..isQuote = false);

  @override
  EntityType get entityType {
    return EntityType.quote;
  }

  double get amount;

  double get balance;

  @BuiltValueField(wireName: 'is_quote')
  bool get isQuote;

  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'quote_status_id')
  String get quoteStatusId;

  @BuiltValueField(wireName: 'quote_number')
  String get quoteNumber;

  @override
  double get discount;

  @BuiltValueField(wireName: 'po_number')
  String get poNumber;

  @BuiltValueField(wireName: 'quote_date')
  String get quoteDate;

  @BuiltValueField(wireName: 'due_date')
  String get dueDate;

  String get terms;

  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

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

  @BuiltValueField(wireName: 'recurring_quote_id')
  String get recurringQuoteId;

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

  @BuiltValueField(wireName: 'quote_footer')
  String get quoteFooter;

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

  @BuiltValueField(wireName: 'quote_quote_id')
  String get quoteQuoteId;

  @BuiltValueField(wireName: 'custom_text_value1')
  String get customTextValue1;

  @BuiltValueField(wireName: 'custom_text_value2')
  String get customTextValue2;

  @BuiltValueField(wireName: 'is_public')
  bool get isPublic;

  String get filename;

  @override
  @BuiltValueField(wireName: 'quote_items')
  BuiltList<InvoiceItemEntity> get invoiceItems;

  BuiltList<InvitationEntity> get invitations;

  @nullable
  @BuiltValueField(wireName: 'quote_design_id')
  String get designId;

  bool get isApproved => (quoteQuoteId ?? '').isNotEmpty;

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
      case QuoteFields.quoteDate:
        response = quoteA.quoteDate.compareTo(quoteB.quoteDate);
        break;
    }

    if (response == 0) {
      return quoteA.quoteNumber.compareTo(quoteB.quoteNumber);
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
      if (status.id == quoteStatusId) {
        return true;
      }

      if (status.id == kQuoteStatusPastDue && isPastDue) {
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

    if (quoteNumber.toLowerCase().contains(filter)) {
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

      if (userCompany.canCreate(EntityType.quote)) {
        if (isQuote &&
            userCompany.canEditEntity(this) &&
            quoteQuoteId == null) {
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
          !isQuote) {
        actions.add(EntityAction.enterPayment);
      }

      if (isQuote && (quoteQuoteId ?? '').isNotEmpty) {
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

    if (taxRate.isInclusive) {
      quote = quote.rebuild((b) => b
        ..invoiceItems.replace(invoiceItems
            .map((item) => item.rebuild(
                (b) => b.cost = round(b.cost / (100 + taxRate.rate) * 100, 2)))
            .toList()));
    }

    return quote;
  }

  @override
  String get listDisplayName {
    return quoteNumber;
  }

  @override
  double get listDisplayAmount => balance;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  bool isBetween(String startDate, String endDate) {
    return startDate.compareTo(quoteDate) <= 0 &&
        endDate.compareTo(quoteDate) >= 0;
  }

  double get requestedAmount => partial > 0 ? partial : amount;

  bool get isPastDue {
    if (dueDate.isEmpty) {
      return false;
    }

    return !isDeleted &&
        isPublic &&
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
