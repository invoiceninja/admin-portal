// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AppLayout _$mobile = const AppLayout._('mobile');
const AppLayout _$tablet = const AppLayout._('tablet');
const AppLayout _$desktop = const AppLayout._('desktop');

AppLayout _$valueOf(String name) {
  switch (name) {
    case 'mobile':
      return _$mobile;
    case 'tablet':
      return _$tablet;
    case 'desktop':
      return _$desktop;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AppLayout> _$values = new BuiltSet<AppLayout>(const <AppLayout>[
  _$mobile,
  _$tablet,
  _$desktop,
]);

const AppSidebar _$menu = const AppSidebar._('menu');
const AppSidebar _$history = const AppSidebar._('history');

AppSidebar _$valueOfSidebar(String name) {
  switch (name) {
    case 'menu':
      return _$menu;
    case 'history':
      return _$history;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AppSidebar> _$valuesSidebar =
    new BuiltSet<AppSidebar>(const <AppSidebar>[
  _$menu,
  _$history,
]);

Serializer<UIState> _$uIStateSerializer = new _$UIStateSerializer();
Serializer<AppLayout> _$appLayoutSerializer = new _$AppLayoutSerializer();
Serializer<AppSidebar> _$appSidebarSerializer = new _$AppSidebarSerializer();

class _$UIStateSerializer implements StructuredSerializer<UIState> {
  @override
  final Iterable<Type> types = const [UIState, _$UIState];
  @override
  final String wireName = 'UIState';

  @override
  Iterable<Object> serialize(Serializers serializers, UIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'layout',
      serializers.serialize(object.layout,
          specifiedType: const FullType(AppLayout)),
      'isTesting',
      serializers.serialize(object.isTesting,
          specifiedType: const FullType(bool)),
      'isMenuVisible',
      serializers.serialize(object.isMenuVisible,
          specifiedType: const FullType(bool)),
      'isHistoryVisible',
      serializers.serialize(object.isHistoryVisible,
          specifiedType: const FullType(bool)),
      'selectedCompanyIndex',
      serializers.serialize(object.selectedCompanyIndex,
          specifiedType: const FullType(int)),
      'currentRoute',
      serializers.serialize(object.currentRoute,
          specifiedType: const FullType(String)),
      'previousRoute',
      serializers.serialize(object.previousRoute,
          specifiedType: const FullType(String)),
      'enableDarkMode',
      serializers.serialize(object.enableDarkMode,
          specifiedType: const FullType(bool)),
      'requireAuthentication',
      serializers.serialize(object.requireAuthentication,
          specifiedType: const FullType(bool)),
      'emailPayment',
      serializers.serialize(object.emailPayment,
          specifiedType: const FullType(bool)),
      'autoStartTasks',
      serializers.serialize(object.autoStartTasks,
          specifiedType: const FullType(bool)),
      'addDocumentsToInvoice',
      serializers.serialize(object.addDocumentsToInvoice,
          specifiedType: const FullType(bool)),
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
    ];
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
        case 'layout':
          result.layout = serializers.deserialize(value,
              specifiedType: const FullType(AppLayout)) as AppLayout;
          break;
        case 'isTesting':
          result.isTesting = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isMenuVisible':
          result.isMenuVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isHistoryVisible':
          result.isHistoryVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
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
        case 'enableDarkMode':
          result.enableDarkMode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'requireAuthentication':
          result.requireAuthentication = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'emailPayment':
          result.emailPayment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'autoStartTasks':
          result.autoStartTasks = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'addDocumentsToInvoice':
          result.addDocumentsToInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'filter':
          result.filter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
      }
    }

    return result.build();
  }
}

class _$AppLayoutSerializer implements PrimitiveSerializer<AppLayout> {
  @override
  final Iterable<Type> types = const <Type>[AppLayout];
  @override
  final String wireName = 'AppLayout';

  @override
  Object serialize(Serializers serializers, AppLayout object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  AppLayout deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AppLayout.valueOf(serialized as String);
}

class _$AppSidebarSerializer implements PrimitiveSerializer<AppSidebar> {
  @override
  final Iterable<Type> types = const <Type>[AppSidebar];
  @override
  final String wireName = 'AppSidebar';

  @override
  Object serialize(Serializers serializers, AppSidebar object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  AppSidebar deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AppSidebar.valueOf(serialized as String);
}

class _$UIState extends UIState {
  @override
  final AppLayout layout;
  @override
  final bool isTesting;
  @override
  final bool isMenuVisible;
  @override
  final bool isHistoryVisible;
  @override
  final int selectedCompanyIndex;
  @override
  final String currentRoute;
  @override
  final String previousRoute;
  @override
  final bool enableDarkMode;
  @override
  final bool requireAuthentication;
  @override
  final bool emailPayment;
  @override
  final bool autoStartTasks;
  @override
  final bool addDocumentsToInvoice;
  @override
  final String filter;
  @override
  final DashboardUIState dashboardUIState;
  @override
  final ProductUIState productUIState;
  @override
  final ClientUIState clientUIState;
  @override
  final InvoiceUIState invoiceUIState;
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

  factory _$UIState([void Function(UIStateBuilder) updates]) =>
      (new UIStateBuilder()..update(updates)).build();

  _$UIState._(
      {this.layout,
      this.isTesting,
      this.isMenuVisible,
      this.isHistoryVisible,
      this.selectedCompanyIndex,
      this.currentRoute,
      this.previousRoute,
      this.enableDarkMode,
      this.requireAuthentication,
      this.emailPayment,
      this.autoStartTasks,
      this.addDocumentsToInvoice,
      this.filter,
      this.dashboardUIState,
      this.productUIState,
      this.clientUIState,
      this.invoiceUIState,
      this.groupUIState,
      this.documentUIState,
      this.expenseUIState,
      this.vendorUIState,
      this.taskUIState,
      this.projectUIState,
      this.paymentUIState,
      this.quoteUIState,
      this.settingsUIState})
      : super._() {
    if (layout == null) {
      throw new BuiltValueNullFieldError('UIState', 'layout');
    }
    if (isTesting == null) {
      throw new BuiltValueNullFieldError('UIState', 'isTesting');
    }
    if (isMenuVisible == null) {
      throw new BuiltValueNullFieldError('UIState', 'isMenuVisible');
    }
    if (isHistoryVisible == null) {
      throw new BuiltValueNullFieldError('UIState', 'isHistoryVisible');
    }
    if (selectedCompanyIndex == null) {
      throw new BuiltValueNullFieldError('UIState', 'selectedCompanyIndex');
    }
    if (currentRoute == null) {
      throw new BuiltValueNullFieldError('UIState', 'currentRoute');
    }
    if (previousRoute == null) {
      throw new BuiltValueNullFieldError('UIState', 'previousRoute');
    }
    if (enableDarkMode == null) {
      throw new BuiltValueNullFieldError('UIState', 'enableDarkMode');
    }
    if (requireAuthentication == null) {
      throw new BuiltValueNullFieldError('UIState', 'requireAuthentication');
    }
    if (emailPayment == null) {
      throw new BuiltValueNullFieldError('UIState', 'emailPayment');
    }
    if (autoStartTasks == null) {
      throw new BuiltValueNullFieldError('UIState', 'autoStartTasks');
    }
    if (addDocumentsToInvoice == null) {
      throw new BuiltValueNullFieldError('UIState', 'addDocumentsToInvoice');
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
        layout == other.layout &&
        isTesting == other.isTesting &&
        isMenuVisible == other.isMenuVisible &&
        isHistoryVisible == other.isHistoryVisible &&
        selectedCompanyIndex == other.selectedCompanyIndex &&
        currentRoute == other.currentRoute &&
        previousRoute == other.previousRoute &&
        enableDarkMode == other.enableDarkMode &&
        requireAuthentication == other.requireAuthentication &&
        emailPayment == other.emailPayment &&
        autoStartTasks == other.autoStartTasks &&
        addDocumentsToInvoice == other.addDocumentsToInvoice &&
        filter == other.filter &&
        dashboardUIState == other.dashboardUIState &&
        productUIState == other.productUIState &&
        clientUIState == other.clientUIState &&
        invoiceUIState == other.invoiceUIState &&
        groupUIState == other.groupUIState &&
        documentUIState == other.documentUIState &&
        expenseUIState == other.expenseUIState &&
        vendorUIState == other.vendorUIState &&
        taskUIState == other.taskUIState &&
        projectUIState == other.projectUIState &&
        paymentUIState == other.paymentUIState &&
        quoteUIState == other.quoteUIState &&
        settingsUIState == other.settingsUIState;
  }

  @override
  int get hashCode {
    return $jf($jc(
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc(0, layout.hashCode), isTesting.hashCode), isMenuVisible.hashCode), isHistoryVisible.hashCode), selectedCompanyIndex.hashCode), currentRoute.hashCode), previousRoute.hashCode),
                                                                                enableDarkMode.hashCode),
                                                                            requireAuthentication.hashCode),
                                                                        emailPayment.hashCode),
                                                                    autoStartTasks.hashCode),
                                                                addDocumentsToInvoice.hashCode),
                                                            filter.hashCode),
                                                        dashboardUIState.hashCode),
                                                    productUIState.hashCode),
                                                clientUIState.hashCode),
                                            invoiceUIState.hashCode),
                                        groupUIState.hashCode),
                                    documentUIState.hashCode),
                                expenseUIState.hashCode),
                            vendorUIState.hashCode),
                        taskUIState.hashCode),
                    projectUIState.hashCode),
                paymentUIState.hashCode),
            quoteUIState.hashCode),
        settingsUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UIState')
          ..add('layout', layout)
          ..add('isTesting', isTesting)
          ..add('isMenuVisible', isMenuVisible)
          ..add('isHistoryVisible', isHistoryVisible)
          ..add('selectedCompanyIndex', selectedCompanyIndex)
          ..add('currentRoute', currentRoute)
          ..add('previousRoute', previousRoute)
          ..add('enableDarkMode', enableDarkMode)
          ..add('requireAuthentication', requireAuthentication)
          ..add('emailPayment', emailPayment)
          ..add('autoStartTasks', autoStartTasks)
          ..add('addDocumentsToInvoice', addDocumentsToInvoice)
          ..add('filter', filter)
          ..add('dashboardUIState', dashboardUIState)
          ..add('productUIState', productUIState)
          ..add('clientUIState', clientUIState)
          ..add('invoiceUIState', invoiceUIState)
          ..add('groupUIState', groupUIState)
          ..add('documentUIState', documentUIState)
          ..add('expenseUIState', expenseUIState)
          ..add('vendorUIState', vendorUIState)
          ..add('taskUIState', taskUIState)
          ..add('projectUIState', projectUIState)
          ..add('paymentUIState', paymentUIState)
          ..add('quoteUIState', quoteUIState)
          ..add('settingsUIState', settingsUIState))
        .toString();
  }
}

