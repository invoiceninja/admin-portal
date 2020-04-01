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
      'filterClearedAt',
      serializers.serialize(object.filterClearedAt,
          specifiedType: const FullType(int)),
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
  SettingsUIState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingsUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
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
      {this.userCompany,
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
      this.designState,
      this.creditState,
      this.userState,
      this.taxRateState,
      this.companyGatewayState,
      this.groupState})
      : super._() {
    if (documentState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'documentState');
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
    if (designState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'designState');
    }
    if (creditState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'creditState');
    }
    if (userState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'userState');
    }
    if (taxRateState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'taxRateState');
    }
    if (companyGatewayState == null) {
      throw new BuiltValueNullFieldError(
          'UserCompanyState', 'companyGatewayState');
    }
    if (groupState == null) {
      throw new BuiltValueNullFieldError('UserCompanyState', 'groupState');
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
        productState == other.productState &&
        clientState == other.clientState &&
        invoiceState == other.invoiceState &&
        expenseState == other.expenseState &&
        vendorState == other.vendorState &&
        taskState == other.taskState &&
        projectState == other.projectState &&
        paymentState == other.paymentState &&
        quoteState == other.quoteState &&
        designState == other.designState &&
        creditState == other.creditState &&
        userState == other.userState &&
        taxRateState == other.taxRateState &&
        companyGatewayState == other.companyGatewayState &&
        groupState == other.groupState;
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
                                                                        0,
                                                                        userCompany
                                                                            .hashCode),
                                                                    documentState
                                                                        .hashCode),
                                                                productState
                                                                    .hashCode),
                                                            clientState
                                                                .hashCode),
                                                        invoiceState.hashCode),
                                                    expenseState.hashCode),
                                                vendorState.hashCode),
                                            taskState.hashCode),
                                        projectState.hashCode),
                                    paymentState.hashCode),
                                quoteState.hashCode),
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
    if (_$v != null) {
      _userCompany = _$v.userCompany?.toBuilder();
      _documentState = _$v.documentState?.toBuilder();
      _productState = _$v.productState?.toBuilder();
      _clientState = _$v.clientState?.toBuilder();
      _invoiceState = _$v.invoiceState?.toBuilder();
      _expenseState = _$v.expenseState?.toBuilder();
      _vendorState = _$v.vendorState?.toBuilder();
      _taskState = _$v.taskState?.toBuilder();
      _projectState = _$v.projectState?.toBuilder();
      _paymentState = _$v.paymentState?.toBuilder();
      _quoteState = _$v.quoteState?.toBuilder();
      _designState = _$v.designState?.toBuilder();
      _creditState = _$v.creditState?.toBuilder();
      _userState = _$v.userState?.toBuilder();
      _taxRateState = _$v.taxRateState?.toBuilder();
      _companyGatewayState = _$v.companyGatewayState?.toBuilder();
      _groupState = _$v.groupState?.toBuilder();
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
              productState: productState.build(),
              clientState: clientState.build(),
              invoiceState: invoiceState.build(),
              expenseState: expenseState.build(),
              vendorState: vendorState.build(),
              taskState: taskState.build(),
              projectState: projectState.build(),
              paymentState: paymentState.build(),
              quoteState: quoteState.build(),
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
      this.filter,
      this.filterClearedAt})
      : super._() {
    if (company == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'company');
    }
    if (origCompany == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'origCompany');
    }
    if (client == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'client');
    }
    if (origClient == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'origClient');
    }
    if (group == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'group');
    }
    if (origGroup == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'origGroup');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'user');
    }
    if (origUser == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'origUser');
    }
    if (entityType == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'entityType');
    }
    if (isChanged == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'isChanged');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'updatedAt');
    }
    if (section == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'section');
    }
    if (filterClearedAt == null) {
      throw new BuiltValueNullFieldError('SettingsUIState', 'filterClearedAt');
    }
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
        filter == other.filter &&
        filterClearedAt == other.filterClearedAt;
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
                                                        $jc(0,
                                                            company.hashCode),
                                                        origCompany.hashCode),
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

  String _filter;
  String get filter => _$this._filter;
  set filter(String filter) => _$this._filter = filter;

  int _filterClearedAt;
  int get filterClearedAt => _$this._filterClearedAt;
  set filterClearedAt(int filterClearedAt) =>
      _$this._filterClearedAt = filterClearedAt;

  SettingsUIStateBuilder();

  SettingsUIStateBuilder get _$this {
    if (_$v != null) {
      _company = _$v.company?.toBuilder();
      _origCompany = _$v.origCompany?.toBuilder();
      _client = _$v.client?.toBuilder();
      _origClient = _$v.origClient?.toBuilder();
      _group = _$v.group?.toBuilder();
      _origGroup = _$v.origGroup?.toBuilder();
      _user = _$v.user?.toBuilder();
      _origUser = _$v.origUser?.toBuilder();
      _entityType = _$v.entityType;
      _isChanged = _$v.isChanged;
      _updatedAt = _$v.updatedAt;
      _section = _$v.section;
      _filter = _$v.filter;
      _filterClearedAt = _$v.filterClearedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              entityType: entityType,
              isChanged: isChanged,
              updatedAt: updatedAt,
              section: section,
              filter: filter,
              filterClearedAt: filterClearedAt);
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
