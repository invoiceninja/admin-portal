// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state.dart';

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
      'currentRoute',
      serializers.serialize(object.currentRoute,
          specifiedType: const FullType(String)),
      'productUIState',
      serializers.serialize(object.productUIState,
          specifiedType: const FullType(EntityUIState)),
      'clientUIState',
      serializers.serialize(object.clientUIState,
          specifiedType: const FullType(EntityUIState)),
      'invoiceUIState',
      serializers.serialize(object.invoiceUIState,
          specifiedType: const FullType(EntityUIState)),
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
        case 'currentRoute':
          result.currentRoute = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'productUIState':
          result.productUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(EntityUIState)) as EntityUIState);
          break;
        case 'clientUIState':
          result.clientUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(EntityUIState)) as EntityUIState);
          break;
        case 'invoiceUIState':
          result.invoiceUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(EntityUIState)) as EntityUIState);
          break;
      }
    }

    return result.build();
  }
}

class _$UIState extends UIState {
  @override
  final String currentRoute;
  @override
  final EntityUIState productUIState;
  @override
  final EntityUIState clientUIState;
  @override
  final EntityUIState invoiceUIState;

  factory _$UIState([void updates(UIStateBuilder b)]) =>
      (new UIStateBuilder()..update(updates)).build();

  _$UIState._(
      {this.currentRoute,
      this.productUIState,
      this.clientUIState,
      this.invoiceUIState})
      : super._() {
    if (currentRoute == null)
      throw new BuiltValueNullFieldError('UIState', 'currentRoute');
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
    return currentRoute == other.currentRoute &&
        productUIState == other.productUIState &&
        clientUIState == other.clientUIState &&
        invoiceUIState == other.invoiceUIState;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, currentRoute.hashCode), productUIState.hashCode),
            clientUIState.hashCode),
        invoiceUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UIState')
          ..add('currentRoute', currentRoute)
          ..add('productUIState', productUIState)
          ..add('clientUIState', clientUIState)
          ..add('invoiceUIState', invoiceUIState))
        .toString();
  }
}

class UIStateBuilder implements Builder<UIState, UIStateBuilder> {
  _$UIState _$v;

  String _currentRoute;
  String get currentRoute => _$this._currentRoute;
  set currentRoute(String currentRoute) => _$this._currentRoute = currentRoute;

  EntityUIStateBuilder _productUIState;
  EntityUIStateBuilder get productUIState =>
      _$this._productUIState ??= new EntityUIStateBuilder();
  set productUIState(EntityUIStateBuilder productUIState) =>
      _$this._productUIState = productUIState;

  EntityUIStateBuilder _clientUIState;
  EntityUIStateBuilder get clientUIState =>
      _$this._clientUIState ??= new EntityUIStateBuilder();
  set clientUIState(EntityUIStateBuilder clientUIState) =>
      _$this._clientUIState = clientUIState;

  EntityUIStateBuilder _invoiceUIState;
  EntityUIStateBuilder get invoiceUIState =>
      _$this._invoiceUIState ??= new EntityUIStateBuilder();
  set invoiceUIState(EntityUIStateBuilder invoiceUIState) =>
      _$this._invoiceUIState = invoiceUIState;

  UIStateBuilder();

  UIStateBuilder get _$this {
    if (_$v != null) {
      _currentRoute = _$v.currentRoute;
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
              currentRoute: currentRoute,
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
