// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<LoginResponse> _$loginResponseSerializer =
    new _$LoginResponseSerializer();
Serializer<CompanyEntity> _$companyEntitySerializer =
    new _$CompanyEntitySerializer();
Serializer<DashboardResponse> _$dashboardResponseSerializer =
    new _$DashboardResponseSerializer();
Serializer<DashboardEntity> _$dashboardEntitySerializer =
    new _$DashboardEntitySerializer();
Serializer<ProductResponse> _$productResponseSerializer =
    new _$ProductResponseSerializer();
Serializer<ProductEntity> _$productEntitySerializer =
    new _$ProductEntitySerializer();

class _$LoginResponseSerializer implements StructuredSerializer<LoginResponse> {
  @override
  final Iterable<Type> types = const [LoginResponse, _$LoginResponse];
  @override
  final String wireName = 'LoginResponse';

  @override
  Iterable serialize(Serializers serializers, LoginResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CompanyEntity)])),
    ];

    return result;
  }

  @override
  LoginResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new LoginResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CompanyEntity)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$CompanyEntitySerializer implements StructuredSerializer<CompanyEntity> {
  @override
  final Iterable<Type> types = const [CompanyEntity, _$CompanyEntity];
  @override
  final String wireName = 'CompanyEntity';

  @override
  Iterable serialize(Serializers serializers, CompanyEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'logo_url',
      serializers.serialize(object.logoUrl,
          specifiedType: const FullType(String)),
    ];
    if (object.plan != null) {
      result
        ..add('plan')
        ..add(serializers.serialize(object.plan,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  CompanyEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new CompanyEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'plan':
          result.plan = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'logo_url':
          result.logoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardResponseSerializer
    implements StructuredSerializer<DashboardResponse> {
  @override
  final Iterable<Type> types = const [DashboardResponse, _$DashboardResponse];
  @override
  final String wireName = 'DashboardResponse';

  @override
  Iterable serialize(Serializers serializers, DashboardResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(DashboardEntity)),
    ];

    return result;
  }

  @override
  DashboardResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new DashboardResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DashboardEntity))
              as DashboardEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$DashboardEntitySerializer
    implements StructuredSerializer<DashboardEntity> {
  @override
  final Iterable<Type> types = const [DashboardEntity, _$DashboardEntity];
  @override
  final String wireName = 'DashboardEntity';

  @override
  Iterable serialize(Serializers serializers, DashboardEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'paidToDate',
      serializers.serialize(object.paidToDate,
          specifiedType: const FullType(double)),
      'paidToDateCurrency',
      serializers.serialize(object.paidToDateCurrency,
          specifiedType: const FullType(int)),
      'balances',
      serializers.serialize(object.balances,
          specifiedType: const FullType(double)),
      'balancesCurrency',
      serializers.serialize(object.balancesCurrency,
          specifiedType: const FullType(int)),
      'averageInvoice',
      serializers.serialize(object.averageInvoice,
          specifiedType: const FullType(double)),
      'averageInvoiceCurrency',
      serializers.serialize(object.averageInvoiceCurrency,
          specifiedType: const FullType(int)),
      'invoicesSent',
      serializers.serialize(object.invoicesSent,
          specifiedType: const FullType(int)),
      'activeClients',
      serializers.serialize(object.activeClients,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  DashboardEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new DashboardEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'paidToDate':
          result.paidToDate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'paidToDateCurrency':
          result.paidToDateCurrency = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'balances':
          result.balances = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'balancesCurrency':
          result.balancesCurrency = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'averageInvoice':
          result.averageInvoice = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'averageInvoiceCurrency':
          result.averageInvoiceCurrency = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoicesSent':
          result.invoicesSent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'activeClients':
          result.activeClients = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductResponseSerializer
    implements StructuredSerializer<ProductResponse> {
  @override
  final Iterable<Type> types = const [ProductResponse, _$ProductResponse];
  @override
  final String wireName = 'ProductResponse';

  @override
  Iterable serialize(Serializers serializers, ProductResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ProductEntity)])),
    ];

    return result;
  }

  @override
  ProductResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ProductResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProductEntity)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$ProductEntitySerializer implements StructuredSerializer<ProductEntity> {
  @override
  final Iterable<Type> types = const [ProductEntity, _$ProductEntity];
  @override
  final String wireName = 'ProductEntity';

  @override
  Iterable serialize(Serializers serializers, ProductEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'product_key',
      serializers.serialize(object.productKey,
          specifiedType: const FullType(String)),
      'notes',
      serializers.serialize(object.notes,
          specifiedType: const FullType(String)),
      'cost',
      serializers.serialize(object.cost, specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  ProductEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ProductEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'product_key':
          result.productKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'notes':
          result.notes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cost':
          result.cost = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$LoginResponse extends LoginResponse {
  @override
  final BuiltList<CompanyEntity> data;

  factory _$LoginResponse([void updates(LoginResponseBuilder b)]) =>
      (new LoginResponseBuilder()..update(updates)).build();

  _$LoginResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('LoginResponse', 'data');
  }

  @override
  LoginResponse rebuild(void updates(LoginResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResponseBuilder toBuilder() => new LoginResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! LoginResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginResponse')..add('data', data))
        .toString();
  }
}

class LoginResponseBuilder
    implements Builder<LoginResponse, LoginResponseBuilder> {
  _$LoginResponse _$v;

  ListBuilder<CompanyEntity> _data;
  ListBuilder<CompanyEntity> get data =>
      _$this._data ??= new ListBuilder<CompanyEntity>();
  set data(ListBuilder<CompanyEntity> data) => _$this._data = data;

  LoginResponseBuilder();

  LoginResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$LoginResponse;
  }

  @override
  void update(void updates(LoginResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginResponse build() {
    _$LoginResponse _$result;
    try {
      _$result = _$v ?? new _$LoginResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LoginResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CompanyEntity extends CompanyEntity {
  @override
  final String name;
  @override
  final String token;
  @override
  final String plan;
  @override
  final String logoUrl;

  factory _$CompanyEntity([void updates(CompanyEntityBuilder b)]) =>
      (new CompanyEntityBuilder()..update(updates)).build();

  _$CompanyEntity._({this.name, this.token, this.plan, this.logoUrl})
      : super._() {
    if (name == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'name');
    if (token == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'token');
    if (logoUrl == null)
      throw new BuiltValueNullFieldError('CompanyEntity', 'logoUrl');
  }

  @override
  CompanyEntity rebuild(void updates(CompanyEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyEntityBuilder toBuilder() => new CompanyEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! CompanyEntity) return false;
    return name == other.name &&
        token == other.token &&
        plan == other.plan &&
        logoUrl == other.logoUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, name.hashCode), token.hashCode), plan.hashCode),
        logoUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyEntity')
          ..add('name', name)
          ..add('token', token)
          ..add('plan', plan)
          ..add('logoUrl', logoUrl))
        .toString();
  }
}

class CompanyEntityBuilder
    implements Builder<CompanyEntity, CompanyEntityBuilder> {
  _$CompanyEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  String _plan;
  String get plan => _$this._plan;
  set plan(String plan) => _$this._plan = plan;

  String _logoUrl;
  String get logoUrl => _$this._logoUrl;
  set logoUrl(String logoUrl) => _$this._logoUrl = logoUrl;

  CompanyEntityBuilder();

  CompanyEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _token = _$v.token;
      _plan = _$v.plan;
      _logoUrl = _$v.logoUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$CompanyEntity;
  }

  @override
  void update(void updates(CompanyEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyEntity build() {
    final _$result = _$v ??
        new _$CompanyEntity._(
            name: name, token: token, plan: plan, logoUrl: logoUrl);
    replace(_$result);
    return _$result;
  }
}

class _$DashboardResponse extends DashboardResponse {
  @override
  final DashboardEntity data;

  factory _$DashboardResponse([void updates(DashboardResponseBuilder b)]) =>
      (new DashboardResponseBuilder()..update(updates)).build();

  _$DashboardResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('DashboardResponse', 'data');
  }

  @override
  DashboardResponse rebuild(void updates(DashboardResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardResponseBuilder toBuilder() =>
      new DashboardResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! DashboardResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardResponse')..add('data', data))
        .toString();
  }
}

class DashboardResponseBuilder
    implements Builder<DashboardResponse, DashboardResponseBuilder> {
  _$DashboardResponse _$v;

  DashboardEntityBuilder _data;
  DashboardEntityBuilder get data =>
      _$this._data ??= new DashboardEntityBuilder();
  set data(DashboardEntityBuilder data) => _$this._data = data;

  DashboardResponseBuilder();

  DashboardResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$DashboardResponse;
  }

  @override
  void update(void updates(DashboardResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardResponse build() {
    _$DashboardResponse _$result;
    try {
      _$result = _$v ?? new _$DashboardResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DashboardResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$DashboardEntity extends DashboardEntity {
  @override
  final double paidToDate;
  @override
  final int paidToDateCurrency;
  @override
  final double balances;
  @override
  final int balancesCurrency;
  @override
  final double averageInvoice;
  @override
  final int averageInvoiceCurrency;
  @override
  final int invoicesSent;
  @override
  final int activeClients;

  factory _$DashboardEntity([void updates(DashboardEntityBuilder b)]) =>
      (new DashboardEntityBuilder()..update(updates)).build();

  _$DashboardEntity._(
      {this.paidToDate,
      this.paidToDateCurrency,
      this.balances,
      this.balancesCurrency,
      this.averageInvoice,
      this.averageInvoiceCurrency,
      this.invoicesSent,
      this.activeClients})
      : super._() {
    if (paidToDate == null)
      throw new BuiltValueNullFieldError('DashboardEntity', 'paidToDate');
    if (paidToDateCurrency == null)
      throw new BuiltValueNullFieldError(
          'DashboardEntity', 'paidToDateCurrency');
    if (balances == null)
      throw new BuiltValueNullFieldError('DashboardEntity', 'balances');
    if (balancesCurrency == null)
      throw new BuiltValueNullFieldError('DashboardEntity', 'balancesCurrency');
    if (averageInvoice == null)
      throw new BuiltValueNullFieldError('DashboardEntity', 'averageInvoice');
    if (averageInvoiceCurrency == null)
      throw new BuiltValueNullFieldError(
          'DashboardEntity', 'averageInvoiceCurrency');
    if (invoicesSent == null)
      throw new BuiltValueNullFieldError('DashboardEntity', 'invoicesSent');
    if (activeClients == null)
      throw new BuiltValueNullFieldError('DashboardEntity', 'activeClients');
  }

  @override
  DashboardEntity rebuild(void updates(DashboardEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardEntityBuilder toBuilder() =>
      new DashboardEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! DashboardEntity) return false;
    return paidToDate == other.paidToDate &&
        paidToDateCurrency == other.paidToDateCurrency &&
        balances == other.balances &&
        balancesCurrency == other.balancesCurrency &&
        averageInvoice == other.averageInvoice &&
        averageInvoiceCurrency == other.averageInvoiceCurrency &&
        invoicesSent == other.invoicesSent &&
        activeClients == other.activeClients;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, paidToDate.hashCode),
                                paidToDateCurrency.hashCode),
                            balances.hashCode),
                        balancesCurrency.hashCode),
                    averageInvoice.hashCode),
                averageInvoiceCurrency.hashCode),
            invoicesSent.hashCode),
        activeClients.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DashboardEntity')
          ..add('paidToDate', paidToDate)
          ..add('paidToDateCurrency', paidToDateCurrency)
          ..add('balances', balances)
          ..add('balancesCurrency', balancesCurrency)
          ..add('averageInvoice', averageInvoice)
          ..add('averageInvoiceCurrency', averageInvoiceCurrency)
          ..add('invoicesSent', invoicesSent)
          ..add('activeClients', activeClients))
        .toString();
  }
}

