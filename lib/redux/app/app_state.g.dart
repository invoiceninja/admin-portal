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
      'isTesting',
      serializers.serialize(object.isTesting,
          specifiedType: const FullType(bool)),
      'lastError',
      serializers.serialize(object.lastError,
          specifiedType: const FullType(String)),
      'authState',
      serializers.serialize(object.authState,
          specifiedType: const FullType(AuthState)),
      'staticState',
      serializers.serialize(object.staticState,
          specifiedType: const FullType(StaticState)),
      'prefState',
      serializers.serialize(object.prefState,
          specifiedType: const FullType(PrefState)),
      'uiState',
      serializers.serialize(object.uiState,
          specifiedType: const FullType(UIState)),
      'userCompanyStates',
      serializers.serialize(object.userCompanyStates,
          specifiedType: const FullType(
              BuiltList, const [const FullType(UserCompanyState)])),
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
        case 'isTesting':
          result.isTesting = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'lastError':
          result.lastError = serializers.deserialize(value,
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
        case 'prefState':
          result.prefState.replace(serializers.deserialize(value,
              specifiedType: const FullType(PrefState)) as PrefState);
          break;
        case 'uiState':
          result.uiState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UIState)) as UIState);
          break;
        case 'userCompanyStates':
          result.userCompanyStates.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(UserCompanyState)]))
              as BuiltList<Object>);
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
  final bool isTesting;
  @override
  final String lastError;
  @override
  final AuthState authState;
  @override
  final StaticState staticState;
  @override
  final PrefState prefState;
  @override
  final UIState uiState;
  @override
  final BuiltList<UserCompanyState> userCompanyStates;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.isLoading,
      this.isSaving,
      this.isTesting,
      this.lastError,
      this.authState,
      this.staticState,
      this.prefState,
      this.uiState,
      this.userCompanyStates})
      : super._() {
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('AppState', 'isLoading');
    }
    if (isSaving == null) {
      throw new BuiltValueNullFieldError('AppState', 'isSaving');
    }
    if (isTesting == null) {
      throw new BuiltValueNullFieldError('AppState', 'isTesting');
    }
    if (lastError == null) {
      throw new BuiltValueNullFieldError('AppState', 'lastError');
    }
    if (authState == null) {
      throw new BuiltValueNullFieldError('AppState', 'authState');
    }
    if (staticState == null) {
      throw new BuiltValueNullFieldError('AppState', 'staticState');
    }
    if (prefState == null) {
      throw new BuiltValueNullFieldError('AppState', 'prefState');
    }
    if (uiState == null) {
      throw new BuiltValueNullFieldError('AppState', 'uiState');
    }
    if (userCompanyStates == null) {
      throw new BuiltValueNullFieldError('AppState', 'userCompanyStates');
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
        isTesting == other.isTesting &&
        lastError == other.lastError &&
        authState == other.authState &&
        staticState == other.staticState &&
        prefState == other.prefState &&
        uiState == other.uiState &&
        userCompanyStates == other.userCompanyStates;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, isLoading.hashCode),
                                    isSaving.hashCode),
                                isTesting.hashCode),
                            lastError.hashCode),
                        authState.hashCode),
                    staticState.hashCode),
                prefState.hashCode),
            uiState.hashCode),
        userCompanyStates.hashCode));
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

  bool _isTesting;
  bool get isTesting => _$this._isTesting;
  set isTesting(bool isTesting) => _$this._isTesting = isTesting;

  String _lastError;
  String get lastError => _$this._lastError;
  set lastError(String lastError) => _$this._lastError = lastError;

  AuthStateBuilder _authState;
  AuthStateBuilder get authState =>
      _$this._authState ??= new AuthStateBuilder();
  set authState(AuthStateBuilder authState) => _$this._authState = authState;

  StaticStateBuilder _staticState;
  StaticStateBuilder get staticState =>
      _$this._staticState ??= new StaticStateBuilder();
  set staticState(StaticStateBuilder staticState) =>
      _$this._staticState = staticState;

  PrefStateBuilder _prefState;
  PrefStateBuilder get prefState =>
      _$this._prefState ??= new PrefStateBuilder();
  set prefState(PrefStateBuilder prefState) => _$this._prefState = prefState;

  UIStateBuilder _uiState;
  UIStateBuilder get uiState => _$this._uiState ??= new UIStateBuilder();
  set uiState(UIStateBuilder uiState) => _$this._uiState = uiState;

  ListBuilder<UserCompanyState> _userCompanyStates;
  ListBuilder<UserCompanyState> get userCompanyStates =>
      _$this._userCompanyStates ??= new ListBuilder<UserCompanyState>();
  set userCompanyStates(ListBuilder<UserCompanyState> userCompanyStates) =>
      _$this._userCompanyStates = userCompanyStates;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _isSaving = _$v.isSaving;
      _isTesting = _$v.isTesting;
      _lastError = _$v.lastError;
      _authState = _$v.authState?.toBuilder();
      _staticState = _$v.staticState?.toBuilder();
      _prefState = _$v.prefState?.toBuilder();
      _uiState = _$v.uiState?.toBuilder();
      _userCompanyStates = _$v.userCompanyStates?.toBuilder();
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
              isTesting: isTesting,
              lastError: lastError,
              authState: authState.build(),
              staticState: staticState.build(),
              prefState: prefState.build(),
              uiState: uiState.build(),
              userCompanyStates: userCompanyStates.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'authState';
        authState.build();
        _$failedField = 'staticState';
        staticState.build();
        _$failedField = 'prefState';
        prefState.build();
        _$failedField = 'uiState';
        uiState.build();
        _$failedField = 'userCompanyStates';
        userCompanyStates.build();
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
