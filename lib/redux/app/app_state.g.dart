// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable<Object> serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'isSaving',
      serializers.serialize(object.isSaving,
          specifiedType: const FullType(bool)),
      'lastError',
      serializers.serialize(object.lastError,
          specifiedType: const FullType(String)),
      'serverVersion',
      serializers.serialize(object.serverVersion,
          specifiedType: const FullType(String)),
      'authState',
      serializers.serialize(object.authState,
          specifiedType: const FullType(AuthState)),
      'staticState',
      serializers.serialize(object.staticState,
          specifiedType: const FullType(StaticState)),
      'uiState',
      serializers.serialize(object.uiState,
          specifiedType: const FullType(UIState)),
      'companyState1',
      serializers.serialize(object.companyState1,
          specifiedType: const FullType(UserCompanyState)),
      'companyState2',
      serializers.serialize(object.companyState2,
          specifiedType: const FullType(UserCompanyState)),
      'companyState3',
      serializers.serialize(object.companyState3,
          specifiedType: const FullType(UserCompanyState)),
      'companyState4',
      serializers.serialize(object.companyState4,
          specifiedType: const FullType(UserCompanyState)),
      'companyState5',
      serializers.serialize(object.companyState5,
          specifiedType: const FullType(UserCompanyState)),
      'companyState6',
      serializers.serialize(object.companyState6,
          specifiedType: const FullType(UserCompanyState)),
      'companyState7',
      serializers.serialize(object.companyState7,
          specifiedType: const FullType(UserCompanyState)),
      'companyState8',
      serializers.serialize(object.companyState8,
          specifiedType: const FullType(UserCompanyState)),
      'companyState9',
      serializers.serialize(object.companyState9,
          specifiedType: const FullType(UserCompanyState)),
      'companyState10',
      serializers.serialize(object.companyState10,
          specifiedType: const FullType(UserCompanyState)),
    ];

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
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
        case 'isSaving':
          result.isSaving = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'lastError':
          result.lastError = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'serverVersion':
          result.serverVersion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'authState':
          result.authState.replace(serializers.deserialize(value,
              specifiedType: const FullType(AuthState)) as AuthState);
          break;
        case 'staticState':
          result.staticState.replace(serializers.deserialize(value,
              specifiedType: const FullType(StaticState)) as StaticState);
          break;
        case 'uiState':
          result.uiState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UIState)) as UIState);
          break;
        case 'companyState1':
          result.companyState1.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
          break;
        case 'companyState2':
          result.companyState2.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
          break;
        case 'companyState3':
          result.companyState3.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
          break;
        case 'companyState4':
          result.companyState4.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
          break;
        case 'companyState5':
          result.companyState5.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
          break;
        case 'companyState6':
          result.companyState6.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
          break;
        case 'companyState7':
          result.companyState7.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
          break;
        case 'companyState8':
          result.companyState8.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
          break;
        case 'companyState9':
          result.companyState9.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
          break;
        case 'companyState10':
          result.companyState10.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyState))
              as UserCompanyState);
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
  final bool isSaving;
  @override
  final String lastError;
  @override
  final String serverVersion;
  @override
  final AuthState authState;
  @override
  final StaticState staticState;
  @override
  final UIState uiState;
  @override
  final UserCompanyState companyState1;
  @override
  final UserCompanyState companyState2;
  @override
  final UserCompanyState companyState3;
  @override
  final UserCompanyState companyState4;
  @override
  final UserCompanyState companyState5;
  @override
  final UserCompanyState companyState6;
  @override
  final UserCompanyState companyState7;
  @override
  final UserCompanyState companyState8;
  @override
  final UserCompanyState companyState9;
  @override
  final UserCompanyState companyState10;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.isLoading,
      this.isSaving,
      this.lastError,
      this.serverVersion,
      this.authState,
      this.staticState,
      this.uiState,
      this.companyState1,
      this.companyState2,
      this.companyState3,
      this.companyState4,
      this.companyState5,
      this.companyState6,
      this.companyState7,
      this.companyState8,
      this.companyState9,
      this.companyState10})
      : super._() {
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('AppState', 'isLoading');
    }
    if (isSaving == null) {
      throw new BuiltValueNullFieldError('AppState', 'isSaving');
    }
    if (lastError == null) {
      throw new BuiltValueNullFieldError('AppState', 'lastError');
    }
    if (serverVersion == null) {
      throw new BuiltValueNullFieldError('AppState', 'serverVersion');
    }
    if (authState == null) {
      throw new BuiltValueNullFieldError('AppState', 'authState');
    }
    if (staticState == null) {
      throw new BuiltValueNullFieldError('AppState', 'staticState');
    }
    if (uiState == null) {
      throw new BuiltValueNullFieldError('AppState', 'uiState');
    }
    if (companyState1 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState1');
    }
    if (companyState2 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState2');
    }
    if (companyState3 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState3');
    }
    if (companyState4 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState4');
    }
    if (companyState5 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState5');
    }
    if (companyState6 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState6');
    }
    if (companyState7 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState7');
    }
    if (companyState8 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState8');
    }
    if (companyState9 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState9');
    }
    if (companyState10 == null) {
      throw new BuiltValueNullFieldError('AppState', 'companyState10');
    }
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        isLoading == other.isLoading &&
        isSaving == other.isSaving &&
        lastError == other.lastError &&
        serverVersion == other.serverVersion &&
        authState == other.authState &&
        staticState == other.staticState &&
        uiState == other.uiState &&
        companyState1 == other.companyState1 &&
        companyState2 == other.companyState2 &&
        companyState3 == other.companyState3 &&
        companyState4 == other.companyState4 &&
        companyState5 == other.companyState5 &&
        companyState6 == other.companyState6 &&
        companyState7 == other.companyState7 &&
        companyState8 == other.companyState8 &&
        companyState9 == other.companyState9 &&
        companyState10 == other.companyState10;
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
                                                                        isLoading
                                                                            .hashCode),
                                                                    isSaving
                                                                        .hashCode),
                                                                lastError
                                                                    .hashCode),
                                                            serverVersion
                                                                .hashCode),
                                                        authState.hashCode),
                                                    staticState.hashCode),
                                                uiState.hashCode),
                                            companyState1.hashCode),
                                        companyState2.hashCode),
                                    companyState3.hashCode),
                                companyState4.hashCode),
                            companyState5.hashCode),
                        companyState6.hashCode),
                    companyState7.hashCode),
                companyState8.hashCode),
            companyState9.hashCode),
        companyState10.hashCode));
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  bool _isSaving;
  bool get isSaving => _$this._isSaving;
  set isSaving(bool isSaving) => _$this._isSaving = isSaving;

  String _lastError;
  String get lastError => _$this._lastError;
  set lastError(String lastError) => _$this._lastError = lastError;

  String _serverVersion;
  String get serverVersion => _$this._serverVersion;
  set serverVersion(String serverVersion) =>
      _$this._serverVersion = serverVersion;

  AuthStateBuilder _authState;
  AuthStateBuilder get authState =>
      _$this._authState ??= new AuthStateBuilder();
  set authState(AuthStateBuilder authState) => _$this._authState = authState;

  StaticStateBuilder _staticState;
  StaticStateBuilder get staticState =>
      _$this._staticState ??= new StaticStateBuilder();
  set staticState(StaticStateBuilder staticState) =>
      _$this._staticState = staticState;

  UIStateBuilder _uiState;
  UIStateBuilder get uiState => _$this._uiState ??= new UIStateBuilder();
  set uiState(UIStateBuilder uiState) => _$this._uiState = uiState;

  UserCompanyStateBuilder _companyState1;
  UserCompanyStateBuilder get companyState1 =>
      _$this._companyState1 ??= new UserCompanyStateBuilder();
  set companyState1(UserCompanyStateBuilder companyState1) =>
      _$this._companyState1 = companyState1;

  UserCompanyStateBuilder _companyState2;
  UserCompanyStateBuilder get companyState2 =>
      _$this._companyState2 ??= new UserCompanyStateBuilder();
  set companyState2(UserCompanyStateBuilder companyState2) =>
      _$this._companyState2 = companyState2;

  UserCompanyStateBuilder _companyState3;
  UserCompanyStateBuilder get companyState3 =>
      _$this._companyState3 ??= new UserCompanyStateBuilder();
  set companyState3(UserCompanyStateBuilder companyState3) =>
      _$this._companyState3 = companyState3;

  UserCompanyStateBuilder _companyState4;
  UserCompanyStateBuilder get companyState4 =>
      _$this._companyState4 ??= new UserCompanyStateBuilder();
  set companyState4(UserCompanyStateBuilder companyState4) =>
      _$this._companyState4 = companyState4;

  UserCompanyStateBuilder _companyState5;
  UserCompanyStateBuilder get companyState5 =>
      _$this._companyState5 ??= new UserCompanyStateBuilder();
  set companyState5(UserCompanyStateBuilder companyState5) =>
      _$this._companyState5 = companyState5;

  UserCompanyStateBuilder _companyState6;
  UserCompanyStateBuilder get companyState6 =>
      _$this._companyState6 ??= new UserCompanyStateBuilder();
  set companyState6(UserCompanyStateBuilder companyState6) =>
      _$this._companyState6 = companyState6;

  UserCompanyStateBuilder _companyState7;
  UserCompanyStateBuilder get companyState7 =>
      _$this._companyState7 ??= new UserCompanyStateBuilder();
  set companyState7(UserCompanyStateBuilder companyState7) =>
      _$this._companyState7 = companyState7;

  UserCompanyStateBuilder _companyState8;
  UserCompanyStateBuilder get companyState8 =>
      _$this._companyState8 ??= new UserCompanyStateBuilder();
  set companyState8(UserCompanyStateBuilder companyState8) =>
      _$this._companyState8 = companyState8;

  UserCompanyStateBuilder _companyState9;
  UserCompanyStateBuilder get companyState9 =>
      _$this._companyState9 ??= new UserCompanyStateBuilder();
  set companyState9(UserCompanyStateBuilder companyState9) =>
      _$this._companyState9 = companyState9;

  UserCompanyStateBuilder _companyState10;
  UserCompanyStateBuilder get companyState10 =>
      _$this._companyState10 ??= new UserCompanyStateBuilder();
  set companyState10(UserCompanyStateBuilder companyState10) =>
      _$this._companyState10 = companyState10;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _isSaving = _$v.isSaving;
      _lastError = _$v.lastError;
      _serverVersion = _$v.serverVersion;
      _authState = _$v.authState?.toBuilder();
      _staticState = _$v.staticState?.toBuilder();
      _uiState = _$v.uiState?.toBuilder();
      _companyState1 = _$v.companyState1?.toBuilder();
      _companyState2 = _$v.companyState2?.toBuilder();
      _companyState3 = _$v.companyState3?.toBuilder();
      _companyState4 = _$v.companyState4?.toBuilder();
      _companyState5 = _$v.companyState5?.toBuilder();
      _companyState6 = _$v.companyState6?.toBuilder();
      _companyState7 = _$v.companyState7?.toBuilder();
      _companyState8 = _$v.companyState8?.toBuilder();
      _companyState9 = _$v.companyState9?.toBuilder();
      _companyState10 = _$v.companyState10?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              isLoading: isLoading,
              isSaving: isSaving,
              lastError: lastError,
              serverVersion: serverVersion,
              authState: authState.build(),
              staticState: staticState.build(),
              uiState: uiState.build(),
              companyState1: companyState1.build(),
              companyState2: companyState2.build(),
              companyState3: companyState3.build(),
              companyState4: companyState4.build(),
              companyState5: companyState5.build(),
              companyState6: companyState6.build(),
              companyState7: companyState7.build(),
              companyState8: companyState8.build(),
              companyState9: companyState9.build(),
              companyState10: companyState10.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'authState';
        authState.build();
        _$failedField = 'staticState';
        staticState.build();
        _$failedField = 'uiState';
        uiState.build();
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
        _$failedField = 'companyState6';
        companyState6.build();
        _$failedField = 'companyState7';
        companyState7.build();
        _$failedField = 'companyState8';
        companyState8.build();
        _$failedField = 'companyState9';
        companyState9.build();
        _$failedField = 'companyState10';
        companyState10.build();
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
