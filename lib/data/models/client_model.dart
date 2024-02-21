// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/gateway_token_model.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/system_log_model.dart';
import 'package:invoiceninja_flutter/data/models/tax_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/design/design_selectors.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'client_model.g.dart';

abstract class ClientListResponse
    implements Built<ClientListResponse, ClientListResponseBuilder> {
  factory ClientListResponse([void updates(ClientListResponseBuilder b)]) =
      _$ClientListResponse;

  ClientListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<ClientEntity> get data;

  static Serializer<ClientListResponse> get serializer =>
      _$clientListResponseSerializer;
}

abstract class ClientItemResponse
    implements Built<ClientItemResponse, ClientItemResponseBuilder> {
  factory ClientItemResponse([void updates(ClientItemResponseBuilder b)]) =
      _$ClientItemResponse;

  ClientItemResponse._();

  @override
  @memoized
  int get hashCode;

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
  static const String creditBalance = 'credit_balance';
  static const String paymentBalance = 'payment_balance';
  static const String vatNumber = 'vat_number';
  static const String idNumber = 'id_number';
  static const String number = 'number';
  static const String paidToDate = 'paid_to_date';
  static const String lastLoginAt = 'last_login_at';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
  static const String contacts = 'contacts';
  static const String contactName = 'contact_name';
  static const String contactEmail = 'contact_email';
  static const String contactPhone = 'contact_phone';
  static const String state = 'state';
  static const String phone = 'phone';
  static const String website = 'website';
  static const String language = 'language';
  static const String taskRate = 'task_rate';
  static const String publicNotes = 'public_notes';
  static const String privateNotes = 'private_notes';
  static const String currency = 'currency';
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
  static const String custom3 = 'custom3';
  static const String custom4 = 'custom4';
  static const String assignedToId = 'assigned_to_id';
  static const String createdById = 'created_by_id';
  static const String cityStatePostal = 'city_state_postal';
  static const String postalCityState = 'postal_city_state';
  static const String postalCity = 'postal_city';
  static const String documents = 'documents';
  static const String postalCode = 'postal_code';
  static const String city = 'city';
  static const String shippingAddress1 = 'shipping_address1';
  static const String shippingAddress2 = 'shipping_address2';
  static const String shippingCity = 'shipping_city';
  static const String shippingState = 'shipping_state';
  static const String shippingPostalCode = 'shipping_postal_code';
  static const String shippingCountry = 'shipping_country';
  static const String group = 'group';
  static const String routingId = 'routing_id';
  static const String isTaxExempt = 'tax_exempt';
  static const String classification = 'classification';
}

