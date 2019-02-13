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
  factory VendorEntity() {
    return _$VendorEntity._(
      id: --VendorEntity.counter,
      name: '',
      balance: 0.0,
      paidToDate: 0.0,
      address1: '',
      address2: '',
      city: '',
      state: '',
      postalCode: '',
      countryId: 0,
      workPhone: '',
      privateNotes: '',
      lastLogin: '',
      website: '',
      vatNumber: '',
      idNumber: '',
      currencyId: 0,
      customValue1: '',
      customValue2: '',
      vendorContacts: BuiltList<VendorContactEntity>(),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  VendorEntity._();

  static int counter = 0;

  VendorEntity get clone => rebuild((b) => b
    ..id = --VendorEntity.counter
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
  int get countryId;

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
  int get currencyId;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'vendor_contacts')
  BuiltList<VendorContactEntity> get vendorContacts;

  List<EntityAction> getEntityActions({UserEntity user, ClientEntity client}) {
    final actions = <EntityAction>[];

    return actions..addAll(getBaseActions(user: user));
  }

  int compareTo(VendorEntity vendor, String sortField, bool sortAscending) {
    int response = 0;
    final VendorEntity vendorA = sortAscending ? this : vendor;
    final VendorEntity vendorB = sortAscending ? vendor : this;

    switch (sortField) {
      case VendorFields.name:
        response = vendorA.name.compareTo(vendorB.name);
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    return name.toLowerCase().contains(filter);
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
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

  static Serializer<VendorEntity> get serializer => _$vendorEntitySerializer;
}

abstract class VendorContactEntity extends Object
    with BaseEntity
    implements Built<VendorContactEntity, VendorContactEntityBuilder> {
  factory VendorContactEntity() {
    return _$VendorContactEntity._(
      id: --VendorContactEntity.counter,
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

  static int counter = 0;

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  String get email;

  @BuiltValueField(wireName: 'is_primary')
  bool get isPrimary;

  String get phone;

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
