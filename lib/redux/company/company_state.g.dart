// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserCompanyState> _$userCompanyStateSerializer =
    new _$UserCompanyStateSerializer();

class _$UserCompanyStateSerializer
    implements StructuredSerializer<UserCompanyState> {
  @override
  final Iterable<Type> types = const [UserCompanyState, _$UserCompanyState];
  @override
  final String wireName = 'UserCompanyState';

  @override
  Iterable<Object?> serialize(Serializers serializers, UserCompanyState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'lastUpdated',
      serializers.serialize(object.lastUpdated,
          specifiedType: const FullType(int)),
      'userCompany',
      serializers.serialize(object.userCompany,
          specifiedType: const FullType(UserCompanyEntity)),
      'documentState',
      serializers.serialize(object.documentState,
          specifiedType: const FullType(DocumentState)),
      'productState',
      serializers.serialize(object.productState,
          specifiedType: const FullType(ProductState)),
      'clientState',
      serializers.serialize(object.clientState,
          specifiedType: const FullType(ClientState)),
      'invoiceState',
      serializers.serialize(object.invoiceState,
          specifiedType: const FullType(InvoiceState)),
      'expenseState',
      serializers.serialize(object.expenseState,
          specifiedType: const FullType(ExpenseState)),
      'vendorState',
      serializers.serialize(object.vendorState,
          specifiedType: const FullType(VendorState)),
      'taskState',
      serializers.serialize(object.taskState,
          specifiedType: const FullType(TaskState)),
      'projectState',
      serializers.serialize(object.projectState,
          specifiedType: const FullType(ProjectState)),
      'paymentState',
      serializers.serialize(object.paymentState,
          specifiedType: const FullType(PaymentState)),
      'quoteState',
      serializers.serialize(object.quoteState,
          specifiedType: const FullType(QuoteState)),
      'scheduleState',
      serializers.serialize(object.scheduleState,
          specifiedType: const FullType(ScheduleState)),
      'transactionRuleState',
      serializers.serialize(object.transactionRuleState,
          specifiedType: const FullType(TransactionRuleState)),
      'transactionState',
      serializers.serialize(object.transactionState,
          specifiedType: const FullType(TransactionState)),
      'bankAccountState',
      serializers.serialize(object.bankAccountState,
          specifiedType: const FullType(BankAccountState)),
      'purchaseOrderState',
      serializers.serialize(object.purchaseOrderState,
          specifiedType: const FullType(PurchaseOrderState)),
      'recurringExpenseState',
      serializers.serialize(object.recurringExpenseState,
          specifiedType: const FullType(RecurringExpenseState)),
      'subscriptionState',
      serializers.serialize(object.subscriptionState,
          specifiedType: const FullType(SubscriptionState)),
      'taskStatusState',
      serializers.serialize(object.taskStatusState,
          specifiedType: const FullType(TaskStatusState)),
      'expenseCategoryState',
      serializers.serialize(object.expenseCategoryState,
          specifiedType: const FullType(ExpenseCategoryState)),
      'recurringInvoiceState',
      serializers.serialize(object.recurringInvoiceState,
          specifiedType: const FullType(RecurringInvoiceState)),
      'webhookState',
      serializers.serialize(object.webhookState,
          specifiedType: const FullType(WebhookState)),
      'tokenState',
      serializers.serialize(object.tokenState,
          specifiedType: const FullType(TokenState)),
      'paymentTermState',
      serializers.serialize(object.paymentTermState,
          specifiedType: const FullType(PaymentTermState)),
      'designState',
      serializers.serialize(object.designState,
          specifiedType: const FullType(DesignState)),
      'creditState',
      serializers.serialize(object.creditState,
          specifiedType: const FullType(CreditState)),
      'userState',
      serializers.serialize(object.userState,
          specifiedType: const FullType(UserState)),
      'taxRateState',
      serializers.serialize(object.taxRateState,
          specifiedType: const FullType(TaxRateState)),
      'companyGatewayState',
      serializers.serialize(object.companyGatewayState,
          specifiedType: const FullType(CompanyGatewayState)),
      'groupState',
      serializers.serialize(object.groupState,
          specifiedType: const FullType(GroupState)),
    ];

    return result;
  }

  @override
  UserCompanyState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserCompanyStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'lastUpdated':
          result.lastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'userCompany':
          result.userCompany.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyEntity))!
              as UserCompanyEntity);
          break;
        case 'documentState':
          result.documentState.replace(serializers.deserialize(value,
              specifiedType: const FullType(DocumentState))! as DocumentState);
          break;
        case 'productState':
          result.productState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProductState))! as ProductState);
          break;
        case 'clientState':
          result.clientState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientState))! as ClientState);
          break;
        case 'invoiceState':
          result.invoiceState.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceState))! as InvoiceState);
          break;
        case 'expenseState':
          result.expenseState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ExpenseState))! as ExpenseState);
          break;
        case 'vendorState':
          result.vendorState.replace(serializers.deserialize(value,
              specifiedType: const FullType(VendorState))! as VendorState);
          break;
        case 'taskState':
          result.taskState.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaskState))! as TaskState);
          break;
        case 'projectState':
          result.projectState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProjectState))! as ProjectState);
          break;
        case 'paymentState':
          result.paymentState.replace(serializers.deserialize(value,
              specifiedType: const FullType(PaymentState))! as PaymentState);
          break;
        case 'quoteState':
          result.quoteState.replace(serializers.deserialize(value,
              specifiedType: const FullType(QuoteState))! as QuoteState);
          break;
        case 'scheduleState':
          result.scheduleState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ScheduleState))! as ScheduleState);
          break;
        case 'transactionRuleState':
          result.transactionRuleState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TransactionRuleState))!
              as TransactionRuleState);
          break;
        case 'transactionState':
          result.transactionState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TransactionState))!
              as TransactionState);
          break;
        case 'bankAccountState':
          result.bankAccountState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BankAccountState))!
              as BankAccountState);
          break;
        case 'purchaseOrderState':
          result.purchaseOrderState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PurchaseOrderState))!
              as PurchaseOrderState);
          break;
        case 'recurringExpenseState':
          result.recurringExpenseState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(RecurringExpenseState))!
              as RecurringExpenseState);
          break;
        case 'subscriptionState':
          result.subscriptionState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SubscriptionState))!
              as SubscriptionState);
          break;
        case 'taskStatusState':
          result.taskStatusState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TaskStatusState))!
              as TaskStatusState);
          break;
        case 'expenseCategoryState':
          result.expenseCategoryState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ExpenseCategoryState))!
              as ExpenseCategoryState);
          break;
        case 'recurringInvoiceState':
          result.recurringInvoiceState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(RecurringInvoiceState))!
              as RecurringInvoiceState);
          break;
        case 'webhookState':
          result.webhookState.replace(serializers.deserialize(value,
              specifiedType: const FullType(WebhookState))! as WebhookState);
          break;
        case 'tokenState':
          result.tokenState.replace(serializers.deserialize(value,
              specifiedType: const FullType(TokenState))! as TokenState);
          break;
        case 'paymentTermState':
          result.paymentTermState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PaymentTermState))!
              as PaymentTermState);
          break;
        case 'designState':
          result.designState.replace(serializers.deserialize(value,
              specifiedType: const FullType(DesignState))! as DesignState);
          break;
        case 'creditState':
          result.creditState.replace(serializers.deserialize(value,
              specifiedType: const FullType(CreditState))! as CreditState);
          break;
        case 'userState':
          result.userState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserState))! as UserState);
          break;
        case 'taxRateState':
          result.taxRateState.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaxRateState))! as TaxRateState);
          break;
        case 'companyGatewayState':
          result.companyGatewayState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CompanyGatewayState))!
              as CompanyGatewayState);
          break;
        case 'groupState':
          result.groupState.replace(serializers.deserialize(value,
              specifiedType: const FullType(GroupState))! as GroupState);
          break;
      }
    }

    return result.build();
  }
}

