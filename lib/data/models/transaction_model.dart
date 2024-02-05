import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'transaction_model.g.dart';

abstract class TransactionListResponse
    implements Built<TransactionListResponse, TransactionListResponseBuilder> {
  factory TransactionListResponse(
          [void updates(TransactionListResponseBuilder b)]) =
      _$TransactionListResponse;

  TransactionListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<TransactionEntity> get data;

  static Serializer<TransactionListResponse> get serializer =>
      _$transactionListResponseSerializer;
}

abstract class TransactionItemResponse
    implements Built<TransactionItemResponse, TransactionItemResponseBuilder> {
  factory TransactionItemResponse(
          [void updates(TransactionItemResponseBuilder b)]) =
      _$TransactionItemResponse;

  TransactionItemResponse._();

  @override
  @memoized
  int get hashCode;

  TransactionEntity get data;

  static Serializer<TransactionItemResponse> get serializer =>
      _$transactionItemResponseSerializer;
}

class TransactionFields {
  static const String description = 'description';
  static const String date = 'date';
  static const String amount = 'amount';
  static const String deposit = 'deposit';
  static const String withdrawal = 'withdrawal';
  static const String currency = 'currency';
  static const String vendor = 'vendor';
  static const String category = 'category';
  static const String payment = 'payment';
  static const String bankAccountId = 'bank_account_id';
  static const String bankAccount = 'bank_account';
  static const String invoiceIds = 'invoice_ids';
  static const String invoices = 'invoices';
  static const String expenseId = 'expense_id';
  static const String expense = 'expense';
  static const String status = 'status';
  static const String accountType = 'account_type';
  static const String defaultCategory = 'default_category';
  static const String participantName = 'participant_name';
  static const String participant = 'participant';
}

