// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UIState> _$uIStateSerializer = new _$UIStateSerializer();

class _$UIStateSerializer implements StructuredSerializer<UIState> {
  @override
  final Iterable<Type> types = const [UIState, _$UIState];
  @override
  final String wireName = 'UIState';

  @override
  Iterable<Object> serialize(Serializers serializers, UIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'selectedCompanyIndex',
      serializers.serialize(object.selectedCompanyIndex,
          specifiedType: const FullType(int)),
      'currentRoute',
      serializers.serialize(object.currentRoute,
          specifiedType: const FullType(String)),
      'previousRoute',
      serializers.serialize(object.previousRoute,
          specifiedType: const FullType(String)),
      'previewStack',
      serializers.serialize(object.previewStack,
          specifiedType:
              const FullType(BuiltList, const [const FullType(EntityType)])),
      'filterClearedAt',
      serializers.serialize(object.filterClearedAt,
          specifiedType: const FullType(int)),
      'dashboardUIState',
      serializers.serialize(object.dashboardUIState,
          specifiedType: const FullType(DashboardUIState)),
      'productUIState',
      serializers.serialize(object.productUIState,
          specifiedType: const FullType(ProductUIState)),
      'clientUIState',
      serializers.serialize(object.clientUIState,
          specifiedType: const FullType(ClientUIState)),
      'invoiceUIState',
      serializers.serialize(object.invoiceUIState,
          specifiedType: const FullType(InvoiceUIState)),
      'taskStatusUIState',
      serializers.serialize(object.taskStatusUIState,
          specifiedType: const FullType(TaskStatusUIState)),
      'expenseCategoryUIState',
      serializers.serialize(object.expenseCategoryUIState,
          specifiedType: const FullType(ExpenseCategoryUIState)),
      'recurringInvoiceUIState',
      serializers.serialize(object.recurringInvoiceUIState,
          specifiedType: const FullType(RecurringInvoiceUIState)),
      'webhookUIState',
      serializers.serialize(object.webhookUIState,
          specifiedType: const FullType(WebhookUIState)),
      'tokenUIState',
      serializers.serialize(object.tokenUIState,
          specifiedType: const FullType(TokenUIState)),
      'paymentTermUIState',
      serializers.serialize(object.paymentTermUIState,
          specifiedType: const FullType(PaymentTermUIState)),
      'designUIState',
      serializers.serialize(object.designUIState,
          specifiedType: const FullType(DesignUIState)),
      'creditUIState',
      serializers.serialize(object.creditUIState,
          specifiedType: const FullType(CreditUIState)),
      'userUIState',
      serializers.serialize(object.userUIState,
          specifiedType: const FullType(UserUIState)),
      'taxRateUIState',
      serializers.serialize(object.taxRateUIState,
          specifiedType: const FullType(TaxRateUIState)),
      'companyGatewayUIState',
      serializers.serialize(object.companyGatewayUIState,
          specifiedType: const FullType(CompanyGatewayUIState)),
      'groupUIState',
      serializers.serialize(object.groupUIState,
          specifiedType: const FullType(GroupUIState)),
      'documentUIState',
      serializers.serialize(object.documentUIState,
          specifiedType: const FullType(DocumentUIState)),
      'expenseUIState',
      serializers.serialize(object.expenseUIState,
          specifiedType: const FullType(ExpenseUIState)),
      'vendorUIState',
      serializers.serialize(object.vendorUIState,
          specifiedType: const FullType(VendorUIState)),
      'taskUIState',
      serializers.serialize(object.taskUIState,
          specifiedType: const FullType(TaskUIState)),
      'projectUIState',
      serializers.serialize(object.projectUIState,
          specifiedType: const FullType(ProjectUIState)),
      'paymentUIState',
      serializers.serialize(object.paymentUIState,
          specifiedType: const FullType(PaymentUIState)),
      'quoteUIState',
      serializers.serialize(object.quoteUIState,
          specifiedType: const FullType(QuoteUIState)),
      'settingsUIState',
      serializers.serialize(object.settingsUIState,
          specifiedType: const FullType(SettingsUIState)),
      'reportsUIState',
      serializers.serialize(object.reportsUIState,
          specifiedType: const FullType(ReportsUIState)),
    ];
    if (object.filterEntityId != null) {
      result
        ..add('filterEntityId')
        ..add(serializers.serialize(object.filterEntityId,
            specifiedType: const FullType(String)));
    }
    if (object.filterEntityType != null) {
      result
        ..add('filterEntityType')
        ..add(serializers.serialize(object.filterEntityType,
            specifiedType: const FullType(EntityType)));
    }
    if (object.filter != null) {
      result
        ..add('filter')
        ..add(serializers.serialize(object.filter,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UIState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'selectedCompanyIndex':
          result.selectedCompanyIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'currentRoute':
          result.currentRoute = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'previousRoute':
          result.previousRoute = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'previewStack':
          result.previewStack.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(EntityType)]))
              as BuiltList<Object>);
          break;
        case 'filterEntityId':
          result.filterEntityId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'filterEntityType':
          result.filterEntityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
          break;
        case 'filter':
          result.filter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'filterClearedAt':
          result.filterClearedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'dashboardUIState':
          result.dashboardUIState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DashboardUIState))
              as DashboardUIState);
          break;
        case 'productUIState':
          result.productUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProductUIState)) as ProductUIState);
          break;
        case 'clientUIState':
          result.clientUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientUIState)) as ClientUIState);
          break;
        case 'invoiceUIState':
          result.invoiceUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceUIState)) as InvoiceUIState);
          break;
        case 'taskStatusUIState':
          result.taskStatusUIState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TaskStatusUIState))
              as TaskStatusUIState);
          break;
        case 'expenseCategoryUIState':
          result.expenseCategoryUIState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ExpenseCategoryUIState))
              as ExpenseCategoryUIState);
          break;
        case 'recurringInvoiceUIState':
          result.recurringInvoiceUIState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(RecurringInvoiceUIState))
              as RecurringInvoiceUIState);
          break;
        case 'webhookUIState':
          result.webhookUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(WebhookUIState)) as WebhookUIState);
          break;
        case 'tokenUIState':
          result.tokenUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(TokenUIState)) as TokenUIState);
          break;
        case 'paymentTermUIState':
          result.paymentTermUIState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PaymentTermUIState))
              as PaymentTermUIState);
          break;
        case 'designUIState':
          result.designUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(DesignUIState)) as DesignUIState);
          break;
        case 'creditUIState':
          result.creditUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(CreditUIState)) as CreditUIState);
          break;
        case 'userUIState':
          result.userUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserUIState)) as UserUIState);
          break;
        case 'taxRateUIState':
          result.taxRateUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaxRateUIState)) as TaxRateUIState);
          break;
        case 'companyGatewayUIState':
          result.companyGatewayUIState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CompanyGatewayUIState))
              as CompanyGatewayUIState);
          break;
        case 'groupUIState':
          result.groupUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(GroupUIState)) as GroupUIState);
          break;
        case 'documentUIState':
          result.documentUIState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DocumentUIState))
              as DocumentUIState);
          break;
        case 'expenseUIState':
          result.expenseUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ExpenseUIState)) as ExpenseUIState);
          break;
        case 'vendorUIState':
          result.vendorUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(VendorUIState)) as VendorUIState);
          break;
        case 'taskUIState':
          result.taskUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaskUIState)) as TaskUIState);
          break;
        case 'projectUIState':
          result.projectUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProjectUIState)) as ProjectUIState);
          break;
        case 'paymentUIState':
          result.paymentUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(PaymentUIState)) as PaymentUIState);
          break;
        case 'quoteUIState':
          result.quoteUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(QuoteUIState)) as QuoteUIState);
          break;
        case 'settingsUIState':
          result.settingsUIState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SettingsUIState))
              as SettingsUIState);
          break;
        case 'reportsUIState':
          result.reportsUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ReportsUIState)) as ReportsUIState);
          break;
      }
    }

    return result.build();
  }
}

