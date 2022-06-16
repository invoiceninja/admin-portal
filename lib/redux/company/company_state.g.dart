// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserCompanyState> _$userCompanyStateSerializer =
    new _$UserCompanyStateSerializer();
Serializer<SettingsUIState> _$settingsUIStateSerializer =
    new _$SettingsUIStateSerializer();

class _$UserCompanyStateSerializer
    implements StructuredSerializer<UserCompanyState> {
  @override
  final Iterable<Type> types = const [UserCompanyState, _$UserCompanyState];
  @override
  final String wireName = 'UserCompanyState';

  @override
  Iterable<Object> serialize(Serializers serializers, UserCompanyState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'lastUpdated',
      serializers.serialize(object.lastUpdated,
          specifiedType: const FullType(int)),
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
    Object value;
    value = object.userCompany;
    if (value != null) {
      result
        ..add('userCompany')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(UserCompanyEntity)));
    }
    return result;
  }

  @override
  UserCompanyState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserCompanyStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'lastUpdated':
          result.lastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userCompany':
          result.userCompany.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyEntity))
              as UserCompanyEntity);
          break;
        case 'documentState':
          result.documentState.replace(serializers.deserialize(value,
              specifiedType: const FullType(DocumentState)) as DocumentState);
          break;
        case 'productState':
          result.productState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProductState)) as ProductState);
          break;
        case 'clientState':
          result.clientState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientState)) as ClientState);
          break;
        case 'invoiceState':
          result.invoiceState.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceState)) as InvoiceState);
          break;
        case 'expenseState':
          result.expenseState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ExpenseState)) as ExpenseState);
          break;
        case 'vendorState':
          result.vendorState.replace(serializers.deserialize(value,
              specifiedType: const FullType(VendorState)) as VendorState);
          break;
        case 'taskState':
          result.taskState.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaskState)) as TaskState);
          break;
        case 'projectState':
          result.projectState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProjectState)) as ProjectState);
          break;
        case 'paymentState':
          result.paymentState.replace(serializers.deserialize(value,
              specifiedType: const FullType(PaymentState)) as PaymentState);
          break;
        case 'quoteState':
          result.quoteState.replace(serializers.deserialize(value,
              specifiedType: const FullType(QuoteState)) as QuoteState);
          break;
        case 'purchaseOrderState':
          result.purchaseOrderState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PurchaseOrderState))
              as PurchaseOrderState);
          break;
        case 'recurringExpenseState':
          result.recurringExpenseState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(RecurringExpenseState))
              as RecurringExpenseState);
          break;
        case 'subscriptionState':
          result.subscriptionState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SubscriptionState))
              as SubscriptionState);
          break;
        case 'taskStatusState':
          result.taskStatusState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TaskStatusState))
              as TaskStatusState);
          break;
        case 'expenseCategoryState':
          result.expenseCategoryState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ExpenseCategoryState))
              as ExpenseCategoryState);
          break;
        case 'recurringInvoiceState':
          result.recurringInvoiceState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(RecurringInvoiceState))
              as RecurringInvoiceState);
          break;
        case 'webhookState':
          result.webhookState.replace(serializers.deserialize(value,
              specifiedType: const FullType(WebhookState)) as WebhookState);
          break;
        case 'tokenState':
          result.tokenState.replace(serializers.deserialize(value,
              specifiedType: const FullType(TokenState)) as TokenState);
          break;
        case 'paymentTermState':
          result.paymentTermState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PaymentTermState))
              as PaymentTermState);
          break;
        case 'designState':
          result.designState.replace(serializers.deserialize(value,
              specifiedType: const FullType(DesignState)) as DesignState);
          break;
        case 'creditState':
          result.creditState.replace(serializers.deserialize(value,
              specifiedType: const FullType(CreditState)) as CreditState);
          break;
        case 'userState':
          result.userState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserState)) as UserState);
          break;
        case 'taxRateState':
          result.taxRateState.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaxRateState)) as TaxRateState);
          break;
        case 'companyGatewayState':
          result.companyGatewayState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CompanyGatewayState))
              as CompanyGatewayState);
          break;
        case 'groupState':
          result.groupState.replace(serializers.deserialize(value,
              specifiedType: const FullType(GroupState)) as GroupState);
          break;
      }
    }

    return result.build();
  }
}