abstract class ClientEntity extends Object
    with BaseEntity, SelectableEntity, HasActivities
    implements Built<ClientEntity, ClientEntityBuilder> {
  factory ClientEntity({
    String? id,
    AppState? state,
    UserEntity? user,
    GroupEntity? group,
  }) {
    return _$ClientEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      settings: SettingsEntity(),
      name: '',
      displayName: '',
      balance: 0,
      creditBalance: 0,
      paymentBalance: 0,
      paidToDate: 0,
      lastLogin: 0,
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
      number: '',
      shippingAddress1: '',
      shippingAddress2: '',
      shippingCity: '',
      shippingState: '',
      groupId: group?.id ?? '',
      shippingPostalCode: '',
      shippingCountryId: '',
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      routingId: '',
      isTaxExempt: false,
      hasValidVatNumber: false,
      classification: '',
      taxData: TaxDataEntity(),
      contacts: BuiltList<ClientContactEntity>(
        <ClientContactEntity>[
          ClientContactEntity().rebuild((b) => b..isPrimary = true)
        ],
      ),
      activities: BuiltList<ActivityEntity>(),
      ledger: BuiltList<LedgerEntity>(),
      gatewayTokens: BuiltList<GatewayTokenEntity>(),
      systemLogs: BuiltList<SystemLogEntity>(),
      loadedAt: 0,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      createdUserId: '',
      assignedUserId: user?.id ?? '',
      createdAt: 0,
      documents: BuiltList<DocumentEntity>(),
      clientHash: '',
    );
  }

  ClientEntity._();

  @override
  @memoized
  int get hashCode;

  ClientEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..idNumber = ''
    ..documents.clear()
    ..isChanged = false
    ..isDeleted = false);

  @BuiltValueField(wireName: 'group_settings_id')
  String get groupId;

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
    return EntityType.client;
  }

  String get name;

  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  double get balance;

  @BuiltValueField(wireName: 'credit_balance')
  double get creditBalance;

  @BuiltValueField(wireName: 'payment_balance')
  double get paymentBalance;

  @BuiltValueField(wireName: 'paid_to_date')
  double get paidToDate;

  @BuiltValueField(wireName: 'client_hash')
  String get clientHash;

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

  @BuiltValueField(wireName: 'number')
  String get number;

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

  @BuiltValueField(wireName: 'last_login')
  int get lastLogin;

  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @BuiltValueField(wireName: 'routing_id')
  String get routingId;

  @BuiltValueField(wireName: 'is_tax_exempt')
  bool get isTaxExempt;

  @BuiltValueField(wireName: 'has_valid_vat_number')
  bool get hasValidVatNumber;

  @BuiltValueField(wireName: 'tax_info')
  TaxDataEntity get taxData;

  String get classification;

  BuiltList<ClientContactEntity> get contacts;

  @override
  BuiltList<ActivityEntity> get activities;

  BuiltList<LedgerEntity> get ledger;

  @BuiltValueField(wireName: 'gateway_tokens')
  BuiltList<GatewayTokenEntity> get gatewayTokens;

  BuiltList<DocumentEntity> get documents;

  @BuiltValueField(wireName: 'system_logs')
  BuiltList<SystemLogEntity> get systemLogs;

  //String get last_login;
  //String get custom_messages;

  @override
  String get listDisplayName {
    return displayName;
  }

  bool? getManualPaymentEmail(
      {required CompanyEntity company, required GroupEntity? group}) {
    if (settings.clientManualPaymentNotification != null) {
      return settings.clientManualPaymentNotification;
    } else if (group?.settings.clientManualPaymentNotification != null) {
      return group!.settings.clientManualPaymentNotification;
    } else {
      return company.settings.clientManualPaymentNotification;
    }
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

  ClientContactEntity get primaryContact =>
      contacts.firstWhere((contact) => contact.isPrimary,
          orElse: () => ClientContactEntity());

  List<ClientContactEntity> get emailContacts {
    final list = contacts.where((contact) => contact.sendEmail).toList();
    return list.isEmpty ? [primaryContact] : list;
  }

  bool get hasGroup => groupId.isNotEmpty;

  bool get hasUser => assignedUserId != null && assignedUserId!.isNotEmpty;

  bool get hasLanguage =>
      settings.languageId != null && settings.languageId!.isNotEmpty;

  bool get hasEmailAddress =>
      contacts.where((contact) => contact.email.isNotEmpty).isNotEmpty;

  int compareTo(ClientEntity? client, String sortField, bool sortAscending,
      BuiltMap<String, UserEntity> userMap, StaticState staticState) {
    int response = 0;
    final ClientEntity? clientA = sortAscending ? this : client;
    final ClientEntity? clientB = sortAscending ? client : this;

    switch (sortField) {
      case ClientFields.name:
        response = removeDiacritics(clientA!.displayName)
            .toLowerCase()
            .compareTo(removeDiacritics(clientB!.displayName).toLowerCase());
        break;
      case ClientFields.contactName:
        response = removeDiacritics(clientA!.primaryContact.fullName)
            .toLowerCase()
            .compareTo(removeDiacritics(clientB!.primaryContact.fullName)
                .toLowerCase());
        break;
      case ClientFields.contactEmail:
        response = clientA!.primaryContact.email
            .toLowerCase()
            .compareTo(clientB!.primaryContact.email.toLowerCase());
        break;
      case ClientFields.balance:
        response = clientA!.balance.compareTo(clientB!.balance);
        break;
      case ClientFields.creditBalance:
        response = clientA!.creditBalance.compareTo(clientB!.creditBalance);
        break;
      case ClientFields.paymentBalance:
        response = clientA!.paymentBalance.compareTo(clientB!.paymentBalance);
        break;
      case ClientFields.paidToDate:
        response = clientA!.paidToDate.compareTo(clientB!.paidToDate);
        break;
      case ClientFields.updatedAt:
        response = clientA!.updatedAt.compareTo(clientB!.updatedAt);
        break;
      case ClientFields.idNumber:
        response = clientA!.idNumber.compareTo(clientB!.idNumber);
        break;
      case ClientFields.number:
        response = compareNatural(clientA!.number, clientB!.number);
        break;
      case ClientFields.website:
        response = clientA!.website
            .toLowerCase()
            .compareTo(clientB!.website.toLowerCase());
        break;
      case ClientFields.address1:
        response = clientA!.address1
            .toLowerCase()
            .compareTo(clientB!.address1.toLowerCase());
        break;
      case ClientFields.address2:
        response = clientA!.address2
            .toLowerCase()
            .compareTo(clientB!.address2.toLowerCase());
        break;
      case ClientFields.phone:
        response = clientA!.phone
            .toLowerCase()
            .compareTo(clientB!.phone.toLowerCase());
        break;
      case ClientFields.publicNotes:
        response = clientA!.publicNotes
            .toLowerCase()
            .compareTo(clientB!.publicNotes.toLowerCase());
        break;
      case ClientFields.privateNotes:
        response = clientA!.privateNotes
            .toLowerCase()
            .compareTo(clientB!.privateNotes.toLowerCase());
        break;
      case ClientFields.vatNumber:
        response = clientA!.vatNumber
            .toLowerCase()
            .compareTo(clientB!.vatNumber.toLowerCase());
        break;
      case ClientFields.assignedToId:
      case EntityFields.assignedTo:
        final userA = userMap[clientA!.assignedUserId] ?? UserEntity();
        final userB = userMap[clientB!.assignedUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case ClientFields.createdById:
      case EntityFields.createdBy:
        final userA = userMap[clientA!.createdUserId] ?? UserEntity();
        final userB = userMap[clientB!.createdUserId] ?? UserEntity();
        response = userA.listDisplayName
            .toLowerCase()
            .compareTo(userB.listDisplayName.toLowerCase());
        break;
      case ClientFields.country:
        final countryA =
            staticState.countryMap[clientA!.countryId] ?? CountryEntity();
        final countryB =
            staticState.countryMap[clientB!.countryId] ?? CountryEntity();
        response =
            countryA.name.toLowerCase().compareTo(countryB.name.toLowerCase());
        break;
      case ClientFields.currency:
        final currencyA =
            staticState.currencyMap[clientA!.currencyId] ?? CurrencyEntity();
        final currencyB =
            staticState.currencyMap[clientB!.currencyId] ?? CurrencyEntity();
        response = currencyA.name
            .toLowerCase()
            .compareTo(currencyB.name.toLowerCase());
        break;
      case EntityFields.state:
      case ClientFields.state:
        final stateA = EntityState.valueOf(clientA!.entityState);
        final stateB = EntityState.valueOf(clientB!.entityState);
        response =
            stateA.name.toLowerCase().compareTo(stateB.name.toLowerCase());
        break;
      case ClientFields.language:
        final languageA =
            staticState.languageMap[clientA!.languageId] ?? LanguageEntity();
        final languageB =
            staticState.languageMap[clientB!.languageId] ?? LanguageEntity();
        response = languageA.name
            .toLowerCase()
            .compareTo(languageB.name.toLowerCase());
        break;
      case ClientFields.createdAt:
        response = clientA!.createdAt.compareTo(clientB!.createdAt);
        break;
      case ClientFields.archivedAt:
        response = clientA!.archivedAt.compareTo(clientB!.archivedAt);
        break;
      case ClientFields.lastLoginAt:
        response = clientA!.lastLogin.compareTo(clientB!.lastLogin);
        break;
      case ClientFields.custom1:
        response = clientA!.customValue1
            .toLowerCase()
            .compareTo(clientB!.customValue1.toLowerCase());
        break;
      case ClientFields.custom2:
        response = clientA!.customValue2
            .toLowerCase()
            .compareTo(clientB!.customValue2.toLowerCase());
        break;
      case ClientFields.custom3:
        response = clientA!.customValue3
            .toLowerCase()
            .compareTo(clientB!.customValue3.toLowerCase());
        break;
      case ClientFields.custom4:
        response = clientA!.customValue4
            .toLowerCase()
            .compareTo(clientB!.customValue4.toLowerCase());
        break;
      case ClientFields.documents:
        response =
            clientA!.documents.length.compareTo(clientA.documents.length);
        break;
      case ClientFields.group:
        response = clientA!.groupId.compareTo(clientB!.groupId);
        break;
      case ClientFields.classification:
        response = clientA!.classification.compareTo(clientB!.classification);
        break;
      default:
        print('## ERROR: sort by client.$sortField not implemented');
        break;
    }

    if (response == 0) {
      response = client!.number.toLowerCase().compareTo(number.toLowerCase());
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
    for (var i = 0; i < contacts.length; i++) {
      if (contacts[i].matchesFilter(filter)) {
        return true;
      }
    }

    return matchesStrings(
      haystacks: [
        displayName,
        vatNumber,
        idNumber,
        number,
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
  String? matchesFilterValue(String? filter) {
    for (var i = 0; i < contacts.length; i++) {
      final value = contacts[i].matchesFilterValue(filter);
      if (value != null) {
        return value;
      }
    }

    return matchesStringsValue(
      haystacks: [
        vatNumber,
        idNumber,
        number,
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
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted! && !multiselect) {
      if (includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      actions.add(EntityAction.viewStatement);

      actions.add(EntityAction.clientPortal);

      if (userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.settings);
      }
    }

    if (!isDeleted! && multiselect) {
      actions.add(EntityAction.documents);
    }

    if (!isDeleted!) {
      final store = StoreProvider.of<AppState>(navigatorKey.currentContext!);
      if (hasDesignTemplatesForEntityType(
          store.state.designState.map, entityType)) {
        actions.add(EntityAction.runTemplate);
      }
    }

    if (!isDeleted! && !multiselect) {
      if (actions.isNotEmpty && actions.last != null) {
        actions.add(null);
      }

      if (userCompany!.canCreate(EntityType.invoice)) {
        actions.add(EntityAction.newInvoice);
      }

      if (userCompany.canCreate(EntityType.quote)) {
        actions.add(EntityAction.newQuote);
      }

      if (userCompany.canCreate(EntityType.payment)) {
        actions.add(EntityAction.newPayment);
      }

      if (userCompany.canCreate(EntityType.task)) {
        actions.add(EntityAction.newTask);
      }

      if (userCompany.canCreate(EntityType.expense)) {
        actions.add(EntityAction.newExpense);
      }
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    if (userCompany!.isAdmin && !multiselect) {
      actions.add(EntityAction.merge);
    }

    actions..addAll(super.getActions(userCompany: userCompany));

    if (userCompany.isAdmin && !multiselect) {
      actions.add(EntityAction.purge);
    }

    return actions;
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
      shippingCountryId.isNotEmpty;

  bool get hasBillingAddress =>
      address1.isNotEmpty ||
      address2.isNotEmpty ||
      city.isNotEmpty ||
      state.isNotEmpty ||
      postalCode.isNotEmpty ||
      countryId.isNotEmpty;

  bool get hasCountry => countryId.isNotEmpty;

  String? get currencyId => settings.currencyId;

  bool get hasCurrency =>
      settings.currencyId != null && settings.currencyId!.isNotEmpty;

  String get languageId => settings.languageId ?? kLanguageEnglish;

  ClientContactEntity getContact(String? contactId) =>
      contacts.firstWhere((contact) => contact.id == contactId,
          orElse: () => ClientContactEntity());

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

  // ignore: unused_element
  static void _initializeBuilder(ClientEntityBuilder builder) => builder
    ..number = ''
    ..routingId = ''
    ..isTaxExempt = false
    ..hasValidVatNumber = false
    ..taxData.replace(TaxDataEntity())
    ..paymentBalance = 0
    ..classification = '';

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

abstract class ClientContactEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<ClientContactEntity, ClientContactEntityBuilder> {
  factory ClientContactEntity() {
    return _$ClientContactEntity._(
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
      link: '',
    );
  }

  ClientContactEntity._();

  @override
  @memoized
  int get hashCode;

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

  @BuiltValueField(wireName: 'last_login')
  int get lastLogin;

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
  EntityType get entityType {
    return EntityType.contact;
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
    return fullNameOrEmail;
  }

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  static Serializer<ClientContactEntity> get serializer =>
      _$clientContactEntitySerializer;
}
