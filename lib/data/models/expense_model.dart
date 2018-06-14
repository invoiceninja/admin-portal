import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'expense_model.g.dart';

abstract class ExpenseListResponse implements Built<ExpenseListResponse, ExpenseListResponseBuilder> {

  BuiltList<ExpenseEntity> get data;

  ExpenseListResponse._();
  factory ExpenseListResponse([updates(ExpenseListResponseBuilder b)]) = _$ExpenseListResponse;
  static Serializer<ExpenseListResponse> get serializer => _$expenseListResponseSerializer;
}

abstract class ExpenseItemResponse implements Built<ExpenseItemResponse, ExpenseItemResponseBuilder> {

  ExpenseEntity get data;

  ExpenseItemResponse._();
  factory ExpenseItemResponse([updates(ExpenseItemResponseBuilder b)]) = _$ExpenseItemResponse;
  static Serializer<ExpenseItemResponse> get serializer => _$expenseItemResponseSerializer;
}


class ExpenseFields {
  static const String privateNotes = 'privateNotes';
  static const String publicNotes = 'publicNotes';
  static const String shouldBeInvoiced = 'shouldBeInvoiced';
  static const String transactionId = 'transactionId';
  static const String transactionReference = 'transactionReference';
  static const String bankId = 'bankId';
  static const String expenseCurrencyId = 'expenseCurrencyId';
  static const String expenseCategoryId = 'expenseCategoryId';
  static const String amount = 'amount';
  static const String expenseDate = 'expenseDate';
  static const String exchangeRate = 'exchangeRate';
  static const String invoiceCurrencyId = 'invoiceCurrencyId';
  static const String taxName1 = 'taxName1';
  static const String taxName2 = 'taxName2';
  static const String taxRate1 = 'taxRate1';
  static const String taxRate2 = 'taxRate2';
  static const String clientId = 'clientId';
  static const String invoiceId = 'invoiceId';
  static const String vendorId = 'vendorId';
  static const String customValue1 = 'customValue1';
  static const String customValue2 = 'customValue2';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class ExpenseEntity extends Object with BaseEntity implements Built<ExpenseEntity, ExpenseEntityBuilder> {

  @nullable
  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @nullable
  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @nullable
  @BuiltValueField(wireName: 'should_be_invoiced')
  bool get shouldBeInvoiced;

  @nullable
  @BuiltValueField(wireName: 'transaction_id')
  String get transactionId;

  @nullable
  @BuiltValueField(wireName: 'transaction_reference')
  String get transactionReference;

  @nullable
  @BuiltValueField(wireName: 'bank_id')
  String get bankId;

  @nullable
  @BuiltValueField(wireName: 'expense_currency_id')
  int get expenseCurrencyId;

  @nullable
  @BuiltValueField(wireName: 'expense_category_id')
  int get exchangeCurrencyId;

  @nullable
  double get amount;

  @nullable
  @BuiltValueField(wireName: 'expense_date')
  String get expenseDate;

  @nullable
  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @nullable
  @BuiltValueField(wireName: 'invoiceCurrencyId')
  int get invoiceCurrencyId;

  @nullable
  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @nullable
  @BuiltValueField(wireName: 'tax_rate1')
  String get taxRate1;

  @nullable
  @BuiltValueField(wireName: 'tax_rate2')
  String get taxRate2;

  @nullable
  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  int get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'vendor_id')
  int get vendorId;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'expense_category')
  BuiltList<ExpenseCategoryEntity> get expenseCtegories;


  int compareTo(ExpenseEntity expense, String sortField, bool sortAscending) {
    int response = 0;
    ExpenseEntity creditA = sortAscending ? this : expense;
    ExpenseEntity creditB = sortAscending ? expense: this;

    switch (sortField) {
      case ExpenseFields.amount:
        response = creditA.amount.compareTo(creditB.amount);
    }
    
    return response;
  }
  
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return privateNotes.contains(search);
  }
  
  ExpenseEntity._();
  factory ExpenseEntity([updates(ExpenseEntityBuilder b)]) = _$ExpenseEntity;
  static Serializer<ExpenseEntity> get serializer => _$expenseEntitySerializer;
}

abstract class ExpenseCategoryEntity extends Object with BaseEntity implements Built<ExpenseCategoryEntity, ExpenseCategoryEntityBuilder> {

  @nullable
  String get name;

  ExpenseCategoryEntity._();
  factory ExpenseCategoryEntity([updates(ExpenseCategoryEntityBuilder b)]) = _$ExpenseCategoryEntity;
  static Serializer<ExpenseCategoryEntity> get serializer => _$expenseCategoryEntitySerializer;
}