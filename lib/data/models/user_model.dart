import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'user_model.g.dart';

abstract class UserListResponse
    implements Built<UserListResponse, UserListResponseBuilder> {
  factory UserListResponse([void updates(UserListResponseBuilder b)]) =
      _$UserListResponse;

  UserListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<UserEntity> get data;

  static Serializer<UserListResponse> get serializer =>
      _$userListResponseSerializer;
}

abstract class UserItemResponse
    implements Built<UserItemResponse, UserItemResponseBuilder> {
  factory UserItemResponse([void updates(UserItemResponseBuilder b)]) =
      _$UserItemResponse;

  UserItemResponse._();

  @override
  @memoized
  int get hashCode;

  UserEntity get data;

  static Serializer<UserItemResponse> get serializer =>
      _$userItemResponseSerializer;
}

abstract class UserTwoFactorResponse
    implements Built<UserTwoFactorResponse, UserTwoFactorResponseBuilder> {
  factory UserTwoFactorResponse(
      [void updates(UserTwoFactorResponseBuilder b)]) = _$UserTwoFactorResponse;

  UserTwoFactorResponse._();

  @override
  @memoized
  int get hashCode;

  UserTwoFactorData get data;

  static Serializer<UserTwoFactorResponse> get serializer =>
      _$userTwoFactorResponseSerializer;
}

abstract class UserTwoFactorData
    implements Built<UserTwoFactorData, UserTwoFactorDataBuilder> {
  factory UserTwoFactorData([void updates(UserTwoFactorDataBuilder b)]) =
      _$UserTwoFactorData;

  UserTwoFactorData._();

  @override
  @memoized
  int get hashCode;

  String get secret;

  String get qrCode;

  static Serializer<UserTwoFactorData> get serializer =>
      _$userTwoFactorDataSerializer;
}

abstract class UserCompanyItemResponse
    implements Built<UserCompanyItemResponse, UserCompanyItemResponseBuilder> {
  factory UserCompanyItemResponse(
          [void updates(UserCompanyItemResponseBuilder b)]) =
      _$UserCompanyItemResponse;

  UserCompanyItemResponse._();

  @override
  @memoized
  int get hashCode;

  UserCompanyEntity get data;

  static Serializer<UserCompanyItemResponse> get serializer =>
      _$userCompanyItemResponseSerializer;
}

class UserFields {
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String updatedAt = 'updated_at';
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
  static const String custom3 = 'custom3';
  static const String custom4 = 'custom4';
}

abstract class UserEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<UserEntity, UserEntityBuilder> {
  factory UserEntity(
      {String id, AppState state, UserCompanyEntity userCompany}) {
    return _$UserEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      createdUserId: '',
      createdAt: 0,
      assignedUserId: '',
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      userCompany: userCompany,
      oauthProvider: '',
      isTwoFactorEnabled: false,
      hasPassword: false,
      lastEmailAddress: '',
      oauthUserToken: '',
      password: '',
    );
  }

  UserEntity._();

  static const OAUTH_PROVIDER_GOOGLE = 'google';

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType {
    return EntityType.user;
  }

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  String get email;

  String get phone;

  String get password;

  @nullable
  @BuiltValueField(wireName: 'email_verified_at')
  int get emailVerifiedAt;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @BuiltValueField(wireName: 'google_2fa_secret')
  bool get isTwoFactorEnabled;

  @BuiltValueField(wireName: 'has_password')
  bool get hasPassword;

  @BuiltValueField(wireName: 'last_confirmed_email_address')
  String get lastEmailAddress;

  @BuiltValueField(wireName: 'oauth_user_token')
  String get oauthUserToken;

  @nullable
  @BuiltValueField(wireName: 'company_user')
  UserCompanyEntity get userCompany;

  @BuiltValueField(wireName: 'oauth_provider_id')
  String get oauthProvider;

  String get fullName => (firstName + ' ' + lastName).trim();

  bool canEdit(BaseEntity entity) =>
      entity.createdUserId == id || entity.assignedUserId == id;

  @override
  String get listDisplayName {
    return fullName.isNotEmpty ? fullName : email;
  }

  int compareTo(UserEntity user, String sortField, bool sortAscending) {
    int response = 0;
    final UserEntity userA = sortAscending ? this : user;
    final UserEntity userB = sortAscending ? user : this;

    switch (sortField) {
      case UserFields.lastName:
        response = userA.lastName
            .toLowerCase()
            .compareTo(userB.lastName.toLowerCase());
        break;
      case UserFields.firstName:
        response = userA.firstName
            .toLowerCase()
            .compareTo(userB.firstName.toLowerCase());
        break;
      case UserFields.email:
        response = userA.email.compareTo(userB.email);
        break;
      default:
        print('## ERROR: sort by user.$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    return matchesStrings(
      haystacks: [
        firstName,
        lastName,
        email,
        phone,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        firstName,
        lastName,
        email,
        phone,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted && !multiselect) {
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }
    }

    if (userCompany.isAdmin || userCompany.isOwner) {
      if (!isEmailVerified) {
        actions.add(EntityAction.resendInvite);
      }

      actions.add(EntityAction.remove);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => null;

  bool get isConnectedToGoogle =>
      oauthProvider == UserEntity.OAUTH_PROVIDER_GOOGLE;

  bool get isConnectedToGmail =>
      isConnectedToGoogle && oauthUserToken.isNotEmpty;

  bool get isEmailVerified => emailVerifiedAt != null;

  // ignore: unused_element
  static void _initializeBuilder(UserEntityBuilder builder) => builder
    ..isTwoFactorEnabled = false
    ..hasPassword = false
    ..password = ''
    ..lastEmailAddress = ''
    ..oauthUserToken = '';

  static Serializer<UserEntity> get serializer => _$userEntitySerializer;
}