class _$UIState extends UIState {
  @override
  final int selectedCompanyIndex;
  @override
  final String currentRoute;
  @override
  final String previousRoute;
  @override
  final BuiltList<EntityType> previewStack;
  @override
  final String filterEntityId;
  @override
  final EntityType filterEntityType;
  @override
  final String filter;
  @override
  final int filterClearedAt;
  @override
  final DashboardUIState dashboardUIState;
  @override
  final ProductUIState productUIState;
  @override
  final ClientUIState clientUIState;
  @override
  final InvoiceUIState invoiceUIState;
  @override
  final TaskStatusUIState taskStatusUIState;
  @override
  final ExpenseCategoryUIState expenseCategoryUIState;
  @override
  final RecurringInvoiceUIState recurringInvoiceUIState;
  @override
  final WebhookUIState webhookUIState;
  @override
  final TokenUIState tokenUIState;
  @override
  final PaymentTermUIState paymentTermUIState;
  @override
  final DesignUIState designUIState;
  @override
  final CreditUIState creditUIState;
  @override
  final UserUIState userUIState;
  @override
  final TaxRateUIState taxRateUIState;
  @override
  final CompanyGatewayUIState companyGatewayUIState;
  @override
  final GroupUIState groupUIState;
  @override
  final DocumentUIState documentUIState;
  @override
  final ExpenseUIState expenseUIState;
  @override
  final VendorUIState vendorUIState;
  @override
  final TaskUIState taskUIState;
  @override
  final ProjectUIState projectUIState;
  @override
  final PaymentUIState paymentUIState;
  @override
  final QuoteUIState quoteUIState;
  @override
  final SettingsUIState settingsUIState;
  @override
  final ReportsUIState reportsUIState;