class _$UserCompanyState extends UserCompanyState {
  @override
  final int lastUpdated;
  @override
  final UserCompanyEntity userCompany;
  @override
  final DocumentState documentState;
  @override
  final ProductState productState;
  @override
  final ClientState clientState;
  @override
  final InvoiceState invoiceState;
  @override
  final ExpenseState expenseState;
  @override
  final VendorState vendorState;
  @override
  final TaskState taskState;
  @override
  final ProjectState projectState;
  @override
  final PaymentState paymentState;
  @override
  final QuoteState quoteState;
  @override
  final ScheduleState scheduleState;
  @override
  final TransactionRuleState transactionRuleState;
  @override
  final TransactionState transactionState;
  @override
  final BankAccountState bankAccountState;
  @override
  final PurchaseOrderState purchaseOrderState;
  @override
  final RecurringExpenseState recurringExpenseState;
  @override
  final SubscriptionState subscriptionState;
  @override
  final TaskStatusState taskStatusState;
  @override
  final ExpenseCategoryState expenseCategoryState;
  @override
  final RecurringInvoiceState recurringInvoiceState;
  @override
  final WebhookState webhookState;
  @override
  final TokenState tokenState;
  @override
  final PaymentTermState paymentTermState;
  @override
  final DesignState designState;
  @override
  final CreditState creditState;
  @override
  final UserState userState;
  @override
  final TaxRateState taxRateState;
  @override
  final CompanyGatewayState companyGatewayState;
  @override
  final GroupState groupState;

