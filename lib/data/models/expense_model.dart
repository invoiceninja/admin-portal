import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'expense_model.g.dart';

abstract class ExpenseListResponse
    implements Built<ExpenseListResponse, ExpenseListResponseBuilder> {
  factory ExpenseListResponse([void updates(ExpenseListResponseBuilder b)]) =
      _$ExpenseListResponse;

  ExpenseListResponse._();

  BuiltList<ExpenseEntity> get data;

  static Serializer<ExpenseListResponse> get serializer =>
      _$expenseListResponseSerializer;
}

abstract class ExpenseItemResponse
    implements Built<ExpenseItemResponse, ExpenseItemResponseBuilder> {
  factory ExpenseItemResponse([void updates(ExpenseItemResponseBuilder b)]) =
      _$ExpenseItemResponse;

  ExpenseItemResponse._();

  ExpenseEntity get data;

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
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<ExpenseEntity, ExpenseEntityBuilder> {
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

  ExpenseEntity._();

  static int counter = 0;

  ExpenseEntity get clone => rebuild((b) => b
    ..id = --ExpenseEntity.counter
    ..isDeleted = false);

  @override
  EntityType get entityType {
    return EntityType.expense;
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

  @override
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

  List<EntityAction> getEntityActions({UserEntity user, ClientEntity client}) {
    final actions = <EntityAction>[];

    return actions..addAll(getBaseActions(user: user));
  }

  int compareTo(ExpenseEntity expense, String sortField, bool sortAscending) {
    int response = 0;
    final ExpenseEntity creditA = sortAscending ? this : expense;
    final ExpenseEntity creditB = sortAscending ? expense : this;

    switch (sortField) {
      case ExpenseFields.amount:
        response = creditA.amount.compareTo(creditB.amount);
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    return privateNotes.contains(filter);
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
    return publicNotes;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static Serializer<ExpenseEntity> get serializer => _$expenseEntitySerializer;
}

abstract class ExpenseCategoryEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ExpenseCategoryEntity, ExpenseCategoryEntityBuilder> {
  factory ExpenseCategoryEntity(
      [void updates(ExpenseCategoryEntityBuilder b)]) = _$ExpenseCategoryEntity;

  ExpenseCategoryEntity._();

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

  String get name;

  static Serializer<ExpenseCategoryEntity> get serializer =>
      _$expenseCategoryEntitySerializer;
}