  factory _$UIState([void Function(UIStateBuilder) updates]) =>
      (new UIStateBuilder()..update(updates)).build();

  _$UIState._(
      {this.selectedCompanyIndex,
      this.currentRoute,
      this.previousRoute,
      this.previewStack,
      this.filterEntityId,
      this.filterEntityType,
      this.filter,
      this.filterClearedAt,
      this.dashboardUIState,
      this.productUIState,
      this.clientUIState,
      this.invoiceUIState,
      this.taskStatusUIState,
      this.expenseCategoryUIState,
      this.recurringInvoiceUIState,
      this.webhookUIState,
      this.tokenUIState,
      this.paymentTermUIState,
      this.designUIState,
      this.creditUIState,
      this.userUIState,
      this.taxRateUIState,
      this.companyGatewayUIState,
      this.groupUIState,
      this.documentUIState,
      this.expenseUIState,
      this.vendorUIState,
      this.taskUIState,
      this.projectUIState,
      this.paymentUIState,
      this.quoteUIState,
      this.settingsUIState,
      this.reportsUIState})
      : super._() {
    if (selectedCompanyIndex == null) {
      throw new BuiltValueNullFieldError('UIState', 'selectedCompanyIndex');
    }
    if (currentRoute == null) {
      throw new BuiltValueNullFieldError('UIState', 'currentRoute');
    }
    if (previousRoute == null) {
      throw new BuiltValueNullFieldError('UIState', 'previousRoute');
    }
    if (previewStack == null) {
      throw new BuiltValueNullFieldError('UIState', 'previewStack');
    }
    if (filterClearedAt == null) {
      throw new BuiltValueNullFieldError('UIState', 'filterClearedAt');
    }
    if (dashboardUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'dashboardUIState');
    }
    if (productUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'productUIState');
    }
    if (clientUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'clientUIState');
    }
    if (invoiceUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'invoiceUIState');
    }
    if (taskStatusUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'taskStatusUIState');
    }
    if (expenseCategoryUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'expenseCategoryUIState');
    }
    if (recurringInvoiceUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'recurringInvoiceUIState');
    }
    if (webhookUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'webhookUIState');
    }
    if (tokenUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'tokenUIState');
    }
    if (paymentTermUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'paymentTermUIState');
    }
    if (designUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'designUIState');
    }
    if (creditUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'creditUIState');
    }
    if (userUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'userUIState');
    }
    if (taxRateUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'taxRateUIState');
    }
    if (companyGatewayUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'companyGatewayUIState');
    }
    if (groupUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'groupUIState');
    }
    if (documentUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'documentUIState');
    }
    if (expenseUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'expenseUIState');
    }
    if (vendorUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'vendorUIState');
    }
    if (taskUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'taskUIState');
    }
    if (projectUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'projectUIState');
    }
    if (paymentUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'paymentUIState');
    }
    if (quoteUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'quoteUIState');
    }
    if (settingsUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'settingsUIState');
    }
    if (reportsUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'reportsUIState');
    }
  }

  @override
  UIState rebuild(void Function(UIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UIStateBuilder toBuilder() => new UIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UIState &&
        selectedCompanyIndex == other.selectedCompanyIndex &&
        currentRoute == other.currentRoute &&
        previousRoute == other.previousRoute &&
        previewStack == other.previewStack &&
        filterEntityId == other.filterEntityId &&
        filterEntityType == other.filterEntityType &&
        filter == other.filter &&
        filterClearedAt == other.filterClearedAt &&
        dashboardUIState == other.dashboardUIState &&
        productUIState == other.productUIState &&
        clientUIState == other.clientUIState &&
        invoiceUIState == other.invoiceUIState &&
        taskStatusUIState == other.taskStatusUIState &&
        expenseCategoryUIState == other.expenseCategoryUIState &&
        recurringInvoiceUIState == other.recurringInvoiceUIState &&
        webhookUIState == other.webhookUIState &&
        tokenUIState == other.tokenUIState &&
        paymentTermUIState == other.paymentTermUIState &&
        designUIState == other.designUIState &&
        creditUIState == other.creditUIState &&
        userUIState == other.userUIState &&
        taxRateUIState == other.taxRateUIState &&
        companyGatewayUIState == other.companyGatewayUIState &&
        groupUIState == other.groupUIState &&
        documentUIState == other.documentUIState &&
        expenseUIState == other.expenseUIState &&
        vendorUIState == other.vendorUIState &&
        taskUIState == other.taskUIState &&
        projectUIState == other.projectUIState &&
        paymentUIState == other.paymentUIState &&
        quoteUIState == other.quoteUIState &&
        settingsUIState == other.settingsUIState &&
        reportsUIState == other.reportsUIState;
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, selectedCompanyIndex.hashCode), currentRoute.hashCode), previousRoute.hashCode), previewStack.hashCode), filterEntityId.hashCode), filterEntityType.hashCode), filter.hashCode), filterClearedAt.hashCode), dashboardUIState.hashCode), productUIState.hashCode), clientUIState.hashCode), invoiceUIState.hashCode), taskStatusUIState.hashCode), expenseCategoryUIState.hashCode),
                                                                                recurringInvoiceUIState.hashCode),
                                                                            webhookUIState.hashCode),
                                                                        tokenUIState.hashCode),
                                                                    paymentTermUIState.hashCode),
                                                                designUIState.hashCode),
                                                            creditUIState.hashCode),
                                                        userUIState.hashCode),
                                                    taxRateUIState.hashCode),
                                                companyGatewayUIState.hashCode),
                                            groupUIState.hashCode),
                                        documentUIState.hashCode),
                                    expenseUIState.hashCode),
                                vendorUIState.hashCode),
                            taskUIState.hashCode),
                        projectUIState.hashCode),
                    paymentUIState.hashCode),
                quoteUIState.hashCode),
            settingsUIState.hashCode),
        reportsUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UIState')
          ..add('selectedCompanyIndex', selectedCompanyIndex)
          ..add('currentRoute', currentRoute)
          ..add('previousRoute', previousRoute)
          ..add('previewStack', previewStack)
          ..add('filterEntityId', filterEntityId)
          ..add('filterEntityType', filterEntityType)
          ..add('filter', filter)
          ..add('filterClearedAt', filterClearedAt)
          ..add('dashboardUIState', dashboardUIState)
          ..add('productUIState', productUIState)
          ..add('clientUIState', clientUIState)
          ..add('invoiceUIState', invoiceUIState)
          ..add('taskStatusUIState', taskStatusUIState)
          ..add('expenseCategoryUIState', expenseCategoryUIState)
          ..add('recurringInvoiceUIState', recurringInvoiceUIState)
          ..add('webhookUIState', webhookUIState)
          ..add('tokenUIState', tokenUIState)
          ..add('paymentTermUIState', paymentTermUIState)
          ..add('designUIState', designUIState)
          ..add('creditUIState', creditUIState)
          ..add('userUIState', userUIState)
          ..add('taxRateUIState', taxRateUIState)
          ..add('companyGatewayUIState', companyGatewayUIState)
          ..add('groupUIState', groupUIState)
          ..add('documentUIState', documentUIState)
          ..add('expenseUIState', expenseUIState)
          ..add('vendorUIState', vendorUIState)
          ..add('taskUIState', taskUIState)
          ..add('projectUIState', projectUIState)
          ..add('paymentUIState', paymentUIState)
          ..add('quoteUIState', quoteUIState)
          ..add('settingsUIState', settingsUIState)
          ..add('reportsUIState', reportsUIState))
        .toString();
  }
}

