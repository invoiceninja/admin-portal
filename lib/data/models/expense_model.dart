import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
  static const String privateNotes = 'private_notes';
  static const String publicNotes = 'public_notes';
  static const String shouldBeInvoiced = 'should_be_invoiced';
  static const String transactionId = 'transaction_id';
  static const String transactionReference = 'transaction_reference';
  static const String bankId = 'bank_id';
  static const String expenseCurrencyId = 'expense_currency_id';
  static const String expenseCategoryId = 'expense_category_id';
  static const String expenseCategory = 'expense_category';
  static const String amount = 'amount';
  static const String expenseDate = 'expense_date';
  static const String paymentDate = 'payment_date';
  static const String exchangeRate = 'exchange_rate';
  static const String invoiceCurrencyId = 'invoice_currency_id';
  static const String taxName1 = 'tax_name1';
  static const String taxName2 = 'tax_name2';
  static const String taxRate1 = 'tax_rate1';
  static const String taxRate2 = 'tax_rate2';
  static const String clientId = 'client_id';
  static const String client = 'client';
  static const String invoiceId = 'invoice_id';
  static const String vendorId = 'vendor_id';
  static const String vendor = 'vendor';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
}

abstract class ExpenseEntity extends Object
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<ExpenseEntity, ExpenseEntityBuilder> {
  factory ExpenseEntity(
      {String id, AppState state, VendorEntity vendor, ClientEntity client}) {
    return _$ExpenseEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      privateNotes: '',
      publicNotes: '',
      shouldBeInvoiced: false,
      invoiceDocuments: state?.prefState?.addDocumentsToInvoice ?? false,
      transactionId: '',
      transactionReference: '',
      bankId: '',
      amount: 0,
      expenseDate: convertDateTimeToSqlDate(),
      paymentDate: '',
      paymentTypeId: '',
      exchangeRate: 1,
      expenseCurrencyId: (vendor != null && vendor.hasCurrency)
          ? vendor.currencyId
          : (state?.company?.currencyId ?? kDefaultCurrencyId),
      invoiceCurrencyId: (client != null && client.hasCurrency)
          ? client.settings.currencyId // TODO handle group currency
          : (state?.company?.currencyId ?? kDefaultCurrencyId),
      taxName1: '',
      taxName2: '',
      taxRate1: 0,
      taxRate2: 0,
      taxName3: '',
      taxRate3: 0,
      clientId: client?.id,
      vendorId: vendor?.id,
      invoiceId: '',
      categoryId: '',
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      isDeleted: false,
      createdAt: 0,
      assignedUserId: '',
      createdUserId: '',
      archivedAt: 0,
      updatedAt: 0,
    );
  }

  ExpenseEntity._();

  ExpenseEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false
    ..invoiceId = null
    ..expenseDate = convertDateTimeToSqlDate()
    ..transactionReference = ''
    ..paymentTypeId = null
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
  String get bankId;

  @BuiltValueField(wireName: 'expense_currency_id')
  String get expenseCurrencyId;

  @nullable
  @BuiltValueField(wireName: 'expense_category_id')
  String get categoryId;

  double get amount;

  @BuiltValueField(wireName: 'expense_date')
  String get expenseDate;

  @BuiltValueField(wireName: 'payment_date')
  String get paymentDate;

  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @BuiltValueField(wireName: 'invoice_currency_id')
  String get invoiceCurrencyId;

  @BuiltValueField(wireName: 'payment_type_id')
  String get paymentTypeId;

  @BuiltValueField(wireName: 'tax_name1')
  String get taxName1;

  @BuiltValueField(wireName: 'tax_name2')
  String get taxName2;

  @BuiltValueField(wireName: 'tax_rate1')
  double get taxRate1;

  @BuiltValueField(wireName: 'tax_rate2')
  double get taxRate2;

  @BuiltValueField(wireName: 'tax_name3')
  String get taxName3;

  @BuiltValueField(wireName: 'tax_rate3')
  double get taxRate3;

  @nullable
  @override
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @nullable
  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

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
        actions.add(EntityAction.newInvoice);
      }
    }

    if (isInvoiced) {
      actions.add(EntityAction.viewInvoice);
    }

    if (userCompany.canCreate(EntityType.task)) {
      actions.add(EntityAction.clone);
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
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
    } else if (privateNotes.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue3.isNotEmpty &&
        customValue3.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue4.isNotEmpty &&
        customValue4.toLowerCase().contains(filter)) {
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
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return customValue1;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return customValue2;
    } else if (customValue3.isNotEmpty &&
        customValue3.toLowerCase().contains(filter)) {
      return customValue3;
    } else if (customValue4.isNotEmpty &&
        customValue4.toLowerCase().contains(filter)) {
      return customValue4;
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
    return startDate.compareTo(expenseDate) <= 0 &&
        endDate.compareTo(expenseDate) >= 0;
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

  String get statusId {
    if (isInvoiced) {
      return kExpenseStatusInvoiced;
    } else if (shouldBeInvoiced) {
      return kExpenseStatusPending;
    } else {
      return kExpenseStatusLogged;
    }
  }

  double get convertedAmount => round(amount * exchangeRate, 2);

  double get convertedAmountWithTax => round(amountWithTax * exchangeRate, 2);

  bool get isInvoiced => invoiceId != null && invoiceId.isNotEmpty;

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
      id: BaseEntity.nextId,
      isChanged: false,
      name: '',
      isDeleted: false,
    );
  }

  ExpenseCategoryEntity._();

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
      id: '',
      name: '',
    );
  }

  ExpenseStatusEntity._();

  @override
  String get listDisplayName => name;

  static Serializer<ExpenseStatusEntity> get serializer =>
      _$expenseStatusEntitySerializer;
}
