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
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'secret',
      serializers.serialize(object.secret,
          specifiedType: const FullType(String)),
      'isInitialized',
      serializers.serialize(object.isInitialized,
          specifiedType: const FullType(bool)),
      'isAuthenticated',
      serializers.serialize(object.isAuthenticated,
          specifiedType: const FullType(bool)),
      'lastEnteredPasswordAt',
      serializers.serialize(object.lastEnteredPasswordAt,
          specifiedType: const FullType(int)),
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
      final dynamic value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'secret':
          result.secret = serializers.deserialize(value,
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
      }
    }

    return result.build();
  }
}

class _$AuthState extends AuthState {
  @override
  final String email;
  @override
  final String password;
  @override
  final String url;
  @override
  final String secret;
  @override
  final bool isInitialized;
  @override
  final bool isAuthenticated;
  @override
  final int lastEnteredPasswordAt;

  factory _$AuthState([void Function(AuthStateBuilder) updates]) =>
      (new AuthStateBuilder()..update(updates)).build();

  _$AuthState._(
      {this.email,
      this.password,
      this.url,
      this.secret,
      this.isInitialized,
      this.isAuthenticated,
      this.lastEnteredPasswordAt})
      : super._() {
    if (email == null) {
      throw new BuiltValueNullFieldError('AuthState', 'email');
    }
    if (password == null) {
      throw new BuiltValueNullFieldError('AuthState', 'password');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('AuthState', 'url');
    }
    if (secret == null) {
      throw new BuiltValueNullFieldError('AuthState', 'secret');
    }
    if (isInitialized == null) {
      throw new BuiltValueNullFieldError('AuthState', 'isInitialized');
    }
    if (isAuthenticated == null) {
      throw new BuiltValueNullFieldError('AuthState', 'isAuthenticated');
    }
    if (lastEnteredPasswordAt == null) {
      throw new BuiltValueNullFieldError('AuthState', 'lastEnteredPasswordAt');
    }
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
        password == other.password &&
        url == other.url &&
        secret == other.secret &&
        isInitialized == other.isInitialized &&
        isAuthenticated == other.isAuthenticated &&
        lastEnteredPasswordAt == other.lastEnteredPasswordAt;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, email.hashCode), password.hashCode),
                        url.hashCode),
                    secret.hashCode),
                isInitialized.hashCode),
            isAuthenticated.hashCode),
        lastEnteredPasswordAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthState')
          ..add('email', email)
          ..add('password', password)
          ..add('url', url)
          ..add('secret', secret)
          ..add('isInitialized', isInitialized)
          ..add('isAuthenticated', isAuthenticated)
          ..add('lastEnteredPasswordAt', lastEnteredPasswordAt))
        .toString();
  }
}

class AuthStateBuilder implements Builder<AuthState, AuthStateBuilder> {
  _$AuthState _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  String _secret;
  String get secret => _$this._secret;
  set secret(String secret) => _$this._secret = secret;

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

  AuthStateBuilder();

  AuthStateBuilder get _$this {
    if (_$v != null) {
      _email = _$v.email;
      _password = _$v.password;
      _url = _$v.url;
      _secret = _$v.secret;
      _isInitialized = _$v.isInitialized;
      _isAuthenticated = _$v.isAuthenticated;
      _lastEnteredPasswordAt = _$v.lastEnteredPasswordAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
            email: email,
            password: password,
            url: url,
            secret: secret,
            isInitialized: isInitialized,
            isAuthenticated: isAuthenticated,
            lastEnteredPasswordAt: lastEnteredPasswordAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
