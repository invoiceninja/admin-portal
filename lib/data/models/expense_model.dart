import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'expense_model.g.dart';

abstract class ExpenseListResponse
    implements Built<ExpenseListResponse, ExpenseListResponseBuilder> {
  BuiltList<ExpenseEntity> get data;

  ExpenseListResponse._();
  factory ExpenseListResponse([void updates(ExpenseListResponseBuilder b)]) =
      _$ExpenseListResponse;
  static Serializer<ExpenseListResponse> get serializer =>
      _$expenseListResponseSerializer;
}

abstract class ExpenseItemResponse
    implements Built<ExpenseItemResponse, ExpenseItemResponseBuilder> {
  ExpenseEntity get data;

  ExpenseItemResponse._();
  factory ExpenseItemResponse([void updates(ExpenseItemResponseBuilder b)]) =
      _$ExpenseItemResponse;
  static Serializer<ExpenseItemResponse> get serializer =>
      _$expenseItemResponseSerializer;
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

abstract class ExpenseEntity extends Object
    with BaseEntity
    implements Built<ExpenseEntity, ExpenseEntityBuilder> {

  @override
  EntityType get entityType {
    return EntityType.expense;
  }

  static int counter = 0;
  factory ExpenseEntity() {
    return _$ExpenseEntity._(
      id: --ExpenseEntity.counter,
      privateNotes: '',
      publicNotes: '',
      shouldBeInvoiced: false,
      transactionId: '',
      transactionReference: '',
      bankId: '',
      expenseCurrencyId: 0,
      exchangeCurrencyId: 0,
      amount: 0.0,
      expenseDate: '',
      exchangeRate: 0.0,
      invoiceCurrencyId: 0,
      taxName1: '',
      taxRate1: '',
      taxRate2: '',
      clientId: 0,
      invoiceId: 0,
      vendorId: 0,
      customValue1: '',
      customValue2: '',
      expenseCategories: BuiltList<ExpenseCategoryEntity>(),
    );
  }

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @BuiltValueField(wireName: 'should_be_invoiced')
  bool get shouldBeInvoiced;

  @BuiltValueField(wireName: 'transaction_id')
  String get transactionId;

  @BuiltValueField(wireName: 'transaction_reference')
  String get transactionReference;

  @BuiltValueField(wireName: 'bank_id')
  String get bankId;

  @BuiltValueField(wireName: 'expense_currency_id')
  int get expenseCurrencyId;

  @BuiltValueField(wireName: 'expense_category_id')
  int get exchangeCurrencyId;

  double get amount;

  @BuiltValueField(wireName: 'expense_date')
  String get expenseDate;

  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @BuiltValueField(wireName: 'invoiceCurrencyId')
  int get invoiceCurrencyId;

  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @BuiltValueField(wireName: 'tax_rate1')
  String get taxRate1;

  @BuiltValueField(wireName: 'tax_rate2')
  String get taxRate2;

  @BuiltValueField(wireName: 'client_id')
  int get clientId;

  @BuiltValueField(wireName: 'invoice_id')
  int get invoiceId;

  @BuiltValueField(wireName: 'vendor_id')
  int get vendorId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'expense_category')
  BuiltList<ExpenseCategoryEntity> get expenseCategories;

  int compareTo(ExpenseEntity expense, String sortField, bool sortAscending) {
    int response = 0;
    ExpenseEntity creditA = sortAscending ? this : expense;
    ExpenseEntity creditB = sortAscending ? expense : this;

    switch (sortField) {
      case ExpenseFields.amount:
        response = creditA.amount.compareTo(creditB.amount);
    }

    return response;
  }

  @override
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return privateNotes.contains(search);
  }

  ExpenseEntity._();
  static Serializer<ExpenseEntity> get serializer => _$expenseEntitySerializer;
}

abstract class ExpenseCategoryEntity extends Object
    with BaseEntity
    implements Built<ExpenseCategoryEntity, ExpenseCategoryEntityBuilder> {
  String get name;

  ExpenseCategoryEntity._();
  factory ExpenseCategoryEntity([void updates(ExpenseCategoryEntityBuilder b)]) =
      _$ExpenseCategoryEntity;
  static Serializer<ExpenseCategoryEntity> get serializer =>
      _$expenseCategoryEntitySerializer;
}
