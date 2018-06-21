import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'client_model.g.dart';

abstract class ClientListResponse implements Built<ClientListResponse, ClientListResponseBuilder> {

  BuiltList<ClientEntity> get data;

  ClientListResponse._();
  factory ClientListResponse([updates(ClientListResponseBuilder b)]) = _$ClientListResponse;
  static Serializer<ClientListResponse> get serializer => _$clientListResponseSerializer;
}

abstract class ClientItemResponse implements Built<ClientItemResponse, ClientItemResponseBuilder> {

  ClientEntity get data;

  ClientItemResponse._();
  factory ClientItemResponse([updates(ClientItemResponseBuilder b)]) = _$ClientItemResponse;
  static Serializer<ClientItemResponse> get serializer => _$clientItemResponseSerializer;
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


abstract class ClientEntity extends Object with BaseEntity implements Built<ClientEntity, ClientEntityBuilder> {

  static int counter = 0;
  factory ClientEntity() {
    return _$ClientEntity._(
        id: --ClientEntity.counter,
        contacts: BuiltList<ContactEntity>(),
    );
  }

  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

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
  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  @nullable
  String get website;

  @nullable
  @BuiltValueField(wireName: 'industry_id')
  int get industryId;

  @nullable
  @BuiltValueField(wireName: 'size_id')
  int get sizeId;

  @nullable
  @BuiltValueField(wireName: 'payment_terms')
  int get paymentTerms;

  @nullable
  @BuiltValueField(wireName: 'vat_number')
  String get vatNumber;

  @nullable
  @BuiltValueField(wireName: 'id_number')
  String get idNumber;

  @nullable
  @BuiltValueField(wireName: 'language_id')
  int get languageId;

  @nullable
  @BuiltValueField(wireName: 'currency_id')
  int get currencyId;

  @nullable
  @BuiltValueField(wireName: 'invoice_number_counter')
  int get invoiceNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'quote_number_counter')
  int get quoteNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'task_rate')
  double get taskRate;

  @nullable
  @BuiltValueField(wireName: 'shipping_address1')
  String get shippingAddress1;

  @nullable
  @BuiltValueField(wireName: 'shipping_address2')
  String get shippingAddress2;

  @nullable
  @BuiltValueField(wireName: 'shipping_city')
  String get shippingCity;

  @nullable
  @BuiltValueField(wireName: 'shipping_state')
  String get shippingState;

  @nullable
  @BuiltValueField(wireName: 'shipping_postal_code')
  String get shippingPostalCode;

  @nullable
  @BuiltValueField(wireName: 'shipping_country_id')
  int get shippingCountryId;

  @nullable
  @BuiltValueField(wireName: 'show_tasks_in_portal')
  bool get showTasksInPortal;

  @nullable
  @BuiltValueField(wireName: 'send_reminders')
  bool get sendReminders;

  @nullable
  @BuiltValueField(wireName: 'credit_number_counter')
  int get creditNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  BuiltList<ContactEntity> get contacts;

  //String get last_login;
  //String get custom_messages;

  String get listDisplayName {
    return displayName;
  }

  bool get hasEmailAddress => contacts.where((contact) => contact.email?.isNotEmpty).length > 0;

  int compareTo(ClientEntity client, String sortField, bool sortAscending) {
    int response = 0;
    ClientEntity clientA = sortAscending ? this : client;
    ClientEntity clientB = sortAscending ? client: this;

    switch (sortField) {
      case ClientFields.balance:
        response = clientA.balance.compareTo(clientB.balance);
    }

    if (response == 0) {
      return clientA.displayName.toLowerCase().compareTo(clientB.displayName.toLowerCase());
    } else {
      return response;
    }
  }

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

  String matchesSearchField(String search) {
    if (search == null || search.isEmpty) {
      return null;
    }
    search = search.toLowerCase();
    if (displayName.toLowerCase().contains(search)) {
      return null;
    }
    if (vatNumber.toLowerCase().contains(search)) {
      return ClientFields.vatNumber;
    }
    if (idNumber.toLowerCase().contains(search)) {
      return ClientFields.idNumber;
    }
    if (workPhone.toLowerCase().contains(search)) {
      return ClientFields.workPhone;
    }
    var contact = contacts.where((contact) => contact.matchesSearch(search)).first;
    if (contact != null) {
      return contact.matchesSearchField(search);
    }

    return null;
  }

  String matchesSearchValue(String search) {
    if (search == null || search.isEmpty) {
      return null;
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
    var contact = contacts.where((contact) => contact.matchesSearch(search)).first;
    if (contact != null) {
      return contact.matchesSearchValue(search);
    }

    return null;
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

abstract class ContactEntity extends Object with BaseEntity implements Built<ContactEntity, ContactEntityBuilder> {

  static int counter = 0;
  factory ContactEntity() {
    return _$ContactEntity._(
        id: --ContactEntity.counter
    );
  }

  @nullable
  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @nullable
  String get email;

  @nullable
  String get phone;

  @nullable
  @BuiltValueField(wireName: 'contact_key')
  String get contactKey;

  @nullable
  @BuiltValueField(wireName: 'is_primary')
  bool get isPrimary;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  String fullName () {
    return (firstName + ' ' + lastName).trim();
  }

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

  String matchesSearchField(String search) {
    if (search == null || search.isEmpty) {
      return null;
    }
    search = search.toLowerCase();
    if (fullName().toLowerCase().contains(search)) {
      return ClientFields.contact;
    } else if (email.toLowerCase().contains(search)) {
      return ContactFields.email;
    } else if (phone.toLowerCase().contains(search)) {
      return ContactFields.phone;
    }

    return null;
  }

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
