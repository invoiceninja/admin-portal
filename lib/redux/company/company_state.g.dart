// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<CompanyState> _$companyStateSerializer =
    new _$CompanyStateSerializer();

class _$CompanyStateSerializer implements StructuredSerializer<CompanyState> {
  @override
  final Iterable<Type> types = const [CompanyState, _$CompanyState];
  @override
  final String wireName = 'CompanyState';

  @override
  Iterable serialize(Serializers serializers, CompanyState object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
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
    ];
    if (object.company != null) {
      result
        ..add('company')
        ..add(serializers.serialize(object.company,
            specifiedType: const FullType(CompanyEntity)));
    }

    return result;
  }

  @override
  CompanyState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new CompanyStateBuilder();

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
      }
    }

    return result.build();
  }
}

class _$CompanyState extends CompanyState {
  @override
  final CompanyEntity company;
  @override
  final DashboardState dashboardState;
  @override
  final ProductState productState;
  @override
  final ClientState clientState;
  @override
  final InvoiceState invoiceState;

  factory _$CompanyState([void updates(CompanyStateBuilder b)]) =>
      (new CompanyStateBuilder()..update(updates)).build();

  _$CompanyState._(
      {this.company,
      this.dashboardState,
      this.productState,
      this.clientState,
      this.invoiceState})
      : super._() {
    if (dashboardState == null)
      throw new BuiltValueNullFieldError('CompanyState', 'dashboardState');
    if (productState == null)
      throw new BuiltValueNullFieldError('CompanyState', 'productState');
    if (clientState == null)
      throw new BuiltValueNullFieldError('CompanyState', 'clientState');
    if (invoiceState == null)
      throw new BuiltValueNullFieldError('CompanyState', 'invoiceState');
  }

  @override
  CompanyState rebuild(void updates(CompanyStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyStateBuilder toBuilder() => new CompanyStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! CompanyState) return false;
    return company == other.company &&
        dashboardState == other.dashboardState &&
        productState == other.productState &&
        clientState == other.clientState &&
        invoiceState == other.invoiceState;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, company.hashCode), dashboardState.hashCode),
                productState.hashCode),
            clientState.hashCode),
        invoiceState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CompanyState')
          ..add('company', company)
          ..add('dashboardState', dashboardState)
          ..add('productState', productState)
          ..add('clientState', clientState)
          ..add('invoiceState', invoiceState))
        .toString();
  }
}

class CompanyStateBuilder
    implements Builder<CompanyState, CompanyStateBuilder> {
  _$CompanyState _$v;

  CompanyEntityBuilder _company;
  CompanyEntityBuilder get company =>
      _$this._company ??= new CompanyEntityBuilder();
  set company(CompanyEntityBuilder company) => _$this._company = company;

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

  CompanyStateBuilder();

  CompanyStateBuilder get _$this {
    if (_$v != null) {
      _company = _$v.company?.toBuilder();
      _dashboardState = _$v.dashboardState?.toBuilder();
      _productState = _$v.productState?.toBuilder();
      _clientState = _$v.clientState?.toBuilder();
      _invoiceState = _$v.invoiceState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$CompanyState;
  }

  @override
  void update(void updates(CompanyStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CompanyState build() {
    _$CompanyState _$result;
    try {
      _$result = _$v ??
          new _$CompanyState._(
              company: _company?.build(),
              dashboardState: dashboardState.build(),
              productState: productState.build(),
              clientState: clientState.build(),
              invoiceState: invoiceState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'company';
        _company?.build();
        _$failedField = 'dashboardState';
        dashboardState.build();
        _$failedField = 'productState';
        productState.build();
        _$failedField = 'clientState';
        clientState.build();
        _$failedField = 'invoiceState';
        invoiceState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CompanyState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
