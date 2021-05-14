import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'expense_model.g.dart';

abstract class ExpenseListResponse
    implements Built<ExpenseListResponse, ExpenseListResponseBuilder> {
  factory ExpenseListResponse([void updates(ExpenseListResponseBuilder b)]) =
      _$ExpenseListResponse;

  ExpenseListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<ExpenseEntity> get data;

  static Serializer<ExpenseListResponse> get serializer =>
      _$expenseListResponseSerializer;
}

abstract class ExpenseItemResponse
    implements Built<ExpenseItemResponse, ExpenseItemResponseBuilder> {
  factory ExpenseItemResponse([void updates(ExpenseItemResponseBuilder b)]) =
      _$ExpenseItemResponse;

  ExpenseItemResponse._();

  @override
  @memoized
  int get hashCode;

  ExpenseEntity get data;

  static Serializer<ExpenseItemResponse> get serializer =>
      _$expenseItemResponseSerializer;
}

class ExpenseFields {
  static const String number = 'number';
  static const String privateNotes = 'private_notes';
  static const String publicNotes = 'public_notes';
  static const String shouldBeInvoiced = 'should_be_invoiced';
  static const String transactionId = 'transaction_id';
  static const String transactionReference = 'transaction_reference';
  static const String bankId = 'bank_id';
  static const String currencyId = 'currency_id';
  static const String categoryId = 'category_id';
  static const String category = 'category';
  static const String netAmount = 'net_amount';
  static const String amount = 'amount';
  static const String taxAmount = 'tax_amount';
  static const String expenseDate = 'date';
  static const String paymentDate = 'payment_date';
  static const String exchangeRate = 'exchange_rate';
  static const String invoiceCurrencyId = 'invoice_currency_id';
  static const String taxRate1 = 'tax_rate1';
  static const String taxName1 = 'tax_name1';
  static const String taxRate2 = 'tax_rate2';
  static const String taxName2 = 'tax_name2';
  static const String taxRate3 = 'tax_rate3';
  static const String taxName3 = 'tax_name3';
  static const String clientId = 'client_id';
  static const String client = 'client';
  static const String invoiceId = 'invoice_id';
  static const String vendorId = 'vendor_id';
  static const String vendor = 'vendor';
  static const String status = 'status';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
  static const String documents = 'documents';
}

