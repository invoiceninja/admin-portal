// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'vendor_model.g.dart';

abstract class VendorListResponse
    implements Built<VendorListResponse, VendorListResponseBuilder> {
  factory VendorListResponse([void updates(VendorListResponseBuilder b)]) =
      _$VendorListResponse;

  VendorListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<VendorEntity> get data;

  static Serializer<VendorListResponse> get serializer =>
      _$vendorListResponseSerializer;
}

abstract class VendorItemResponse
    implements Built<VendorItemResponse, VendorItemResponseBuilder> {
  factory VendorItemResponse([void updates(VendorItemResponseBuilder b)]) =
      _$VendorItemResponse;

  VendorItemResponse._();

  @override
  @memoized
  int get hashCode;

  VendorEntity get data;

  static Serializer<VendorItemResponse> get serializer =>
      _$vendorItemResponseSerializer;
}

class VendorFields {
  static const String name = 'name';
  static const String number = 'number';
  static const String balance = 'balance';
  static const String address1 = 'address1';
  static const String address2 = 'address2';
  static const String city = 'city';
  static const String state = 'state';
  static const String postalCode = 'postal_code';
  static const String countryId = 'country_id';
  static const String languageId = 'language_id';
  static const String country = 'country';
  static const String phone = 'phone';
  static const String privateNotes = 'private_notes';
  static const String publicNotes = 'public_notes';
  static const String website = 'website';
  static const String vatNumber = 'vat_number';
  static const String idNumber = 'id_number';
  static const String currencyId = 'currency_id';
  static const String customValue1 = 'custom1';
  static const String customValue2 = 'custom2';
  static const String customValue3 = 'custom3';
  static const String customValue4 = 'custom4';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
  static const String documents = 'documents';
  static const String contacts = 'contacts';
  static const String cityStatePostal = 'city_state_postal';
  static const String postalCityState = 'postal_city_state';
  static const String postalCity = 'postal_city';
  static const String lastLoginAt = 'last_login_at';
  static const String contactEmail = 'contact_email';
  static const String classification = 'classification';
}

