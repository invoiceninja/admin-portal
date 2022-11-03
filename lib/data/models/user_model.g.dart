// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserListResponse> _$userListResponseSerializer =
    new _$UserListResponseSerializer();
Serializer<UserItemResponse> _$userItemResponseSerializer =
    new _$UserItemResponseSerializer();
Serializer<UserTwoFactorResponse> _$userTwoFactorResponseSerializer =
    new _$UserTwoFactorResponseSerializer();
Serializer<UserTwoFactorData> _$userTwoFactorDataSerializer =
    new _$UserTwoFactorDataSerializer();
Serializer<UserCompanyItemResponse> _$userCompanyItemResponseSerializer =
    new _$UserCompanyItemResponseSerializer();
Serializer<UserEntity> _$userEntitySerializer = new _$UserEntitySerializer();

class _$UserListResponseSerializer
    implements StructuredSerializer<UserListResponse> {
  @override
  final Iterable<Type> types = const [UserListResponse, _$UserListResponse];
  @override
  final String wireName = 'UserListResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, UserListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(UserEntity)])),
    ];

    return result;
  }

  @override
  UserListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(UserEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$UserItemResponseSerializer
    implements StructuredSerializer<UserItemResponse> {
  @override
  final Iterable<Type> types = const [UserItemResponse, _$UserItemResponse];
  @override
  final String wireName = 'UserItemResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, UserItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(UserEntity)),
    ];

    return result;
  }

  @override
  UserItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserEntity)) as UserEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$UserTwoFactorResponseSerializer
    implements StructuredSerializer<UserTwoFactorResponse> {
  @override
  final Iterable<Type> types = const [
    UserTwoFactorResponse,
    _$UserTwoFactorResponse
  ];
  @override
  final String wireName = 'UserTwoFactorResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, UserTwoFactorResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(UserTwoFactorData)),
    ];

    return result;
  }

  @override
  UserTwoFactorResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserTwoFactorResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserTwoFactorData))
              as UserTwoFactorData);
          break;
      }
    }

    return result.build();
  }
}

