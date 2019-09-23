import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'vendor_model.g.dart';

abstract class VendorListResponse
    implements Built<VendorListResponse, VendorListResponseBuilder> {
  factory VendorListResponse([void updates(VendorListResponseBuilder b)]) =
      _$VendorListResponse;

  VendorListResponse._();

  BuiltList<VendorEntity> get data;

  static Serializer<VendorListResponse> get serializer =>
      _$vendorListResponseSerializer;
}

abstract class VendorItemResponse
    implements Built<VendorItemResponse, VendorItemResponseBuilder> {
  factory VendorItemResponse([void updates(VendorItemResponseBuilder b)]) =
      _$VendorItemResponse;

  VendorItemResponse._();

  VendorEntity get data;

  static Serializer<VendorItemResponse> get serializer =>
      _$vendorItemResponseSerializer;
}

class VendorFields {
  static const String name = 'name';
  static const String balance = 'balance';
  static const String paidToDate = 'paidToDate';
  static const String address1 = 'address1';
  static const String address2 = 'address2';
  static const String city = 'city';
  static const String state = 'state';
  static const String postalCode = 'postalCode';
  static const String countryId = 'countryId';
  static const String workPhone = 'workPhone';
  static const String privateNotes = 'privateNotes';
  static const String lastLogin = 'lastLogin';
  static const String website = 'website';
  static const String vatNumber = 'vatNumber';
  static const String idNumber = 'idNumber';
  static const String currencyId = 'currencyId';
  static const String customValue1 = 'customValue1';
  static const String customValue2 = 'customValue2';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class VendorEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<VendorEntity, VendorEntityBuilder> {
  factory VendorEntity({String id}) {
    return _$VendorEntity._(
      id: id ?? BaseEntity.nextId,
      name: '',
      balance: 0.0,
      paidToDate: 0.0,
      address1: '',
      address2: '',
      city: '',
      state: '',
      postalCode: '',
      countryId: '',
      workPhone: '',
      privateNotes: '',
      lastLogin: '',
      website: '',
      vatNumber: '',
      idNumber: '',
      currencyId: '',
      customValue1: '',
      customValue2: '',
      contacts: BuiltList<VendorContactEntity>(
        <VendorContactEntity>[
          VendorContactEntity().rebuild((b) => b..isPrimary = true)
        ],
      ),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  VendorEntity._();

  VendorEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isDeleted = false);

  @override
  EntityType get entityType {
    return EntityType.vendor;
  }

  String get name;

  double get balance;

  @BuiltValueField(wireName: 'paid_to_date')
  double get paidToDate;

  String get address1;

  String get address2;

  String get city;

  String get state;

  @BuiltValueField(wireName: 'postal_code')
  String get postalCode;

  @BuiltValueField(wireName: 'country_id')
  String get countryId;

  @BuiltValueField(wireName: 'work_phone')
  String get workPhone;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'last_login')
  String get lastLogin;

  String get website;

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

  @BuiltValueField(wireName: 'vendor_contacts')
  BuiltList<VendorContactEntity> get contacts;

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false}) {
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

  int compareTo(VendorEntity vendor, String sortField, bool sortAscending) {
    int response = 0;
    final VendorEntity vendorA = sortAscending ? this : vendor;
    final VendorEntity vendorB = sortAscending ? vendor : this;

    switch (sortField) {
      case VendorFields.name:
        response = vendorA.name.compareTo(vendorB.name);
        break;
      case VendorFields.updatedAt:
        response = vendorA.updatedAt.compareTo(vendorB.updatedAt);
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (name.toLowerCase().contains(filter)) {
      return true;
    } else if (vatNumber.toLowerCase().contains(filter)) {
      return true;
    } else if (idNumber.toLowerCase().contains(filter)) {
      return true;
    } else if (workPhone.toLowerCase().contains(filter)) {
      return true;
    } else if (address1.toLowerCase().contains(filter)) {
      return true;
    } else if (city.toLowerCase().contains(filter)) {
      return true;
    } else if (contacts
        .where((contact) => contact.matchesFilter(filter))
        .isNotEmpty) {
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
    final contact = contacts.firstWhere(
        (contact) => contact.matchesFilter(filter),
        orElse: () => null);

    if (vatNumber.toLowerCase().contains(filter)) {
      return vatNumber;
    } else if (idNumber.toLowerCase().contains(filter)) {
      return idNumber;
    } else if (workPhone.toLowerCase().contains(filter)) {
      return workPhone;
    } else if (address1.toLowerCase().contains(filter)) {
      return address1;
    } else if (city.toLowerCase().contains(filter)) {
      return city;
    } else if (contact != null) {
      final match = contact.matchesFilterValue(filter);
      return match == name ? null : match;
    }

    return null;
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
      firstName: '',
      lastName: '',
      email: '',
      isPrimary: false,
      phone: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  VendorContactEntity._();

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