abstract class VendorEntity extends Object
    with BaseEntity, SelectableEntity, HasActivities
    implements Built<VendorEntity, VendorEntityBuilder> {
  factory VendorEntity({String? id, AppState? state, UserEntity? user}) {
    return _$VendorEntity._(
      id: id ?? BaseEntity.nextId,
      number: '',
      isChanged: false,
      name: '',
      displayName: '',
      address1: '',
      address2: '',
      city: '',
      state: '',
      postalCode: '',
      countryId: '',
      languageId: '',
      phone: '',
      privateNotes: '',
      publicNotes: '',
      website: '',
      vatNumber: '',
      idNumber: '',
      currencyId: '',
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      activities: BuiltList<ActivityEntity>(),
      contacts: BuiltList<VendorContactEntity>(
        <VendorContactEntity>[
          VendorContactEntity().rebuild((b) => b..isPrimary = true)
        ],
      ),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      assignedUserId: user?.id ?? '',
      createdUserId: '',
      createdAt: 0,
      lastLogin: 0,
      classification: '',
      documents: BuiltList<DocumentEntity>(),
    );
  }

  VendorEntity._();

  @override
  @memoized
  int get hashCode;

  VendorEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..number = ''
    ..documents.clear()
    ..isChanged = false
    ..isDeleted = false);

  @BuiltValueField(compare: false)
  int? get loadedAt;

  bool get isLoaded => loadedAt != null && loadedAt! > 0;

  bool get isStale {
    if (!isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - loadedAt! >
        kMillisecondsToRefreshActivities;
  }

  @override
  EntityType get entityType {
    return EntityType.vendor;
  }

  String get name;

  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  String get address1;

  String get address2;

  String get city;

  String get state;

  @BuiltValueField(wireName: 'postal_code')
  String get postalCode;

  @BuiltValueField(wireName: 'country_id')
  String get countryId;

  @BuiltValueField(wireName: 'language_id')
  String get languageId;

  @BuiltValueField(wireName: 'phone')
  String get phone;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  String get website;

  String get number;

  @BuiltValueField(wireName: 'vat_number')
  String get vatNumber;

  @BuiltValueField(wireName: 'id_number')
  String get idNumber;

  @BuiltValueField(wireName: 'currency_id')
  String get currencyId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @BuiltValueField(wireName: 'last_login')
  int get lastLogin;

  String get classification;

  BuiltList<VendorContactEntity> get contacts;

  @override
  BuiltList<ActivityEntity> get activities;

  BuiltList<DocumentEntity> get documents;

  @override
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted! && !multiselect) {
      if (includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      actions.add(EntityAction.vendorPortal);

      if (userCompany!.canCreate(EntityType.purchaseOrder)) {
        actions.add(EntityAction.newPurchaseOrder);
      }

      if (userCompany.canCreate(EntityType.expense)) {
        actions.add(EntityAction.newExpense);
      }

      if (userCompany.canCreate(EntityType.recurringExpense)) {
        actions.add(EntityAction.newRecurringExpense);
      }
    }

    if (!isDeleted! && multiselect) {
      actions.add(EntityAction.documents);
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(VendorEntity? vendor, String sortField, bool sortAscending,
      BuiltMap<String, UserEntity> userMap, StaticState staticState) {
    int response = 0;
    final VendorEntity? vendorA = sortAscending ? this : vendor;
    final VendorEntity? vendorB = sortAscending ? vendor : this;

    switch (sortField) {
      case VendorFields.name:
        response = removeDiacritics(vendorA!.name)
            .toLowerCase()
            .compareTo(removeDiacritics(vendorB!.name).toLowerCase());
        break;
      case VendorFields.city:
        response =
            vendorA!.city.toLowerCase().compareTo(vendorB!.city.toLowerCase());
        break;
      case VendorFields.phone:
        response = vendorA!.phone
            .toLowerCase()
            .compareTo(vendorB!.phone.toLowerCase());
        break;
      case EntityFields.state:
      case VendorFields.state:
        final stateA = EntityState.valueOf(vendorA!.entityState);
        final stateB = EntityState.valueOf(vendorB!.entityState);
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case EntityFields.assignedTo:
        final userA = userMap[vendorA!.assignedUserId] ?? UserEntity();
        final userB = userMap[vendorB!.assignedUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdBy:
        final userA = userMap[vendorA!.createdUserId] ?? UserEntity();
        final userB = userMap[vendorB!.createdUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdAt:
        response = vendorA!.createdAt.compareTo(vendorB!.createdAt);
        break;
      case VendorFields.archivedAt:
        response = vendorA!.archivedAt.compareTo(vendorB!.archivedAt);
        break;
      case VendorFields.updatedAt:
        response = vendorA!.updatedAt.compareTo(vendorB!.updatedAt);
        break;
      case VendorFields.documents:
        response =
            vendorA!.documents.length.compareTo(vendorB!.documents.length);
        break;
      case VendorFields.number:
        response = compareNatural(vendorA!.number, vendorB!.number);
        break;
      case VendorFields.address1:
        response = vendorA!.address1.compareTo(vendorB!.address1);
        break;
      case VendorFields.address2:
        response = vendorA!.address2.compareTo(vendorB!.address2);
        break;
      case VendorFields.postalCode:
        response = vendorA!.postalCode.compareTo(vendorB!.postalCode);
        break;
      case VendorFields.countryId:
        response = vendorA!.countryId.compareTo(vendorB!.countryId);
        break;
      case VendorFields.languageId:
        response = vendorA!.languageId.compareTo(vendorB!.languageId);
        break;
      case VendorFields.privateNotes:
        response = vendorA!.privateNotes.compareTo(vendorB!.privateNotes);
        break;
      case VendorFields.publicNotes:
        response = vendorA!.publicNotes.compareTo(vendorB!.publicNotes);
        break;
      case VendorFields.website:
        response = vendorA!.website.compareTo(vendorB!.website);
        break;
      case VendorFields.vatNumber:
        response = vendorA!.vatNumber.compareTo(vendorB!.vatNumber);
        break;
      case VendorFields.idNumber:
        response = vendorA!.idNumber.compareTo(vendorB!.idNumber);
        break;
      case VendorFields.currencyId:
        final currencyMap = staticState.currencyMap;
        response = currencyMap[vendorA!.currencyId]!
            .listDisplayName
            .compareTo(currencyMap[vendorB!.currencyId]!.listDisplayName);
        break;
      case VendorFields.customValue1:
        response = vendorA!.customValue1.compareTo(vendorB!.customValue1);
        break;
      case VendorFields.customValue2:
        response = vendorA!.customValue2.compareTo(vendorB!.customValue2);
        break;
      case VendorFields.customValue3:
        response = vendorA!.customValue3.compareTo(vendorB!.customValue3);
        break;
      case VendorFields.customValue4:
        response = vendorA!.customValue4.compareTo(vendorB!.customValue4);
        break;
      case VendorFields.classification:
        response = vendorA!.classification.compareTo(vendorB!.classification);
        break;
      default:
        print('## ERROR: sort by vendor.$sortField is not implemented');
        break;
    }

    if (response == 0) {
      response = vendor!.number.toLowerCase().compareTo(number.toLowerCase());
    }

    return response;
  }

  bool matchesNameOrEmail(String? filter) {
    if (matchesString(haystack: name, needle: filter)) {
      return true;
    }

    for (var i = 0; i < contacts.length; i++) {
      final contact = contacts[i];
      if (matchesString(haystack: contact.fullName, needle: filter)) {
        return true;
      }

      if (matchesString(haystack: contact.email, needle: filter)) {
        return true;
      }
    }

    return false;
  }

  @override
  bool matchesFilter(String? filter) {
    for (final contact in contacts) {
      if (contact.matchesFilter(filter)) {
        return true;
      }
    }

    return matchesStrings(
      haystacks: [
        name,
        vatNumber,
        idNumber,
        number,
        phone,
        address1,
        address2,
        city,
        state,
        postalCode,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    for (final contact in contacts) {
      final value = contact.matchesFilterValue(filter);
      if (value != null) {
        return value;
      }
    }

    return matchesStringsValue(
      haystacks: [
        name,
        vatNumber,
        idNumber,
        number,
        phone,
        address1,
        address2,
        city,
        state,
        postalCode,
        customValue1,
        customValue2,
        customValue3,
        customValue4,
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName {
    // TODO simplify once not needed any more
    return displayName.isNotEmpty ? displayName : calculateDisplayName;
  }

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  String get calculateDisplayName {
    if (name.isNotEmpty) {
      return name;
    } else {
      return primaryContact.fullNameOrEmail;
    }
  }

  List<VendorContactEntity> get emailContacts {
    final list = contacts.where((contact) => contact.sendEmail).toList();

    return list.isEmpty ? [primaryContact] : list;
  }

  VendorContactEntity get primaryContact =>
      contacts.firstWhere((contact) => contact.isPrimary,
          orElse: () => VendorContactEntity());

  bool get hasCurrency => currencyId.isNotEmpty;

  bool get hasLanguage => languageId.isNotEmpty;

  bool get hasUser => assignedUserId != null && assignedUserId!.isNotEmpty;

  bool get hasEmailAddress =>
      contacts.where((contact) => contact.email.isNotEmpty).isNotEmpty;

  bool get hasNameSet {
    final contact = contacts.first;
    return name.isNotEmpty ||
        contact.fullName.isNotEmpty ||
        contact.email.isNotEmpty;
  }

  VendorContactEntity getContact(String? contactId) =>
      contacts.firstWhere((contact) => contact.id == contactId,
          orElse: () => VendorContactEntity());

  static void _initializeBuilder(VendorEntityBuilder builder) => builder
    ..activities.replace(BuiltList<ActivityEntity>())
    ..lastLogin = 0
    ..languageId = ''
    ..displayName = ''
    ..classification = '';

  static Serializer<VendorEntity> get serializer => _$vendorEntitySerializer;
}

abstract class VendorContactEntity extends Object
    with BaseEntity
    implements Built<VendorContactEntity, VendorContactEntityBuilder> {
  factory VendorContactEntity() {
    return _$VendorContactEntity._(
      id: BaseEntity.nextId,
      isChanged: false,
      firstName: '',
      lastName: '',
      email: '',
      isPrimary: false,
      phone: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      sendEmail: true,
      createdUserId: '',
      createdAt: 0,
      assignedUserId: '',
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      link: '',
      password: '',
    );
  }

  VendorContactEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType {
    return EntityType.vendorContact;
  }

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  String get email;

  @BuiltValueField(wireName: 'is_primary')
  bool get isPrimary;

  @BuiltValueField(wireName: 'send_email')
  bool get sendEmail;

  String get phone;

  String get password;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  String get link;

  String get silentLink => '$link?silent=true';

  String get fullName {
    return (firstName + ' ' + lastName).trim();
  }

  String get fullNameOrEmail {
    if (fullName.isNotEmpty) {
      return fullName;
    } else {
      return email;
    }
  }

  String get emailOrFullName {
    if (email.isNotEmpty) {
      return email;
    } else {
      return fullName;
    }
  }

  String get fullNameWithEmail {
    String name = fullName;

    if (email.isNotEmpty) {
      if (name.isEmpty) {
        name += email;
      } else {
        name += ' • $email';
      }
    }

    return name;
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        '$firstName $lastName',
        email,
        phone,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        '$firstName $lastName',
        email,
        phone,
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName {
    return '';
  }

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static void _initializeBuilder(VendorContactEntityBuilder builder) => builder
    ..sendEmail = true
    ..link = ''
    ..password = ''
    ..customValue1 = ''
    ..customValue2 = ''
    ..customValue3 = ''
    ..customValue4 = '';

  static Serializer<VendorContactEntity> get serializer =>
      _$vendorContactEntitySerializer;
}