class DashboardEntityBuilder
    implements Builder<DashboardEntity, DashboardEntityBuilder> {
  _$DashboardEntity _$v;

  double _paidToDate;
  double get paidToDate => _$this._paidToDate;
  set paidToDate(double paidToDate) => _$this._paidToDate = paidToDate;

  int _paidToDateCurrency;
  int get paidToDateCurrency => _$this._paidToDateCurrency;
  set paidToDateCurrency(int paidToDateCurrency) =>
      _$this._paidToDateCurrency = paidToDateCurrency;

  double _balances;
  double get balances => _$this._balances;
  set balances(double balances) => _$this._balances = balances;

  int _balancesCurrency;
  int get balancesCurrency => _$this._balancesCurrency;
  set balancesCurrency(int balancesCurrency) =>
      _$this._balancesCurrency = balancesCurrency;

  double _averageInvoice;
  double get averageInvoice => _$this._averageInvoice;
  set averageInvoice(double averageInvoice) =>
      _$this._averageInvoice = averageInvoice;

  int _averageInvoiceCurrency;
  int get averageInvoiceCurrency => _$this._averageInvoiceCurrency;
  set averageInvoiceCurrency(int averageInvoiceCurrency) =>
      _$this._averageInvoiceCurrency = averageInvoiceCurrency;

  int _invoicesSent;
  int get invoicesSent => _$this._invoicesSent;
  set invoicesSent(int invoicesSent) => _$this._invoicesSent = invoicesSent;

  int _activeClients;
  int get activeClients => _$this._activeClients;
  set activeClients(int activeClients) => _$this._activeClients = activeClients;

  DashboardEntityBuilder();

  DashboardEntityBuilder get _$this {
    if (_$v != null) {
      _paidToDate = _$v.paidToDate;
      _paidToDateCurrency = _$v.paidToDateCurrency;
      _balances = _$v.balances;
      _balancesCurrency = _$v.balancesCurrency;
      _averageInvoice = _$v.averageInvoice;
      _averageInvoiceCurrency = _$v.averageInvoiceCurrency;
      _invoicesSent = _$v.invoicesSent;
      _activeClients = _$v.activeClients;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$DashboardEntity;
  }

  @override
  void update(void updates(DashboardEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DashboardEntity build() {
    final _$result = _$v ??
        new _$DashboardEntity._(
            paidToDate: paidToDate,
            paidToDateCurrency: paidToDateCurrency,
            balances: balances,
            balancesCurrency: balancesCurrency,
            averageInvoice: averageInvoice,
            averageInvoiceCurrency: averageInvoiceCurrency,
            invoicesSent: invoicesSent,
            activeClients: activeClients);
    replace(_$result);
    return _$result;
  }
}

class _$ProductResponse extends ProductResponse {
  @override
  final BuiltList<ProductEntity> data;

  factory _$ProductResponse([void updates(ProductResponseBuilder b)]) =>
      (new ProductResponseBuilder()..update(updates)).build();

  _$ProductResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('ProductResponse', 'data');
  }

  @override
  ProductResponse rebuild(void updates(ProductResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductResponseBuilder toBuilder() =>
      new ProductResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ProductResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductResponse')..add('data', data))
        .toString();
  }
}

class ProductResponseBuilder
    implements Builder<ProductResponse, ProductResponseBuilder> {
  _$ProductResponse _$v;

  ListBuilder<ProductEntity> _data;
  ListBuilder<ProductEntity> get data =>
      _$this._data ??= new ListBuilder<ProductEntity>();
  set data(ListBuilder<ProductEntity> data) => _$this._data = data;

  ProductResponseBuilder();

  ProductResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ProductResponse;
  }

  @override
  void update(void updates(ProductResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductResponse build() {
    _$ProductResponse _$result;
    try {
      _$result = _$v ?? new _$ProductResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProductResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProductEntity extends ProductEntity {
  @override
  final int id;
  @override
  final String productKey;
  @override
  final String notes;
  @override
  final double cost;

  factory _$ProductEntity([void updates(ProductEntityBuilder b)]) =>
      (new ProductEntityBuilder()..update(updates)).build();

  _$ProductEntity._({this.id, this.productKey, this.notes, this.cost})
      : super._() {
    if (id == null) throw new BuiltValueNullFieldError('ProductEntity', 'id');
    if (productKey == null)
      throw new BuiltValueNullFieldError('ProductEntity', 'productKey');
    if (notes == null)
      throw new BuiltValueNullFieldError('ProductEntity', 'notes');
    if (cost == null)
      throw new BuiltValueNullFieldError('ProductEntity', 'cost');
  }

  @override
  ProductEntity rebuild(void updates(ProductEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductEntityBuilder toBuilder() => new ProductEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ProductEntity) return false;
    return id == other.id &&
        productKey == other.productKey &&
        notes == other.notes &&
        cost == other.cost;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), productKey.hashCode), notes.hashCode),
        cost.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductEntity')
          ..add('id', id)
          ..add('productKey', productKey)
          ..add('notes', notes)
          ..add('cost', cost))
        .toString();
  }
}

class ProductEntityBuilder
    implements Builder<ProductEntity, ProductEntityBuilder> {
  _$ProductEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _productKey;
  String get productKey => _$this._productKey;
  set productKey(String productKey) => _$this._productKey = productKey;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  double _cost;
  double get cost => _$this._cost;
  set cost(double cost) => _$this._cost = cost;

  ProductEntityBuilder();

  ProductEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _productKey = _$v.productKey;
      _notes = _$v.notes;
      _cost = _$v.cost;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ProductEntity;
  }

  @override
  void update(void updates(ProductEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductEntity build() {
    final _$result = _$v ??
        new _$ProductEntity._(
            id: id, productKey: productKey, notes: notes, cost: cost);
    replace(_$result);
    return _$result;
  }
}