class UIStateBuilder implements Builder<UIState, UIStateBuilder> {
  _$UIState _$v;

  int _selectedCompanyIndex;
  int get selectedCompanyIndex => _$this._selectedCompanyIndex;
  set selectedCompanyIndex(int selectedCompanyIndex) =>
      _$this._selectedCompanyIndex = selectedCompanyIndex;

  String _currentRoute;
  String get currentRoute => _$this._currentRoute;
  set currentRoute(String currentRoute) => _$this._currentRoute = currentRoute;

  String _previousRoute;
  String get previousRoute => _$this._previousRoute;
  set previousRoute(String previousRoute) =>
      _$this._previousRoute = previousRoute;

  ListBuilder<EntityType> _previewStack;
  ListBuilder<EntityType> get previewStack =>
      _$this._previewStack ??= new ListBuilder<EntityType>();
  set previewStack(ListBuilder<EntityType> previewStack) =>
      _$this._previewStack = previewStack;

  String _filterEntityId;
  String get filterEntityId => _$this._filterEntityId;
  set filterEntityId(String filterEntityId) =>
      _$this._filterEntityId = filterEntityId;

  EntityType _filterEntityType;
  EntityType get filterEntityType => _$this._filterEntityType;
  set filterEntityType(EntityType filterEntityType) =>
      _$this._filterEntityType = filterEntityType;

