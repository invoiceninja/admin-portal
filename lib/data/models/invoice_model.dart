import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'invoice_model.g.dart';

abstract class InvoiceListResponse implements Built<InvoiceListResponse, 
  InvoiceListResponseBuilder> {

  BuiltList<InvoiceEntity> get data;

  InvoiceListResponse._();
  factory InvoiceListResponse([updates(InvoiceListResponseBuilder b)]) = _$InvoiceListResponse;
  static Serializer<InvoiceListResponse> get serializer => _$invoiceListResponseSerializer;
}

abstract class InvoiceItemResponse implements Built<InvoiceItemResponse, InvoiceItemResponseBuilder> {

  InvoiceEntity get data;

  InvoiceItemResponse._();
  factory InvoiceItemResponse([updates(InvoiceItemResponseBuilder b)]) = _$InvoiceItemResponse;
  static Serializer<InvoiceItemResponse> get serializer => _$invoiceItemResponseSerializer;
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


abstract class InvoiceEntity extends Object with BaseEntity 
  implements Built<InvoiceEntity, InvoiceEntityBuilder> {

  @nullable
  double get amount;

  @nullable
  double get balance;

  @nullable
  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  @nullable
  @BuiltValueField(wireName: 'invoice_status_id')
  int get invoiceStatusId;

  @nullable
  @BuiltValueField(wireName: 'invoice_number')
  String get invoiceNumber;

  @nullable
  double get discount;

  @nullable
  @BuiltValueField(wireName: 'po_number')
  String get poNumber;

  @nullable
  @BuiltValueField(wireName: 'invoice_date')
  String get invoiceDate;

  @nullable
  @BuiltValueField(wireName: 'due_date')
  String get dueDate;

  @nullable
  String get terms;

  @nullable
  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @nullable
  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @nullable
  @BuiltValueField(wireName: 'invoice_type_id')
  int get invoiceTypeId;

  @nullable
  @BuiltValueField(wireName: 'is_recurring')
  bool get isRecurring;

  @nullable
  @BuiltValueField(wireName: 'frequency_id')
  int get frequencyId;

  @nullable
  @BuiltValueField(wireName: 'start_date')
  String get startDate;

  @nullable
  @BuiltValueField(wireName: 'end_date')
  String get endDate;
  
  @nullable
  @BuiltValueField(wireName: 'last_sent_date')
  String get lastSentDate;

  @nullable
  @BuiltValueField(wireName: 'recurring_invoice_id')
  int get recurringInvoiceId;

  @nullable
  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @nullable
  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;

  @nullable
  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;

  @nullable
  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;

  @nullable
  @BuiltValueField(wireName: 'is_amount_discount')
  bool get isAmountDiscount;

  @nullable
  @BuiltValueField(wireName: 'invoice_footer')
  String get invoiceFooter;
  
  @nullable
  double get partial;

  @nullable
  @BuiltValueField(wireName: 'partial_due_date')
  String get partialDueDate;

  @nullable
  @BuiltValueField(wireName: 'has_tasks')
  bool get hasTasks;

  @nullable
  @BuiltValueField(wireName: 'auto_bill')
  bool get autoBill;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  double get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  double get customValue2;

  @nullable
  @BuiltValueField(wireName: 'custom_taxes1')
  bool get customTaxes1;

  @nullable
  @BuiltValueField(wireName: 'custom_taxes2')
  bool get customTaxes2;

  @nullable
  @BuiltValueField(wireName: 'has_expenses')
  bool get hasExpenses;

  @nullable
  @BuiltValueField(wireName: 'quote_invoice_id')
  int get quoteInvoiceId;

  @nullable
  @BuiltValueField(wireName: 'custom_text_value1')
  String get customTextValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_text_value2')
  String get customTextValue2;

  @nullable
  @BuiltValueField(wireName: 'is_quote')
  bool get isQuote;

  @nullable
  @BuiltValueField(wireName: 'is_public')
  bool get isPublic;

  @nullable
  String get filename;

  @nullable
  @BuiltValueField(wireName: 'invoice_items')
  BuiltList<InvoiceItemEntity> get invoiceItems;

  @nullable
  BuiltList<InvitationEntity> get invitations;

  //String get last_login;
  //String get custom_messages;

  int compareTo(InvoiceEntity invoice, String sortField, bool sortAscending) {
    int response = 0;
    InvoiceEntity invoiceA = sortAscending ? this : invoice;
    InvoiceEntity invoiceB = sortAscending ? invoice: this;

    /*
    switch (sortField) {
      case ClientFields.cost:
        response = clientA.cost.compareTo(clientB.cost);
    }
    */
    if (response == 0) {
      return invoiceA.invoiceNumber.compareTo(invoiceB.invoiceNumber);
    } else {
      return response;
    }
  }

  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return invoiceNumber.contains(search);
  }

  InvoiceEntity._();
  factory InvoiceEntity([updates(InvoiceEntityBuilder b)]) = _$InvoiceEntity;
  static Serializer<InvoiceEntity> get serializer => _$invoiceEntitySerializer;
}


abstract class InvoiceItemEntity extends Object with BaseEntity implements Built<InvoiceItemEntity, InvoiceItemEntityBuilder> {

  @nullable
  @BuiltValueField(wireName: 'product_key')
  String get productKey;

  @nullable
  String get notes;

  @nullable
  double get cost;

  @nullable
  double get qty;

  @nullable
  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @nullable
  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;

  @nullable
  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;

  @nullable
  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;

  @nullable
  @BuiltValueField(wireName: 'invoice_item_type_id')
  int get invoiceItemTypeId;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  double get discount;

  InvoiceItemEntity._();
  factory InvoiceItemEntity([updates(InvoiceItemEntityBuilder b)]) = _$InvoiceItemEntity;
  static Serializer<InvoiceItemEntity> get serializer => _$invoiceItemEntitySerializer;
}

abstract class InvitationEntity extends Object with BaseEntity implements Built<InvitationEntity, InvitationEntityBuilder> {

  @nullable
  String get key;

  @nullable
  String get link;

  @nullable
  @BuiltValueField(wireName: 'sent_date')
  String get sentDate;

  @nullable
  @BuiltValueField(wireName: 'viewed_date')
  String get viewedDate;

  InvitationEntity._();
  factory InvitationEntity([updates(InvitationEntityBuilder b)]) = _$InvitationEntity;
  static Serializer<InvitationEntity> get serializer => _$invitationEntitySerializer;
}