  factory _$UserCompanyState(
          [void Function(UserCompanyStateBuilder)? updates]) =>
      (new UserCompanyStateBuilder()..update(updates))._build();

  _$UserCompanyState._(
      {required this.lastUpdated,
      required this.userCompany,
      required this.documentState,
      required this.productState,
      required this.clientState,
      required this.invoiceState,
      required this.expenseState,
      required this.vendorState,
      required this.taskState,
      required this.projectState,
      required this.paymentState,
      required this.quoteState,
      required this.scheduleState,
      required this.transactionRuleState,
      required this.transactionState,
      required this.bankAccountState,
      required this.purchaseOrderState,
      required this.recurringExpenseState,
      required this.subscriptionState,
      required this.taskStatusState,
      required this.expenseCategoryState,
      required this.recurringInvoiceState,
      required this.webhookState,
      required this.tokenState,
      required this.paymentTermState,
      required this.designState,
      required this.creditState,
      required this.userState,
      required this.taxRateState,
      required this.companyGatewayState,
      required this.groupState})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        lastUpdated, r'UserCompanyState', 'lastUpdated');
    BuiltValueNullFieldError.checkNotNull(
        userCompany, r'UserCompanyState', 'userCompany');
    BuiltValueNullFieldError.checkNotNull(
        documentState, r'UserCompanyState', 'documentState');
    BuiltValueNullFieldError.checkNotNull(
        productState, r'UserCompanyState', 'productState');
    BuiltValueNullFieldError.checkNotNull(
        clientState, r'UserCompanyState', 'clientState');
    BuiltValueNullFieldError.checkNotNull(
        invoiceState, r'UserCompanyState', 'invoiceState');
    BuiltValueNullFieldError.checkNotNull(
        expenseState, r'UserCompanyState', 'expenseState');
    BuiltValueNullFieldError.checkNotNull(
        vendorState, r'UserCompanyState', 'vendorState');
    BuiltValueNullFieldError.checkNotNull(
        taskState, r'UserCompanyState', 'taskState');
    BuiltValueNullFieldError.checkNotNull(
        projectState, r'UserCompanyState', 'projectState');
    BuiltValueNullFieldError.checkNotNull(
        paymentState, r'UserCompanyState', 'paymentState');
    BuiltValueNullFieldError.checkNotNull(
        quoteState, r'UserCompanyState', 'quoteState');
    BuiltValueNullFieldError.checkNotNull(
        scheduleState, r'UserCompanyState', 'scheduleState');
    BuiltValueNullFieldError.checkNotNull(
        transactionRuleState, r'UserCompanyState', 'transactionRuleState');
    BuiltValueNullFieldError.checkNotNull(
        transactionState, r'UserCompanyState', 'transactionState');
    BuiltValueNullFieldError.checkNotNull(
        bankAccountState, r'UserCompanyState', 'bankAccountState');
    BuiltValueNullFieldError.checkNotNull(
        purchaseOrderState, r'UserCompanyState', 'purchaseOrderState');
    BuiltValueNullFieldError.checkNotNull(
        recurringExpenseState, r'UserCompanyState', 'recurringExpenseState');
    BuiltValueNullFieldError.checkNotNull(
        subscriptionState, r'UserCompanyState', 'subscriptionState');
    BuiltValueNullFieldError.checkNotNull(
        taskStatusState, r'UserCompanyState', 'taskStatusState');
    BuiltValueNullFieldError.checkNotNull(
        expenseCategoryState, r'UserCompanyState', 'expenseCategoryState');
    BuiltValueNullFieldError.checkNotNull(
        recurringInvoiceState, r'UserCompanyState', 'recurringInvoiceState');
    BuiltValueNullFieldError.checkNotNull(
        webhookState, r'UserCompanyState', 'webhookState');
    BuiltValueNullFieldError.checkNotNull(
        tokenState, r'UserCompanyState', 'tokenState');
    BuiltValueNullFieldError.checkNotNull(
        paymentTermState, r'UserCompanyState', 'paymentTermState');
    BuiltValueNullFieldError.checkNotNull(
        designState, r'UserCompanyState', 'designState');
    BuiltValueNullFieldError.checkNotNull(
        creditState, r'UserCompanyState', 'creditState');
    BuiltValueNullFieldError.checkNotNull(
        userState, r'UserCompanyState', 'userState');
    BuiltValueNullFieldError.checkNotNull(
        taxRateState, r'UserCompanyState', 'taxRateState');
    BuiltValueNullFieldError.checkNotNull(
        companyGatewayState, r'UserCompanyState', 'companyGatewayState');
    BuiltValueNullFieldError.checkNotNull(
        groupState, r'UserCompanyState', 'groupState');
  }

  @override
  UserCompanyState rebuild(void Function(UserCompanyStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserCompanyStateBuilder toBuilder() =>
      new UserCompanyStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserCompanyState &&
        lastUpdated == other.lastUpdated &&
        userCompany == other.userCompany &&
        documentState == other.documentState &&
        productState == other.productState &&
        clientState == other.clientState &&
        invoiceState == other.invoiceState &&
        expenseState == other.expenseState &&
        vendorState == other.vendorState &&
        taskState == other.taskState &&
        projectState == other.projectState &&
        paymentState == other.paymentState &&
        quoteState == other.quoteState &&
        scheduleState == other.scheduleState &&
        transactionRuleState == other.transactionRuleState &&
        transactionState == other.transactionState &&
        bankAccountState == other.bankAccountState &&
        purchaseOrderState == other.purchaseOrderState &&
        recurringExpenseState == other.recurringExpenseState &&
        subscriptionState == other.subscriptionState &&
        taskStatusState == other.taskStatusState &&
        expenseCategoryState == other.expenseCategoryState &&
        recurringInvoiceState == other.recurringInvoiceState &&
        webhookState == other.webhookState &&
        tokenState == other.tokenState &&
        paymentTermState == other.paymentTermState &&
        designState == other.designState &&
        creditState == other.creditState &&
        userState == other.userState &&
        taxRateState == other.taxRateState &&
        companyGatewayState == other.companyGatewayState &&
        groupState == other.groupState;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, lastUpdated.hashCode);
    _$hash = $jc(_$hash, userCompany.hashCode);
    _$hash = $jc(_$hash, documentState.hashCode);
    _$hash = $jc(_$hash, productState.hashCode);
    _$hash = $jc(_$hash, clientState.hashCode);
    _$hash = $jc(_$hash, invoiceState.hashCode);
    _$hash = $jc(_$hash, expenseState.hashCode);
    _$hash = $jc(_$hash, vendorState.hashCode);
    _$hash = $jc(_$hash, taskState.hashCode);
    _$hash = $jc(_$hash, projectState.hashCode);
    _$hash = $jc(_$hash, paymentState.hashCode);
    _$hash = $jc(_$hash, quoteState.hashCode);
    _$hash = $jc(_$hash, scheduleState.hashCode);
    _$hash = $jc(_$hash, transactionRuleState.hashCode);
    _$hash = $jc(_$hash, transactionState.hashCode);
    _$hash = $jc(_$hash, bankAccountState.hashCode);
    _$hash = $jc(_$hash, purchaseOrderState.hashCode);
    _$hash = $jc(_$hash, recurringExpenseState.hashCode);
    _$hash = $jc(_$hash, subscriptionState.hashCode);
    _$hash = $jc(_$hash, taskStatusState.hashCode);
    _$hash = $jc(_$hash, expenseCategoryState.hashCode);
    _$hash = $jc(_$hash, recurringInvoiceState.hashCode);
    _$hash = $jc(_$hash, webhookState.hashCode);
    _$hash = $jc(_$hash, tokenState.hashCode);
    _$hash = $jc(_$hash, paymentTermState.hashCode);
    _$hash = $jc(_$hash, designState.hashCode);
    _$hash = $jc(_$hash, creditState.hashCode);
    _$hash = $jc(_$hash, userState.hashCode);
    _$hash = $jc(_$hash, taxRateState.hashCode);
    _$hash = $jc(_$hash, companyGatewayState.hashCode);
    _$hash = $jc(_$hash, groupState.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserCompanyState')
          ..add('lastUpdated', lastUpdated)
          ..add('userCompany', userCompany)
          ..add('documentState', documentState)
          ..add('productState', productState)
          ..add('clientState', clientState)
          ..add('invoiceState', invoiceState)
          ..add('expenseState', expenseState)
          ..add('vendorState', vendorState)
          ..add('taskState', taskState)
          ..add('projectState', projectState)
          ..add('paymentState', paymentState)
          ..add('quoteState', quoteState)
          ..add('scheduleState', scheduleState)
          ..add('transactionRuleState', transactionRuleState)
          ..add('transactionState', transactionState)
          ..add('bankAccountState', bankAccountState)
          ..add('purchaseOrderState', purchaseOrderState)
          ..add('recurringExpenseState', recurringExpenseState)
          ..add('subscriptionState', subscriptionState)
          ..add('taskStatusState', taskStatusState)
          ..add('expenseCategoryState', expenseCategoryState)
          ..add('recurringInvoiceState', recurringInvoiceState)
          ..add('webhookState', webhookState)
          ..add('tokenState', tokenState)
          ..add('paymentTermState', paymentTermState)
          ..add('designState', designState)
          ..add('creditState', creditState)
          ..add('userState', userState)
          ..add('taxRateState', taxRateState)
          ..add('companyGatewayState', companyGatewayState)
          ..add('groupState', groupState))
        .toString();
  }
}

