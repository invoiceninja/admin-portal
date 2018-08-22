import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
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
  static const String clientId = 'clientId';
  static const String quoteStatusId = 'quoteStatusId';
  static const String quoteNumber = 'quoteNumber';
  static const String discount = 'discount';
  static const String poNumber = 'poNumber';
  static const String quoteDate = 'quoteDate';
  static const String validUntil = 'validUntil';
  static const String terms = 'terms';
  static const String partial = 'partial';
  static const String partialDueDate = 'partialDueDate';
  static const String publicNotes = 'publicNotes';
  static const String privateNotes = 'privateNotes';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class QuoteEntity extends Object
    with BaseEntity, CalculateInvoiceTotal
    implements Built<QuoteEntity, QuoteEntityBuilder> {
  static int counter = 0;

  factory QuoteEntity() {
    return _$QuoteEntity._(
      id: --QuoteEntity.counter,
      amount: 0.0,
      clientId: 0,
      quoteStatusId: 0,
      quoteNumber: '',
      discount: 0.0,
      poNumber: '',
      quoteDate: convertDateTimeToSqlDate(),
      validUntil: '',
      terms: '',
      publicNotes: '',
      privateNotes: '',
      recurringQuoteId: 0,
      taxName1: '',
      taxRate1: 0.0,
      taxName2: '',
      taxRate2: 0.0,
      isAmountDiscount: false,
      footer: '',
      partial: 0.0,
      partialDueDate: '',
      customValue1: 0.0,
      customValue2: 0.0,
      customTaxes1: false,
      customTaxes2: false,
      quoteInvoiceId: 0,
      customTextValue1: '',
      customTextValue2: '',
      isPublic: false,
      filename: '',
      invoiceItems: BuiltList<InvoiceItemEntity>(),
      invitations: BuiltList<InvitationEntity>(),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  QuoteEntity._();

  QuoteEntity get clone => rebuild((b) => b
    ..id = --QuoteEntity.counter
    ..quoteNumber = ''
    ..isPublic = false);

  @override
  EntityType get entityType {
    return EntityType.invoice;
  }

  double get amount;

  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  @BuiltValueField(wireName: 'invoice_status_id')
  int get quoteStatusId;

  @BuiltValueField(wireName: 'invoice_number')
  String get quoteNumber;

  @override
  double get discount;

  @BuiltValueField(wireName: 'po_number')
  String get poNumber;

  @BuiltValueField(wireName: 'invoice_date')
  String get quoteDate;

  @BuiltValueField(wireName: 'due_date')
  String get validUntil;

  String get terms;

  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'recurring_invoice_id')
  int get recurringQuoteId;

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
  String get footer;

  double get partial;

  @BuiltValueField(wireName: 'partial_due_date')
  String get partialDueDate;

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

  @BuiltValueField(wireName: 'quote_invoice_id')
  int get quoteInvoiceId;

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

  QuoteEntity applyTax(TaxRateEntity taxRate) {
    QuoteEntity invoice = rebuild((b) => b
      ..taxRate1 = taxRate.rate
      ..taxName1 = taxRate.name);

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
    return quoteNumber;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  double get requestedAmount => partial > 0 ? partial : amount;

  bool get isPastDue {
    if (validUntil.isEmpty) {
      return false;
    }

    return !isDeleted &&
        isPublic &&
        quoteStatusId != kInvoiceStatusPaid &&
        DateTime.tryParse(validUntil)
            .isBefore(DateTime.now().subtract(Duration(days: 1)));
  }

  String get invitationLink => invitations.first?.link;

  String get invitationSilentLink => invitations.first?.silentLink;

  String get invitationDownloadLink => invitations.first?.downloadLink;

  static Serializer<QuoteEntity> get serializer => _$quoteEntitySerializer;
}
