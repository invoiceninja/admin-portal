import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'vendor_model.g.dart';

abstract class VendorListResponse implements Built<VendorListResponse, VendorListResponseBuilder> {

  BuiltList<VendorEntity> get data;

  VendorListResponse._();
  factory VendorListResponse([updates(VendorListResponseBuilder b)]) = _$VendorListResponse;
  static Serializer<VendorListResponse> get serializer => _$vendorListResponseSerializer;
}

abstract class VendorItemResponse implements Built<VendorItemResponse, VendorItemResponseBuilder> {

  VendorEntity get data;

  VendorItemResponse._();
  factory VendorItemResponse([updates(VendorItemResponseBuilder b)]) = _$VendorItemResponse;
  static Serializer<VendorItemResponse> get serializer => _$vendorItemResponseSerializer;
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

abstract class VendorEntity extends Object with BaseEntity implements Built<VendorEntity, VendorEntityBuilder> {

  @nullable
  String get name;

  @nullable
  double get balance;

  @nullable
  @BuiltValueField(wireName: 'paid_to_date')
  double get paidToDate;

  @nullable
  String get address1;

  @nullable
  String get address2;

  @nullable
  String get city;

  @nullable
  String get state;

  @nullable
  @BuiltValueField(wireName: 'postal_code')
  String get postalCode;

  @nullable
  @BuiltValueField(wireName: 'country_id')
  int get countryId;

  @nullable
  @BuiltValueField(wireName: 'work_phone')
  String get workPhone;

  @nullable
  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @nullable
  @BuiltValueField(wireName: 'last_login')
  String get lastLogin;

  @nullable
  String get website;

  @nullable
  @BuiltValueField(wireName: 'vat_number')
  String get vatNumber;

  @nullable
  @BuiltValueField(wireName: 'id_number')
  String get idNumber;

  @nullable
  @BuiltValueField(wireName: 'currency_id')
  int get currencyId;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'vendor_contacts')
  BuiltList<VendorContactEntity> get vendorContacts;


  int compareTo(VendorEntity vendor, String sortField, bool sortAscending) {
    int response = 0;
    VendorEntity vendorA = sortAscending ? this : vendor;
    VendorEntity vendorB = sortAscending ? vendor: this;

    switch (sortField) {
      case VendorFields.name:
        response = vendorA.name.compareTo(vendorB.name);
    }
    
    return response;
  }
  
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    return name.contains(search);
  }
  
  VendorEntity._();
  factory VendorEntity([updates(VendorEntityBuilder b)]) = _$VendorEntity;
  static Serializer<VendorEntity> get serializer => _$vendorEntitySerializer;
}

abstract class VendorContactEntity extends Object with BaseEntity implements Built<VendorContactEntity, VendorContactEntityBuilder> {

  @nullable
  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'is_primary')
  bool get isPrimary;

  @nullable
  String get phone;

  VendorContactEntity._();
  factory VendorContactEntity([updates(VendorContactEntityBuilder b)]) = _$VendorContactEntity;
  static Serializer<VendorContactEntity> get serializer => _$vendorContactEntitySerializer;
}