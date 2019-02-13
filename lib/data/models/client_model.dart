import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'client_model.g.dart';

abstract class ClientListResponse
    implements Built<ClientListResponse, ClientListResponseBuilder> {
  factory ClientListResponse([void updates(ClientListResponseBuilder b)]) =
      _$ClientListResponse;

  ClientListResponse._();

  BuiltList<ClientEntity> get data;

  static Serializer<ClientListResponse> get serializer =>
      _$clientListResponseSerializer;
}

abstract class ClientItemResponse
    implements Built<ClientItemResponse, ClientItemResponseBuilder> {
  factory ClientItemResponse([void updates(ClientItemResponseBuilder b)]) =
      _$ClientItemResponse;

  ClientItemResponse._();

  ClientEntity get data;

  static Serializer<ClientItemResponse> get serializer =>
      _$clientItemResponseSerializer;
}

class ClientFields {
  static const String name = 'name';
  static const String balance = 'balance';
  static const String vatNumber = 'vatNumber';
  static const String idNumber = 'idNumber';
  static const String paidToDate = 'paidToDate';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
  static const String contact = 'contact';
  static const String workPhone = 'workPhone';
  static const String language = 'language';
  static const String currency = 'currency';
}

abstract class ClientEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ClientEntity, ClientEntityBuilder> {
  factory ClientEntity({int id}) {
    return _$ClientEntity._(
      id: id ?? --ClientEntity.counter,
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
      contacts: BuiltList<ContactEntity>(
        <ContactEntity>[ContactEntity().rebuild((b) => b..isPrimary = true)],
      ),
      activities: BuiltList<ActivityEntity>(),
      lastUpdatedActivities: 0,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  ClientEntity._();

  static int counter = 0;

  ClientEntity get clone => rebuild((b) => b
    ..id = --ClientEntity.counter
    ..isDeleted = false);

  @nullable
  int get lastUpdatedActivities;

  bool get areActivitiesLoaded =>
      lastUpdatedActivities != null && lastUpdatedActivities > 0;

  bool get areActivitiesStale {
    if (!areActivitiesLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdatedActivities >
        kMillisecondsToRefreshActivities;
  }

  @override
  EntityType get entityType {
    return EntityType.client;
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

  BuiltList<ActivityEntity> get activities;

  //String get last_login;
  //String get custom_messages;

  @override
  String get listDisplayName {
    return displayName;
  }

  Iterable<ActivityEntity> getActivities({int invoiceId, int typeId}) {
    return activities.where((activity) {
      if (invoiceId != null && activity.invoiceId != invoiceId) {
        return false;
      }
      if (typeId != null && activity.activityTypeId != typeId) {
        return false;
      }
      return true;
    });
  }

  EmailTemplate getNextEmailTemplate(int invoiceId) {
    EmailTemplate template = EmailTemplate.initial;
    getActivities(invoiceId: invoiceId, typeId: kActivityEmailInvoice)
        .forEach((activity) {
      if (template == EmailTemplate.initial) {
        template = EmailTemplate.reminder1;
      }
      if (activity.notes == 'reminder1') {
        template = EmailTemplate.reminder2;
      } else if (activity.notes == 'reminder2') {
        template = EmailTemplate.reminder3;
      }
    });
    return template;
  }

  String getPaymentTerm(String netLabel) {
    if (paymentTerms == 0) {
      return '';
    } else if (paymentTerms == -1) {
      return '$netLabel 0';
    } else {
      return '$netLabel $paymentTerms';
    }
  }

  bool get hasEmailAddress =>
      contacts.where((contact) => contact.email?.isNotEmpty).isNotEmpty;

  int compareTo(ClientEntity client, String sortField, bool sortAscending) {
    int response = 0;
    final ClientEntity clientA = sortAscending ? this : client;
    final ClientEntity clientB = sortAscending ? client : this;

    switch (sortField) {
      case ClientFields.balance:
        response = clientA.balance.compareTo(clientB.balance);
        break;
      case ClientFields.updatedAt:
        response = clientA.updatedAt.compareTo(clientB.updatedAt);
        break;
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
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }
    filter = filter.toLowerCase();
    if (displayName.toLowerCase().contains(filter)) {
      return true;
    }
    if (vatNumber.toLowerCase().contains(filter)) {
      return true;
    }
    if (idNumber.toLowerCase().contains(filter)) {
      return true;
    }
    if (workPhone.toLowerCase().contains(filter)) {
      return true;
    }
    if (contacts.where((contact) => contact.matchesFilter(filter)).isNotEmpty) {
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
    if (vatNumber.toLowerCase().contains(filter)) {
      return vatNumber;
    }
    if (idNumber.toLowerCase().contains(filter)) {
      return idNumber;
    }
    if (workPhone.toLowerCase().contains(filter)) {
      return workPhone;
    }
    final contact = contacts.firstWhere(
        (contact) => contact.matchesFilter(filter),
        orElse: () => null);
    if (contact != null) {
      final match = contact.matchesFilterValue(filter);
      return match == displayName ? null : match;
    }

    return null;
  }

  List<EntityAction> getEntityActions(
      {UserEntity user, bool includeCreate = false, bool includeEdit = false}) {
    final actions = <EntityAction>[];

    if (includeEdit && user.canEditEntity(this)) {
      actions.add(EntityAction.edit);
    }

    if (includeCreate && user.canCreate(EntityType.client) && isActive) {
      actions.add(EntityAction.newInvoice);
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(getBaseActions(user: user));
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  bool get areAddressesDifferent =>
      address1 != shippingAddress1 ||
      address2 != shippingAddress2 ||
      city != shippingCity ||
      state != shippingState ||
      postalCode != shippingPostalCode ||
      countryId != shippingCountryId;

  bool get hasShippingAddress =>
      shippingAddress1.isNotEmpty ||
      shippingAddress2.isNotEmpty ||
      shippingCity.isNotEmpty ||
      shippingState.isNotEmpty ||
      shippingPostalCode.isNotEmpty ||
      shippingCountryId > 0;

  bool get hasBillingAddress =>
      address1.isNotEmpty ||
      address2.isNotEmpty ||
      city.isNotEmpty ||
      state.isNotEmpty ||
      postalCode.isNotEmpty ||
      countryId > 0;

  bool get hasNameSet {
    final contact = contacts.first;
    return name.isNotEmpty ||
        contact.fullName.isNotEmpty ||
        contact.email.isNotEmpty;
  }

  /*
  @override
  String toString() {
    return displayName;
  }
  */

  static Serializer<ClientEntity> get serializer => _$clientEntitySerializer;
}

class ContactFields {
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String phone = 'phone';
}

abstract class ContactEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ContactEntity, ContactEntityBuilder> {
  factory ContactEntity() {
    return _$ContactEntity._(
      id: --ContactEntity.counter,
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      phone: '',
      contactKey: '',
      isPrimary: false,
      sendInvoice: true,
      customValue1: '',
      customValue2: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  ContactEntity._();

  static int counter = 0;

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  String get email;

  @nullable
  String get password;

  String get phone;

  @BuiltValueField(wireName: 'contact_key')
  String get contactKey;

  @BuiltValueField(wireName: 'is_primary')
  bool get isPrimary;

  @BuiltValueField(wireName: 'send_invoice')
  bool get sendInvoice;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  String get fullName {
    return (firstName + ' ' + lastName).trim();
  }

  @override
  EntityType get entityType {
    return EntityType.contact;
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }
    filter = filter.toLowerCase();
    if (firstName.toLowerCase().contains(filter)) {
      return true;
    }
    if (lastName.toLowerCase().contains(filter)) {
      return true;
    }
    if (phone.toLowerCase().contains(filter)) {
      return true;
    }
    if (email.toLowerCase().contains(filter)) {
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
    return fullName;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static Serializer<ContactEntity> get serializer => _$contactEntitySerializer;
}