class UIStateBuilder implements Builder<UIState, UIStateBuilder> {
  _$UIState _$v;

  AppLayout _layout;
  AppLayout get layout => _$this._layout;
  set layout(AppLayout layout) => _$this._layout = layout;

  bool _isTesting;
  bool get isTesting => _$this._isTesting;
  set isTesting(bool isTesting) => _$this._isTesting = isTesting;

  bool _isMenuVisible;
  bool get isMenuVisible => _$this._isMenuVisible;
  set isMenuVisible(bool isMenuVisible) =>
      _$this._isMenuVisible = isMenuVisible;

  bool _isHistoryVisible;
  bool get isHistoryVisible => _$this._isHistoryVisible;
  set isHistoryVisible(bool isHistoryVisible) =>
      _$this._isHistoryVisible = isHistoryVisible;

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

  bool _enableDarkMode;
  bool get enableDarkMode => _$this._enableDarkMode;
  set enableDarkMode(bool enableDarkMode) =>
      _$this._enableDarkMode = enableDarkMode;

  bool _requireAuthentication;
  bool get requireAuthentication => _$this._requireAuthentication;
  set requireAuthentication(bool requireAuthentication) =>
      _$this._requireAuthentication = requireAuthentication;

  bool _emailPayment;
  bool get emailPayment => _$this._emailPayment;
  set emailPayment(bool emailPayment) => _$this._emailPayment = emailPayment;