class _$SettingsUIStateSerializer
    implements StructuredSerializer<SettingsUIState> {
  @override
  final Iterable<Type> types = const [SettingsUIState, _$SettingsUIState];
  @override
  final String wireName = 'SettingsUIState';

  @override
  Iterable<Object> serialize(Serializers serializers, SettingsUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'company',
      serializers.serialize(object.company,
          specifiedType: const FullType(CompanyEntity)),
      'origCompany',
      serializers.serialize(object.origCompany,
          specifiedType: const FullType(CompanyEntity)),
      'client',
      serializers.serialize(object.client,
          specifiedType: const FullType(ClientEntity)),
      'origClient',
      serializers.serialize(object.origClient,
          specifiedType: const FullType(ClientEntity)),
      'group',
      serializers.serialize(object.group,
          specifiedType: const FullType(GroupEntity)),
      'origGroup',
      serializers.serialize(object.origGroup,
          specifiedType: const FullType(GroupEntity)),
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(UserEntity)),
      'origUser',
      serializers.serialize(object.origUser,
          specifiedType: const FullType(UserEntity)),
      'entityType',
      serializers.serialize(object.entityType,
          specifiedType: const FullType(EntityType)),
      'isChanged',
      serializers.serialize(object.isChanged,
          specifiedType: const FullType(bool)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'section',
      serializers.serialize(object.section,
          specifiedType: const FullType(String)),
      'tabIndex',
      serializers.serialize(object.tabIndex,
          specifiedType: const FullType(int)),
      'selectedTemplate',
      serializers.serialize(object.selectedTemplate,
          specifiedType: const FullType(EmailTemplate)),
      'filterClearedAt',
      serializers.serialize(object.filterClearedAt,
          specifiedType: const FullType(int)),
    ];
    Object value;
    value = object.filter;
    if (value != null) {
      result
        ..add('filter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SettingsUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingsUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'company':
          result.company.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyEntity)) as CompanyEntity);
          break;
        case 'origCompany':
          result.origCompany.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyEntity)) as CompanyEntity);
          break;
        case 'client':
          result.client.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientEntity)) as ClientEntity);
          break;
        case 'origClient':
          result.origClient.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientEntity)) as ClientEntity);
          break;
        case 'group':
          result.group.replace(serializers.deserialize(value,
              specifiedType: const FullType(GroupEntity)) as GroupEntity);
          break;
        case 'origGroup':
          result.origGroup.replace(serializers.deserialize(value,
              specifiedType: const FullType(GroupEntity)) as GroupEntity);
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserEntity)) as UserEntity);
          break;
        case 'origUser':
          result.origUser.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserEntity)) as UserEntity);
          break;
        case 'entityType':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'section':
          result.section = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tabIndex':
          result.tabIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'selectedTemplate':
          result.selectedTemplate = serializers.deserialize(value,
              specifiedType: const FullType(EmailTemplate)) as EmailTemplate;
          break;
        case 'filter':
          result.filter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'filterClearedAt':
          result.filterClearedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
          [void Function(UserCompanyStateBuilder) updates]) =>
      (new UserCompanyStateBuilder()..update(updates)).build();

  _$UserCompanyState._(
      {this.lastUpdated,
      this.userCompany,
      this.documentState,
      this.productState,
      this.clientState,
      this.invoiceState,
      this.expenseState,
      this.vendorState,
      this.taskState,
      this.projectState,
      this.paymentState,
      this.quoteState,
      this.purchaseOrderState,
      this.recurringExpenseState,
      this.subscriptionState,
      this.taskStatusState,
      this.expenseCategoryState,
      this.recurringInvoiceState,
      this.webhookState,
      this.tokenState,
      this.paymentTermState,
      this.designState,
      this.creditState,
      this.userState,
      this.taxRateState,
      this.companyGatewayState,
      this.groupState})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        lastUpdated, 'UserCompanyState', 'lastUpdated');
    BuiltValueNullFieldError.checkNotNull(
        documentState, 'UserCompanyState', 'documentState');
    BuiltValueNullFieldError.checkNotNull(
        productState, 'UserCompanyState', 'productState');
    BuiltValueNullFieldError.checkNotNull(
        clientState, 'UserCompanyState', 'clientState');
    BuiltValueNullFieldError.checkNotNull(
        invoiceState, 'UserCompanyState', 'invoiceState');
    BuiltValueNullFieldError.checkNotNull(
        expenseState, 'UserCompanyState', 'expenseState');
    BuiltValueNullFieldError.checkNotNull(
        vendorState, 'UserCompanyState', 'vendorState');
    BuiltValueNullFieldError.checkNotNull(
        taskState, 'UserCompanyState', 'taskState');
    BuiltValueNullFieldError.checkNotNull(
        projectState, 'UserCompanyState', 'projectState');
    BuiltValueNullFieldError.checkNotNull(
        paymentState, 'UserCompanyState', 'paymentState');
    BuiltValueNullFieldError.checkNotNull(
        quoteState, 'UserCompanyState', 'quoteState');
    BuiltValueNullFieldError.checkNotNull(
        purchaseOrderState, 'UserCompanyState', 'purchaseOrderState');
    BuiltValueNullFieldError.checkNotNull(
        recurringExpenseState, 'UserCompanyState', 'recurringExpenseState');
    BuiltValueNullFieldError.checkNotNull(
        subscriptionState, 'UserCompanyState', 'subscriptionState');
    BuiltValueNullFieldError.checkNotNull(
        taskStatusState, 'UserCompanyState', 'taskStatusState');
    BuiltValueNullFieldError.checkNotNull(
        expenseCategoryState, 'UserCompanyState', 'expenseCategoryState');
    BuiltValueNullFieldError.checkNotNull(
        recurringInvoiceState, 'UserCompanyState', 'recurringInvoiceState');
    BuiltValueNullFieldError.checkNotNull(
        webhookState, 'UserCompanyState', 'webhookState');
    BuiltValueNullFieldError.checkNotNull(
        tokenState, 'UserCompanyState', 'tokenState');
    BuiltValueNullFieldError.checkNotNull(
        paymentTermState, 'UserCompanyState', 'paymentTermState');
    BuiltValueNullFieldError.checkNotNull(
        designState, 'UserCompanyState', 'designState');
    BuiltValueNullFieldError.checkNotNull(
        creditState, 'UserCompanyState', 'creditState');
    BuiltValueNullFieldError.checkNotNull(
        userState, 'UserCompanyState', 'userState');
    BuiltValueNullFieldError.checkNotNull(
        taxRateState, 'UserCompanyState', 'taxRateState');
    BuiltValueNullFieldError.checkNotNull(
        companyGatewayState, 'UserCompanyState', 'companyGatewayState');
    BuiltValueNullFieldError.checkNotNull(
        groupState, 'UserCompanyState', 'groupState');
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc(0, lastUpdated.hashCode), userCompany.hashCode), documentState.hashCode), productState.hashCode), clientState.hashCode), invoiceState.hashCode), expenseState.hashCode), vendorState.hashCode),
                                                                                taskState.hashCode),
                                                                            projectState.hashCode),
                                                                        paymentState.hashCode),
                                                                    quoteState.hashCode),
                                                                purchaseOrderState.hashCode),
                                                            recurringExpenseState.hashCode),
                                                        subscriptionState.hashCode),
                                                    taskStatusState.hashCode),
                                                expenseCategoryState.hashCode),
                                            recurringInvoiceState.hashCode),
                                        webhookState.hashCode),
                                    tokenState.hashCode),
                                paymentTermState.hashCode),
                            designState.hashCode),
                        creditState.hashCode),
                    userState.hashCode),
                taxRateState.hashCode),
            companyGatewayState.hashCode),
        groupState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserCompanyState')
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
  _$UserCompanyState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  UserCompanyEntityBuilder _userCompany;
  UserCompanyEntityBuilder get userCompany =>
      _$this._userCompany ??= new UserCompanyEntityBuilder();
  set userCompany(UserCompanyEntityBuilder userCompany) =>
      _$this._userCompany = userCompany;

  DocumentStateBuilder _documentState;
  DocumentStateBuilder get documentState =>
      _$this._documentState ??= new DocumentStateBuilder();
  set documentState(DocumentStateBuilder documentState) =>
      _$this._documentState = documentState;

  ProductStateBuilder _productState;
  ProductStateBuilder get productState =>
      _$this._productState ??= new ProductStateBuilder();
  set productState(ProductStateBuilder productState) =>
      _$this._productState = productState;

  ClientStateBuilder _clientState;
  ClientStateBuilder get clientState =>
      _$this._clientState ??= new ClientStateBuilder();
  set clientState(ClientStateBuilder clientState) =>
      _$this._clientState = clientState;

  InvoiceStateBuilder _invoiceState;
  InvoiceStateBuilder get invoiceState =>
      _$this._invoiceState ??= new InvoiceStateBuilder();
  set invoiceState(InvoiceStateBuilder invoiceState) =>
      _$this._invoiceState = invoiceState;

  ExpenseStateBuilder _expenseState;
  ExpenseStateBuilder get expenseState =>
      _$this._expenseState ??= new ExpenseStateBuilder();
  set expenseState(ExpenseStateBuilder expenseState) =>
      _$this._expenseState = expenseState;

  VendorStateBuilder _vendorState;
  VendorStateBuilder get vendorState =>
      _$this._vendorState ??= new VendorStateBuilder();
  set vendorState(VendorStateBuilder vendorState) =>
      _$this._vendorState = vendorState;

  TaskStateBuilder _taskState;
  TaskStateBuilder get taskState =>
      _$this._taskState ??= new TaskStateBuilder();
  set taskState(TaskStateBuilder taskState) => _$this._taskState = taskState;

  ProjectStateBuilder _projectState;
  ProjectStateBuilder get projectState =>
      _$this._projectState ??= new ProjectStateBuilder();
  set projectState(ProjectStateBuilder projectState) =>
      _$this._projectState = projectState;

  PaymentStateBuilder _paymentState;
  PaymentStateBuilder get paymentState =>
      _$this._paymentState ??= new PaymentStateBuilder();
  set paymentState(PaymentStateBuilder paymentState) =>
      _$this._paymentState = paymentState;

  QuoteStateBuilder _quoteState;
  QuoteStateBuilder get quoteState =>
      _$this._quoteState ??= new QuoteStateBuilder();
  set quoteState(QuoteStateBuilder quoteState) =>
      _$this._quoteState = quoteState;

  PurchaseOrderStateBuilder _purchaseOrderState;
  PurchaseOrderStateBuilder get purchaseOrderState =>
      _$this._purchaseOrderState ??= new PurchaseOrderStateBuilder();
  set purchaseOrderState(PurchaseOrderStateBuilder purchaseOrderState) =>
      _$this._purchaseOrderState = purchaseOrderState;

  RecurringExpenseStateBuilder _recurringExpenseState;
  RecurringExpenseStateBuilder get recurringExpenseState =>
      _$this._recurringExpenseState ??= new RecurringExpenseStateBuilder();
  set recurringExpenseState(
          RecurringExpenseStateBuilder recurringExpenseState) =>
      _$this._recurringExpenseState = recurringExpenseState;

  SubscriptionStateBuilder _subscriptionState;
  SubscriptionStateBuilder get subscriptionState =>
      _$this._subscriptionState ??= new SubscriptionStateBuilder();
  set subscriptionState(SubscriptionStateBuilder subscriptionState) =>
      _$this._subscriptionState = subscriptionState;

  TaskStatusStateBuilder _taskStatusState;
  TaskStatusStateBuilder get taskStatusState =>
      _$this._taskStatusState ??= new TaskStatusStateBuilder();
  set taskStatusState(TaskStatusStateBuilder taskStatusState) =>
      _$this._taskStatusState = taskStatusState;

  ExpenseCategoryStateBuilder _expenseCategoryState;
  ExpenseCategoryStateBuilder get expenseCategoryState =>
      _$this._expenseCategoryState ??= new ExpenseCategoryStateBuilder();
  set expenseCategoryState(ExpenseCategoryStateBuilder expenseCategoryState) =>
      _$this._expenseCategoryState = expenseCategoryState;

  RecurringInvoiceStateBuilder _recurringInvoiceState;
  RecurringInvoiceStateBuilder get recurringInvoiceState =>
      _$this._recurringInvoiceState ??= new RecurringInvoiceStateBuilder();
  set recurringInvoiceState(
          RecurringInvoiceStateBuilder recurringInvoiceState) =>
      _$this._recurringInvoiceState = recurringInvoiceState;

  WebhookStateBuilder _webhookState;
  WebhookStateBuilder get webhookState =>
      _$this._webhookState ??= new WebhookStateBuilder();
  set webhookState(WebhookStateBuilder webhookState) =>
      _$this._webhookState = webhookState;

  TokenStateBuilder _tokenState;
  TokenStateBuilder get tokenState =>
      _$this._tokenState ??= new TokenStateBuilder();
  set tokenState(TokenStateBuilder tokenState) =>
      _$this._tokenState = tokenState;

  PaymentTermStateBuilder _paymentTermState;
  PaymentTermStateBuilder get paymentTermState =>
      _$this._paymentTermState ??= new PaymentTermStateBuilder();
  set paymentTermState(PaymentTermStateBuilder paymentTermState) =>
      _$this._paymentTermState = paymentTermState;

  DesignStateBuilder _designState;
  DesignStateBuilder get designState =>
      _$this._designState ??= new DesignStateBuilder();
  set designState(DesignStateBuilder designState) =>
      _$this._designState = designState;

  CreditStateBuilder _creditState;
  CreditStateBuilder get creditState =>
      _$this._creditState ??= new CreditStateBuilder();
  set creditState(CreditStateBuilder creditState) =>
      _$this._creditState = creditState;

  UserStateBuilder _userState;
  UserStateBuilder get userState =>
      _$this._userState ??= new UserStateBuilder();
  set userState(UserStateBuilder userState) => _$this._userState = userState;

  TaxRateStateBuilder _taxRateState;
  TaxRateStateBuilder get taxRateState =>
      _$this._taxRateState ??= new TaxRateStateBuilder();
  set taxRateState(TaxRateStateBuilder taxRateState) =>
      _$this._taxRateState = taxRateState;

  CompanyGatewayStateBuilder _companyGatewayState;
  CompanyGatewayStateBuilder get companyGatewayState =>
      _$this._companyGatewayState ??= new CompanyGatewayStateBuilder();
  set companyGatewayState(CompanyGatewayStateBuilder companyGatewayState) =>
      _$this._companyGatewayState = companyGatewayState;

  GroupStateBuilder _groupState;
  GroupStateBuilder get groupState =>
      _$this._groupState ??= new GroupStateBuilder();
  set groupState(GroupStateBuilder groupState) =>
      _$this._groupState = groupState;

  UserCompanyStateBuilder();

  UserCompanyStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lastUpdated = $v.lastUpdated;
      _userCompany = $v.userCompany?.toBuilder();
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
  void update(void Function(UserCompanyStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserCompanyState build() {
    _$UserCompanyState _$result;
    try {
      _$result = _$v ??
          new _$UserCompanyState._(
              lastUpdated: BuiltValueNullFieldError.checkNotNull(
                  lastUpdated, 'UserCompanyState', 'lastUpdated'),
              userCompany: _userCompany?.build(),
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
      String _$failedField;
      try {
        _$failedField = 'userCompany';
        _userCompany?.build();
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
            'UserCompanyState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SettingsUIState extends SettingsUIState {
  @override
  final CompanyEntity company;
  @override
  final CompanyEntity origCompany;
  @override
  final ClientEntity client;
  @override
  final ClientEntity origClient;
  @override
  final GroupEntity group;
  @override
  final GroupEntity origGroup;
  @override
  final UserEntity user;
  @override
  final UserEntity origUser;
  @override
  final EntityType entityType;
  @override
  final bool isChanged;
  @override
  final int updatedAt;
  @override
  final String section;
  @override
  final int tabIndex;
  @override
  final EmailTemplate selectedTemplate;
  @override
  final String filter;
  @override
  final int filterClearedAt;

  factory _$SettingsUIState([void Function(SettingsUIStateBuilder) updates]) =>
      (new SettingsUIStateBuilder()..update(updates)).build();

  _$SettingsUIState._(
      {this.company,
      this.origCompany,
      this.client,
      this.origClient,
      this.group,
      this.origGroup,
      this.user,
      this.origUser,
      this.entityType,
      this.isChanged,
      this.updatedAt,
      this.section,
      this.tabIndex,
      this.selectedTemplate,
      this.filter,
      this.filterClearedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        company, 'SettingsUIState', 'company');
    BuiltValueNullFieldError.checkNotNull(
        origCompany, 'SettingsUIState', 'origCompany');
    BuiltValueNullFieldError.checkNotNull(client, 'SettingsUIState', 'client');
    BuiltValueNullFieldError.checkNotNull(
        origClient, 'SettingsUIState', 'origClient');
    BuiltValueNullFieldError.checkNotNull(group, 'SettingsUIState', 'group');
    BuiltValueNullFieldError.checkNotNull(
        origGroup, 'SettingsUIState', 'origGroup');
    BuiltValueNullFieldError.checkNotNull(user, 'SettingsUIState', 'user');
    BuiltValueNullFieldError.checkNotNull(
        origUser, 'SettingsUIState', 'origUser');
    BuiltValueNullFieldError.checkNotNull(
        entityType, 'SettingsUIState', 'entityType');
    BuiltValueNullFieldError.checkNotNull(
        isChanged, 'SettingsUIState', 'isChanged');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'SettingsUIState', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        section, 'SettingsUIState', 'section');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, 'SettingsUIState', 'tabIndex');
    BuiltValueNullFieldError.checkNotNull(
        selectedTemplate, 'SettingsUIState', 'selectedTemplate');
    BuiltValueNullFieldError.checkNotNull(
        filterClearedAt, 'SettingsUIState', 'filterClearedAt');
  }

  @override
  SettingsUIState rebuild(void Function(SettingsUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsUIStateBuilder toBuilder() =>
      new SettingsUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsUIState &&
        company == other.company &&
        origCompany == other.origCompany &&
        client == other.client &&
        origClient == other.origClient &&
        group == other.group &&
        origGroup == other.origGroup &&
        user == other.user &&
        origUser == other.origUser &&
        entityType == other.entityType &&
        isChanged == other.isChanged &&
        updatedAt == other.updatedAt &&
        section == other.section &&
        tabIndex == other.tabIndex &&
        selectedTemplate == other.selectedTemplate &&
        filter == other.filter &&
        filterClearedAt == other.filterClearedAt;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    0,
                                                                    company
                                                                        .hashCode),
                                                                origCompany
                                                                    .hashCode),
                                                            client.hashCode),
                                                        origClient.hashCode),
                                                    group.hashCode),
                                                origGroup.hashCode),
                                            user.hashCode),
                                        origUser.hashCode),
                                    entityType.hashCode),
                                isChanged.hashCode),
                            updatedAt.hashCode),
                        section.hashCode),
                    tabIndex.hashCode),
                selectedTemplate.hashCode),
            filter.hashCode),
        filterClearedAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingsUIState')
          ..add('company', company)
          ..add('origCompany', origCompany)
          ..add('client', client)
          ..add('origClient', origClient)
          ..add('group', group)
          ..add('origGroup', origGroup)
          ..add('user', user)
          ..add('origUser', origUser)
          ..add('entityType', entityType)
          ..add('isChanged', isChanged)
          ..add('updatedAt', updatedAt)
          ..add('section', section)
          ..add('tabIndex', tabIndex)
          ..add('selectedTemplate', selectedTemplate)
          ..add('filter', filter)
          ..add('filterClearedAt', filterClearedAt))
        .toString();
  }
}