  String _filter;
  String get filter => _$this._filter;
  set filter(String filter) => _$this._filter = filter;

  int _filterClearedAt;
  int get filterClearedAt => _$this._filterClearedAt;
  set filterClearedAt(int filterClearedAt) =>
      _$this._filterClearedAt = filterClearedAt;

  DashboardUIStateBuilder _dashboardUIState;
  DashboardUIStateBuilder get dashboardUIState =>
      _$this._dashboardUIState ??= new DashboardUIStateBuilder();
  set dashboardUIState(DashboardUIStateBuilder dashboardUIState) =>
      _$this._dashboardUIState = dashboardUIState;

  ProductUIStateBuilder _productUIState;
  ProductUIStateBuilder get productUIState =>
      _$this._productUIState ??= new ProductUIStateBuilder();
  set productUIState(ProductUIStateBuilder productUIState) =>
      _$this._productUIState = productUIState;

  ClientUIStateBuilder _clientUIState;
  ClientUIStateBuilder get clientUIState =>
      _$this._clientUIState ??= new ClientUIStateBuilder();
  set clientUIState(ClientUIStateBuilder clientUIState) =>
      _$this._clientUIState = clientUIState;

  InvoiceUIStateBuilder _invoiceUIState;
  InvoiceUIStateBuilder get invoiceUIState =>
      _$this._invoiceUIState ??= new InvoiceUIStateBuilder();
  set invoiceUIState(InvoiceUIStateBuilder invoiceUIState) =>
      _$this._invoiceUIState = invoiceUIState;

  TaskStatusUIStateBuilder _taskStatusUIState;
  TaskStatusUIStateBuilder get taskStatusUIState =>
      _$this._taskStatusUIState ??= new TaskStatusUIStateBuilder();
  set taskStatusUIState(TaskStatusUIStateBuilder taskStatusUIState) =>
      _$this._taskStatusUIState = taskStatusUIState;