  bool _autoStartTasks;
  bool get autoStartTasks => _$this._autoStartTasks;
  set autoStartTasks(bool autoStartTasks) =>
      _$this._autoStartTasks = autoStartTasks;

  bool _addDocumentsToInvoice;
  bool get addDocumentsToInvoice => _$this._addDocumentsToInvoice;
  set addDocumentsToInvoice(bool addDocumentsToInvoice) =>
      _$this._addDocumentsToInvoice = addDocumentsToInvoice;

  String _filter;
  String get filter => _$this._filter;
  set filter(String filter) => _$this._filter = filter;

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

  UIStateBuilder();

  UIStateBuilder get _$this {
    if (_$v != null) {
      _layout = _$v.layout;
      _isTesting = _$v.isTesting;
      _isMenuVisible = _$v.isMenuVisible;
      _isHistoryVisible = _$v.isHistoryVisible;
      _selectedCompanyIndex = _$v.selectedCompanyIndex;
      _currentRoute = _$v.currentRoute;
      _previousRoute = _$v.previousRoute;
      _enableDarkMode = _$v.enableDarkMode;
      _requireAuthentication = _$v.requireAuthentication;
      _emailPayment = _$v.emailPayment;
      _autoStartTasks = _$v.autoStartTasks;
      _addDocumentsToInvoice = _$v.addDocumentsToInvoice;
      _filter = _$v.filter;
      _dashboardUIState = _$v.dashboardUIState?.toBuilder();
      _productUIState = _$v.productUIState?.toBuilder();
      _clientUIState = _$v.clientUIState?.toBuilder();
      _invoiceUIState = _$v.invoiceUIState?.toBuilder();
      _groupUIState = _$v.groupUIState?.toBuilder();
      _documentUIState = _$v.documentUIState?.toBuilder();
      _expenseUIState = _$v.expenseUIState?.toBuilder();
      _vendorUIState = _$v.vendorUIState?.toBuilder();
      _taskUIState = _$v.taskUIState?.toBuilder();
      _projectUIState = _$v.projectUIState?.toBuilder();
      _paymentUIState = _$v.paymentUIState?.toBuilder();
      _quoteUIState = _$v.quoteUIState?.toBuilder();
      _settingsUIState = _$v.settingsUIState?.toBuilder();
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
              layout: layout,
              isTesting: isTesting,
              isMenuVisible: isMenuVisible,
              isHistoryVisible: isHistoryVisible,
              selectedCompanyIndex: selectedCompanyIndex,
              currentRoute: currentRoute,
              previousRoute: previousRoute,
              enableDarkMode: enableDarkMode,
              requireAuthentication: requireAuthentication,
              emailPayment: emailPayment,
              autoStartTasks: autoStartTasks,
              addDocumentsToInvoice: addDocumentsToInvoice,
              filter: filter,
              dashboardUIState: dashboardUIState.build(),
              productUIState: productUIState.build(),
              clientUIState: clientUIState.build(),
              invoiceUIState: invoiceUIState.build(),
              groupUIState: groupUIState.build(),
              documentUIState: documentUIState.build(),
              expenseUIState: expenseUIState.build(),
              vendorUIState: vendorUIState.build(),
              taskUIState: taskUIState.build(),
              projectUIState: projectUIState.build(),
              paymentUIState: paymentUIState.build(),
              quoteUIState: quoteUIState.build(),
              settingsUIState: settingsUIState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'dashboardUIState';
        dashboardUIState.build();
        _$failedField = 'productUIState';
        productUIState.build();
        _$failedField = 'clientUIState';
        clientUIState.build();
        _$failedField = 'invoiceUIState';
        invoiceUIState.build();
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
