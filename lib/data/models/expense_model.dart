// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/recurring_expense_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
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
  static const String currency = 'currency';
  static const String currencyId = 'currency_id';
  static const String categoryId = 'category_id';
  static const String category = 'category';
  static const String project = 'project';
  static const String netAmount = 'net_amount';
  static const String convertedAmount = 'converted_amount';
  static const String amount = 'amount';
  static const String taxAmount = 'tax_amount';
  static const String expenseDate = 'date';
  static const String paymentDate = 'payment_date';
  static const String paymentType = 'payment_type';
  static const String exchangeRate = 'exchange_rate';
  static const String invoiceCurrency = 'invoice_currency';
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
  static const String recurringExpense = 'recurring_expense';
}

abstract class ExpenseEntity extends Object
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<ExpenseEntity, ExpenseEntityBuilder> {
  factory ExpenseEntity({
    String? id,
    AppState? state,
    VendorEntity? vendor,
    ClientEntity? client,
    UserEntity? user,
    ProjectEntity? project,
    EntityType? entityType,
  }) {
    final company = state?.company;
    return _$ExpenseEntity._(
      id: id ?? BaseEntity.nextId,
      entityType: entityType ?? EntityType.expense,
      number: '',
      isChanged: false,
      privateNotes: '',
      publicNotes: '',
      shouldBeInvoiced: company?.markExpensesInvoiceable ?? false,
      invoiceDocuments: company?.invoiceExpenseDocuments ?? false,
      transactionId: '',
      transactionReference: '',
      recurringExpenseId: '',
      bankId: '',
      amount: 0,
      date: convertDateTimeToSqlDate(),
      paymentDate: (company?.markExpensesPaid ?? false)
          ? convertDateTimeToSqlDate()
          : '',
      paymentTypeId: company?.settings.defaultExpensePaymentTypeId ?? '',
      exchangeRate: 1,
      currencyId: (vendor != null && vendor.hasCurrency)
          ? vendor.currencyId
          : (state?.company.currencyId ?? kDefaultCurrencyId),
      invoiceCurrencyId: (client != null && client.hasCurrency)
          ? client.settings.currencyId! // TODO handle group currency
          : (state?.company.currencyId ?? kDefaultCurrencyId),
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
      frequencyId: kFrequencyMonthly,
      lastSentDate: '',
      nextSendDate: convertDateTimeToSqlDate(),
      remainingCycles: -1,
      recurringDates: BuiltList<ExpenseScheduleEntity>(),
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
    ..transactionId = ''
    ..paymentTypeId = ''
    ..paymentDate = '');

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

  // TODO remove this
  @BuiltValueField(wireName: 'date')
  String? get date;

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

  @override
  @BuiltValueField(wireName: 'client_id')
  String? get clientId;

  @BuiltValueField(wireName: 'invoice_id')
  String? get invoiceId;

  @BuiltValueField(wireName: 'vendor_id')
  String? get vendorId;

  @BuiltValueField(wireName: 'project_id')
  String? get projectId;

  @BuiltValueField(wireName: 'status_id')
  String? get statusId;

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

  @BuiltValueField(wireName: 'calculate_tax_by_amount')
  bool? get calculateTaxByAmount;

  BuiltList<DocumentEntity> get documents;

  String get number;

  // TODO remove this
  @BuiltValueField(wireName: 'recurring_expense_id')
  String get recurringExpenseId;

  @BuiltValueField(wireName: 'frequency_id')
  String get frequencyId;

  @BuiltValueField(wireName: 'last_sent_date')
  String get lastSentDate;

  @BuiltValueField(wireName: 'next_send_date')
  String get nextSendDate;

  @BuiltValueField(wireName: 'remaining_cycles')
  int get remainingCycles;

  @BuiltValueField(wireName: 'recurring_dates')
  BuiltList<ExpenseScheduleEntity>? get recurringDates;

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted!) {
      if (includeEdit &&
          !multiselect &&
          userCompany!.canEditEntity(this) &&
          !multiselect) {
        actions.add(EntityAction.edit);
      }

      if (isRecurring) {
        if (canBeStarted) {
          actions.add(EntityAction.start);
        } else if (canBeStopped) {
          actions.add(EntityAction.stop);
        }
      }

      if (!isInvoiced &&
          !isRecurring &&
          shouldBeInvoiced &&
          userCompany!.canCreate(EntityType.invoice)) {
        actions.add(EntityAction.invoiceExpense);
        if ((clientId ?? '').isNotEmpty) {
          actions.add(EntityAction.addToInvoice);
        }
      }
    }

    if (!multiselect && isOld) {
      if (userCompany!.canCreate(EntityType.expense) && !isRecurring) {
        actions.add(EntityAction.cloneToExpense);
      }

      if (userCompany.canCreate(EntityType.recurringExpense)) {
        actions.add(EntityAction.cloneToRecurring);
      }

      if (userCompany.canCreate(EntityType.expense) && isRecurring) {
        actions.add(EntityAction.cloneToExpense);
      }
    }

    if (!isDeleted! && multiselect) {
      actions.add(EntityAction.documents);
    }

    final superActions = super.getActions(userCompany: userCompany);

    if (actions.isNotEmpty && superActions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(superActions);
  }

  int compareTo(
      ExpenseEntity? expense,
      String sortField,
      bool sortAscending,
      BuiltMap<String, ClientEntity> clientMap,
      BuiltMap<String, UserEntity> userMap,
      BuiltMap<String, VendorEntity> vendorMap,
      BuiltMap<String, InvoiceEntity> invoiceMap,
      BuiltMap<String, ExpenseCategoryEntity> expenseCategoryMap,
      StaticState staticState) {
    int response = 0;
    final ExpenseEntity? expenseA = sortAscending ? this : expense;
    final ExpenseEntity? expenseB = sortAscending ? expense : this;

    switch (sortField) {
      case ExpenseFields.netAmount:
        response = expenseA!.netAmount.compareTo(expenseB!.netAmount);
        break;
      case ExpenseFields.amount:
        response = expenseA!.amount.compareTo(expenseB!.amount);
        break;
      case EntityFields.assignedTo:
        final userA = userMap[expenseA!.assignedUserId] ?? UserEntity();
        final userB = userMap[expenseB!.assignedUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdBy:
        final userA = userMap[expenseA!.createdUserId] ?? UserEntity();
        final userB = userMap[expenseB!.createdUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case ExpenseFields.clientId:
      case ExpenseFields.client:
        final clientA = clientMap[expenseA!.clientId] ?? ClientEntity();
        final clientB = clientMap[expenseB!.clientId] ?? ClientEntity();
        response = removeDiacritics(clientA.listDisplayName)
            .toLowerCase()
            .compareTo(removeDiacritics(clientB.listDisplayName).toLowerCase());
        break;
      case ExpenseFields.vendorId:
      case ExpenseFields.vendor:
        final vendorA = vendorMap[expenseA!.vendorId] ?? VendorEntity();
        final vendorB = vendorMap[expenseB!.vendorId] ?? VendorEntity();
        response = removeDiacritics(vendorA.listDisplayName)
            .toLowerCase()
            .compareTo(removeDiacritics(vendorB.listDisplayName).toLowerCase());
        break;
      case EntityFields.state:
        final stateA = EntityState.valueOf(expenseA!.entityState);
        final stateB = EntityState.valueOf(expenseB!.entityState);
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case ExpenseFields.publicNotes:
        response = expenseA!.publicNotes
            .toLowerCase()
            .compareTo(expenseB!.publicNotes.toLowerCase());
        break;
      case ExpenseFields.expenseDate:
        response = expenseA!.date!
            .toLowerCase()
            .compareTo(expenseB!.date!.toLowerCase());
        break;
      case ExpenseFields.paymentDate:
        response = expenseA!.paymentDate
            .toLowerCase()
            .compareTo(expenseB!.paymentDate.toLowerCase());
        break;
      case EntityFields.createdAt:
        response = expenseA!.createdAt.compareTo(expenseB!.createdAt);
        break;
      case ExpenseFields.updatedAt:
        response = expenseA!.updatedAt.compareTo(expenseB!.updatedAt);
        break;
      case ExpenseFields.archivedAt:
        response = expenseA!.archivedAt.compareTo(expenseB!.archivedAt);
        break;
      case ExpenseFields.documents:
        response =
            expenseA!.documents.length.compareTo(expenseB!.documents.length);
        break;
      case ExpenseFields.number:
        response = compareNatural(expenseA!.number, expenseB!.number);
        break;
      case ExpenseFields.privateNotes:
        response = expenseA!.privateNotes.compareTo(expenseB!.privateNotes);
        break;
      case ExpenseFields.transactionId:
        response = expenseA!.transactionId.compareTo(expenseB!.transactionId);
        break;
      case ExpenseFields.transactionReference:
        response = expenseA!.transactionReference
            .compareTo(expenseB!.transactionReference);
        break;
      case ExpenseFields.bankId:
        response = expenseA!.bankId.compareTo(expenseB!.bankId);
        break;
      case ExpenseFields.currencyId:
        final currencyMap = staticState.currencyMap;
        final currencyA = currencyMap[expenseA!.currencyId] ?? CurrencyEntity();
        final currencyB = currencyMap[expenseB!.currencyId] ?? CurrencyEntity();
        response = currencyA.name
            .toLowerCase()
            .compareTo(currencyB.name.toLowerCase());
        break;
      case ExpenseFields.categoryId:
      case ExpenseFields.category:
        final categoryA =
            expenseCategoryMap[expenseA!.categoryId] ?? ExpenseCategoryEntity();
        final categoryB =
            expenseCategoryMap[expenseB!.categoryId] ?? ExpenseCategoryEntity();
        response = categoryA.name
            .toLowerCase()
            .compareTo(categoryB.name.toLowerCase());
        break;
      case ExpenseFields.exchangeRate:
        response = expenseA!.exchangeRate.compareTo(expenseB!.exchangeRate);
        break;
      case ExpenseFields.invoiceCurrencyId:
        final currencyMap = staticState.currencyMap;
        final currencyA =
            currencyMap[expenseA!.invoiceCurrencyId] ?? CurrencyEntity();
        final currencyB =
            currencyMap[expenseB!.invoiceCurrencyId] ?? CurrencyEntity();
        response = currencyA.name
            .toLowerCase()
            .compareTo(currencyB.name.toLowerCase());
        break;
      case ExpenseFields.taxName1:
        response = expenseA!.taxName1.compareTo(expenseB!.taxName1);
        break;
      case ExpenseFields.taxName2:
        response = expenseA!.taxName2.compareTo(expenseB!.taxName2);
        break;
      case ExpenseFields.taxRate1:
        response = expenseA!.taxRate1.compareTo(expenseB!.taxRate1);
        break;
      case ExpenseFields.taxRate2:
        response = expenseA!.taxRate2.compareTo(expenseB!.taxRate2);
        break;
      case ExpenseFields.invoiceId:
        final invoiceA = invoiceMap[expenseA!.invoiceId] ?? InvoiceEntity();
        final invoiceB = invoiceMap[expenseB!.invoiceId] ?? InvoiceEntity();
        response = invoiceA.listDisplayName.compareTo(invoiceB.listDisplayName);
        break;
      case ExpenseFields.customValue1:
        response = expenseA!.customValue1.compareTo(expenseB!.customValue1);
        break;
      case ExpenseFields.customValue2:
        response = expenseA!.customValue2.compareTo(expenseB!.customValue2);
        break;
      case ExpenseFields.customValue3:
        response = expenseA!.customValue3.compareTo(expenseB!.customValue3);
        break;
      case ExpenseFields.customValue4:
        response = expenseA!.customValue4.compareTo(expenseB!.customValue4);
        break;
      case RecurringExpenseFields.frequency:
        response = expenseA!.frequencyId.compareTo(expenseB!.frequencyId);
        break;
      case RecurringExpenseFields.nextSendDate:
        response = expenseA!.nextSendDate.compareTo(expenseB!.nextSendDate);
        break;
      case RecurringExpenseFields.lastSentDate:
        response = expenseA!.lastSentDate.compareTo(expenseB!.lastSentDate);
        break;
      case ExpenseFields.status:
        response = expenseA!.calculatedStatusId!
            .compareTo(expenseB!.calculatedStatusId!);
        break;
      default:
        print('## ERROR: sort by expense.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      response = expense!.number.toLowerCase().compareTo(number.toLowerCase());
    }

    return response;
  }

  @override
  bool matchesFilter(String? filter) {
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
        formatNumber(amount, navigatorKey.currentContext),
        formatDate(date, navigatorKey.currentContext)
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
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
        formatNumber(amount, navigatorKey.currentContext),
        formatDate(date, navigatorKey.currentContext)
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
      if (isRecurring) {
        if (status.id == statusId || status.id == calculatedStatusId) {
          // Handle pending recurring invoices which are active
          if (isRecurring &&
              status.id == kRecurringExpenseStatusActive &&
              statusId == kRecurringExpenseStatusActive &&
              calculatedStatusId == kRecurringExpenseStatusPending) {
            // skip
          } else {
            return true;
          }
        }
      } else if (status.id == kExpenseStatusInvoiced && isInvoiced) {
        return true;
      } else if (status.id == kExpenseStatusPending && isPending) {
        return true;
      } else if (status.id == kExpenseStatusLogged &&
          !isInvoiced &&
          !isPending) {
        return true;
      } else if (status.id == kExpenseStatusUnpaid && paymentDate.isEmpty) {
        return true;
      } else if (status.id == kExpenseStatusPaid && paymentDate.isNotEmpty) {
        return true;
      }
    }

    return false;
  }

  @override
  String get listDisplayName => number;

  @BuiltValueField(compare: false)
  int? get loadedAt;

  bool get isPaid =>
      paymentDate.isNotEmpty ||
      paymentTypeId.isNotEmpty ||
      transactionReference.isNotEmpty;

  bool isBetween(String? startDate, String? endDate) {
    return (startDate ?? '').compareTo(date ?? '') <= 0 &&
        (endDate ?? '').compareTo(date ?? '') >= 0;
  }

  bool get isLoaded => loadedAt != null && loadedAt! > 0;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - loadedAt! >
        kMillisecondsToRefreshActivities;
  }

  bool get isUpcoming => convertSqlDateToDateTime(date).isAfter(DateTime.now());

  bool get isRecurring => [EntityType.recurringExpense].contains(entityType);

  bool get isRunning =>
      isRecurring && calculatedStatusId == kRecurringExpenseStatusActive;

  bool get canBeStarted =>
      isRecurring &&
      ([kRecurringExpenseStatusDraft, kRecurringExpenseStatusPaused]
              .contains(calculatedStatusId) ||
          statusId == null);

  bool get canBeStopped =>
      isRecurring &&
      [kRecurringExpenseStatusPending, kRecurringExpenseStatusActive]
          .contains(calculatedStatusId);

  @override
  double? get listDisplayAmount => null;

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

  double get calculatetaxRate2 {
    if (calculateTaxByAmount == true) {
      if (usesInclusiveTaxes) {
        return taxAmount2 / (amount - taxAmount2) * 100;
      } else {
        return taxAmount2 / amount * 100;
      }
    } else {
      return taxRate2;
    }
  }

  double get calculatetaxRate3 {
    if (calculateTaxByAmount == true) {
      if (usesInclusiveTaxes) {
        return taxAmount3 / (amount - taxAmount3) * 100;
      } else {
        return taxAmount3 / amount * 100;
      }
    } else {
      return taxRate3;
    }
  }

  double get taxAmount =>
      calculateTaxAmount1 + calculateTaxAmount2 + calculateTaxAmount3;

  double get calculateTaxAmount1 {
    if (calculateTaxByAmount == true) {
      return taxAmount1;
    }

    if (usesInclusiveTaxes) {
      if (taxRate1 != 0) {
        return round(amount - (amount / (1 + (taxRate1 / 100))), 2);
      }
    } else {
      if (taxRate1 != 0) {
        return round(amount * taxRate1 / 100, 2);
      }
    }

    return 0;
  }

  double get calculateTaxAmount2 {
    if (calculateTaxByAmount == true) {
      return taxAmount2;
    }

    if (usesInclusiveTaxes) {
      if (taxRate2 != 0) {
        return round(amount - (amount / (1 + (taxRate2 / 100))), 2);
      }
    } else {
      if (taxRate2 != 0) {
        return round(amount * taxRate2 / 100, 2);
      }
    }

    return 0;
  }

  double get calculateTaxAmount3 {
    if (calculateTaxByAmount == true) {
      return taxAmount3;
    }

    if (usesInclusiveTaxes) {
      if (taxRate3 != 0) {
        return round(amount - (amount / (1 + (taxRate3 / 100))), 2);
      }
    } else {
      if (taxRate3 != 0) {
        return round(amount * taxRate3 / 100, 2);
      }
    }

    return 0;
  }

  double get netAmount => usesInclusiveTaxes ? amount - taxAmount : amount;

  double get grossAmount => usesInclusiveTaxes ? amount : amount + taxAmount;

  String? get calculatedStatusId {
    if (isRecurring) {
      if (remainingCycles == 0) {
        return kRecurringInvoiceStatusCompleted;
      } else if (isPending) {
        return kRecurringExpenseStatusPending;
      } else {
        return statusId;
      }
    } else {
      if (isInvoiced) {
        return kExpenseStatusInvoiced;
      } else if (shouldBeInvoiced) {
        return kExpenseStatusPending;
      } else if (isPaid) {
        return kExpenseStatusPaid;
      } else {
        return kExpenseStatusLogged;
      }
    }
  }

  double get convertedExchangeRate => exchangeRate == 0 ? 1 : exchangeRate;

  double get convertedAmount => grossAmount * convertedExchangeRate;

  double get convertedNetAmount => netAmount * convertedExchangeRate;

  double get convertedAmountWithTax =>
      round(grossAmount * convertedExchangeRate, 2);

  bool get isInvoiced => invoiceId != null && invoiceId!.isNotEmpty;

  bool get isPending {
    if (isRecurring) {
      return statusId == kRecurringExpenseStatusActive && lastSentDate.isEmpty;
    } else {
      return !isInvoiced && shouldBeInvoiced;
    }
  }

  bool get isConverted => exchangeRate != 1 && exchangeRate != 0;

  bool get hasExchangeRate => exchangeRate != 1 && exchangeRate != 0;

  // ignore: unused_element
  static void _initializeBuilder(ExpenseEntityBuilder builder) => builder
    ..entityType = EntityType.expense
    ..frequencyId = ''
    ..lastSentDate = ''
    ..nextSendDate = ''
    ..recurringExpenseId = ''
    ..remainingCycles = -1;

  static Serializer<ExpenseEntity> get serializer => _$expenseEntitySerializer;
}

abstract class ExpenseScheduleEntity
    implements Built<ExpenseScheduleEntity, ExpenseScheduleEntityBuilder> {
  factory ExpenseScheduleEntity() {
    return _$ExpenseScheduleEntity._(
      sendDate: '',
    );
  }

  ExpenseScheduleEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'send_date')
  String get sendDate;

  static Serializer<ExpenseScheduleEntity> get serializer =>
      _$expenseScheduleEntitySerializer;
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
