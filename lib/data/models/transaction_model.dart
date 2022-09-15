import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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
  static const String currencyId = 'currency_id';
  static const String currency = 'currency';
  static const String category = 'category';
  static const String bankAccountId = 'bank_account_id';
  static const String bankAccount = 'bank_account';
  static const String invoiceId = 'invoice_id';
  static const String invoice = 'invoice';
  static const String expenseId = 'expense_id';
  static const String expense = 'expense';
}

abstract class TransactionEntity extends Object
    with BaseEntity
    implements Built<TransactionEntity, TransactionEntityBuilder> {
  factory TransactionEntity({String id, AppState state}) {
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
      bankAccountId: '',
      category: '',
      currencyId: '',
      date: '',
      description: '',
      expenseId: '',
      invoiceId: '',
    );
  }

  TransactionEntity._();

  @override
  @memoized
  int get hashCode;

  double get amount;

  @BuiltValueField(wireName: 'currency_id')
  String get currencyId;

  @BuiltValueField(wireName: 'category_type')
  String get category;

  String get date;

  @BuiltValueField(wireName: 'bank_integration_id')
  String get bankAccountId;

  String get description;

  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @BuiltValueField(wireName: 'expense_id')
  String get expenseId;

  //@BuiltValueField(wireName: 'is_matched')
  //bool get isMached;

  @override
  EntityType get entityType => EntityType.transaction;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted &&
        !multiselect &&
        includeEdit &&
        userCompany.canEditEntity(this)) {
      actions.add(EntityAction.edit);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(
    TransactionEntity transaction,
    String sortField,
    bool sortAscending,
    BuiltMap<String, InvoiceEntity> invoiceMap,
    BuiltMap<String, ExpenseEntity> expenseMap,
    BuiltMap<String, BankAccountEntity> bankAccountMap,
  ) {
    int response = 0;
    final transactionA = sortAscending ? this : transaction;
    final transactionB = sortAscending ? transaction : this;

    switch (sortField) {
      case TransactionFields.description:
        response = transactionA.description
            .toLowerCase()
            .compareTo(transactionB.description.toLowerCase());
        break;
      case TransactionFields.amount:
        response = transactionA.amount.compareTo(transactionB.amount);
        break;
      case TransactionFields.category:
        response = transactionA.category
            .toLowerCase()
            .compareTo(transactionB.category.toLowerCase());
        break;
      case TransactionFields.date:
        response = transactionA.date.compareTo(transactionB.date);
        break;
      case TransactionFields.invoice:
        final invoiceA = invoiceMap[transactionA.invoiceId] ?? InvoiceEntity();
        final invoiceB = invoiceMap[transactionB.invoiceId] ?? InvoiceEntity();
        response = invoiceA.listDisplayName
            .toLowerCase()
            .compareTo(invoiceB.listDisplayName.toLowerCase());
        break;
      case TransactionFields.expense:
        final expenseA = expenseMap[transactionA.expenseId] ?? ExpenseEntity();
        final expenseB = expenseMap[transactionB.expenseId] ?? ExpenseEntity();
        response = expenseA.listDisplayName
            .toLowerCase()
            .compareTo(expenseB.listDisplayName.toLowerCase());
        break;
      case TransactionFields.bankAccount:
        final bankAccountA =
            bankAccountMap[transactionA.bankAccountId] ?? BankAccountEntity();
        final bankAccountB =
            bankAccountMap[transactionB.bankAccountId] ?? BankAccountEntity();
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
      return transactionA.description
          .toLowerCase()
          .compareTo(transactionB.description.toLowerCase());
    } else {
      return response;
    }
  }

  @override
  bool matchesFilter(String filter) {
    return matchesStrings(
      haystacks: [
        category,
        description,
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        category,
        description,
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName => description;

  @override
  double get listDisplayAmount => amount;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  // ignore: unused_element
  static void _initializeBuilder(TransactionEntityBuilder builder) => builder
    ..bankAccountId = ''
    ..currencyId = '';

  static Serializer<TransactionEntity> get serializer =>
      _$transactionEntitySerializer;
}