class _$UserTwoFactorDataSerializer
    implements StructuredSerializer<UserTwoFactorData> {
  @override
  final Iterable<Type> types = const [UserTwoFactorData, _$UserTwoFactorData];
  @override
  final String wireName = 'UserTwoFactorData';

  @override
  Iterable<Object> serialize(Serializers serializers, UserTwoFactorData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'secret',
      serializers.serialize(object.secret,
          specifiedType: const FullType(String)),
      'qrCode',
      serializers.serialize(object.qrCode,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  UserTwoFactorData deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserTwoFactorDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'secret':
          result.secret = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'qrCode':
          result.qrCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UserCompanyItemResponseSerializer
    implements StructuredSerializer<UserCompanyItemResponse> {
  @override
  final Iterable<Type> types = const [
    UserCompanyItemResponse,
    _$UserCompanyItemResponse
  ];
  @override
  final String wireName = 'UserCompanyItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, UserCompanyItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(UserCompanyEntity)),
    ];

    return result;
  }

  @override
  UserCompanyItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserCompanyItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyEntity))
              as UserCompanyEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$UserEntitySerializer implements StructuredSerializer<UserEntity> {
  @override
  final Iterable<Type> types = const [UserEntity, _$UserEntity];
  @override
  final String wireName = 'UserEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, UserEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'first_name',
      serializers.serialize(object.firstName,
          specifiedType: const FullType(String)),
      'last_name',
      serializers.serialize(object.lastName,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'phone',
      serializers.serialize(object.phone,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'verified_phone_number',
      serializers.serialize(object.phoneVerified,
          specifiedType: const FullType(bool)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'custom_value3',
      serializers.serialize(object.customValue3,
          specifiedType: const FullType(String)),
      'custom_value4',
      serializers.serialize(object.customValue4,
          specifiedType: const FullType(String)),
      'google_2fa_secret',
      serializers.serialize(object.isTwoFactorEnabled,
          specifiedType: const FullType(bool)),
      'has_password',
      serializers.serialize(object.hasPassword,
          specifiedType: const FullType(bool)),
      'last_confirmed_email_address',
      serializers.serialize(object.lastEmailAddress,
          specifiedType: const FullType(String)),
      'oauth_user_token',
      serializers.serialize(object.oauthUserToken,
          specifiedType: const FullType(String)),
      'oauth_provider_id',
      serializers.serialize(object.oauthProvider,
          specifiedType: const FullType(String)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'archived_at',
      serializers.serialize(object.archivedAt,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object value;
    value = object.emailVerifiedAt;
    if (value != null) {
      result
        ..add('email_verified_at')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.userCompany;
    if (value != null) {
      result
        ..add('company_user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(UserCompanyEntity)));
    }
    value = object.isChanged;
    if (value != null) {
      result
        ..add('isChanged')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isDeleted;
    if (value != null) {
      result
        ..add('is_deleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdUserId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assignedUserId;
    if (value != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_verified_at':
          result.emailVerifiedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'verified_phone_number':
          result.phoneVerified = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'google_2fa_secret':
          result.isTwoFactorEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_password':
          result.hasPassword = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'last_confirmed_email_address':
          result.lastEmailAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'oauth_user_token':
          result.oauthUserToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'company_user':
          result.userCompany.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserCompanyEntity))
              as UserCompanyEntity);
          break;
        case 'oauth_provider_id':
          result.oauthProvider = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UserListResponse extends UserListResponse {
  @override
  final BuiltList<UserEntity> data;

  factory _$UserListResponse(
          [void Function(UserListResponseBuilder) updates]) =>
      (new UserListResponseBuilder()..update(updates)).build();

  _$UserListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'UserListResponse', 'data');
  }

  @override
  UserListResponse rebuild(void Function(UserListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserListResponseBuilder toBuilder() =>
      new UserListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserListResponse')..add('data', data))
        .toString();
  }
}

class UserListResponseBuilder
    implements Builder<UserListResponse, UserListResponseBuilder> {
  _$UserListResponse _$v;

  ListBuilder<UserEntity> _data;
  ListBuilder<UserEntity> get data =>
      _$this._data ??= new ListBuilder<UserEntity>();
  set data(ListBuilder<UserEntity> data) => _$this._data = data;

  UserListResponseBuilder();

  UserListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserListResponse;
  }

  @override
  void update(void Function(UserListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserListResponse build() {
    _$UserListResponse _$result;
    try {
      _$result = _$v ?? new _$UserListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UserItemResponse extends UserItemResponse {
  @override
  final UserEntity data;

  factory _$UserItemResponse(
          [void Function(UserItemResponseBuilder) updates]) =>
      (new UserItemResponseBuilder()..update(updates)).build();

  _$UserItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'UserItemResponse', 'data');
  }

  @override
  UserItemResponse rebuild(void Function(UserItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserItemResponseBuilder toBuilder() =>
      new UserItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserItemResponse')..add('data', data))
        .toString();
  }
}

class UserItemResponseBuilder
    implements Builder<UserItemResponse, UserItemResponseBuilder> {
  _$UserItemResponse _$v;

  UserEntityBuilder _data;
  UserEntityBuilder get data => _$this._data ??= new UserEntityBuilder();
  set data(UserEntityBuilder data) => _$this._data = data;

  UserItemResponseBuilder();

  UserItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserItemResponse;
  }

  @override
  void update(void Function(UserItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserItemResponse build() {
    _$UserItemResponse _$result;
    try {
      _$result = _$v ?? new _$UserItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UserTwoFactorResponse extends UserTwoFactorResponse {
  @override
  final UserTwoFactorData data;

  factory _$UserTwoFactorResponse(
          [void Function(UserTwoFactorResponseBuilder) updates]) =>
      (new UserTwoFactorResponseBuilder()..update(updates)).build();

  _$UserTwoFactorResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'UserTwoFactorResponse', 'data');
  }

  @override
  UserTwoFactorResponse rebuild(
          void Function(UserTwoFactorResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserTwoFactorResponseBuilder toBuilder() =>
      new UserTwoFactorResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserTwoFactorResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserTwoFactorResponse')
          ..add('data', data))
        .toString();
  }
}

class UserTwoFactorResponseBuilder
    implements Builder<UserTwoFactorResponse, UserTwoFactorResponseBuilder> {
  _$UserTwoFactorResponse _$v;

  UserTwoFactorDataBuilder _data;
  UserTwoFactorDataBuilder get data =>
      _$this._data ??= new UserTwoFactorDataBuilder();
  set data(UserTwoFactorDataBuilder data) => _$this._data = data;

  UserTwoFactorResponseBuilder();

  UserTwoFactorResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserTwoFactorResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserTwoFactorResponse;
  }

  @override
  void update(void Function(UserTwoFactorResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserTwoFactorResponse build() {
    _$UserTwoFactorResponse _$result;
    try {
      _$result = _$v ?? new _$UserTwoFactorResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserTwoFactorResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UserTwoFactorData extends UserTwoFactorData {
  @override
  final String secret;
  @override
  final String qrCode;

  factory _$UserTwoFactorData(
          [void Function(UserTwoFactorDataBuilder) updates]) =>
      (new UserTwoFactorDataBuilder()..update(updates)).build();

  _$UserTwoFactorData._({this.secret, this.qrCode}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        secret, 'UserTwoFactorData', 'secret');
    BuiltValueNullFieldError.checkNotNull(
        qrCode, 'UserTwoFactorData', 'qrCode');
  }

  @override
  UserTwoFactorData rebuild(void Function(UserTwoFactorDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserTwoFactorDataBuilder toBuilder() =>
      new UserTwoFactorDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserTwoFactorData &&
        secret == other.secret &&
        qrCode == other.qrCode;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc($jc(0, secret.hashCode), qrCode.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserTwoFactorData')
          ..add('secret', secret)
          ..add('qrCode', qrCode))
        .toString();
  }
}

class UserTwoFactorDataBuilder
    implements Builder<UserTwoFactorData, UserTwoFactorDataBuilder> {
  _$UserTwoFactorData _$v;

  String _secret;
  String get secret => _$this._secret;
  set secret(String secret) => _$this._secret = secret;

  String _qrCode;
  String get qrCode => _$this._qrCode;
  set qrCode(String qrCode) => _$this._qrCode = qrCode;

  UserTwoFactorDataBuilder();

  UserTwoFactorDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _secret = $v.secret;
      _qrCode = $v.qrCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserTwoFactorData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserTwoFactorData;
  }

  @override
  void update(void Function(UserTwoFactorDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserTwoFactorData build() {
    final _$result = _$v ??
        new _$UserTwoFactorData._(
            secret: BuiltValueNullFieldError.checkNotNull(
                secret, 'UserTwoFactorData', 'secret'),
            qrCode: BuiltValueNullFieldError.checkNotNull(
                qrCode, 'UserTwoFactorData', 'qrCode'));
    replace(_$result);
    return _$result;
  }
}

class _$UserCompanyItemResponse extends UserCompanyItemResponse {
  @override
  final UserCompanyEntity data;

  factory _$UserCompanyItemResponse(
          [void Function(UserCompanyItemResponseBuilder) updates]) =>
      (new UserCompanyItemResponseBuilder()..update(updates)).build();

  _$UserCompanyItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, 'UserCompanyItemResponse', 'data');
  }

  @override
  UserCompanyItemResponse rebuild(
          void Function(UserCompanyItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserCompanyItemResponseBuilder toBuilder() =>
      new UserCompanyItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserCompanyItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserCompanyItemResponse')
          ..add('data', data))
        .toString();
  }
}

class UserCompanyItemResponseBuilder
    implements
        Builder<UserCompanyItemResponse, UserCompanyItemResponseBuilder> {
  _$UserCompanyItemResponse _$v;

  UserCompanyEntityBuilder _data;
  UserCompanyEntityBuilder get data =>
      _$this._data ??= new UserCompanyEntityBuilder();
  set data(UserCompanyEntityBuilder data) => _$this._data = data;

  UserCompanyItemResponseBuilder();

  UserCompanyItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCompanyItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserCompanyItemResponse;
  }

  @override
  void update(void Function(UserCompanyItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserCompanyItemResponse build() {
    _$UserCompanyItemResponse _$result;
    try {
      _$result = _$v ?? new _$UserCompanyItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserCompanyItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UserEntity extends UserEntity {
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String password;
  @override
  final int emailVerifiedAt;
  @override
  final bool phoneVerified;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final bool isTwoFactorEnabled;
  @override
  final bool hasPassword;
  @override
  final String lastEmailAddress;
  @override
  final String oauthUserToken;
  @override
  final UserCompanyEntity userCompany;
  @override
  final String oauthProvider;
  @override
  final bool isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final String createdUserId;
  @override
  final String assignedUserId;
  @override
  final String id;

  factory _$UserEntity([void Function(UserEntityBuilder) updates]) =>
      (new UserEntityBuilder()..update(updates)).build();

  _$UserEntity._(
      {this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.password,
      this.emailVerifiedAt,
      this.phoneVerified,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.isTwoFactorEnabled,
      this.hasPassword,
      this.lastEmailAddress,
      this.oauthUserToken,
      this.userCompany,
      this.oauthProvider,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(firstName, 'UserEntity', 'firstName');
    BuiltValueNullFieldError.checkNotNull(lastName, 'UserEntity', 'lastName');
    BuiltValueNullFieldError.checkNotNull(email, 'UserEntity', 'email');
    BuiltValueNullFieldError.checkNotNull(phone, 'UserEntity', 'phone');
    BuiltValueNullFieldError.checkNotNull(password, 'UserEntity', 'password');
    BuiltValueNullFieldError.checkNotNull(
        phoneVerified, 'UserEntity', 'phoneVerified');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, 'UserEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, 'UserEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, 'UserEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, 'UserEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        isTwoFactorEnabled, 'UserEntity', 'isTwoFactorEnabled');
    BuiltValueNullFieldError.checkNotNull(
        hasPassword, 'UserEntity', 'hasPassword');
    BuiltValueNullFieldError.checkNotNull(
        lastEmailAddress, 'UserEntity', 'lastEmailAddress');
    BuiltValueNullFieldError.checkNotNull(
        oauthUserToken, 'UserEntity', 'oauthUserToken');
    BuiltValueNullFieldError.checkNotNull(
        oauthProvider, 'UserEntity', 'oauthProvider');
    BuiltValueNullFieldError.checkNotNull(createdAt, 'UserEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(updatedAt, 'UserEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'UserEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'UserEntity', 'id');
  }

  @override
  UserEntity rebuild(void Function(UserEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserEntityBuilder toBuilder() => new UserEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserEntity &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        phone == other.phone &&
        password == other.password &&
        emailVerifiedAt == other.emailVerifiedAt &&
        phoneVerified == other.phoneVerified &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        isTwoFactorEnabled == other.isTwoFactorEnabled &&
        hasPassword == other.hasPassword &&
        lastEmailAddress == other.lastEmailAddress &&
        oauthUserToken == other.oauthUserToken &&
        userCompany == other.userCompany &&
        oauthProvider == other.oauthProvider &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        id == other.id;
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
                                                                            $jc($jc($jc($jc($jc($jc($jc(0, firstName.hashCode), lastName.hashCode), email.hashCode), phone.hashCode), password.hashCode), emailVerifiedAt.hashCode),
                                                                                phoneVerified.hashCode),
                                                                            customValue1.hashCode),
                                                                        customValue2.hashCode),
                                                                    customValue3.hashCode),
                                                                customValue4.hashCode),
                                                            isTwoFactorEnabled.hashCode),
                                                        hasPassword.hashCode),
                                                    lastEmailAddress.hashCode),
                                                oauthUserToken.hashCode),
                                            userCompany.hashCode),
                                        oauthProvider.hashCode),
                                    isChanged.hashCode),
                                createdAt.hashCode),
                            updatedAt.hashCode),
                        archivedAt.hashCode),
                    isDeleted.hashCode),
                createdUserId.hashCode),
            assignedUserId.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserEntity')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('phone', phone)
          ..add('password', password)
          ..add('emailVerifiedAt', emailVerifiedAt)
          ..add('phoneVerified', phoneVerified)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('isTwoFactorEnabled', isTwoFactorEnabled)
          ..add('hasPassword', hasPassword)
          ..add('lastEmailAddress', lastEmailAddress)
          ..add('oauthUserToken', oauthUserToken)
          ..add('userCompany', userCompany)
          ..add('oauthProvider', oauthProvider)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('id', id))
        .toString();
  }
}

class UserEntityBuilder implements Builder<UserEntity, UserEntityBuilder> {
  _$UserEntity _$v;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  int _emailVerifiedAt;
  int get emailVerifiedAt => _$this._emailVerifiedAt;
  set emailVerifiedAt(int emailVerifiedAt) =>
      _$this._emailVerifiedAt = emailVerifiedAt;

  bool _phoneVerified;
  bool get phoneVerified => _$this._phoneVerified;
  set phoneVerified(bool phoneVerified) =>
      _$this._phoneVerified = phoneVerified;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  String _customValue3;
  String get customValue3 => _$this._customValue3;
  set customValue3(String customValue3) => _$this._customValue3 = customValue3;

  String _customValue4;
  String get customValue4 => _$this._customValue4;
  set customValue4(String customValue4) => _$this._customValue4 = customValue4;

  bool _isTwoFactorEnabled;
  bool get isTwoFactorEnabled => _$this._isTwoFactorEnabled;
  set isTwoFactorEnabled(bool isTwoFactorEnabled) =>
      _$this._isTwoFactorEnabled = isTwoFactorEnabled;

  bool _hasPassword;
  bool get hasPassword => _$this._hasPassword;
  set hasPassword(bool hasPassword) => _$this._hasPassword = hasPassword;

  String _lastEmailAddress;
  String get lastEmailAddress => _$this._lastEmailAddress;
  set lastEmailAddress(String lastEmailAddress) =>
      _$this._lastEmailAddress = lastEmailAddress;

  String _oauthUserToken;
  String get oauthUserToken => _$this._oauthUserToken;
  set oauthUserToken(String oauthUserToken) =>
      _$this._oauthUserToken = oauthUserToken;

  UserCompanyEntityBuilder _userCompany;
  UserCompanyEntityBuilder get userCompany =>
      _$this._userCompany ??= new UserCompanyEntityBuilder();
  set userCompany(UserCompanyEntityBuilder userCompany) =>
      _$this._userCompany = userCompany;

  String _oauthProvider;
  String get oauthProvider => _$this._oauthProvider;
  set oauthProvider(String oauthProvider) =>
      _$this._oauthProvider = oauthProvider;

  bool _isChanged;
  bool get isChanged => _$this._isChanged;
  set isChanged(bool isChanged) => _$this._isChanged = isChanged;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  String _createdUserId;
  String get createdUserId => _$this._createdUserId;
  set createdUserId(String createdUserId) =>
      _$this._createdUserId = createdUserId;

  String _assignedUserId;
  String get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  UserEntityBuilder() {
    UserEntity._initializeBuilder(this);
  }

  UserEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _phone = $v.phone;
      _password = $v.password;
      _emailVerifiedAt = $v.emailVerifiedAt;
      _phoneVerified = $v.phoneVerified;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _isTwoFactorEnabled = $v.isTwoFactorEnabled;
      _hasPassword = $v.hasPassword;
      _lastEmailAddress = $v.lastEmailAddress;
      _oauthUserToken = $v.oauthUserToken;
      _userCompany = $v.userCompany?.toBuilder();
      _oauthProvider = $v.oauthProvider;
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserEntity;
  }

  @override
  void update(void Function(UserEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserEntity build() {
    _$UserEntity _$result;
    try {
      _$result = _$v ??
          new _$UserEntity._(
              firstName: BuiltValueNullFieldError.checkNotNull(
                  firstName, 'UserEntity', 'firstName'),
              lastName: BuiltValueNullFieldError.checkNotNull(
                  lastName, 'UserEntity', 'lastName'),
              email: BuiltValueNullFieldError.checkNotNull(
                  email, 'UserEntity', 'email'),
              phone: BuiltValueNullFieldError.checkNotNull(
                  phone, 'UserEntity', 'phone'),
              password: BuiltValueNullFieldError.checkNotNull(
                  password, 'UserEntity', 'password'),
              emailVerifiedAt: emailVerifiedAt,
              phoneVerified: BuiltValueNullFieldError.checkNotNull(
                  phoneVerified, 'UserEntity', 'phoneVerified'),
              customValue1: BuiltValueNullFieldError.checkNotNull(
                  customValue1, 'UserEntity', 'customValue1'),
              customValue2: BuiltValueNullFieldError.checkNotNull(
                  customValue2, 'UserEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(
                  customValue3, 'UserEntity', 'customValue3'),
              customValue4:
                  BuiltValueNullFieldError.checkNotNull(customValue4, 'UserEntity', 'customValue4'),
              isTwoFactorEnabled: BuiltValueNullFieldError.checkNotNull(isTwoFactorEnabled, 'UserEntity', 'isTwoFactorEnabled'),
              hasPassword: BuiltValueNullFieldError.checkNotNull(hasPassword, 'UserEntity', 'hasPassword'),
              lastEmailAddress: BuiltValueNullFieldError.checkNotNull(lastEmailAddress, 'UserEntity', 'lastEmailAddress'),
              oauthUserToken: BuiltValueNullFieldError.checkNotNull(oauthUserToken, 'UserEntity', 'oauthUserToken'),
              userCompany: _userCompany?.build(),
              oauthProvider: BuiltValueNullFieldError.checkNotNull(oauthProvider, 'UserEntity', 'oauthProvider'),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, 'UserEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, 'UserEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, 'UserEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(id, 'UserEntity', 'id'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userCompany';
        _userCompany?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
