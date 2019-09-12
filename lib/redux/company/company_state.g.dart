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
  Iterable<Object> serialize(Serializers serializers, UserCompanyState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'documentState',
      serializers.serialize(object.documentState,
          specifiedType: const FullType(DocumentState)),
      'dashboardState',
      serializers.serialize(object.dashboardState,
          specifiedType: const FullType(DashboardState)),
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
    ];
    if (object.userCompany != null) {
      result
        ..add('userCompany')
        ..add(serializers.serialize(object.userCompany,
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
      final dynamic value = iterator.current;
      switch (key) {
        case 'userCompany':
          result.userCompany.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyEntity))
              as UserCompanyEntity);
          break;
        case 'documentState':
          result.documentState.replace(serializers.deserialize(value,
              specifiedType: const FullType(DocumentState)) as DocumentState);
          break;
        case 'dashboardState':
          result.dashboardState.replace(serializers.deserialize(value,
              specifiedType: const FullType(DashboardState)) as DashboardState);
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
      }
    }

    return result.build();
  }
}

class _$UserCompanyState extends UserCompanyState {
  @override
  final UserCompanyEntity userCompany;
  @override
  final DocumentState documentState;
  @override
  final DashboardState dashboardState;
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

  factory _$UserCompanyState(
          [void Function(UserCompanyStateBuilder) updates]) =>
      (new UserCompanyStateBuilder()..update(updates)).build();

  _$UserCompanyState._(
      {this.userCompany,
      this.documentState,
      this.dashboardState,
      this.productState,
      this.clientState,
      this.invoiceState,
      this.expenseState,
      this.vendorState,
      this.taskState,
      this.projectState,
      this.paymentState,
      this.quoteState})
      : super._() {
    if (documentState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'documentState');
    }
    if (dashboardState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'dashboardState');
    }
    if (productState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'productState');
    }
    if (clientState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'clientState');
    }
    if (invoiceState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'invoiceState');
    }
    if (expenseState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'expenseState');
    }
    if (vendorState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'vendorState');
    }
    if (taskState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'taskState');
    }
    if (projectState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'projectState');
    }
    if (paymentState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'paymentState');
    }
    if (quoteState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'quoteState');
    }
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
        userCompany == other.userCompany &&
        documentState == other.documentState &&
        dashboardState == other.dashboardState &&
        productState == other.productState &&
        clientState == other.clientState &&
        invoiceState == other.invoiceState &&
        expenseState == other.expenseState &&
        vendorState == other.vendorState &&
        taskState == other.taskState &&
        projectState == other.projectState &&
        paymentState == other.paymentState &&
        quoteState == other.quoteState;
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
                                            $jc($jc(0, userCompany.hashCode),
                                                documentState.hashCode),
                                            dashboardState.hashCode),
                                        productState.hashCode),
                                    clientState.hashCode),
                                invoiceState.hashCode),
                            expenseState.hashCode),
                        vendorState.hashCode),
                    taskState.hashCode),
                projectState.hashCode),
            paymentState.hashCode),
        quoteState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserCompanyState')
          ..add('userCompany', userCompany)
          ..add('documentState', documentState)
          ..add('dashboardState', dashboardState)
          ..add('productState', productState)
          ..add('clientState', clientState)
          ..add('invoiceState', invoiceState)
          ..add('expenseState', expenseState)
          ..add('vendorState', vendorState)
          ..add('taskState', taskState)
          ..add('projectState', projectState)
          ..add('paymentState', paymentState)
          ..add('quoteState', quoteState))
        .toString();
  }
}

class UserCompanyStateBuilder
    implements Builder<UserCompanyState, UserCompanyStateBuilder> {
  _$UserCompanyState _$v;

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

  DashboardStateBuilder _dashboardState;
  DashboardStateBuilder get dashboardState =>
      _$this._dashboardState ??= new DashboardStateBuilder();
  set dashboardState(DashboardStateBuilder dashboardState) =>
      _$this._dashboardState = dashboardState;

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

  UserCompanyStateBuilder();

  UserCompanyStateBuilder get _$this {
    if (_$v != null) {
      _userCompany = _$v.userCompany?.toBuilder();
      _documentState = _$v.documentState?.toBuilder();
      _dashboardState = _$v.dashboardState?.toBuilder();
      _productState = _$v.productState?.toBuilder();
      _clientState = _$v.clientState?.toBuilder();
      _invoiceState = _$v.invoiceState?.toBuilder();
      _expenseState = _$v.expenseState?.toBuilder();
      _vendorState = _$v.vendorState?.toBuilder();
      _taskState = _$v.taskState?.toBuilder();
      _projectState = _$v.projectState?.toBuilder();
      _paymentState = _$v.paymentState?.toBuilder();
      _quoteState = _$v.quoteState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCompanyState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              userCompany: _userCompany?.build(),
              documentState: documentState.build(),
              dashboardState: dashboardState.build(),
              productState: productState.build(),
              clientState: clientState.build(),
              invoiceState: invoiceState.build(),
              expenseState: expenseState.build(),
              vendorState: vendorState.build(),
              taskState: taskState.build(),
              projectState: projectState.build(),
              paymentState: paymentState.build(),
              quoteState: quoteState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userCompany';
        _userCompany?.build();
        _$failedField = 'documentState';
        documentState.build();
        _$failedField = 'dashboardState';
        dashboardState.build();
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
