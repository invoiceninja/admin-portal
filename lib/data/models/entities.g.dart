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

const EntityType _$invoice = const EntityType._('invoice');
const EntityType _$quote = const EntityType._('quote');
const EntityType _$product = const EntityType._('product');
const EntityType _$client = const EntityType._('client');
const EntityType _$contact = const EntityType._('contact');
const EntityType _$task = const EntityType._('task');
const EntityType _$project = const EntityType._('project');
const EntityType _$expense = const EntityType._('expense');
const EntityType _$vendor = const EntityType._('vendor');
const EntityType _$credit = const EntityType._('credit');
const EntityType _$payment = const EntityType._('payment');

EntityType _$typeValueOf(String name) {
  switch (name) {
    case 'invoice':
      return _$invoice;
    case 'quote':
      return _$quote;
    case 'product':
      return _$product;
    case 'client':
      return _$client;
    case 'contact':
      return _$contact;
    case 'task':
      return _$task;
    case 'project':
      return _$project;
    case 'expense':
      return _$expense;
    case 'vendor':
      return _$vendor;
    case 'credit':
      return _$credit;
    case 'payment':
      return _$payment;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EntityType> _$typeValues =
    new BuiltSet<EntityType>(const <EntityType>[
  _$invoice,
  _$quote,
  _$product,
  _$client,
  _$contact,
  _$task,
  _$project,
  _$expense,
  _$vendor,
  _$credit,
  _$payment,
]);

const EntityState _$active = const EntityState._('active');
const EntityState _$archived = const EntityState._('archived');
const EntityState _$deleted = const EntityState._('deleted');

EntityState _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'archived':
      return _$archived;
    case 'deleted':
      return _$deleted;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EntityState> _$values =
    new BuiltSet<EntityState>(const <EntityState>[
  _$active,
  _$archived,
  _$deleted,
]);

Serializer<EntityType> _$entityTypeSerializer = new _$EntityTypeSerializer();
Serializer<EntityState> _$entityStateSerializer = new _$EntityStateSerializer();
Serializer<ErrorMessage> _$errorMessageSerializer =
    new _$ErrorMessageSerializer();
Serializer<LoginResponse> _$loginResponseSerializer =
    new _$LoginResponseSerializer();
Serializer<CompanyEntity> _$companyEntitySerializer =
    new _$CompanyEntitySerializer();
Serializer<DashboardResponse> _$dashboardResponseSerializer =
    new _$DashboardResponseSerializer();
Serializer<DashboardEntity> _$dashboardEntitySerializer =
    new _$DashboardEntitySerializer();

class _$EntityTypeSerializer implements PrimitiveSerializer<EntityType> {
  @override
  final Iterable<Type> types = const <Type>[EntityType];
  @override
  final String wireName = 'EntityType';

  @override
  Object serialize(Serializers serializers, EntityType object,
          {FullType specifiedType: FullType.unspecified}) =>
      object.name;

  @override
  EntityType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      EntityType.valueOf(serialized as String);
}

class _$EntityStateSerializer implements PrimitiveSerializer<EntityState> {
  @override
  final Iterable<Type> types = const <Type>[EntityState];
  @override
  final String wireName = 'EntityState';

  @override
  Object serialize(Serializers serializers, EntityState object,
          {FullType specifiedType: FullType.unspecified}) =>
      object.name;

  @override
  EntityState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      EntityState.valueOf(serialized as String);
}

class _$ErrorMessageSerializer implements StructuredSerializer<ErrorMessage> {
  @override
  final Iterable<Type> types = const [ErrorMessage, _$ErrorMessage];
  @override
  final String wireName = 'ErrorMessage';

  @override
  Iterable serialize(Serializers serializers, ErrorMessage object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ErrorMessage deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ErrorMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

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
    if (object.error != null) {
      result
        ..add('error')
        ..add(serializers.serialize(object.error,
            specifiedType: const FullType(ErrorMessage)));
    }

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
        case 'error':
          result.error.replace(serializers.deserialize(value,
              specifiedType: const FullType(ErrorMessage)) as ErrorMessage);
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
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.token != null) {
      result
        ..add('token')
        ..add(serializers.serialize(object.token,
            specifiedType: const FullType(String)));
    }
    if (object.plan != null) {
      result
        ..add('plan')
        ..add(serializers.serialize(object.plan,
            specifiedType: const FullType(String)));
    }
    if (object.logoUrl != null) {
      result
        ..add('logo_url')
        ..add(serializers.serialize(object.logoUrl,
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
    final result = <Object>[];
    if (object.paidToDate != null) {
      result
        ..add('paidToDate')
        ..add(serializers.serialize(object.paidToDate,
            specifiedType: const FullType(double)));
    }
    if (object.paidToDateCurrency != null) {
      result
        ..add('paidToDateCurrency')
        ..add(serializers.serialize(object.paidToDateCurrency,
            specifiedType: const FullType(int)));
    }
    if (object.balances != null) {
      result
        ..add('balances')
        ..add(serializers.serialize(object.balances,
            specifiedType: const FullType(double)));
    }
    if (object.balancesCurrency != null) {
      result
        ..add('balancesCurrency')
        ..add(serializers.serialize(object.balancesCurrency,
            specifiedType: const FullType(int)));
    }
    if (object.averageInvoice != null) {
      result
        ..add('averageInvoice')
        ..add(serializers.serialize(object.averageInvoice,
            specifiedType: const FullType(double)));
    }
    if (object.averageInvoiceCurrency != null) {
      result
        ..add('averageInvoiceCurrency')
        ..add(serializers.serialize(object.averageInvoiceCurrency,
            specifiedType: const FullType(int)));
    }
    if (object.invoicesSent != null) {
      result
        ..add('invoicesSent')
        ..add(serializers.serialize(object.invoicesSent,
            specifiedType: const FullType(int)));
    }
    if (object.activeClients != null) {
      result
        ..add('activeClients')
        ..add(serializers.serialize(object.activeClients,
            specifiedType: const FullType(int)));
    }

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

class _$ErrorMessage extends ErrorMessage {
  @override
  final String message;

  factory _$ErrorMessage([void updates(ErrorMessageBuilder b)]) =>
      (new ErrorMessageBuilder()..update(updates)).build();

  _$ErrorMessage._({this.message}) : super._() {
    if (message == null)
      throw new BuiltValueNullFieldError('ErrorMessage', 'message');
  }

  @override
  ErrorMessage rebuild(void updates(ErrorMessageBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorMessageBuilder toBuilder() => new ErrorMessageBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ErrorMessage) return false;
    return message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(0, message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ErrorMessage')
          ..add('message', message))
        .toString();
  }
}

class ErrorMessageBuilder
    implements Builder<ErrorMessage, ErrorMessageBuilder> {
  _$ErrorMessage _$v;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ErrorMessageBuilder();

  ErrorMessageBuilder get _$this {
    if (_$v != null) {
      _message = _$v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorMessage other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ErrorMessage;
  }

  @override
  void update(void updates(ErrorMessageBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ErrorMessage build() {
    final _$result = _$v ?? new _$ErrorMessage._(message: message);
    replace(_$result);
    return _$result;
  }
}

class _$LoginResponse extends LoginResponse {
  @override
  final BuiltList<CompanyEntity> data;
  @override
  final ErrorMessage error;

  factory _$LoginResponse([void updates(LoginResponseBuilder b)]) =>
      (new LoginResponseBuilder()..update(updates)).build();

  _$LoginResponse._({this.data, this.error}) : super._() {
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
    return data == other.data && error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, data.hashCode), error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginResponse')
          ..add('data', data)
          ..add('error', error))
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

  ErrorMessageBuilder _error;
  ErrorMessageBuilder get error => _$this._error ??= new ErrorMessageBuilder();
  set error(ErrorMessageBuilder error) => _$this._error = error;

  LoginResponseBuilder();

  LoginResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _error = _$v.error?.toBuilder();
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
      _$result = _$v ??
          new _$LoginResponse._(data: data.build(), error: _error?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
        _$failedField = 'error';
        _error?.build();
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
      : super._();

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
      : super._();

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
