import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/gateway_token_model.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
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
  static const String clientId = 'client_id';
  static const String name = 'name';
  static const String address1 = 'address1';
  static const String address2 = 'address2';
  static const String country = 'country';
  static const String balance = 'balance';
  static const String vatNumber = 'vat_number';
  static const String idNumber = 'id_number';
  static const String paidToDate = 'paid_to_date';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
  static const String contact = 'contact';
  static const String contactEmail = 'contact_email';
  static const String state = 'state';
  static const String phone = 'phone';
  static const String website = 'website';
  static const String language = 'language';
  static const String currency = 'currency';
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
  static const String custom3 = 'custom3';
  static const String custom4 = 'custom4';
  static const String assignedTo = 'assigned_to';
  static const String createdBy = 'created_by';
  static const String assignedToId = 'assigned_to_id';
  static const String createdById = 'created_by_id';
  static const String cityStatePostal = 'city_state_postal';
  static const String postalCityState = 'postal_city_state';
}

abstract class ClientEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ClientEntity, ClientEntityBuilder> {
  factory ClientEntity({String id, AppState state}) {
    return _$ClientEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      settings: SettingsEntity(),
      name: '',
      displayName: '',
      balance: 0,
      creditBalance: 0,
      paidToDate: 0,
      address1: '',
      address2: '',
      city: '',
      state: '',
      postalCode: '',
      countryId: '',
      phone: '',
      privateNotes: '',
      publicNotes: '',
      website: '',
      industryId: '',
      sizeId: '',
      vatNumber: '',
      idNumber: '',
      shippingAddress1: '',
      shippingAddress2: '',
      shippingCity: '',
      shippingState: '',
      groupId: '',
      shippingPostalCode: '',
      shippingCountryId: '',
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      contacts: BuiltList<ContactEntity>(
        <ContactEntity>[ContactEntity().rebuild((b) => b..isPrimary = true)],
      ),
      activities: BuiltList<ActivityEntity>(),
      gatewayTokens: BuiltList<GatewayTokenEntity>(),
      lastUpdatedActivities: 0,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      createdUserId: '',
      assignedUserId: '',
      createdAt: 0,
    );
  }

  ClientEntity._();

  ClientEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false);

  @BuiltValueField(wireName: 'group_settings_id')
  String get groupId;

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

  String get name;

  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  double get balance;

  @BuiltValueField(wireName: 'credit_balance')
  double get creditBalance;

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

  @BuiltValueField(wireName: 'phone')
  String get phone;

  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @BuiltValueField(wireName: 'public_notes')
  String get publicNotes;

  String get website;

  @BuiltValueField(wireName: 'industry_id')
  String get industryId;

  @BuiltValueField(wireName: 'size_id')
  String get sizeId;

  @BuiltValueField(wireName: 'vat_number')
  String get vatNumber;

  @BuiltValueField(wireName: 'id_number')
  String get idNumber;

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
  String get shippingCountryId;

  SettingsEntity get settings;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  BuiltList<ContactEntity> get contacts;

  BuiltList<ActivityEntity> get activities;

  @BuiltValueField(wireName: 'gateway_tokens')
  BuiltList<GatewayTokenEntity> get gatewayTokens;

  //String get last_login;
  //String get custom_messages;

  @override
  String get listDisplayName {
    return displayName;
  }

  String getCurrencyId(
      {@required CompanyEntity company, @required GroupEntity group}) {
    if (hasCurrency) {
      return settings.currencyId;
    } else if (group.hasCurrency) {
      return group.currencyId;
    } else {
      return company.currencyId;
    }
  }

  Iterable<ActivityEntity> getActivities({String invoiceId, String typeId}) {
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

  EmailTemplate getNextEmailTemplate(String invoiceId) {
    EmailTemplate template = EmailTemplate.invoice;
    getActivities(invoiceId: invoiceId, typeId: kActivityEmailInvoice)
        .forEach((activity) {
      if (template == EmailTemplate.invoice) {
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

  ContactEntity get primaryContact =>
      contacts.firstWhere((contact) => contact.isPrimary,
          orElse: () => ContactEntity());

  String getPaymentTerm(String netLabel) {
    if (settings.defaultPaymentTerms == 0 ||
        settings.defaultPaymentTerms == null) {
      return '';
    } else if (settings.defaultPaymentTerms == -1) {
      return '$netLabel 0';
    } else {
      return '$netLabel ${settings.defaultPaymentTerms}';
    }
  }

  bool get hasGroup => groupId != null && groupId.isNotEmpty;

  bool get hasLanguage =>
      settings.languageId != null && settings.languageId.isNotEmpty;

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
      case ClientFields.idNumber:
        response = clientA.idNumber.compareTo(clientB.idNumber);
        break;
      case ClientFields.createdAt:
        response = clientA.createdAt.compareTo(clientB.createdAt);
        break;
      case ClientFields.custom1:
        response = clientA.customValue1
            .toLowerCase()
            .compareTo(clientB.customValue1.toLowerCase());
        break;
      case ClientFields.custom2:
        response = clientA.customValue2
            .toLowerCase()
            .compareTo(clientB.customValue2.toLowerCase());
        break;
      case ClientFields.custom3:
        response = clientA.customValue3
            .toLowerCase()
            .compareTo(clientB.customValue3.toLowerCase());
        break;
      case ClientFields.custom4:
        response = clientA.customValue4
            .toLowerCase()
            .compareTo(clientB.customValue4.toLowerCase());
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
    } else if (vatNumber.toLowerCase().contains(filter)) {
      return true;
    } else if (idNumber.toLowerCase().contains(filter)) {
      return true;
    } else if (phone.toLowerCase().contains(filter)) {
      return true;
    } else if (address1.toLowerCase().contains(filter)) {
      return true;
    } else if (city.toLowerCase().contains(filter)) {
      return true;
    } else if (postalCode.toLowerCase().contains(filter)) {
      return true;
    } else if (contacts
        .where((contact) => contact.matchesFilter(filter))
        .isNotEmpty) {
      return true;
    } else if (customValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue2.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue3.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue4.toLowerCase().contains(filter)) {
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
    } else if (phone.toLowerCase().contains(filter)) {
      return phone;
    } else if (address1.toLowerCase().contains(filter)) {
      return address1;
    } else if (city.toLowerCase().contains(filter)) {
      return city;
    } else if (postalCode.toLowerCase().contains(filter)) {
      return postalCode;
    } else if (contact != null) {
      final match = contact.matchesFilterValue(filter);
      return match == displayName ? null : match;
    } else if (customValue1.toLowerCase().contains(filter)) {
      return customValue1;
    } else if (customValue2.toLowerCase().contains(filter)) {
      return customValue2;
    } else if (customValue3.toLowerCase().contains(filter)) {
      return customValue3;
    } else if (customValue4.toLowerCase().contains(filter)) {
      return customValue4;
    }

    return null;
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

      if (userCompany.canEditEntity(this)) {
        actions.add(EntityAction.settings);
      }

      if (userCompany.canCreate(EntityType.client)) {
        actions.add(EntityAction.newInvoice);
      }

      if (userCompany.canCreate(EntityType.payment)) {
        actions.add(EntityAction.newPayment);
      }

      if (userCompany.canCreate(EntityType.quote)) {
        actions.add(EntityAction.newQuote);
      }

      if (userCompany.canCreate(EntityType.credit)) {
        actions.add(EntityAction.newCredit);
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
      (shippingCountryId ?? '').isNotEmpty;

  bool get hasBillingAddress =>
      address1.isNotEmpty ||
      address2.isNotEmpty ||
      city.isNotEmpty ||
      state.isNotEmpty ||
      postalCode.isNotEmpty ||
      (countryId ?? '').isNotEmpty;

  bool get hasCountry => countryId != null && countryId.isNotEmpty;

  String get currencyId => settings.currencyId;

  bool get hasCurrency =>
      settings.currencyId != null && settings.currencyId.isNotEmpty;

  String get languageId => settings.languageId;

  bool get hasNameSet {
    if (contacts.isEmpty) {
      return false;
    }

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
  static const String fullName = 'full_name';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
  static const String custom3 = 'custom3';
  static const String custom4 = 'custom4';
}

abstract class ContactEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ContactEntity, ContactEntityBuilder> {
  factory ContactEntity() {
    return _$ContactEntity._(
      id: BaseEntity.nextId,
      isChanged: false,
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      phone: '',
      contactKey: '',
      isPrimary: false,
      sendEmail: true,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      lastLogin: 0,
      createdAt: 0,
      assignedUserId: '',
      createdUserId: '',
    );
  }

  ContactEntity._();

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  String get email;

  String get password;

  String get phone;

  @BuiltValueField(wireName: 'contact_key')
  String get contactKey;

  @BuiltValueField(wireName: 'is_primary')
  bool get isPrimary;

  @BuiltValueField(wireName: 'send_email')
  bool get sendEmail;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  // TODO remove this nullable
  @nullable
  @BuiltValueField(wireName: 'last_login')
  int get lastLogin;

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
