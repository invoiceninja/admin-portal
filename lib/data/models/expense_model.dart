import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
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
  static const String paymentDate = 'paymentDate';
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
  factory ExpenseEntity(
      {int id,
      CompanyEntity company,
      UIState uiState,
      VendorEntity vendor,
      ClientEntity client}) {
    return _$ExpenseEntity._(
      id: id ?? --ExpenseEntity.counter,
      privateNotes: '',
      publicNotes: '',
      shouldBeInvoiced: false,
      invoiceDocuments: uiState?.addDocumentsToInvoice ?? false,
      transactionId: '',
      transactionReference: '',
      bankId: 0,
      amount: 0,
      expenseDate: convertDateTimeToSqlDate(),
      paymentDate: '',
      paymentTypeId: 0,
      exchangeRate: 1,
      expenseCurrencyId:
          (vendor != null && vendor.currencyId != null && vendor.currencyId > 0)
              ? vendor.currencyId
              : (company?.currencyId ?? kDefaultCurrencyId),
      invoiceCurrencyId:
          (client != null && client.currencyId != null && client.currencyId > 0)
              ? client.currencyId
              : (company?.currencyId ?? kDefaultCurrencyId),
      taxName1: '',
      taxName2: '',
      taxRate1: 0,
      taxRate2: 0,
      clientId: client?.id ?? 0,
      vendorId: vendor?.id ?? 0,
      invoiceId: 0,
      categoryId: 0,
      customValue1: '',
      customValue2: '',
      isDeleted: false,
    );
  }

  ExpenseEntity._();

  static int counter = 0;

  ExpenseEntity get clone => rebuild((b) => b
    ..id = --ExpenseEntity.counter
    ..isDeleted = false
    ..invoiceId = 0
    ..expenseDate = convertDateTimeToSqlDate()
    ..transactionReference = ''
    ..paymentTypeId = 0
    ..paymentDate = '');

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

  @BuiltValueField(wireName: 'invoice_documents')
  bool get invoiceDocuments;

  @BuiltValueField(wireName: 'transaction_id')
  String get transactionId;

  @BuiltValueField(wireName: 'transaction_reference')
  String get transactionReference;

  @BuiltValueField(wireName: 'bank_id')
  int get bankId;

  @BuiltValueField(wireName: 'expense_currency_id')
  int get expenseCurrencyId;

  @nullable
  @BuiltValueField(wireName: 'expense_category_id')
  int get categoryId;

  double get amount;

  @BuiltValueField(wireName: 'expense_date')
  String get expenseDate;

  @BuiltValueField(wireName: 'payment_date')
  String get paymentDate;

  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @BuiltValueField(wireName: 'invoice_currency_id')
  int get invoiceCurrencyId;

  @BuiltValueField(wireName: 'payment_type_id')
  int get paymentTypeId;

  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;

  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;

  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;

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

  @override
  List<EntityAction> getActions(
      {UserEntity user, ClientEntity client, bool includeEdit = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (includeEdit && user.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (user.canCreate(EntityType.invoice)) {
        actions.add(EntityAction.newInvoice);
      }
    }

    if (isInvoiced) {
      actions.add(EntityAction.viewInvoice);
    }

    if (user.canCreate(EntityType.task)) {
      actions.add(EntityAction.clone);
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(user: user));
  }

  int compareTo(ExpenseEntity expense, String sortField, bool sortAscending) {
    int response = 0;
    final ExpenseEntity expenseA = sortAscending ? this : expense;
    final ExpenseEntity expenseB = sortAscending ? expense : this;

    switch (sortField) {
      case ExpenseFields.amount:
        response = expenseA.amount.compareTo(expenseB.amount);
        break;
      case ExpenseFields.publicNotes:
        response = expenseA.publicNotes
            .toLowerCase()
            .compareTo(expenseB.publicNotes.toLowerCase());
        break;
      case ExpenseFields.updatedAt:
        response = expenseA.updatedAt.compareTo(expenseB.updatedAt);
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (publicNotes.toLowerCase().contains(filter)) {
      return true;
    }

    if (privateNotes.toLowerCase().contains(filter)) {
      return true;
    }

    if (transactionReference.toLowerCase().contains(filter)) {
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

    if (privateNotes.toLowerCase().contains(filter)) {
      return privateNotes;
    }

    if (publicNotes.toLowerCase().contains(filter)) {
      return publicNotes;
    } else if (publicNotes.toLowerCase().contains(filter)) {
      return transactionReference;
    } else if (transactionReference.toLowerCase().contains(filter)) {
      return transactionReference;
    }

    return null;
  }

  @override
  bool matchesStatuses(BuiltList<EntityStatus> statuses) {
    if (statuses.isEmpty) {
      return true;
    }

    for (final status in statuses) {
      if (status.id == kExpenseStatusInvoiced && isInvoiced) {
        return true;
      } else if (status.id == kExpenseStatusPending && isPending) {
        return true;
      } else if (status.id == kExpenseStatusLogged &&
          !isInvoiced &&
          !isPending) {
        return true;
      }
    }

    return false;
  }

  @override
  String get listDisplayName {
    if (publicNotes != null && publicNotes.isNotEmpty) {
      return publicNotes;
    } else {
      return expenseDate;
    }
  }

  bool isBetween(String startDate, String endDate) {
    return startDate.compareTo(endDate) <= 0 && endDate.compareTo(endDate) >= 0;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  double get amountWithTax {
    var total = amount;
    if (taxRate1 != 0) {
      total += amount * taxRate1 / 100;
    }
    if (taxRate2 != 0) {
      total += amount * taxRate2 / 100;
    }
    return round(total, 2);
  }

  int get statusId {
    if ((invoiceId ?? 0) > 0) {
      return kExpenseStatusInvoiced;
    } else if (shouldBeInvoiced) {
      return kExpenseStatusPending;
    } else {
      return kExpenseStatusLogged;
    }
  }

  double get convertedAmount => round(amount * exchangeRate, 2);

  double get convertedAmountWithTax => round(amountWithTax * exchangeRate, 2);

  bool get isInvoiced => invoiceId != null && invoiceId > 0;

  bool get isPending => !isInvoiced && shouldBeInvoiced;

  bool get isConverted => exchangeRate != 1 && exchangeRate != 0;

  static Serializer<ExpenseEntity> get serializer => _$expenseEntitySerializer;
}

class ExpenseCategoryFields {
  static const String name = 'name';
}

abstract class ExpenseCategoryEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ExpenseCategoryEntity, ExpenseCategoryEntityBuilder> {
  factory ExpenseCategoryEntity() {
    return _$ExpenseCategoryEntity._(
      id: --ExpenseCategoryEntity.counter,
      name: '',
      isDeleted: false,
    );
  }

  ExpenseCategoryEntity._();

  static int counter = 0;

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();
    if (name.toLowerCase().contains(filter)) {
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
    return name;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  String get name;

  int compareTo(
      ExpenseCategoryEntity category, String sortField, bool sortAscending) {
    int response = 0;
    final ExpenseCategoryEntity categoryA = sortAscending ? this : category;
    final ExpenseCategoryEntity categoryB = sortAscending ? category : this;

    switch (sortField) {
      case ExpenseCategoryFields.name:
        response = categoryA.name
            .toLowerCase()
            .compareTo(categoryB.name.toLowerCase());
    }

    return response;
  }

  static Serializer<ExpenseCategoryEntity> get serializer =>
      _$expenseCategoryEntitySerializer;
}

abstract class ExpenseStatusEntity extends Object
    with EntityStatus, SelectableEntity
    implements Built<ExpenseStatusEntity, ExpenseStatusEntityBuilder> {
  factory ExpenseStatusEntity() {
    return _$ExpenseStatusEntity._(
      id: 0,
      name: '',
    );
  }

  ExpenseStatusEntity._();

  @override
  String get listDisplayName => name;

  static Serializer<ExpenseStatusEntity> get serializer =>
      _$expenseStatusEntitySerializer;
}
