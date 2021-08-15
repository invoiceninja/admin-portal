// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AuthState> _$authStateSerializer = new _$AuthStateSerializer();

class _$AuthStateSerializer implements StructuredSerializer<AuthState> {
  @override
  final Iterable<Type> types = const [AuthState, _$AuthState];
  @override
  final String wireName = 'AuthState';

  @override
  Iterable<Object> serialize(Serializers serializers, AuthState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'isInitialized',
      serializers.serialize(object.isInitialized,
          specifiedType: const FullType(bool)),
      'isAuthenticated',
      serializers.serialize(object.isAuthenticated,
          specifiedType: const FullType(bool)),
      'lastEnteredPasswordAt',
      serializers.serialize(object.lastEnteredPasswordAt,
          specifiedType: const FullType(int)),
      'referralCode',
      serializers.serialize(object.referralCode,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  AuthState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isInitialized':
          result.isInitialized = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isAuthenticated':
          result.isAuthenticated = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'lastEnteredPasswordAt':
          result.lastEnteredPasswordAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'referralCode':
          result.referralCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AuthState extends AuthState {
  @override
  final String email;
  @override
  final String url;
  @override
  final bool isInitialized;
  @override
  final bool isAuthenticated;
  @override
  final int lastEnteredPasswordAt;
  @override
  final String referralCode;

  factory _$AuthState([void Function(AuthStateBuilder) updates]) =>
      (new AuthStateBuilder()..update(updates)).build();

  _$AuthState._(
      {this.email,
      this.url,
      this.isInitialized,
      this.isAuthenticated,
      this.lastEnteredPasswordAt,
      this.referralCode})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, 'AuthState', 'email');
    BuiltValueNullFieldError.checkNotNull(url, 'AuthState', 'url');
    BuiltValueNullFieldError.checkNotNull(
        isInitialized, 'AuthState', 'isInitialized');
    BuiltValueNullFieldError.checkNotNull(
        isAuthenticated, 'AuthState', 'isAuthenticated');
    BuiltValueNullFieldError.checkNotNull(
        lastEnteredPasswordAt, 'AuthState', 'lastEnteredPasswordAt');
    BuiltValueNullFieldError.checkNotNull(
        referralCode, 'AuthState', 'referralCode');
  }

  @override
  AuthState rebuild(void Function(AuthStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthStateBuilder toBuilder() => new AuthStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthState &&
        email == other.email &&
        url == other.url &&
        isInitialized == other.isInitialized &&
        isAuthenticated == other.isAuthenticated &&
        lastEnteredPasswordAt == other.lastEnteredPasswordAt &&
        referralCode == other.referralCode;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, email.hashCode), url.hashCode),
                    isInitialized.hashCode),
                isAuthenticated.hashCode),
            lastEnteredPasswordAt.hashCode),
        referralCode.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthState')
          ..add('email', email)
          ..add('url', url)
          ..add('isInitialized', isInitialized)
          ..add('isAuthenticated', isAuthenticated)
          ..add('lastEnteredPasswordAt', lastEnteredPasswordAt)
          ..add('referralCode', referralCode))
        .toString();
  }
}

class AuthStateBuilder implements Builder<AuthState, AuthStateBuilder> {
  _$AuthState _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  bool _isInitialized;
  bool get isInitialized => _$this._isInitialized;
  set isInitialized(bool isInitialized) =>
      _$this._isInitialized = isInitialized;

  bool _isAuthenticated;
  bool get isAuthenticated => _$this._isAuthenticated;
  set isAuthenticated(bool isAuthenticated) =>
      _$this._isAuthenticated = isAuthenticated;

  int _lastEnteredPasswordAt;
  int get lastEnteredPasswordAt => _$this._lastEnteredPasswordAt;
  set lastEnteredPasswordAt(int lastEnteredPasswordAt) =>
      _$this._lastEnteredPasswordAt = lastEnteredPasswordAt;

  String _referralCode;
  String get referralCode => _$this._referralCode;
  set referralCode(String referralCode) => _$this._referralCode = referralCode;

  AuthStateBuilder() {
    AuthState._initializeBuilder(this);
  }

  AuthStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _url = $v.url;
      _isInitialized = $v.isInitialized;
      _isAuthenticated = $v.isAuthenticated;
      _lastEnteredPasswordAt = $v.lastEnteredPasswordAt;
      _referralCode = $v.referralCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthState;
  }

  @override
  void update(void Function(AuthStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AuthState build() {
    final _$result = _$v ??
        new _$AuthState._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'AuthState', 'email'),
            url: BuiltValueNullFieldError.checkNotNull(url, 'AuthState', 'url'),
            isInitialized: BuiltValueNullFieldError.checkNotNull(
                isInitialized, 'AuthState', 'isInitialized'),
            isAuthenticated: BuiltValueNullFieldError.checkNotNull(
                isAuthenticated, 'AuthState', 'isAuthenticated'),
            lastEnteredPasswordAt: BuiltValueNullFieldError.checkNotNull(
                lastEnteredPasswordAt, 'AuthState', 'lastEnteredPasswordAt'),
            referralCode: BuiltValueNullFieldError.checkNotNull(
                referralCode, 'AuthState', 'referralCode'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