abstract class ExpenseEntity extends Object
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<ExpenseEntity, ExpenseEntityBuilder> {
  factory ExpenseEntity({
    String id,
    AppState state,
    VendorEntity vendor,
    ClientEntity client,
    UserEntity user,
    ProjectEntity project,
  }) {
    final company = state?.company;
    return _$ExpenseEntity._(
      id: id ?? BaseEntity.nextId,
      number: '',
      isChanged: false,
      privateNotes: '',
      publicNotes: '',
      shouldBeInvoiced: company?.markExpensesInvoiceable ?? false,
      invoiceDocuments: company?.invoiceExpenseDocuments ?? false,
      transactionId: '',
      transactionReference: '',
      bankId: '',
      amount: 0,
      date: convertDateTimeToSqlDate(),
      paymentDate: (company?.markExpensesPaid ?? false)
          ? convertDateTimeToSqlDate()
          : '',
      paymentTypeId: '',
      exchangeRate: 1,
      currencyId: (vendor != null && vendor.hasCurrency)
          ? vendor.currencyId
          : (state?.company?.currencyId ?? kDefaultCurrencyId),
      invoiceCurrencyId: (client != null && client.hasCurrency)
          ? client.settings.currencyId // TODO handle group currency
          : (state?.company?.currencyId ?? kDefaultCurrencyId),
      documents: BuiltList<DocumentEntity>(),
      taxName1: '',
      taxName2: '',
      taxName3: '',
      taxRate1: 0,
      taxRate2: 0,
      taxRate3: 0,
      taxAmount1: 0,
      taxAmount2: 0,
      taxAmount3: 0,
      usesInclusiveTaxes: company?.expenseInclusiveTaxes ?? false,
      calculateTaxByAmount: company?.calculateExpenseTaxByAmount ?? false,
      clientId: project?.clientId ?? client?.id,
      vendorId: vendor?.id,
      projectId: project?.id,
      invoiceId: '',
      categoryId: '',
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      isDeleted: false,
      createdAt: 0,
      assignedUserId: user?.id ?? '',
      createdUserId: '',
      archivedAt: 0,
      updatedAt: 0,
    );
  }

  ExpenseEntity._();

  @override
  @memoized
  int get hashCode;

  ExpenseEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..number = ''
    ..isChanged = false
    ..isDeleted = false
    ..invoiceId = null
    ..date = convertDateTimeToSqlDate()
    ..documents.clear()
    ..transactionReference = ''
    ..paymentTypeId = ''
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

  @BuiltValueField(wireName: 'currency_id')
  String get currencyId;

  @BuiltValueField(wireName: 'category_id')
  String get categoryId;

  double get amount;

  @nullable // TODO remove this
  @BuiltValueField(wireName: 'date')
  String get date;

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

  @nullable
  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @BuiltValueField(wireName: 'tax_amount1')
  double get taxAmount1;

  @BuiltValueField(wireName: 'tax_amount2')
  double get taxAmount2;

  @BuiltValueField(wireName: 'tax_amount3')
  double get taxAmount3;

  @BuiltValueField(wireName: 'uses_inclusive_taxes')
  bool get usesInclusiveTaxes;

  @nullable
  @BuiltValueField(wireName: 'calculate_tax_by_amount')
  bool get calculateTaxByAmount;

  BuiltList<DocumentEntity> get documents;

  String get number;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (includeEdit &&
          !multiselect &&
          userCompany.canEditEntity(this) &&
          !multiselect) {
        actions.add(EntityAction.edit);
      }

      if (!isInvoiced && userCompany.canCreate(EntityType.invoice)) {
        actions.add(EntityAction.invoiceExpense);
      }
    }

    if (userCompany.canCreate(EntityType.task) && !multiselect) {
      actions.add(EntityAction.clone);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(
      ExpenseEntity expense,
      String sortField,
      bool sortAscending,
      BuiltMap<String, ClientEntity> clientMap,
      BuiltMap<String, UserEntity> userMap,
      BuiltMap<String, VendorEntity> vendorMap,
      BuiltMap<String, InvoiceEntity> invoiceMap,
      BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
      StaticState staticState) {
    int response = 0;
    final ExpenseEntity expenseA = sortAscending ? this : expense;
    final ExpenseEntity expenseB = sortAscending ? expense : this;

    switch (sortField) {
      case ExpenseFields.netAmount:
        response = expenseA.netAmount.compareTo(expenseB.netAmount);
        break;
      case ExpenseFields.amount:
        response = expenseA.amount.compareTo(expenseB.amount);
        break;
      case EntityFields.assignedTo:
        final userA = userMap[expenseA.assignedUserId] ?? UserEntity();
        final userB = userMap[expenseB.assignedUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdBy:
        final userA = userMap[expenseA.createdUserId] ?? UserEntity();
        final userB = userMap[expenseB.createdUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case ExpenseFields.clientId:
      case ExpenseFields.client:
        final clientA = clientMap[expenseA.clientId] ?? ClientEntity();
        final clientB = clientMap[expenseB.clientId] ?? ClientEntity();
        response = clientA.listDisplayName
            .toLowerCase()
            .compareTo(clientB.listDisplayName.toLowerCase());
        break;
      case ExpenseFields.vendorId:
      case ExpenseFields.vendor:
        final vendorA = vendorMap[expenseA.vendorId] ?? VendorEntity();
        final vendorB = vendorMap[expenseB.vendorId] ?? VendorEntity();
        response = vendorA.listDisplayName
            .toLowerCase()
            .compareTo(vendorB.listDisplayName.toLowerCase());
        break;
      case EntityFields.state:
        final stateA =
            EntityState.valueOf(expenseA.entityState) ?? EntityState.active;
        final stateB =
            EntityState.valueOf(expenseB.entityState) ?? EntityState.active;
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case ExpenseFields.publicNotes:
        response = expenseA.publicNotes
            .toLowerCase()
            .compareTo(expenseB.publicNotes.toLowerCase());
        break;
      case ExpenseFields.expenseDate:
        response =
            expenseA.date.toLowerCase().compareTo(expenseB.date.toLowerCase());
        break;
      case ExpenseFields.paymentDate:
        response = expenseA.paymentDate
            .toLowerCase()
            .compareTo(expenseB.paymentDate.toLowerCase());
        break;
      case EntityFields.createdAt:
        response = expenseA.createdAt.compareTo(expenseB.createdAt);
        break;
      case ExpenseFields.updatedAt:
        response = expenseA.updatedAt.compareTo(expenseB.updatedAt);
        break;
      case ExpenseFields.archivedAt:
        response = expenseA.archivedAt.compareTo(expenseB.archivedAt);
        break;
      case ExpenseFields.documents:
        response =
            expenseA.documents.length.compareTo(expenseB.documents.length);
        break;
      case ExpenseFields.number:
        response = expenseA.number.compareTo(expenseB.number);
        break;
      case ExpenseFields.privateNotes:
        response = expenseA.privateNotes.compareTo(expenseB.privateNotes);
        break;
      case ExpenseFields.transactionId:
        response = expenseA.transactionId.compareTo(expenseB.transactionId);
        break;
      case ExpenseFields.transactionReference:
        response = expenseA.transactionReference
            .compareTo(expenseB.transactionReference);
        break;
      case ExpenseFields.bankId:
        response = expenseA.bankId.compareTo(expenseB.bankId);
        break;
      case ExpenseFields.currencyId:
        final currencyMap = staticState.currencyMap;
        response = currencyMap[expenseA.currencyId]
            .name
            .compareTo(currencyMap[expenseB.currencyId].name);
        break;
      case ExpenseFields.categoryId:
      case ExpenseFields.category:
        response = expenseCategoryMap[expenseA.categoryId]
            .name
            .compareTo(expenseCategoryMap[expenseB.categoryId].name);
        break;
      case ExpenseFields.exchangeRate:
        response = expenseA.exchangeRate.compareTo(expenseB.exchangeRate);
        break;
      case ExpenseFields.invoiceCurrencyId:
        final currencyMap = staticState.currencyMap;
        response = currencyMap[expenseA.invoiceCurrencyId]
            .name
            .compareTo(currencyMap[expenseB.invoiceCurrencyId].name);
        break;
      case ExpenseFields.taxName1:
        response = expenseA.taxName1.compareTo(expenseB.taxName1);
        break;
      case ExpenseFields.taxName2:
        response = expenseA.taxName2.compareTo(expenseB.taxName2);
        break;
      case ExpenseFields.taxRate1:
        response = expenseA.taxRate1.compareTo(expenseB.taxRate1);
        break;
      case ExpenseFields.taxRate2:
        response = expenseA.taxRate2.compareTo(expenseB.taxRate2);
        break;
      case ExpenseFields.invoiceId:
        response = invoiceMap[expenseA.invoiceId]
            .listDisplayName
            .compareTo(invoiceMap[expenseB.invoiceId].listDisplayName);
        break;
      case ExpenseFields.customValue1:
        response = expenseA.customValue1.compareTo(expenseB.customValue1);
        break;
      case ExpenseFields.customValue2:
        response = expenseA.customValue2.compareTo(expenseB.customValue2);
        break;
      case ExpenseFields.customValue3:
        response = expenseA.customValue3.compareTo(expenseB.customValue3);
        break;
      case ExpenseFields.customValue4:
        response = expenseA.customValue4.compareTo(expenseB.customValue4);
        break;
      default:
        print('## ERROR: sort by expense.$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    return matchesStrings(
      haystacks: [
        number,
        publicNotes,
        privateNotes,
        transactionReference,
        taxName1,
        taxName2,
        taxName3,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        number,
        publicNotes,
        privateNotes,
        transactionReference,
        taxName1,
        taxName2,
        taxName3,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
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
      return number ?? '';
    }
  }

  bool isBetween(String startDate, String endDate) {
    return (startDate ?? '').compareTo(date ?? '') <= 0 &&
        (endDate ?? '').compareTo(date ?? '') >= 0;
  }

  bool get isUpcoming => convertSqlDateToDateTime(date).isAfter(DateTime.now());

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  double get calculatetaxRate1 {
    if (calculateTaxByAmount == true) {
      if (usesInclusiveTaxes) {
        return taxAmount1 / (amount - taxAmount1) * 100;
      } else {
        return taxAmount1 / amount * 100;
      }
    } else {
      return taxRate1;
    }
  }

  double get calculatetaxRate2 => calculateTaxByAmount == true
      ? taxAmount2 / (amount - taxAmount2) * 100
      : taxRate2;

  double get calculatetaxRate3 => calculateTaxByAmount == true
      ? taxAmount3 / (amount - taxAmount3) * 100
      : taxRate3;

  double get taxAmount {
    var total = 0.0;

    if (calculateTaxByAmount == true) {
      total += taxAmount1 + taxAmount2 + taxAmount3;
    } else {
      if (usesInclusiveTaxes) {
        if (taxRate1 != 0) {
          total += amount - (amount / (1 + (taxRate1 / 100)));
        }
        if (taxRate2 != 0) {
          total += amount - (amount / (1 + (taxRate2 / 100)));
        }
        if (taxRate3 != 0) {
          total += amount - (amount / (1 + (taxRate3 / 100)));
        }
      } else {
        if (taxRate1 != 0) {
          total += amount * taxRate1 / 100;
        }
        if (taxRate2 != 0) {
          total += amount * taxRate2 / 100;
        }
        if (taxRate3 != 0) {
          total += amount * taxRate3 / 100;
        }
      }
    }

    return total;
  }

  double get netAmount => usesInclusiveTaxes ? amount - taxAmount : amount;

  double get grossAmount => usesInclusiveTaxes ? amount : amount + taxAmount;

  String get statusId {
    if (isInvoiced) {
      return kExpenseStatusInvoiced;
    } else if (shouldBeInvoiced) {
      return kExpenseStatusPending;
    } else {
      return kExpenseStatusLogged;
    }
  }

  double get convertedExchangeRate => exchangeRate == 0 ? 1 : exchangeRate;

  double get convertedAmount => grossAmount * convertedExchangeRate;

  double get convertedNetAmount => netAmount * convertedExchangeRate;

  double get convertedAmountWithTax =>
      round(grossAmount * convertedExchangeRate, 2);

  bool get isInvoiced => invoiceId != null && invoiceId.isNotEmpty;

  bool get isPending => !isInvoiced && shouldBeInvoiced;

  bool get isConverted => exchangeRate != 1 && exchangeRate != 0;

  bool get hasExchangeRate => exchangeRate != 1 && exchangeRate != 0;

  static Serializer<ExpenseEntity> get serializer => _$expenseEntitySerializer;
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
  @memoized
  int get hashCode;

  @override
  String get listDisplayName => name;

  static Serializer<ExpenseStatusEntity> get serializer =>
      _$expenseStatusEntitySerializer;
}
