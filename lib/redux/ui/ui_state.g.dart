// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<UIState> _$uIStateSerializer = new _$UIStateSerializer();

class _$UIStateSerializer implements StructuredSerializer<UIState> {
  @override
  final Iterable<Type> types = const [UIState, _$UIState];
  @override
  final String wireName = 'UIState';

  @override
  Iterable serialize(Serializers serializers, UIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'selectedCompanyIndex',
      serializers.serialize(object.selectedCompanyIndex,
          specifiedType: const FullType(int)),
      'currentRoute',
      serializers.serialize(object.currentRoute,
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
  UIState deserialize(Serializers serializers, Iterable serialized,
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
        case 'filter':
          result.filter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
  final bool enableDarkMode;
  @override
  final bool requireAuthentication;
  @override
  final bool emailPayment;
  @override
  final bool autoStartTasks;
  @override
  final DashboardUIState dashboardUIState;
  @override
  final ProductUIState productUIState;
  @override
  final ClientUIState clientUIState;
  @override
  final InvoiceUIState invoiceUIState;
  @override
  final String filter;
  @override
  final TaskUIState taskUIState;
  @override
  final ProjectUIState projectUIState;
  @override
  final PaymentUIState paymentUIState;
  @override
  final QuoteUIState quoteUIState;

  factory _$UIState([void updates(UIStateBuilder b)]) =>
      (new UIStateBuilder()..update(updates)).build();

  _$UIState._(
      {this.selectedCompanyIndex,
      this.currentRoute,
      this.enableDarkMode,
      this.requireAuthentication,
      this.emailPayment,
      this.autoStartTasks,
      this.dashboardUIState,
      this.productUIState,
      this.clientUIState,
      this.invoiceUIState,
      this.filter,
      this.taskUIState,
      this.projectUIState,
      this.paymentUIState,
      this.quoteUIState})
      : super._() {
    if (selectedCompanyIndex == null) {
      throw new BuiltValueNullFieldError('UIState', 'selectedCompanyIndex');
    }
    if (currentRoute == null) {
      throw new BuiltValueNullFieldError('UIState', 'currentRoute');
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
  }

  @override
  UIState rebuild(void updates(UIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UIStateBuilder toBuilder() => new UIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UIState &&
        selectedCompanyIndex == other.selectedCompanyIndex &&
        currentRoute == other.currentRoute &&
        enableDarkMode == other.enableDarkMode &&
        requireAuthentication == other.requireAuthentication &&
        emailPayment == other.emailPayment &&
        autoStartTasks == other.autoStartTasks &&
        dashboardUIState == other.dashboardUIState &&
        productUIState == other.productUIState &&
        clientUIState == other.clientUIState &&
        invoiceUIState == other.invoiceUIState &&
        filter == other.filter &&
        taskUIState == other.taskUIState &&
        projectUIState == other.projectUIState &&
        paymentUIState == other.paymentUIState &&
        quoteUIState == other.quoteUIState;
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
                                                                0,
                                                                selectedCompanyIndex
                                                                    .hashCode),
                                                            currentRoute
                                                                .hashCode),
                                                        enableDarkMode
                                                            .hashCode),
                                                    requireAuthentication
                                                        .hashCode),
                                                emailPayment.hashCode),
                                            autoStartTasks.hashCode),
                                        dashboardUIState.hashCode),
                                    productUIState.hashCode),
                                clientUIState.hashCode),
                            invoiceUIState.hashCode),
                        filter.hashCode),
                    taskUIState.hashCode),
                projectUIState.hashCode),
            paymentUIState.hashCode),
        quoteUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UIState')
          ..add('selectedCompanyIndex', selectedCompanyIndex)
          ..add('currentRoute', currentRoute)
          ..add('enableDarkMode', enableDarkMode)
          ..add('requireAuthentication', requireAuthentication)
          ..add('emailPayment', emailPayment)
          ..add('autoStartTasks', autoStartTasks)
          ..add('dashboardUIState', dashboardUIState)
          ..add('productUIState', productUIState)
          ..add('clientUIState', clientUIState)
          ..add('invoiceUIState', invoiceUIState)
          ..add('filter', filter)
          ..add('taskUIState', taskUIState)
          ..add('projectUIState', projectUIState)
          ..add('paymentUIState', paymentUIState)
          ..add('quoteUIState', quoteUIState))
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

  String _filter;
  String get filter => _$this._filter;
  set filter(String filter) => _$this._filter = filter;

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

  UIStateBuilder();

  UIStateBuilder get _$this {
    if (_$v != null) {
      _selectedCompanyIndex = _$v.selectedCompanyIndex;
      _currentRoute = _$v.currentRoute;
      _enableDarkMode = _$v.enableDarkMode;
      _requireAuthentication = _$v.requireAuthentication;
      _emailPayment = _$v.emailPayment;
      _autoStartTasks = _$v.autoStartTasks;
      _dashboardUIState = _$v.dashboardUIState?.toBuilder();
      _productUIState = _$v.productUIState?.toBuilder();
      _clientUIState = _$v.clientUIState?.toBuilder();
      _invoiceUIState = _$v.invoiceUIState?.toBuilder();
      _filter = _$v.filter;
      _taskUIState = _$v.taskUIState?.toBuilder();
      _projectUIState = _$v.projectUIState?.toBuilder();
      _paymentUIState = _$v.paymentUIState?.toBuilder();
      _quoteUIState = _$v.quoteUIState?.toBuilder();
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
  void update(void updates(UIStateBuilder b)) {
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
              enableDarkMode: enableDarkMode,
              requireAuthentication: requireAuthentication,
              emailPayment: emailPayment,
              autoStartTasks: autoStartTasks,
              dashboardUIState: dashboardUIState.build(),
              productUIState: productUIState.build(),
              clientUIState: clientUIState.build(),
              invoiceUIState: invoiceUIState.build(),
              filter: filter,
              taskUIState: taskUIState.build(),
              projectUIState: projectUIState.build(),
              paymentUIState: paymentUIState.build(),
              quoteUIState: quoteUIState.build());
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

        _$failedField = 'taskUIState';
        taskUIState.build();
        _$failedField = 'projectUIState';
        projectUIState.build();
        _$failedField = 'paymentUIState';
        paymentUIState.build();
        _$failedField = 'quoteUIState';
        quoteUIState.build();
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
