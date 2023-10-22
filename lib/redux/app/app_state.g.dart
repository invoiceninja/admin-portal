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
  Iterable<Object?> serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'isSaving',
      serializers.serialize(object.isSaving,
          specifiedType: const FullType(bool)),
      'isTesting',
      serializers.serialize(object.isTesting,
          specifiedType: const FullType(bool)),
      'isWhiteLabeled',
      serializers.serialize(object.isWhiteLabeled,
          specifiedType: const FullType(bool)),
      'dismissedNativeWarning',
      serializers.serialize(object.dismissedNativeWarning,
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
  AppState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isSaving':
          result.isSaving = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isTesting':
          result.isTesting = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isWhiteLabeled':
          result.isWhiteLabeled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'dismissedNativeWarning':
          result.dismissedNativeWarning = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'lastError':
          result.lastError = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'authState':
          result.authState.replace(serializers.deserialize(value,
              specifiedType: const FullType(AuthState))! as AuthState);
          break;
        case 'staticState':
          result.staticState.replace(serializers.deserialize(value,
              specifiedType: const FullType(StaticState))! as StaticState);
          break;
        case 'prefState':
          result.prefState.replace(serializers.deserialize(value,
              specifiedType: const FullType(PrefState))! as PrefState);
          break;
        case 'uiState':
          result.uiState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UIState))! as UIState);
          break;
        case 'userCompanyStates':
          result.userCompanyStates.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(UserCompanyState)]))!
              as BuiltList<Object?>);
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
  final bool isWhiteLabeled;
  @override
  final bool dismissedNativeWarning;
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

  factory _$AppState([void Function(AppStateBuilder)? updates]) =>
      (new AppStateBuilder()..update(updates))._build();

  _$AppState._(
      {required this.isLoading,
      required this.isSaving,
      required this.isTesting,
      required this.isWhiteLabeled,
      required this.dismissedNativeWarning,
      required this.lastError,
      required this.authState,
      required this.staticState,
      required this.prefState,
      required this.uiState,
      required this.userCompanyStates})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(isLoading, r'AppState', 'isLoading');
    BuiltValueNullFieldError.checkNotNull(isSaving, r'AppState', 'isSaving');
    BuiltValueNullFieldError.checkNotNull(isTesting, r'AppState', 'isTesting');
    BuiltValueNullFieldError.checkNotNull(
        isWhiteLabeled, r'AppState', 'isWhiteLabeled');
    BuiltValueNullFieldError.checkNotNull(
        dismissedNativeWarning, r'AppState', 'dismissedNativeWarning');
    BuiltValueNullFieldError.checkNotNull(lastError, r'AppState', 'lastError');
    BuiltValueNullFieldError.checkNotNull(authState, r'AppState', 'authState');
    BuiltValueNullFieldError.checkNotNull(
        staticState, r'AppState', 'staticState');
    BuiltValueNullFieldError.checkNotNull(prefState, r'AppState', 'prefState');
    BuiltValueNullFieldError.checkNotNull(uiState, r'AppState', 'uiState');
    BuiltValueNullFieldError.checkNotNull(
        userCompanyStates, r'AppState', 'userCompanyStates');
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
        isWhiteLabeled == other.isWhiteLabeled &&
        dismissedNativeWarning == other.dismissedNativeWarning &&
        lastError == other.lastError &&
        authState == other.authState &&
        staticState == other.staticState &&
        prefState == other.prefState &&
        uiState == other.uiState &&
        userCompanyStates == other.userCompanyStates;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, isLoading.hashCode);
    _$hash = $jc(_$hash, isSaving.hashCode);
    _$hash = $jc(_$hash, isTesting.hashCode);
    _$hash = $jc(_$hash, isWhiteLabeled.hashCode);
    _$hash = $jc(_$hash, dismissedNativeWarning.hashCode);
    _$hash = $jc(_$hash, lastError.hashCode);
    _$hash = $jc(_$hash, authState.hashCode);
    _$hash = $jc(_$hash, staticState.hashCode);
    _$hash = $jc(_$hash, prefState.hashCode);
    _$hash = $jc(_$hash, uiState.hashCode);
    _$hash = $jc(_$hash, userCompanyStates.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState? _$v;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  bool? _isSaving;
  bool? get isSaving => _$this._isSaving;
  set isSaving(bool? isSaving) => _$this._isSaving = isSaving;

  bool? _isTesting;
  bool? get isTesting => _$this._isTesting;
  set isTesting(bool? isTesting) => _$this._isTesting = isTesting;

  bool? _isWhiteLabeled;
  bool? get isWhiteLabeled => _$this._isWhiteLabeled;
  set isWhiteLabeled(bool? isWhiteLabeled) =>
      _$this._isWhiteLabeled = isWhiteLabeled;

  bool? _dismissedNativeWarning;
  bool? get dismissedNativeWarning => _$this._dismissedNativeWarning;
  set dismissedNativeWarning(bool? dismissedNativeWarning) =>
      _$this._dismissedNativeWarning = dismissedNativeWarning;

  String? _lastError;
  String? get lastError => _$this._lastError;
  set lastError(String? lastError) => _$this._lastError = lastError;

  AuthStateBuilder? _authState;
  AuthStateBuilder get authState =>
      _$this._authState ??= new AuthStateBuilder();
  set authState(AuthStateBuilder? authState) => _$this._authState = authState;

  StaticStateBuilder? _staticState;
  StaticStateBuilder get staticState =>
      _$this._staticState ??= new StaticStateBuilder();
  set staticState(StaticStateBuilder? staticState) =>
      _$this._staticState = staticState;

  PrefStateBuilder? _prefState;
  PrefStateBuilder get prefState =>
      _$this._prefState ??= new PrefStateBuilder();
  set prefState(PrefStateBuilder? prefState) => _$this._prefState = prefState;

  UIStateBuilder? _uiState;
  UIStateBuilder get uiState => _$this._uiState ??= new UIStateBuilder();
  set uiState(UIStateBuilder? uiState) => _$this._uiState = uiState;

  ListBuilder<UserCompanyState>? _userCompanyStates;
  ListBuilder<UserCompanyState> get userCompanyStates =>
      _$this._userCompanyStates ??= new ListBuilder<UserCompanyState>();
  set userCompanyStates(ListBuilder<UserCompanyState>? userCompanyStates) =>
      _$this._userCompanyStates = userCompanyStates;

  AppStateBuilder();

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isLoading = $v.isLoading;
      _isSaving = $v.isSaving;
      _isTesting = $v.isTesting;
      _isWhiteLabeled = $v.isWhiteLabeled;
      _dismissedNativeWarning = $v.dismissedNativeWarning;
      _lastError = $v.lastError;
      _authState = $v.authState.toBuilder();
      _staticState = $v.staticState.toBuilder();
      _prefState = $v.prefState.toBuilder();
      _uiState = $v.uiState.toBuilder();
      _userCompanyStates = $v.userCompanyStates.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppState build() => _build();

  _$AppState _build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              isLoading: BuiltValueNullFieldError.checkNotNull(
                  isLoading, r'AppState', 'isLoading'),
              isSaving: BuiltValueNullFieldError.checkNotNull(
                  isSaving, r'AppState', 'isSaving'),
              isTesting: BuiltValueNullFieldError.checkNotNull(
                  isTesting, r'AppState', 'isTesting'),
              isWhiteLabeled: BuiltValueNullFieldError.checkNotNull(
                  isWhiteLabeled, r'AppState', 'isWhiteLabeled'),
              dismissedNativeWarning: BuiltValueNullFieldError.checkNotNull(
                  dismissedNativeWarning,
                  r'AppState',
                  'dismissedNativeWarning'),
              lastError: BuiltValueNullFieldError.checkNotNull(
                  lastError, r'AppState', 'lastError'),
              authState: authState.build(),
              staticState: staticState.build(),
              prefState: prefState.build(),
              uiState: uiState.build(),
              userCompanyStates: userCompanyStates.build());
    } catch (_) {
      late String _$failedField;
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
            r'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
