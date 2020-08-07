import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
  static const String balance = 'balance';
  static const String address1 = 'address1';
  static const String address2 = 'address2';
  static const String city = 'city';
  static const String state = 'state';
  static const String postalCode = 'postal_code';
  static const String countryId = 'country_id';
  static const String phone = 'phone';
  static const String privateNotes = 'private_notes';
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
}

abstract class VendorEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<VendorEntity, VendorEntityBuilder> {
  factory VendorEntity({String id, AppState state}) {
    return _$VendorEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      name: '',
      address1: '',
      address2: '',
      city: '',
      state: '',
      postalCode: '',
      countryId: '',
      phone: '',
      privateNotes: '',
      website: '',
      vatNumber: '',
      idNumber: '',
      currencyId: '',
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      contacts: BuiltList<VendorContactEntity>(
        <VendorContactEntity>[
          VendorContactEntity().rebuild((b) => b..isPrimary = true)
        ],
      ),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      assignedUserId: '',
      createdAt: 0,
      createdUserId: '',
    );
  }

  VendorEntity._();

  @override
  @memoized
  int get hashCode;

  VendorEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false);

  @override
  EntityType get entityType {
    return EntityType.vendor;
  }

  String get name;

  String get address1;

  String get address2;

  String get city;

  String get state;

  @BuiltValueField(wireName: 'postal_code')
  String get postalCode;

  @BuiltValueField(wireName: 'country_id')
  String get countryId;

  @BuiltValueField(wireName: 'phone')
  String get phone;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  String get website;

  @BuiltValueField(wireName: 'vat_number')
  String get vatNumber;

  @BuiltValueField(wireName: 'id_number')
  String get idNumber;

  @nullable
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

  @BuiltValueField(wireName: 'vendor_contacts')
  BuiltList<VendorContactEntity> get contacts;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany.canCreate(EntityType.expense)) {
        actions.add(EntityAction.newExpense);
      }
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  int compareTo(VendorEntity vendor, String sortField, bool sortAscending,
      BuiltMap<String, UserEntity> userMap) {
    int response = 0;
    final VendorEntity vendorA = sortAscending ? this : vendor;
    final VendorEntity vendorB = sortAscending ? vendor : this;

    switch (sortField) {
      case VendorFields.name:
        response =
            vendorA.name.toLowerCase().compareTo(vendorB.name.toLowerCase());
        break;
      case VendorFields.city:
        response =
            vendorA.city.toLowerCase().compareTo(vendorB.city.toLowerCase());
        break;
      case VendorFields.phone:
        response =
            vendorA.phone.toLowerCase().compareTo(vendorB.phone.toLowerCase());
        break;
      case EntityFields.state:
      case VendorFields.state:
        final stateA =
            EntityState.valueOf(vendorA.entityState) ?? EntityState.active;
        final stateB =
            EntityState.valueOf(vendorB.entityState) ?? EntityState.active;
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case EntityFields.assignedTo:
        final userA = userMap[vendorA.assignedUserId] ?? UserEntity();
        final userB = userMap[vendorB.assignedUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdBy:
        final userA = userMap[vendorA.createdUserId] ?? UserEntity();
        final userB = userMap[vendorB.createdUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case EntityFields.createdAt:
        response = vendorA.createdAt.compareTo(vendorB.createdAt);
        break;
      case VendorFields.archivedAt:
        response = vendorA.archivedAt.compareTo(vendorB.archivedAt);
        break;
      case VendorFields.updatedAt:
        response = vendorA.updatedAt.compareTo(vendorB.updatedAt);
        break;
      default:
        print('## ERROR: sort by vendor.$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    for(final contact in contacts) {
      if (contact.matchesFilter(filter)) {
        return true;
      }
    }

    return matchesStrings(
      haystacks: [
        name,
        vatNumber,
        idNumber,
        phone,
        address1,
        city,
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
  String matchesFilterValue(String filter) {
    for(final contact in contacts) {
      final value = contact.matchesFilterValue(filter);
      if (value != null) {
        return value;
      }
    }

    return matchesStringsValue(
      haystacks: [
        vatNumber,
        idNumber,
        phone,
        address1,
        city,
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
    return name;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  bool get hasCurrency => currencyId != null && currencyId.isNotEmpty;

  static Serializer<VendorEntity> get serializer => _$vendorEntitySerializer;

  bool get hasNameSet {
    final contact = contacts.first;
    return name.isNotEmpty ||
        contact.fullName.isNotEmpty ||
        contact.email.isNotEmpty;
  }
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
      createdUserId: '',
      createdAt: 0,
      assignedUserId: '',
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

  String get phone;

  String get fullName {
    return (firstName + ' ' + lastName).trim();
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();
    if (fullName.toLowerCase().contains(filter)) {
      return fullName;
    } else if (email.toLowerCase().contains(filter)) {
      return email;
    } else if (phone.toLowerCase().contains(filter)) {
      return phone;
    }

    return null;
  }

  @override
  String get listDisplayName {
    return '';
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static Serializer<VendorContactEntity> get serializer =>
      _$vendorContactEntitySerializer;
}