class SettingsUIStateBuilder
    implements Builder<SettingsUIState, SettingsUIStateBuilder> {
  _$SettingsUIState _$v;

  CompanyEntityBuilder _company;
  CompanyEntityBuilder get company =>
      _$this._company ??= new CompanyEntityBuilder();
  set company(CompanyEntityBuilder company) => _$this._company = company;

  CompanyEntityBuilder _origCompany;
  CompanyEntityBuilder get origCompany =>
      _$this._origCompany ??= new CompanyEntityBuilder();
  set origCompany(CompanyEntityBuilder origCompany) =>
      _$this._origCompany = origCompany;

  ClientEntityBuilder _client;
  ClientEntityBuilder get client =>
      _$this._client ??= new ClientEntityBuilder();
  set client(ClientEntityBuilder client) => _$this._client = client;

  ClientEntityBuilder _origClient;
  ClientEntityBuilder get origClient =>
      _$this._origClient ??= new ClientEntityBuilder();
  set origClient(ClientEntityBuilder origClient) =>
      _$this._origClient = origClient;

  GroupEntityBuilder _group;
  GroupEntityBuilder get group => _$this._group ??= new GroupEntityBuilder();
  set group(GroupEntityBuilder group) => _$this._group = group;

  GroupEntityBuilder _origGroup;
  GroupEntityBuilder get origGroup =>
      _$this._origGroup ??= new GroupEntityBuilder();
  set origGroup(GroupEntityBuilder origGroup) => _$this._origGroup = origGroup;

  UserEntityBuilder _user;
  UserEntityBuilder get user => _$this._user ??= new UserEntityBuilder();
  set user(UserEntityBuilder user) => _$this._user = user;

  UserEntityBuilder _origUser;
  UserEntityBuilder get origUser =>
      _$this._origUser ??= new UserEntityBuilder();
  set origUser(UserEntityBuilder origUser) => _$this._origUser = origUser;

  EntityType _entityType;
  EntityType get entityType => _$this._entityType;
  set entityType(EntityType entityType) => _$this._entityType = entityType;

  bool _isChanged;
  bool get isChanged => _$this._isChanged;
  set isChanged(bool isChanged) => _$this._isChanged = isChanged;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  String _section;
  String get section => _$this._section;
  set section(String section) => _$this._section = section;

  int _tabIndex;
  int get tabIndex => _$this._tabIndex;
  set tabIndex(int tabIndex) => _$this._tabIndex = tabIndex;

  EmailTemplate _selectedTemplate;
  EmailTemplate get selectedTemplate => _$this._selectedTemplate;
  set selectedTemplate(EmailTemplate selectedTemplate) =>
      _$this._selectedTemplate = selectedTemplate;

  String _filter;
  String get filter => _$this._filter;
  set filter(String filter) => _$this._filter = filter;

  int _filterClearedAt;
  int get filterClearedAt => _$this._filterClearedAt;
  set filterClearedAt(int filterClearedAt) =>
      _$this._filterClearedAt = filterClearedAt;

  SettingsUIStateBuilder() {
    SettingsUIState._initializeBuilder(this);
  }

  SettingsUIStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _company = $v.company.toBuilder();
      _origCompany = $v.origCompany.toBuilder();
      _client = $v.client.toBuilder();
      _origClient = $v.origClient.toBuilder();
      _group = $v.group.toBuilder();
      _origGroup = $v.origGroup.toBuilder();
      _user = $v.user.toBuilder();
      _origUser = $v.origUser.toBuilder();
      _entityType = $v.entityType;
      _isChanged = $v.isChanged;
      _updatedAt = $v.updatedAt;
      _section = $v.section;
      _tabIndex = $v.tabIndex;
      _selectedTemplate = $v.selectedTemplate;
      _filter = $v.filter;
      _filterClearedAt = $v.filterClearedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SettingsUIState;
  }

  @override
  void update(void Function(SettingsUIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingsUIState build() {
    _$SettingsUIState _$result;
    try {
      _$result = _$v ??
          new _$SettingsUIState._(
              company: company.build(),
              origCompany: origCompany.build(),
              client: client.build(),
              origClient: origClient.build(),
              group: group.build(),
              origGroup: origGroup.build(),
              user: user.build(),
              origUser: origUser.build(),
              entityType: BuiltValueNullFieldError.checkNotNull(
                  entityType, 'SettingsUIState', 'entityType'),
              isChanged: BuiltValueNullFieldError.checkNotNull(
                  isChanged, 'SettingsUIState', 'isChanged'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(
                  updatedAt, 'SettingsUIState', 'updatedAt'),
              section: BuiltValueNullFieldError.checkNotNull(
                  section, 'SettingsUIState', 'section'),
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, 'SettingsUIState', 'tabIndex'),
              selectedTemplate: BuiltValueNullFieldError.checkNotNull(
                  selectedTemplate, 'SettingsUIState', 'selectedTemplate'),
              filter: filter,
              filterClearedAt: BuiltValueNullFieldError.checkNotNull(
                  filterClearedAt, 'SettingsUIState', 'filterClearedAt'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'company';
        company.build();
        _$failedField = 'origCompany';
        origCompany.build();
        _$failedField = 'client';
        client.build();
        _$failedField = 'origClient';
        origClient.build();
        _$failedField = 'group';
        group.build();
        _$failedField = 'origGroup';
        origGroup.build();
        _$failedField = 'user';
        user.build();
        _$failedField = 'origUser';
        origUser.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SettingsUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