abstract class TransactionEntity extends Object
    with BaseEntity
    implements Built<TransactionEntity, TransactionEntityBuilder> {
  factory TransactionEntity({String? id, AppState? state}) {
    String bankAccountId = '';
    if (state != null) {
      final bankAccounts = state.bankAccountState.list
          .map((bankAccountId) => state.bankAccountState.map[bankAccountId])
          .where((bankAccount) => !bankAccount!.isDeleted!)
          .toList();
      if (bankAccounts.length == 1) {
        bankAccountId = bankAccounts.first!.id;
      }
    }

    return _$TransactionEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      createdAt: 0,
      updatedAt: 0,
      createdUserId: '',
      assignedUserId: '',
      archivedAt: 0,
      amount: 0,
      bankAccountId: bankAccountId,
      category: '',
      currencyId: state?.company.currencyId ?? kDefaultCurrencyId,
      date: convertDateTimeToSqlDate(),
      description: '',
      expenseId: '',
      vendorId: '',
      invoiceIds: '',
      statusId: '',
      baseType: TYPE_WITHDRAWL,
      transactionId: 0,
      categoryId: '',
      transactionRuleId: '',
      paymentId: '',
      participant: '',
      participantName: '',
    );
  }

  TransactionEntity._();

  static const TYPE_DEPOSIT = 'CREDIT';
  static const TYPE_WITHDRAWL = 'DEBIT';

  @override
  @memoized
  int get hashCode;

  double get amount;

  @BuiltValueField(wireName: 'currency_id')
  String get currencyId;

  @BuiltValueField(wireName: 'category_type')
  String get category;

  @BuiltValueField(wireName: 'base_type')
  String get baseType;

  String get date;

  @BuiltValueField(wireName: 'bank_integration_id')
  String get bankAccountId;

  String get description;

  @BuiltValueField(wireName: 'status_id')
  String get statusId;

  @BuiltValueField(wireName: 'ninja_category_id')
  String get categoryId;

  @BuiltValueField(wireName: 'invoice_ids')
  String get invoiceIds;

  @BuiltValueField(wireName: 'payment_id')
  String get paymentId;

  @BuiltValueField(wireName: 'expense_id')
  String get expenseId;

  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  @BuiltValueField(wireName: 'transaction_id')
  int get transactionId;

  @BuiltValueField(wireName: 'bank_transaction_rule_id')
  String get transactionRuleId;

  @BuiltValueField(wireName: 'participant_name')
  String get participantName;

  String get participant;

  String? get pendingVendorId;

  @BuiltValueField(serialize: false)
  String? get pendingCategoryId;

  @BuiltValueField(serialize: false)
  String? get pendingExpenseId;

  @override
  EntityType get entityType => EntityType.transaction;

  bool get isDeposit => baseType == TYPE_DEPOSIT;

  bool get isWithdrawal => !isDeposit;

  double get withdrawal => isWithdrawal ? amount : 0;

  double get deposit => isDeposit ? amount : 0;

  bool get isMatched => statusId == kTransactionStatusMatched;

  bool get isConverted => statusId == kTransactionStatusConverted;

  String get formattedDescription => description.replaceAll('\\n', ' ');

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted! && userCompany!.canEditEntity(this)) {
      if (!multiselect && includeEdit) {
        actions.add(EntityAction.edit);
      }

      if (isMatched) {
        actions.add(EntityAction.convertMatched);
      }

      if (isConverted) {
        actions.add(EntityAction.unlink);
      }
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(
    TransactionEntity? transaction,
    String sortField,
    bool sortAscending,
    BuiltMap<String, VendorEntity> vendorMap,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
    BuiltMap<String, BankAccountEntity> bankAccountMap,
  ) {
    int response = 0;
    final transactionA = sortAscending ? this : transaction;
    final transactionB = sortAscending ? transaction : this;

    switch (sortField) {
      case TransactionFields.description:
        response = transactionA!.description
            .toLowerCase()
            .compareTo(transactionB!.description.toLowerCase());
        break;
      case TransactionFields.deposit:
      case TransactionFields.withdrawal:
      case TransactionFields.amount:
        response = transactionA!.amount.compareTo(transactionB!.amount);
        break;
      case TransactionFields.status:
        response = transactionA!.statusId.compareTo(transactionB!.statusId);
        break;
      case TransactionFields.date:
        response = transactionA!.date.compareTo(transactionB!.date);
        break;
      case TransactionFields.defaultCategory:
        response = transactionA!.category
            .toLowerCase()
            .compareTo(transactionB!.category.toLowerCase());
        break;
      case TransactionFields.accountType:
        final bankAccountA =
            bankAccountMap[transactionA!.bankAccountId] ?? BankAccountEntity();
        final bankAccountB =
            bankAccountMap[transactionB!.bankAccountId] ?? BankAccountEntity();
        response = bankAccountA.type.compareTo(bankAccountB.type);
        break;
      case TransactionFields.invoices:
        final invoiceA =
            invoiceMap[transactionA!.firstInvoiceId] ?? InvoiceEntity();
        final invoiceB =
            invoiceMap[transactionB!.firstInvoiceId] ?? InvoiceEntity();
        response = invoiceA.listDisplayName
            .toLowerCase()
            .compareTo(invoiceB.listDisplayName.toLowerCase());
        break;
      case TransactionFields.expense:
        final expenseA = expenseMap[transactionA!.expenseId] ?? ExpenseEntity();
        final expenseB = expenseMap[transactionB!.expenseId] ?? ExpenseEntity();
        response = expenseA.listDisplayName
            .toLowerCase()
            .compareTo(expenseB.listDisplayName.toLowerCase());
        break;
      case TransactionFields.vendor:
        final vendorA = vendorMap[transactionA!.vendorId] ?? VendorEntity();
        final vendorB = vendorMap[transactionB!.vendorId] ?? VendorEntity();
        response = vendorA.listDisplayName
            .toLowerCase()
            .compareTo(vendorB.listDisplayName.toLowerCase());
        break;
      case TransactionFields.category:
        final categoryA = expenseCategoryMap[transactionA!.categoryId] ??
            ExpenseCategoryEntity();
        final categoryB = expenseCategoryMap[transactionB!.categoryId] ??
            ExpenseCategoryEntity();
        response = categoryA.listDisplayName
            .toLowerCase()
            .compareTo(categoryB.listDisplayName.toLowerCase());
        break;
      case TransactionFields.bankAccount:
        final bankAccountA =
            bankAccountMap[transactionA!.bankAccountId] ?? BankAccountEntity();
        final bankAccountB =
            bankAccountMap[transactionB!.bankAccountId] ?? BankAccountEntity();
        response = bankAccountA.listDisplayName
            .toLowerCase()
            .compareTo(bankAccountB.listDisplayName.toLowerCase());
        break;
      default:
        print('## ERROR: sort by transaction.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return transactionA!.transactionId.compareTo(transactionB!.transactionId);
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
      if (status.id == kTransactionStatusWithdrawal && isWithdrawal) {
        return true;
      } else if (status.id == kTransactionStatusDeposit && isDeposit) {
        return true;
      }

      if (status.id == statusId || status.id == statusId) {
        return true;
      }
    }

    return false;
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        category,
        description,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        category,
        description,
      ],
      needle: filter,
    );
  }

  String? get firstInvoiceId {
    if (invoiceIds.isEmpty) {
      return null;
    }

    return invoiceIds.split(',').first;
  }

  @override
  String get listDisplayName {
    if (description.isNotEmpty) {
      return description.split('\n').first;
    } else {
      return AppLocalization.of(navigatorKey.currentContext!)!.transaction;
    }
  }

  @override
  double get listDisplayAmount => amount;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  // ignore: unused_element
  static void _initializeBuilder(TransactionEntityBuilder builder) => builder
    ..baseType = ''
    ..bankAccountId = ''
    ..transactionRuleId = ''
    ..paymentId = ''
    ..currencyId = ''
    ..participantName = ''
    ..participant = '';

  static Serializer<TransactionEntity> get serializer =>
      _$transactionEntitySerializer;
}

abstract class TransactionStatusEntity extends Object
    with EntityStatus, SelectableEntity
    implements Built<TransactionStatusEntity, TransactionStatusEntityBuilder> {
  factory TransactionStatusEntity() {
    return _$TransactionStatusEntity._(
      id: '',
      name: '',
    );
  }

  TransactionStatusEntity._();

  @override
  @memoized
  int get hashCode;

  static Serializer<TransactionStatusEntity> get serializer =>
      _$transactionStatusEntitySerializer;
}
