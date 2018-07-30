// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state.dart';

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

Serializer<UIState> _$uIStateSerializer = new _$UIStateSerializer();

class _$UIStateSerializer implements StructuredSerializer<UIState> {
  @override
  final Iterable<Type> types = const [UIState, _$UIState];
  @override
  final String wireName = 'UIState';

  @override
  Iterable serialize(Serializers serializers, UIState object,
      {FullType specifiedType: FullType.unspecified}) {
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
      'productUIState',
      serializers.serialize(object.productUIState,
          specifiedType: const FullType(ProductUIState)),
      'clientUIState',
      serializers.serialize(object.clientUIState,
          specifiedType: const FullType(ClientUIState)),
      'invoiceUIState',
      serializers.serialize(object.invoiceUIState,
          specifiedType: const FullType(InvoiceUIState)),
    ];

    return result;
  }

  @override
  UIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
  final ProductUIState productUIState;
  @override
  final ClientUIState clientUIState;
  @override
  final InvoiceUIState invoiceUIState;

  factory _$UIState([void updates(UIStateBuilder b)]) =>
      (new UIStateBuilder()..update(updates)).build();

  _$UIState._(
      {this.selectedCompanyIndex,
      this.currentRoute,
      this.enableDarkMode,
      this.productUIState,
      this.clientUIState,
      this.invoiceUIState})
      : super._() {
    if (selectedCompanyIndex == null)
      throw new BuiltValueNullFieldError('UIState', 'selectedCompanyIndex');
    if (currentRoute == null)
      throw new BuiltValueNullFieldError('UIState', 'currentRoute');
    if (enableDarkMode == null)
      throw new BuiltValueNullFieldError('UIState', 'enableDarkMode');
    if (productUIState == null)
      throw new BuiltValueNullFieldError('UIState', 'productUIState');
    if (clientUIState == null)
      throw new BuiltValueNullFieldError('UIState', 'clientUIState');
    if (invoiceUIState == null)
      throw new BuiltValueNullFieldError('UIState', 'invoiceUIState');
  }

  @override
  UIState rebuild(void updates(UIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UIStateBuilder toBuilder() => new UIStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! UIState) return false;
    return selectedCompanyIndex == other.selectedCompanyIndex &&
        currentRoute == other.currentRoute &&
        enableDarkMode == other.enableDarkMode &&
        productUIState == other.productUIState &&
        clientUIState == other.clientUIState &&
        invoiceUIState == other.invoiceUIState;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc(0, selectedCompanyIndex.hashCode),
                        currentRoute.hashCode),
                    enableDarkMode.hashCode),
                productUIState.hashCode),
            clientUIState.hashCode),
        invoiceUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UIState')
          ..add('selectedCompanyIndex', selectedCompanyIndex)
          ..add('currentRoute', currentRoute)
          ..add('enableDarkMode', enableDarkMode)
          ..add('productUIState', productUIState)
          ..add('clientUIState', clientUIState)
          ..add('invoiceUIState', invoiceUIState))
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

  UIStateBuilder();

  UIStateBuilder get _$this {
    if (_$v != null) {
      _selectedCompanyIndex = _$v.selectedCompanyIndex;
      _currentRoute = _$v.currentRoute;
      _enableDarkMode = _$v.enableDarkMode;
      _productUIState = _$v.productUIState?.toBuilder();
      _clientUIState = _$v.clientUIState?.toBuilder();
      _invoiceUIState = _$v.invoiceUIState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UIState other) {
    if (other == null) throw new ArgumentError.notNull('other');
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
              productUIState: productUIState.build(),
              clientUIState: clientUIState.build(),
              invoiceUIState: invoiceUIState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'productUIState';
        productUIState.build();
        _$failedField = 'clientUIState';
        clientUIState.build();
        _$failedField = 'invoiceUIState';
        invoiceUIState.build();
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