  ExpenseCategoryUIStateBuilder _expenseCategoryUIState;
  ExpenseCategoryUIStateBuilder get expenseCategoryUIState =>
      _$this._expenseCategoryUIState ??= new ExpenseCategoryUIStateBuilder();
  set expenseCategoryUIState(
          ExpenseCategoryUIStateBuilder expenseCategoryUIState) =>
      _$this._expenseCategoryUIState = expenseCategoryUIState;

  RecurringInvoiceUIStateBuilder _recurringInvoiceUIState;
  RecurringInvoiceUIStateBuilder get recurringInvoiceUIState =>
      _$this._recurringInvoiceUIState ??= new RecurringInvoiceUIStateBuilder();
  set recurringInvoiceUIState(
          RecurringInvoiceUIStateBuilder recurringInvoiceUIState) =>
      _$this._recurringInvoiceUIState = recurringInvoiceUIState;

  WebhookUIStateBuilder _webhookUIState;
  WebhookUIStateBuilder get webhookUIState =>
      _$this._webhookUIState ??= new WebhookUIStateBuilder();
  set webhookUIState(WebhookUIStateBuilder webhookUIState) =>
      _$this._webhookUIState = webhookUIState;

  TokenUIStateBuilder _tokenUIState;
  TokenUIStateBuilder get tokenUIState =>
      _$this._tokenUIState ??= new TokenUIStateBuilder();
  set tokenUIState(TokenUIStateBuilder tokenUIState) =>
      _$this._tokenUIState = tokenUIState;

  PaymentTermUIStateBuilder _paymentTermUIState;
  PaymentTermUIStateBuilder get paymentTermUIState =>
      _$this._paymentTermUIState ??= new PaymentTermUIStateBuilder();
  set paymentTermUIState(PaymentTermUIStateBuilder paymentTermUIState) =>
      _$this._paymentTermUIState = paymentTermUIState;

  DesignUIStateBuilder _designUIState;
  DesignUIStateBuilder get designUIState =>
      _$this._designUIState ??= new DesignUIStateBuilder();
  set designUIState(DesignUIStateBuilder designUIState) =>
      _$this._designUIState = designUIState;

  CreditUIStateBuilder _creditUIState;
  CreditUIStateBuilder get creditUIState =>
      _$this._creditUIState ??= new CreditUIStateBuilder();
  set creditUIState(CreditUIStateBuilder creditUIState) =>
      _$this._creditUIState = creditUIState;

  UserUIStateBuilder _userUIState;
  UserUIStateBuilder get userUIState =>
      _$this._userUIState ??= new UserUIStateBuilder();
  set userUIState(UserUIStateBuilder userUIState) =>
      _$this._userUIState = userUIState;

  TaxRateUIStateBuilder _taxRateUIState;
  TaxRateUIStateBuilder get taxRateUIState =>
      _$this._taxRateUIState ??= new TaxRateUIStateBuilder();
  set taxRateUIState(TaxRateUIStateBuilder taxRateUIState) =>
      _$this._taxRateUIState = taxRateUIState;

  CompanyGatewayUIStateBuilder _companyGatewayUIState;
  CompanyGatewayUIStateBuilder get companyGatewayUIState =>
      _$this._companyGatewayUIState ??= new CompanyGatewayUIStateBuilder();
  set companyGatewayUIState(
          CompanyGatewayUIStateBuilder companyGatewayUIState) =>
      _$this._companyGatewayUIState = companyGatewayUIState;

  GroupUIStateBuilder _groupUIState;
  GroupUIStateBuilder get groupUIState =>
      _$this._groupUIState ??= new GroupUIStateBuilder();
  set groupUIState(GroupUIStateBuilder groupUIState) =>
      _$this._groupUIState = groupUIState;

  DocumentUIStateBuilder _documentUIState;
  DocumentUIStateBuilder get documentUIState =>
      _$this._documentUIState ??= new DocumentUIStateBuilder();
  set documentUIState(DocumentUIStateBuilder documentUIState) =>
      _$this._documentUIState = documentUIState;

