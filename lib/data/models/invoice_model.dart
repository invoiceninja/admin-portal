import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/mixins/invoice_mixin.dart';
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
    with BaseEntity, CalculateInvoiceTotal
    implements Built<InvoiceEntity, InvoiceEntityBuilder> {
  static int counter = 0;
  factory InvoiceEntity() {
    return _$InvoiceEntity._(
      id: --InvoiceEntity.counter,
      amount: 0.0,
      balance: 0.0,
      clientId: 0,
      invoiceStatusId: 0,
      invoiceNumber: '',
      discount: 0.0,
      poNumber: '',
      invoiceDate: convertDateTimeToSqlDate(),
      dueDate: '',
      terms: '',
      publicNotes: '',
      privateNotes: '',
      invoiceTypeId: 0,
      isRecurring: false,
      frequencyId: 0,
      startDate: '',
      endDate: '',
      lastSentDate: '',
      recurringInvoiceId: 0,
      taxName1: '',
      taxRate1: 0.0,
      taxName2: '',
      taxRate2: 0.0,
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
      quoteInvoiceId: 0,
      customTextValue1: '',
      customTextValue2: '',
      isQuote: false,
      isPublic: false,
      filename: '',
      invoiceItems: BuiltList<InvoiceItemEntity>(),
      invitations: BuiltList<InvitationEntity>(),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }
  InvoiceEntity._();

  InvoiceEntity get clone => rebuild((b) => b
    ..id = --InvoiceEntity.counter
    ..invoiceNumber = ''
    ..isPublic = false
  );

  @override
  EntityType get entityType {
    return EntityType.invoice;
  }

  double get amount;

  double get balance;

  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  @BuiltValueField(wireName: 'invoice_status_id')
  int get invoiceStatusId;

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
  int get recurringInvoiceId;

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
  int get quoteInvoiceId;

  @BuiltValueField(wireName: 'custom_text_value1')
  String get customTextValue1;

  @BuiltValueField(wireName: 'custom_text_value2')
  String get customTextValue2;

  @BuiltValueField(wireName: 'is_quote')
  bool get isQuote;

  @BuiltValueField(wireName: 'is_public')
  bool get isPublic;

  String get filename;

  @override
  @BuiltValueField(wireName: 'invoice_items')
  BuiltList<InvoiceItemEntity> get invoiceItems;

  BuiltList<InvitationEntity> get invitations;

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
  String get listDisplayName {
    return invoiceNumber;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  double get requestedAmount => partial > 0 ? partial : amount;

  bool get isPastDue {
    if (dueDate.isEmpty) {
      return false;
    }

    return !isDeleted &&
        isPublic &&
        invoiceStatusId != kInvoiceStatusPaid &&
        DateTime
            .tryParse(dueDate)
            .isBefore(DateTime.now().subtract(Duration(days: 1)));
  }

  String get invitationLink => invitations.first?.link;
  String get invitationSilentLink => invitations.first?.silentLink;
  String get invitationDownloadLink => invitations.first?.downloadLink;

  static Serializer<InvoiceEntity> get serializer => _$invoiceEntitySerializer;
}

abstract class InvoiceItemEntity extends Object
    with BaseEntity
    implements Built<InvoiceItemEntity, InvoiceItemEntityBuilder> {
  static int counter = 0;
  factory InvoiceItemEntity() {
    return _$InvoiceItemEntity._(
      id: --InvoiceItemEntity.counter,
      productKey: '',
      notes: '',
      cost: 0.0,
      qty: 0.0,
      taxName1: '',
      taxRate1: 0.0,
      taxName2: '',
      taxRate2: 0.0,
      invoiceItemTypeId: 0,
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
  int get invoiceItemTypeId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  double get discount;

  double get total => qty * cost;

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

  static Serializer<InvoiceItemEntity> get serializer =>
      _$invoiceItemEntitySerializer;
}

abstract class InvitationEntity extends Object
    with BaseEntity
    implements Built<InvitationEntity, InvitationEntityBuilder> {
  static int counter = 0;
  factory InvitationEntity() {
    return _$InvitationEntity._(
      id: --InvitationEntity.counter,
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

  String get silentLink => link + '?silent=true&borderless=true';
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
