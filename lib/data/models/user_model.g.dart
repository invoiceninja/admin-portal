// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserListResponse> _$userListResponseSerializer =
    new _$UserListResponseSerializer();
Serializer<UserItemResponse> _$userItemResponseSerializer =
    new _$UserItemResponseSerializer();
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
      final dynamic value = iterator.current;
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
      final dynamic value = iterator.current;
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
      final dynamic value = iterator.current;
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
    if (object.password != null) {
      result
        ..add('password')
        ..add(serializers.serialize(object.password,
            specifiedType: const FullType(String)));
    }
    if (object.emailVerifiedAt != null) {
      result
        ..add('email_verified_at')
        ..add(serializers.serialize(object.emailVerifiedAt,
            specifiedType: const FullType(int)));
    }
    if (object.userCompany != null) {
      result
        ..add('company_user')
        ..add(serializers.serialize(object.userCompany,
            specifiedType: const FullType(UserCompanyEntity)));
    }
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.createdUserId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.createdUserId,
            specifiedType: const FullType(String)));
    }
    if (object.assignedUserId != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(object.assignedUserId,
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
      final dynamic value = iterator.current;
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
    if (data == null) {
      throw new BuiltValueNullFieldError('UserListResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
    if (data == null) {
      throw new BuiltValueNullFieldError('UserItemResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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

class _$UserCompanyItemResponse extends UserCompanyItemResponse {
  @override
  final UserCompanyEntity data;

  factory _$UserCompanyItemResponse(
          [void Function(UserCompanyItemResponseBuilder) updates]) =>
      (new UserCompanyItemResponseBuilder()..update(updates)).build();

  _$UserCompanyItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('UserCompanyItemResponse', 'data');
    }
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCompanyItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.isTwoFactorEnabled,
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
    if (firstName == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'firstName');
    }
    if (lastName == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'lastName');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'email');
    }
    if (phone == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'phone');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'customValue4');
    }
    if (isTwoFactorEnabled == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'isTwoFactorEnabled');
    }
    if (oauthProvider == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'oauthProvider');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('UserEntity', 'id');
    }
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
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        isTwoFactorEnabled == other.isTwoFactorEnabled &&
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
                                                                            $jc($jc($jc(0, firstName.hashCode), lastName.hashCode),
                                                                                email.hashCode),
                                                                            phone.hashCode),
                                                                        password.hashCode),
                                                                    emailVerifiedAt.hashCode),
                                                                customValue1.hashCode),
                                                            customValue2.hashCode),
                                                        customValue3.hashCode),
                                                    customValue4.hashCode),
                                                isTwoFactorEnabled.hashCode),
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
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('isTwoFactorEnabled', isTwoFactorEnabled)
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
    if (_$v != null) {
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _email = _$v.email;
      _phone = _$v.phone;
      _password = _$v.password;
      _emailVerifiedAt = _$v.emailVerifiedAt;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _isTwoFactorEnabled = _$v.isTwoFactorEnabled;
      _userCompany = _$v.userCompany?.toBuilder();
      _oauthProvider = _$v.oauthProvider;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
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
              firstName: firstName,
              lastName: lastName,
              email: email,
              phone: phone,
              password: password,
              emailVerifiedAt: emailVerifiedAt,
              customValue1: customValue1,
              customValue2: customValue2,
              customValue3: customValue3,
              customValue4: customValue4,
              isTwoFactorEnabled: isTwoFactorEnabled,
              userCompany: _userCompany?.build(),
              oauthProvider: oauthProvider,
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: id);
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