  ExpenseUIStateBuilder _expenseUIState;
  ExpenseUIStateBuilder get expenseUIState =>
      _$this._expenseUIState ??= new ExpenseUIStateBuilder();
  set expenseUIState(ExpenseUIStateBuilder expenseUIState) =>
      _$this._expenseUIState = expenseUIState;

  VendorUIStateBuilder _vendorUIState;
  VendorUIStateBuilder get vendorUIState =>
      _$this._vendorUIState ??= new VendorUIStateBuilder();
  set vendorUIState(VendorUIStateBuilder vendorUIState) =>
      _$this._vendorUIState = vendorUIState;

  TaskUIStateBuilder _taskUIState;
  TaskUIStateBuilder get taskUIState =>
      _$this._taskUIState ??= new TaskUIStateBuilder();
  set taskUIState(TaskUIStateBuilder taskUIState) =>
      _$this._taskUIState = taskUIState;

  ProjectUIStateBuilder _projectUIState;
  ProjectUIStateBuilder get projectUIState =>
      _$this._projectUIState ??= new ProjectUIStateBuilder();
  set projectUIState(ProjectUIStateBuilder projectUIState) =>
      _$this._projectUIState = projectUIState;

  PaymentUIStateBuilder _paymentUIState;
  PaymentUIStateBuilder get paymentUIState =>
      _$this._paymentUIState ??= new PaymentUIStateBuilder();
  set paymentUIState(PaymentUIStateBuilder paymentUIState) =>
      _$this._paymentUIState = paymentUIState;

  QuoteUIStateBuilder _quoteUIState;
  QuoteUIStateBuilder get quoteUIState =>
      _$this._quoteUIState ??= new QuoteUIStateBuilder();
  set quoteUIState(QuoteUIStateBuilder quoteUIState) =>
      _$this._quoteUIState = quoteUIState;

  SettingsUIStateBuilder _settingsUIState;
  SettingsUIStateBuilder get settingsUIState =>
      _$this._settingsUIState ??= new SettingsUIStateBuilder();
  set settingsUIState(SettingsUIStateBuilder settingsUIState) =>
      _$this._settingsUIState = settingsUIState;

  ReportsUIStateBuilder _reportsUIState;
  ReportsUIStateBuilder get reportsUIState =>
      _$this._reportsUIState ??= new ReportsUIStateBuilder();
  set reportsUIState(ReportsUIStateBuilder reportsUIState) =>
      _$this._reportsUIState = reportsUIState;

  UIStateBuilder();