class UserCompanyStateBuilder
    implements Builder<UserCompanyState, UserCompanyStateBuilder> {
  _$UserCompanyState? _$v;

  int? _lastUpdated;
  int? get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int? lastUpdated) => _$this._lastUpdated = lastUpdated;

  UserCompanyEntityBuilder? _userCompany;
  UserCompanyEntityBuilder get userCompany =>
      _$this._userCompany ??= new UserCompanyEntityBuilder();
  set userCompany(UserCompanyEntityBuilder? userCompany) =>
      _$this._userCompany = userCompany;

  DocumentStateBuilder? _documentState;
  DocumentStateBuilder get documentState =>
      _$this._documentState ??= new DocumentStateBuilder();
  set documentState(DocumentStateBuilder? documentState) =>
      _$this._documentState = documentState;

  ProductStateBuilder? _productState;
  ProductStateBuilder get productState =>
      _$this._productState ??= new ProductStateBuilder();
  set productState(ProductStateBuilder? productState) =>
      _$this._productState = productState;

  ClientStateBuilder? _clientState;
  ClientStateBuilder get clientState =>
      _$this._clientState ??= new ClientStateBuilder();
  set clientState(ClientStateBuilder? clientState) =>
      _$this._clientState = clientState;

  InvoiceStateBuilder? _invoiceState;
  InvoiceStateBuilder get invoiceState =>
      _$this._invoiceState ??= new InvoiceStateBuilder();
  set invoiceState(InvoiceStateBuilder? invoiceState) =>
      _$this._invoiceState = invoiceState;

  ExpenseStateBuilder? _expenseState;
  ExpenseStateBuilder get expenseState =>
      _$this._expenseState ??= new ExpenseStateBuilder();
  set expenseState(ExpenseStateBuilder? expenseState) =>
      _$this._expenseState = expenseState;

  VendorStateBuilder? _vendorState;
  VendorStateBuilder get vendorState =>
      _$this._vendorState ??= new VendorStateBuilder();
  set vendorState(VendorStateBuilder? vendorState) =>
      _$this._vendorState = vendorState;

  TaskStateBuilder? _taskState;
  TaskStateBuilder get taskState =>
      _$this._taskState ??= new TaskStateBuilder();
  set taskState(TaskStateBuilder? taskState) => _$this._taskState = taskState;

  ProjectStateBuilder? _projectState;
  ProjectStateBuilder get projectState =>
      _$this._projectState ??= new ProjectStateBuilder();
  set projectState(ProjectStateBuilder? projectState) =>
      _$this._projectState = projectState;

  PaymentStateBuilder? _paymentState;
  PaymentStateBuilder get paymentState =>
      _$this._paymentState ??= new PaymentStateBuilder();
  set paymentState(PaymentStateBuilder? paymentState) =>
      _$this._paymentState = paymentState;

  QuoteStateBuilder? _quoteState;
  QuoteStateBuilder get quoteState =>
      _$this._quoteState ??= new QuoteStateBuilder();
  set quoteState(QuoteStateBuilder? quoteState) =>
      _$this._quoteState = quoteState;

  ScheduleStateBuilder? _scheduleState;
  ScheduleStateBuilder get scheduleState =>
      _$this._scheduleState ??= new ScheduleStateBuilder();
  set scheduleState(ScheduleStateBuilder? scheduleState) =>
      _$this._scheduleState = scheduleState;

  TransactionRuleStateBuilder? _transactionRuleState;
  TransactionRuleStateBuilder get transactionRuleState =>
      _$this._transactionRuleState ??= new TransactionRuleStateBuilder();
  set transactionRuleState(TransactionRuleStateBuilder? transactionRuleState) =>
      _$this._transactionRuleState = transactionRuleState;

  TransactionStateBuilder? _transactionState;
  TransactionStateBuilder get transactionState =>
      _$this._transactionState ??= new TransactionStateBuilder();
  set transactionState(TransactionStateBuilder? transactionState) =>
      _$this._transactionState = transactionState;

  BankAccountStateBuilder? _bankAccountState;
  BankAccountStateBuilder get bankAccountState =>
      _$this._bankAccountState ??= new BankAccountStateBuilder();
  set bankAccountState(BankAccountStateBuilder? bankAccountState) =>
      _$this._bankAccountState = bankAccountState;

  PurchaseOrderStateBuilder? _purchaseOrderState;
  PurchaseOrderStateBuilder get purchaseOrderState =>
      _$this._purchaseOrderState ??= new PurchaseOrderStateBuilder();
  set purchaseOrderState(PurchaseOrderStateBuilder? purchaseOrderState) =>
      _$this._purchaseOrderState = purchaseOrderState;

  RecurringExpenseStateBuilder? _recurringExpenseState;
  RecurringExpenseStateBuilder get recurringExpenseState =>
      _$this._recurringExpenseState ??= new RecurringExpenseStateBuilder();
  set recurringExpenseState(
          RecurringExpenseStateBuilder? recurringExpenseState) =>
      _$this._recurringExpenseState = recurringExpenseState;

  SubscriptionStateBuilder? _subscriptionState;
  SubscriptionStateBuilder get subscriptionState =>
      _$this._subscriptionState ??= new SubscriptionStateBuilder();
  set subscriptionState(SubscriptionStateBuilder? subscriptionState) =>
      _$this._subscriptionState = subscriptionState;

  TaskStatusStateBuilder? _taskStatusState;
  TaskStatusStateBuilder get taskStatusState =>
      _$this._taskStatusState ??= new TaskStatusStateBuilder();
  set taskStatusState(TaskStatusStateBuilder? taskStatusState) =>
      _$this._taskStatusState = taskStatusState;

  ExpenseCategoryStateBuilder? _expenseCategoryState;
  ExpenseCategoryStateBuilder get expenseCategoryState =>
      _$this._expenseCategoryState ??= new ExpenseCategoryStateBuilder();
  set expenseCategoryState(ExpenseCategoryStateBuilder? expenseCategoryState) =>
      _$this._expenseCategoryState = expenseCategoryState;

  RecurringInvoiceStateBuilder? _recurringInvoiceState;
  RecurringInvoiceStateBuilder get recurringInvoiceState =>
      _$this._recurringInvoiceState ??= new RecurringInvoiceStateBuilder();
  set recurringInvoiceState(
          RecurringInvoiceStateBuilder? recurringInvoiceState) =>
      _$this._recurringInvoiceState = recurringInvoiceState;

  WebhookStateBuilder? _webhookState;
  WebhookStateBuilder get webhookState =>
      _$this._webhookState ??= new WebhookStateBuilder();
  set webhookState(WebhookStateBuilder? webhookState) =>
      _$this._webhookState = webhookState;

  TokenStateBuilder? _tokenState;
  TokenStateBuilder get tokenState =>
      _$this._tokenState ??= new TokenStateBuilder();
  set tokenState(TokenStateBuilder? tokenState) =>
      _$this._tokenState = tokenState;

  PaymentTermStateBuilder? _paymentTermState;
  PaymentTermStateBuilder get paymentTermState =>
      _$this._paymentTermState ??= new PaymentTermStateBuilder();
  set paymentTermState(PaymentTermStateBuilder? paymentTermState) =>
      _$this._paymentTermState = paymentTermState;

  DesignStateBuilder? _designState;
  DesignStateBuilder get designState =>
      _$this._designState ??= new DesignStateBuilder();
  set designState(DesignStateBuilder? designState) =>
      _$this._designState = designState;

  CreditStateBuilder? _creditState;
  CreditStateBuilder get creditState =>
      _$this._creditState ??= new CreditStateBuilder();
  set creditState(CreditStateBuilder? creditState) =>
      _$this._creditState = creditState;

  UserStateBuilder? _userState;
  UserStateBuilder get userState =>
      _$this._userState ??= new UserStateBuilder();
  set userState(UserStateBuilder? userState) => _$this._userState = userState;

  TaxRateStateBuilder? _taxRateState;
  TaxRateStateBuilder get taxRateState =>
      _$this._taxRateState ??= new TaxRateStateBuilder();
  set taxRateState(TaxRateStateBuilder? taxRateState) =>
      _$this._taxRateState = taxRateState;

  CompanyGatewayStateBuilder? _companyGatewayState;
  CompanyGatewayStateBuilder get companyGatewayState =>
      _$this._companyGatewayState ??= new CompanyGatewayStateBuilder();
  set companyGatewayState(CompanyGatewayStateBuilder? companyGatewayState) =>
      _$this._companyGatewayState = companyGatewayState;

  GroupStateBuilder? _groupState;
  GroupStateBuilder get groupState =>
      _$this._groupState ??= new GroupStateBuilder();
  set groupState(GroupStateBuilder? groupState) =>
      _$this._groupState = groupState;

  UserCompanyStateBuilder();

  UserCompanyStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lastUpdated = $v.lastUpdated;
      _userCompany = $v.userCompany.toBuilder();
      _documentState = $v.documentState.toBuilder();
      _productState = $v.productState.toBuilder();
      _clientState = $v.clientState.toBuilder();
      _invoiceState = $v.invoiceState.toBuilder();
      _expenseState = $v.expenseState.toBuilder();
      _vendorState = $v.vendorState.toBuilder();
      _taskState = $v.taskState.toBuilder();
      _projectState = $v.projectState.toBuilder();
      _paymentState = $v.paymentState.toBuilder();
      _quoteState = $v.quoteState.toBuilder();
      _scheduleState = $v.scheduleState.toBuilder();
      _transactionRuleState = $v.transactionRuleState.toBuilder();
      _transactionState = $v.transactionState.toBuilder();
      _bankAccountState = $v.bankAccountState.toBuilder();
      _purchaseOrderState = $v.purchaseOrderState.toBuilder();
      _recurringExpenseState = $v.recurringExpenseState.toBuilder();
      _subscriptionState = $v.subscriptionState.toBuilder();
      _taskStatusState = $v.taskStatusState.toBuilder();
      _expenseCategoryState = $v.expenseCategoryState.toBuilder();
      _recurringInvoiceState = $v.recurringInvoiceState.toBuilder();
      _webhookState = $v.webhookState.toBuilder();
      _tokenState = $v.tokenState.toBuilder();
      _paymentTermState = $v.paymentTermState.toBuilder();
      _designState = $v.designState.toBuilder();
      _creditState = $v.creditState.toBuilder();
      _userState = $v.userState.toBuilder();
      _taxRateState = $v.taxRateState.toBuilder();
      _companyGatewayState = $v.companyGatewayState.toBuilder();
      _groupState = $v.groupState.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCompanyState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserCompanyState;
  }

  @override
  void update(void Function(UserCompanyStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserCompanyState build() => _build();

  _$UserCompanyState _build() {
    _$UserCompanyState _$result;
    try {
      _$result = _$v ??
          new _$UserCompanyState._(
              lastUpdated: BuiltValueNullFieldError.checkNotNull(
                  lastUpdated, r'UserCompanyState', 'lastUpdated'),
              userCompany: userCompany.build(),
              documentState: documentState.build(),
              productState: productState.build(),
              clientState: clientState.build(),
              invoiceState: invoiceState.build(),
              expenseState: expenseState.build(),
              vendorState: vendorState.build(),
              taskState: taskState.build(),
              projectState: projectState.build(),
              paymentState: paymentState.build(),
              quoteState: quoteState.build(),
              scheduleState: scheduleState.build(),
              transactionRuleState: transactionRuleState.build(),
              transactionState: transactionState.build(),
              bankAccountState: bankAccountState.build(),
              purchaseOrderState: purchaseOrderState.build(),
              recurringExpenseState: recurringExpenseState.build(),
              subscriptionState: subscriptionState.build(),
              taskStatusState: taskStatusState.build(),
              expenseCategoryState: expenseCategoryState.build(),
              recurringInvoiceState: recurringInvoiceState.build(),
              webhookState: webhookState.build(),
              tokenState: tokenState.build(),
              paymentTermState: paymentTermState.build(),
              designState: designState.build(),
              creditState: creditState.build(),
              userState: userState.build(),
              taxRateState: taxRateState.build(),
              companyGatewayState: companyGatewayState.build(),
              groupState: groupState.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userCompany';
        userCompany.build();
        _$failedField = 'documentState';
        documentState.build();
        _$failedField = 'productState';
        productState.build();
        _$failedField = 'clientState';
        clientState.build();
        _$failedField = 'invoiceState';
        invoiceState.build();
        _$failedField = 'expenseState';
        expenseState.build();
        _$failedField = 'vendorState';
        vendorState.build();
        _$failedField = 'taskState';
        taskState.build();
        _$failedField = 'projectState';
        projectState.build();
        _$failedField = 'paymentState';
        paymentState.build();
        _$failedField = 'quoteState';
        quoteState.build();
        _$failedField = 'scheduleState';
        scheduleState.build();
        _$failedField = 'transactionRuleState';
        transactionRuleState.build();
        _$failedField = 'transactionState';
        transactionState.build();
        _$failedField = 'bankAccountState';
        bankAccountState.build();
        _$failedField = 'purchaseOrderState';
        purchaseOrderState.build();
        _$failedField = 'recurringExpenseState';
        recurringExpenseState.build();
        _$failedField = 'subscriptionState';
        subscriptionState.build();
        _$failedField = 'taskStatusState';
        taskStatusState.build();
        _$failedField = 'expenseCategoryState';
        expenseCategoryState.build();
        _$failedField = 'recurringInvoiceState';
        recurringInvoiceState.build();
        _$failedField = 'webhookState';
        webhookState.build();
        _$failedField = 'tokenState';
        tokenState.build();
        _$failedField = 'paymentTermState';
        paymentTermState.build();
        _$failedField = 'designState';
        designState.build();
        _$failedField = 'creditState';
        creditState.build();
        _$failedField = 'userState';
        userState.build();
        _$failedField = 'taxRateState';
        taxRateState.build();
        _$failedField = 'companyGatewayState';
        companyGatewayState.build();
        _$failedField = 'groupState';
        groupState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UserCompanyState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
