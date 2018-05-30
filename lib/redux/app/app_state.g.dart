// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

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

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable serialize(Serializers serializers, AppState object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'authState',
      serializers.serialize(object.authState,
          specifiedType: const FullType(AuthState)),
      'selectedCompanyIndex',
      serializers.serialize(object.selectedCompanyIndex,
          specifiedType: const FullType(int)),
      'companyState1',
      serializers.serialize(object.companyState1,
          specifiedType: const FullType(CompanyState)),
      'companyState2',
      serializers.serialize(object.companyState2,
          specifiedType: const FullType(CompanyState)),
      'companyState3',
      serializers.serialize(object.companyState3,
          specifiedType: const FullType(CompanyState)),
      'companyState4',
      serializers.serialize(object.companyState4,
          specifiedType: const FullType(CompanyState)),
      'companyState5',
      serializers.serialize(object.companyState5,
          specifiedType: const FullType(CompanyState)),
      'uiState',
      serializers.serialize(object.uiState,
          specifiedType: const FullType(UIState)),
    ];

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'authState':
          result.authState.replace(serializers.deserialize(value,
              specifiedType: const FullType(AuthState)) as AuthState);
          break;
        case 'selectedCompanyIndex':
          result.selectedCompanyIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'companyState1':
          result.companyState1.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyState)) as CompanyState);
          break;
        case 'companyState2':
          result.companyState2.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyState)) as CompanyState);
          break;
        case 'companyState3':
          result.companyState3.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyState)) as CompanyState);
          break;
        case 'companyState4':
          result.companyState4.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyState)) as CompanyState);
          break;
        case 'companyState5':
          result.companyState5.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyState)) as CompanyState);
          break;
        case 'uiState':
          result.uiState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UIState)) as UIState);
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final bool isLoading;
  @override
  final AuthState authState;
  @override
  final int selectedCompanyIndex;
  @override
  final CompanyState companyState1;
  @override
  final CompanyState companyState2;
  @override
  final CompanyState companyState3;
  @override
  final CompanyState companyState4;
  @override
  final CompanyState companyState5;
  @override
  final UIState uiState;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.isLoading,
      this.authState,
      this.selectedCompanyIndex,
      this.companyState1,
      this.companyState2,
      this.companyState3,
      this.companyState4,
      this.companyState5,
      this.uiState})
      : super._() {
    if (isLoading == null)
      throw new BuiltValueNullFieldError('AppState', 'isLoading');
    if (authState == null)
      throw new BuiltValueNullFieldError('AppState', 'authState');
    if (selectedCompanyIndex == null)
      throw new BuiltValueNullFieldError('AppState', 'selectedCompanyIndex');
    if (companyState1 == null)
      throw new BuiltValueNullFieldError('AppState', 'companyState1');
    if (companyState2 == null)
      throw new BuiltValueNullFieldError('AppState', 'companyState2');
    if (companyState3 == null)
      throw new BuiltValueNullFieldError('AppState', 'companyState3');
    if (companyState4 == null)
      throw new BuiltValueNullFieldError('AppState', 'companyState4');
    if (companyState5 == null)
      throw new BuiltValueNullFieldError('AppState', 'companyState5');
    if (uiState == null)
      throw new BuiltValueNullFieldError('AppState', 'uiState');
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppState) return false;
    return isLoading == other.isLoading &&
        authState == other.authState &&
        selectedCompanyIndex == other.selectedCompanyIndex &&
        companyState1 == other.companyState1 &&
        companyState2 == other.companyState2 &&
        companyState3 == other.companyState3 &&
        companyState4 == other.companyState4 &&
        companyState5 == other.companyState5 &&
        uiState == other.uiState;
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
                                $jc($jc(0, isLoading.hashCode),
                                    authState.hashCode),
                                selectedCompanyIndex.hashCode),
                            companyState1.hashCode),
                        companyState2.hashCode),
                    companyState3.hashCode),
                companyState4.hashCode),
            companyState5.hashCode),
        uiState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('isLoading', isLoading)
          ..add('authState', authState)
          ..add('selectedCompanyIndex', selectedCompanyIndex)
          ..add('companyState1', companyState1)
          ..add('companyState2', companyState2)
          ..add('companyState3', companyState3)
          ..add('companyState4', companyState4)
          ..add('companyState5', companyState5)
          ..add('uiState', uiState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  AuthStateBuilder _authState;
  AuthStateBuilder get authState =>
      _$this._authState ??= new AuthStateBuilder();
  set authState(AuthStateBuilder authState) => _$this._authState = authState;

  int _selectedCompanyIndex;
  int get selectedCompanyIndex => _$this._selectedCompanyIndex;
  set selectedCompanyIndex(int selectedCompanyIndex) =>
      _$this._selectedCompanyIndex = selectedCompanyIndex;

  CompanyStateBuilder _companyState1;
  CompanyStateBuilder get companyState1 =>
      _$this._companyState1 ??= new CompanyStateBuilder();
  set companyState1(CompanyStateBuilder companyState1) =>
      _$this._companyState1 = companyState1;

  CompanyStateBuilder _companyState2;
  CompanyStateBuilder get companyState2 =>
      _$this._companyState2 ??= new CompanyStateBuilder();
  set companyState2(CompanyStateBuilder companyState2) =>
      _$this._companyState2 = companyState2;

  CompanyStateBuilder _companyState3;
  CompanyStateBuilder get companyState3 =>
      _$this._companyState3 ??= new CompanyStateBuilder();
  set companyState3(CompanyStateBuilder companyState3) =>
      _$this._companyState3 = companyState3;

  CompanyStateBuilder _companyState4;
  CompanyStateBuilder get companyState4 =>
      _$this._companyState4 ??= new CompanyStateBuilder();
  set companyState4(CompanyStateBuilder companyState4) =>
      _$this._companyState4 = companyState4;

  CompanyStateBuilder _companyState5;
  CompanyStateBuilder get companyState5 =>
      _$this._companyState5 ??= new CompanyStateBuilder();
  set companyState5(CompanyStateBuilder companyState5) =>
      _$this._companyState5 = companyState5;

  UIStateBuilder _uiState;
  UIStateBuilder get uiState => _$this._uiState ??= new UIStateBuilder();
  set uiState(UIStateBuilder uiState) => _$this._uiState = uiState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _authState = _$v.authState?.toBuilder();
      _selectedCompanyIndex = _$v.selectedCompanyIndex;
      _companyState1 = _$v.companyState1?.toBuilder();
      _companyState2 = _$v.companyState2?.toBuilder();
      _companyState3 = _$v.companyState3?.toBuilder();
      _companyState4 = _$v.companyState4?.toBuilder();
      _companyState5 = _$v.companyState5?.toBuilder();
      _uiState = _$v.uiState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              isLoading: isLoading,
              authState: authState.build(),
              selectedCompanyIndex: selectedCompanyIndex,
              companyState1: companyState1.build(),
              companyState2: companyState2.build(),
              companyState3: companyState3.build(),
              companyState4: companyState4.build(),
              companyState5: companyState5.build(),
              uiState: uiState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'authState';
        authState.build();

        _$failedField = 'companyState1';
        companyState1.build();
        _$failedField = 'companyState2';
        companyState2.build();
        _$failedField = 'companyState3';
        companyState3.build();
        _$failedField = 'companyState4';
        companyState4.build();
        _$failedField = 'companyState5';
        companyState5.build();
        _$failedField = 'uiState';
        uiState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