  UIStateBuilder get _$this {
    if (_$v != null) {
      _selectedCompanyIndex = _$v.selectedCompanyIndex;
      _currentRoute = _$v.currentRoute;
      _previousRoute = _$v.previousRoute;
      _previewStack = _$v.previewStack?.toBuilder();
      _filterEntityId = _$v.filterEntityId;
      _filterEntityType = _$v.filterEntityType;
      _filter = _$v.filter;
      _filterClearedAt = _$v.filterClearedAt;
      _dashboardUIState = _$v.dashboardUIState?.toBuilder();
      _productUIState = _$v.productUIState?.toBuilder();
      _clientUIState = _$v.clientUIState?.toBuilder();
      _invoiceUIState = _$v.invoiceUIState?.toBuilder();
      _taskStatusUIState = _$v.taskStatusUIState?.toBuilder();
      _expenseCategoryUIState = _$v.expenseCategoryUIState?.toBuilder();
      _recurringInvoiceUIState = _$v.recurringInvoiceUIState?.toBuilder();
      _webhookUIState = _$v.webhookUIState?.toBuilder();
      _tokenUIState = _$v.tokenUIState?.toBuilder();
      _paymentTermUIState = _$v.paymentTermUIState?.toBuilder();
      _designUIState = _$v.designUIState?.toBuilder();
      _creditUIState = _$v.creditUIState?.toBuilder();
      _userUIState = _$v.userUIState?.toBuilder();
      _taxRateUIState = _$v.taxRateUIState?.toBuilder();
      _companyGatewayUIState = _$v.companyGatewayUIState?.toBuilder();
      _groupUIState = _$v.groupUIState?.toBuilder();
      _documentUIState = _$v.documentUIState?.toBuilder();
      _expenseUIState = _$v.expenseUIState?.toBuilder();
      _vendorUIState = _$v.vendorUIState?.toBuilder();
      _taskUIState = _$v.taskUIState?.toBuilder();
      _projectUIState = _$v.projectUIState?.toBuilder();
      _paymentUIState = _$v.paymentUIState?.toBuilder();
      _quoteUIState = _$v.quoteUIState?.toBuilder();
      _settingsUIState = _$v.settingsUIState?.toBuilder();
      _reportsUIState = _$v.reportsUIState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UIState;
  }

  @override
  void update(void Function(UIStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UIState build() {
    _$UIState _$result;
    try {
      _$result = _$v ??
          new _$UIState._(
              selectedCompanyIndex: selectedCompanyIndex,
              currentRoute: currentRoute,
              previousRoute: previousRoute,
              previewStack: previewStack.build(),
              filterEntityId: filterEntityId,
              filterEntityType: filterEntityType,
              filter: filter,
              filterClearedAt: filterClearedAt,
              dashboardUIState: dashboardUIState.build(),
              productUIState: productUIState.build(),
              clientUIState: clientUIState.build(),
              invoiceUIState: invoiceUIState.build(),
              taskStatusUIState: taskStatusUIState.build(),
              expenseCategoryUIState: expenseCategoryUIState.build(),
              recurringInvoiceUIState: recurringInvoiceUIState.build(),
              webhookUIState: webhookUIState.build(),
              tokenUIState: tokenUIState.build(),
              paymentTermUIState: paymentTermUIState.build(),
              designUIState: designUIState.build(),
              creditUIState: creditUIState.build(),
              userUIState: userUIState.build(),
              taxRateUIState: taxRateUIState.build(),
              companyGatewayUIState: companyGatewayUIState.build(),
              groupUIState: groupUIState.build(),
              documentUIState: documentUIState.build(),
              expenseUIState: expenseUIState.build(),
              vendorUIState: vendorUIState.build(),
              taskUIState: taskUIState.build(),
              projectUIState: projectUIState.build(),
              paymentUIState: paymentUIState.build(),
              quoteUIState: quoteUIState.build(),
              settingsUIState: settingsUIState.build(),
              reportsUIState: reportsUIState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'previewStack';
        previewStack.build();

        _$failedField = 'dashboardUIState';
        dashboardUIState.build();
        _$failedField = 'productUIState';
        productUIState.build();
        _$failedField = 'clientUIState';
        clientUIState.build();
        _$failedField = 'invoiceUIState';
        invoiceUIState.build();
        _$failedField = 'taskStatusUIState';
        taskStatusUIState.build();
        _$failedField = 'expenseCategoryUIState';
        expenseCategoryUIState.build();
        _$failedField = 'recurringInvoiceUIState';
        recurringInvoiceUIState.build();
        _$failedField = 'webhookUIState';
        webhookUIState.build();
        _$failedField = 'tokenUIState';
        tokenUIState.build();
        _$failedField = 'paymentTermUIState';
        paymentTermUIState.build();
        _$failedField = 'designUIState';
        designUIState.build();
        _$failedField = 'creditUIState';
        creditUIState.build();
        _$failedField = 'userUIState';
        userUIState.build();
        _$failedField = 'taxRateUIState';
        taxRateUIState.build();
        _$failedField = 'companyGatewayUIState';
        companyGatewayUIState.build();
        _$failedField = 'groupUIState';
        groupUIState.build();
        _$failedField = 'documentUIState';
        documentUIState.build();
        _$failedField = 'expenseUIState';
        expenseUIState.build();
        _$failedField = 'vendorUIState';
        vendorUIState.build();
        _$failedField = 'taskUIState';
        taskUIState.build();
        _$failedField = 'projectUIState';
        projectUIState.build();
        _$failedField = 'paymentUIState';
        paymentUIState.build();
        _$failedField = 'quoteUIState';
        quoteUIState.build();
        _$failedField = 'settingsUIState';
        settingsUIState.build();
        _$failedField = 'reportsUIState';
        reportsUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
