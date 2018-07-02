import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'client_model.g.dart';

abstract class ClientListResponse
    implements Built<ClientListResponse, ClientListResponseBuilder> {
  BuiltList<ClientEntity> get data;

  ClientListResponse._();
  factory ClientListResponse([void updates(ClientListResponseBuilder b)]) =
      _$ClientListResponse;
  static Serializer<ClientListResponse> get serializer =>
      _$clientListResponseSerializer;
}

abstract class ClientItemResponse
    implements Built<ClientItemResponse, ClientItemResponseBuilder> {
  ClientEntity get data;

  ClientItemResponse._();
  factory ClientItemResponse([void updates(ClientItemResponseBuilder b)]) =
      _$ClientItemResponse;
  static Serializer<ClientItemResponse> get serializer =>
      _$clientItemResponseSerializer;
}

class ClientFields {
  static const String name = 'name';
  static const String balance = 'balance';
  static const String vatNumber = 'vatNumber';
  static const String idNumber = 'idNumber';
  static const String paidToDate = 'paidToDate';
  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
  static const String contact = 'contact';
  static const String workPhone = 'workPhone';
}

abstract class ClientEntity extends Object
    with BaseEntity
    implements Built<ClientEntity, ClientEntityBuilder> {
  @override
  EntityType get entityType {
    return EntityType.client;
  }

  static int counter = 0;

  factory ClientEntity() {
    return _$ClientEntity._(
      id: --ClientEntity.counter,
      name: '',
      displayName: '',
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
      publicNotes: '',
      website: '',
      industryId: 0,
      sizeId: 0,
      paymentTerms: 0,
      vatNumber: '',
      idNumber: '',
      languageId: 0,
      currencyId: 0,
      invoiceNumberCounter: 0,
      quoteNumberCounter: 0,
      taskRate: 0.0,
      shippingAddress1: '',
      shippingAddress2: '',
      shippingCity: '',
      shippingState: '',
      shippingPostalCode: '',
      shippingCountryId: 0,
      showTasksInPortal: false,
      sendReminders: false,
      creditNumberCounter: 0,
      customValue1: '',
      customValue2: '',
      contacts: BuiltList<ContactEntity>(),
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'display_name')
  String get displayName;

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

  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  String get website;

  @BuiltValueField(wireName: 'industry_id')
  int get industryId;

  @BuiltValueField(wireName: 'size_id')
  int get sizeId;

  @BuiltValueField(wireName: 'payment_terms')
  int get paymentTerms;

  @BuiltValueField(wireName: 'vat_number')
  String get vatNumber;

  @BuiltValueField(wireName: 'id_number')
  String get idNumber;

  @BuiltValueField(wireName: 'language_id')
  int get languageId;

  @BuiltValueField(wireName: 'currency_id')
  int get currencyId;

  @BuiltValueField(wireName: 'invoice_number_counter')
  int get invoiceNumberCounter;

  @BuiltValueField(wireName: 'quote_number_counter')
  int get quoteNumberCounter;

  @BuiltValueField(wireName: 'task_rate')
  double get taskRate;

  @BuiltValueField(wireName: 'shipping_address1')
  String get shippingAddress1;

  @BuiltValueField(wireName: 'shipping_address2')
  String get shippingAddress2;

  @BuiltValueField(wireName: 'shipping_city')
  String get shippingCity;

  @BuiltValueField(wireName: 'shipping_state')
  String get shippingState;

  @BuiltValueField(wireName: 'shipping_postal_code')
  String get shippingPostalCode;

  @BuiltValueField(wireName: 'shipping_country_id')
  int get shippingCountryId;

  @BuiltValueField(wireName: 'show_tasks_in_portal')
  bool get showTasksInPortal;

  @BuiltValueField(wireName: 'send_reminders')
  bool get sendReminders;

  @BuiltValueField(wireName: 'credit_number_counter')
  int get creditNumberCounter;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  BuiltList<ContactEntity> get contacts;

  //String get last_login;
  //String get custom_messages;

  @override
  String get listDisplayName {
    return displayName;
  }

  bool get hasEmailAddress =>
      contacts.where((contact) => contact.email?.isNotEmpty).length > 0;

  int compareTo(ClientEntity client, String sortField, bool sortAscending) {
    int response = 0;
    ClientEntity clientA = sortAscending ? this : client;
    ClientEntity clientB = sortAscending ? client : this;

    switch (sortField) {
      case ClientFields.balance:
        response = clientA.balance.compareTo(clientB.balance);
    }

    if (response == 0) {
      return clientA.displayName
          .toLowerCase()
          .compareTo(clientB.displayName.toLowerCase());
    } else {
      return response;
    }
  }

  @override
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }
    search = search.toLowerCase();
    if (displayName.toLowerCase().contains(search)) {
      return true;
    }
    if (vatNumber.toLowerCase().contains(search)) {
      return true;
    }
    if (idNumber.toLowerCase().contains(search)) {
      return true;
    }
    if (workPhone.toLowerCase().contains(search)) {
      return true;
    }
    if (contacts.where((contact) => contact.matchesSearch(search)).length > 0) {
      return true;
    }
    return false;
  }

  @override
  String matchesSearchValue(String search) {
    if (search == null || search.isEmpty) {
      return '';
    }

    search = search.toLowerCase();
    if (vatNumber.toLowerCase().contains(search)) {
      return vatNumber;
    }
    if (idNumber.toLowerCase().contains(search)) {
      return idNumber;
    }
    if (workPhone.toLowerCase().contains(search)) {
      return workPhone;
    }
    final contact = contacts.firstWhere(
        (contact) => contact.matchesSearch(search),
        orElse: () => null);
    if (contact != null) {
      return contact.matchesSearchValue(search);
    }

    return '';
  }

  ClientEntity._();
  static Serializer<ClientEntity> get serializer => _$clientEntitySerializer;
}

class ContactFields {
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String phone = 'phone';
}

abstract class ContactEntity extends Object
    with BaseEntity
    implements Built<ContactEntity, ContactEntityBuilder> {
  static int counter = 0;
  factory ContactEntity() {
    return _$ContactEntity._(
      id: --ContactEntity.counter,
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      contactKey: '',
      isPrimary: false,
      customValue1: '',
      customValue2: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  String get email;

  String get phone;

  @BuiltValueField(wireName: 'contact_key')
  String get contactKey;

  @BuiltValueField(wireName: 'is_primary')
  bool get isPrimary;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  String fullName() {
    return (firstName + ' ' + lastName).trim();
  }

  @override
  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }
    search = search.toLowerCase();
    if (firstName.toLowerCase().contains(search)) {
      return true;
    }
    if (lastName.toLowerCase().contains(search)) {
      return true;
    }
    if (phone.toLowerCase().contains(search)) {
      return true;
    }
    if (email.toLowerCase().contains(search)) {
      return true;
    }
    return false;
  }

  @override
  String matchesSearchValue(String search) {
    if (search == null || search.isEmpty) {
      return null;
    }

    search = search.toLowerCase();
    if (fullName().toLowerCase().contains(search)) {
      return fullName();
    } else if (email.toLowerCase().contains(search)) {
      return email;
    } else if (phone.toLowerCase().contains(search)) {
      return phone;
    }

    return null;
  }

  ContactEntity._();
  static Serializer<ContactEntity> get serializer => _$contactEntitySerializer;
}
