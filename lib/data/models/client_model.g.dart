// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ClientListResponse> _$clientListResponseSerializer =
    new _$ClientListResponseSerializer();
Serializer<ClientItemResponse> _$clientItemResponseSerializer =
    new _$ClientItemResponseSerializer();
Serializer<ClientEntity> _$clientEntitySerializer =
    new _$ClientEntitySerializer();
Serializer<ClientContactEntity> _$clientContactEntitySerializer =
    new _$ClientContactEntitySerializer();

class _$ClientListResponseSerializer
    implements StructuredSerializer<ClientListResponse> {
  @override
  final Iterable<Type> types = const [ClientListResponse, _$ClientListResponse];
  @override
  final String wireName = 'ClientListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ClientListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ClientEntity)])),
    ];

    return result;
  }

  @override
  ClientListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ClientEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ClientItemResponseSerializer
    implements StructuredSerializer<ClientItemResponse> {
  @override
  final Iterable<Type> types = const [ClientItemResponse, _$ClientItemResponse];
  @override
  final String wireName = 'ClientItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ClientItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ClientEntity)),
    ];

    return result;
  }

  @override
  ClientItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientEntity))! as ClientEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$ClientEntitySerializer implements StructuredSerializer<ClientEntity> {
  @override
  final Iterable<Type> types = const [ClientEntity, _$ClientEntity];
  @override
  final String wireName = 'ClientEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, ClientEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'group_settings_id',
      serializers.serialize(object.groupId,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'display_name',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'balance',
      serializers.serialize(object.balance,
          specifiedType: const FullType(double)),
      'credit_balance',
      serializers.serialize(object.creditBalance,
          specifiedType: const FullType(double)),
      'payment_balance',
      serializers.serialize(object.paymentBalance,
          specifiedType: const FullType(double)),
      'paid_to_date',
      serializers.serialize(object.paidToDate,
          specifiedType: const FullType(double)),
      'client_hash',
      serializers.serialize(object.clientHash,
          specifiedType: const FullType(String)),
      'address1',
      serializers.serialize(object.address1,
          specifiedType: const FullType(String)),
      'address2',
      serializers.serialize(object.address2,
          specifiedType: const FullType(String)),
      'city',
      serializers.serialize(object.city, specifiedType: const FullType(String)),
      'state',
      serializers.serialize(object.state,
          specifiedType: const FullType(String)),
      'postal_code',
      serializers.serialize(object.postalCode,
          specifiedType: const FullType(String)),
      'country_id',
      serializers.serialize(object.countryId,
          specifiedType: const FullType(String)),
      'phone',
      serializers.serialize(object.phone,
          specifiedType: const FullType(String)),
      'private_notes',
      serializers.serialize(object.privateNotes,
          specifiedType: const FullType(String)),
      'public_notes',
      serializers.serialize(object.publicNotes,
          specifiedType: const FullType(String)),
      'website',
      serializers.serialize(object.website,
          specifiedType: const FullType(String)),
      'industry_id',
      serializers.serialize(object.industryId,
          specifiedType: const FullType(String)),
      'size_id',
      serializers.serialize(object.sizeId,
          specifiedType: const FullType(String)),
      'vat_number',
      serializers.serialize(object.vatNumber,
          specifiedType: const FullType(String)),
      'id_number',
      serializers.serialize(object.idNumber,
          specifiedType: const FullType(String)),
      'number',
      serializers.serialize(object.number,
          specifiedType: const FullType(String)),
      'shipping_address1',
      serializers.serialize(object.shippingAddress1,
          specifiedType: const FullType(String)),
      'shipping_address2',
      serializers.serialize(object.shippingAddress2,
          specifiedType: const FullType(String)),
      'shipping_city',
      serializers.serialize(object.shippingCity,
          specifiedType: const FullType(String)),
      'shipping_state',
      serializers.serialize(object.shippingState,
          specifiedType: const FullType(String)),
      'shipping_postal_code',
      serializers.serialize(object.shippingPostalCode,
          specifiedType: const FullType(String)),
      'shipping_country_id',
      serializers.serialize(object.shippingCountryId,
          specifiedType: const FullType(String)),
      'settings',
      serializers.serialize(object.settings,
          specifiedType: const FullType(SettingsEntity)),
      'last_login',
      serializers.serialize(object.lastLogin,
          specifiedType: const FullType(int)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'custom_value3',
      serializers.serialize(object.customValue3,
          specifiedType: const FullType(String)),
      'custom_value4',
      serializers.serialize(object.customValue4,
          specifiedType: const FullType(String)),
      'routing_id',
      serializers.serialize(object.routingId,
          specifiedType: const FullType(String)),
      'is_tax_exempt',
      serializers.serialize(object.isTaxExempt,
          specifiedType: const FullType(bool)),
      'has_valid_vat_number',
      serializers.serialize(object.hasValidVatNumber,
          specifiedType: const FullType(bool)),
      'tax_info',
      serializers.serialize(object.taxData,
          specifiedType: const FullType(TaxDataEntity)),
      'classification',
      serializers.serialize(object.classification,
          specifiedType: const FullType(String)),
      'contacts',
      serializers.serialize(object.contacts,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ClientContactEntity)])),
      'activities',
      serializers.serialize(object.activities,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ActivityEntity)])),
      'ledger',
      serializers.serialize(object.ledger,
          specifiedType:
              const FullType(BuiltList, const [const FullType(LedgerEntity)])),
      'gateway_tokens',
      serializers.serialize(object.gatewayTokens,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GatewayTokenEntity)])),
      'documents',
      serializers.serialize(object.documents,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
      'system_logs',
      serializers.serialize(object.systemLogs,
          specifiedType: const FullType(
              BuiltList, const [const FullType(SystemLogEntity)])),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'archived_at',
      serializers.serialize(object.archivedAt,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.loadedAt;
    if (value != null) {
      result
        ..add('loadedAt')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isChanged;
    if (value != null) {
      result
        ..add('isChanged')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isDeleted;
    if (value != null) {
      result
        ..add('is_deleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdUserId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assignedUserId;
    if (value != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ClientEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'group_settings_id':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'loadedAt':
          result.loadedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'credit_balance':
          result.creditBalance = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'payment_balance':
          result.paymentBalance = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'paid_to_date':
          result.paidToDate = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'client_hash':
          result.clientHash = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'address1':
          result.address1 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'address2':
          result.address2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'postal_code':
          result.postalCode = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'country_id':
          result.countryId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'private_notes':
          result.privateNotes = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'public_notes':
          result.publicNotes = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'industry_id':
          result.industryId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'size_id':
          result.sizeId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'vat_number':
          result.vatNumber = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id_number':
          result.idNumber = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'shipping_address1':
          result.shippingAddress1 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'shipping_address2':
          result.shippingAddress2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'shipping_city':
          result.shippingCity = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'shipping_state':
          result.shippingState = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'shipping_postal_code':
          result.shippingPostalCode = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'shipping_country_id':
          result.shippingCountryId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'settings':
          result.settings.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SettingsEntity))!
              as SettingsEntity);
          break;
        case 'last_login':
          result.lastLogin = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'routing_id':
          result.routingId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'is_tax_exempt':
          result.isTaxExempt = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'has_valid_vat_number':
          result.hasValidVatNumber = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'tax_info':
          result.taxData.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaxDataEntity))! as TaxDataEntity);
          break;
        case 'classification':
          result.classification = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'contacts':
          result.contacts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ClientContactEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'activities':
          result.activities.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ActivityEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'ledger':
          result.ledger.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(LedgerEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'gateway_tokens':
          result.gatewayTokens.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GatewayTokenEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'system_logs':
          result.systemLogs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SystemLogEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ClientContactEntitySerializer
    implements StructuredSerializer<ClientContactEntity> {
  @override
  final Iterable<Type> types = const [
    ClientContactEntity,
    _$ClientContactEntity
  ];
  @override
  final String wireName = 'ClientContactEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ClientContactEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'first_name',
      serializers.serialize(object.firstName,
          specifiedType: const FullType(String)),
      'last_name',
      serializers.serialize(object.lastName,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'phone',
      serializers.serialize(object.phone,
          specifiedType: const FullType(String)),
      'contact_key',
      serializers.serialize(object.contactKey,
          specifiedType: const FullType(String)),
      'is_primary',
      serializers.serialize(object.isPrimary,
          specifiedType: const FullType(bool)),
      'send_email',
      serializers.serialize(object.sendEmail,
          specifiedType: const FullType(bool)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'custom_value3',
      serializers.serialize(object.customValue3,
          specifiedType: const FullType(String)),
      'custom_value4',
      serializers.serialize(object.customValue4,
          specifiedType: const FullType(String)),
      'last_login',
      serializers.serialize(object.lastLogin,
          specifiedType: const FullType(int)),
      'link',
      serializers.serialize(object.link, specifiedType: const FullType(String)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'archived_at',
      serializers.serialize(object.archivedAt,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.isChanged;
    if (value != null) {
      result
        ..add('isChanged')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isDeleted;
    if (value != null) {
      result
        ..add('is_deleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdUserId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assignedUserId;
    if (value != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ClientContactEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientContactEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'contact_key':
          result.contactKey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'is_primary':
          result.isPrimary = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'send_email':
          result.sendEmail = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'last_login':
          result.lastLogin = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'link':
          result.link = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ClientListResponse extends ClientListResponse {
  @override
  final BuiltList<ClientEntity> data;

  factory _$ClientListResponse(
          [void Function(ClientListResponseBuilder)? updates]) =>
      (new ClientListResponseBuilder()..update(updates))._build();

  _$ClientListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'ClientListResponse', 'data');
  }

  @override
  ClientListResponse rebuild(
          void Function(ClientListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientListResponseBuilder toBuilder() =>
      new ClientListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClientListResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClientListResponse')
          ..add('data', data))
        .toString();
  }
}

class ClientListResponseBuilder
    implements Builder<ClientListResponse, ClientListResponseBuilder> {
  _$ClientListResponse? _$v;

  ListBuilder<ClientEntity>? _data;
  ListBuilder<ClientEntity> get data =>
      _$this._data ??= new ListBuilder<ClientEntity>();
  set data(ListBuilder<ClientEntity>? data) => _$this._data = data;

  ClientListResponseBuilder();

  ClientListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ClientListResponse;
  }

  @override
  void update(void Function(ClientListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClientListResponse build() => _build();

  _$ClientListResponse _build() {
    _$ClientListResponse _$result;
    try {
      _$result = _$v ?? new _$ClientListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ClientListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ClientItemResponse extends ClientItemResponse {
  @override
  final ClientEntity data;

  factory _$ClientItemResponse(
          [void Function(ClientItemResponseBuilder)? updates]) =>
      (new ClientItemResponseBuilder()..update(updates))._build();

  _$ClientItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'ClientItemResponse', 'data');
  }

  @override
  ClientItemResponse rebuild(
          void Function(ClientItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientItemResponseBuilder toBuilder() =>
      new ClientItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClientItemResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClientItemResponse')
          ..add('data', data))
        .toString();
  }
}

class ClientItemResponseBuilder
    implements Builder<ClientItemResponse, ClientItemResponseBuilder> {
  _$ClientItemResponse? _$v;

  ClientEntityBuilder? _data;
  ClientEntityBuilder get data => _$this._data ??= new ClientEntityBuilder();
  set data(ClientEntityBuilder? data) => _$this._data = data;

  ClientItemResponseBuilder();

  ClientItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ClientItemResponse;
  }

  @override
  void update(void Function(ClientItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClientItemResponse build() => _build();

  _$ClientItemResponse _build() {
    _$ClientItemResponse _$result;
    try {
      _$result = _$v ?? new _$ClientItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ClientItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ClientEntity extends ClientEntity {
  @override
  final String groupId;
  @override
  final int? loadedAt;
  @override
  final String name;
  @override
  final String displayName;
  @override
  final double balance;
  @override
  final double creditBalance;
  @override
  final double paymentBalance;
  @override
  final double paidToDate;
  @override
  final String clientHash;
  @override
  final String address1;
  @override
  final String address2;
  @override
  final String city;
  @override
  final String state;
  @override
  final String postalCode;
  @override
  final String countryId;
  @override
  final String phone;
  @override
  final String privateNotes;
  @override
  final String publicNotes;
  @override
  final String website;
  @override
  final String industryId;
  @override
  final String sizeId;
  @override
  final String vatNumber;
  @override
  final String idNumber;
  @override
  final String number;
  @override
  final String shippingAddress1;
  @override
  final String shippingAddress2;
  @override
  final String shippingCity;
  @override
  final String shippingState;
  @override
  final String shippingPostalCode;
  @override
  final String shippingCountryId;
  @override
  final SettingsEntity settings;
  @override
  final int lastLogin;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final String routingId;
  @override
  final bool isTaxExempt;
  @override
  final bool hasValidVatNumber;
  @override
  final TaxDataEntity taxData;
  @override
  final String classification;
  @override
  final BuiltList<ClientContactEntity> contacts;
  @override
  final BuiltList<ActivityEntity> activities;
  @override
  final BuiltList<LedgerEntity> ledger;
  @override
  final BuiltList<GatewayTokenEntity> gatewayTokens;
  @override
  final BuiltList<DocumentEntity> documents;
  @override
  final BuiltList<SystemLogEntity> systemLogs;
  @override
  final bool? isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool? isDeleted;
  @override
  final String? createdUserId;
  @override
  final String? assignedUserId;
  @override
  final String id;

  factory _$ClientEntity([void Function(ClientEntityBuilder)? updates]) =>
      (new ClientEntityBuilder()..update(updates))._build();

  _$ClientEntity._(
      {required this.groupId,
      this.loadedAt,
      required this.name,
      required this.displayName,
      required this.balance,
      required this.creditBalance,
      required this.paymentBalance,
      required this.paidToDate,
      required this.clientHash,
      required this.address1,
      required this.address2,
      required this.city,
      required this.state,
      required this.postalCode,
      required this.countryId,
      required this.phone,
      required this.privateNotes,
      required this.publicNotes,
      required this.website,
      required this.industryId,
      required this.sizeId,
      required this.vatNumber,
      required this.idNumber,
      required this.number,
      required this.shippingAddress1,
      required this.shippingAddress2,
      required this.shippingCity,
      required this.shippingState,
      required this.shippingPostalCode,
      required this.shippingCountryId,
      required this.settings,
      required this.lastLogin,
      required this.customValue1,
      required this.customValue2,
      required this.customValue3,
      required this.customValue4,
      required this.routingId,
      required this.isTaxExempt,
      required this.hasValidVatNumber,
      required this.taxData,
      required this.classification,
      required this.contacts,
      required this.activities,
      required this.ledger,
      required this.gatewayTokens,
      required this.documents,
      required this.systemLogs,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(groupId, r'ClientEntity', 'groupId');
    BuiltValueNullFieldError.checkNotNull(name, r'ClientEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        displayName, r'ClientEntity', 'displayName');
    BuiltValueNullFieldError.checkNotNull(balance, r'ClientEntity', 'balance');
    BuiltValueNullFieldError.checkNotNull(
        creditBalance, r'ClientEntity', 'creditBalance');
    BuiltValueNullFieldError.checkNotNull(
        paymentBalance, r'ClientEntity', 'paymentBalance');
    BuiltValueNullFieldError.checkNotNull(
        paidToDate, r'ClientEntity', 'paidToDate');
    BuiltValueNullFieldError.checkNotNull(
        clientHash, r'ClientEntity', 'clientHash');
    BuiltValueNullFieldError.checkNotNull(
        address1, r'ClientEntity', 'address1');
    BuiltValueNullFieldError.checkNotNull(
        address2, r'ClientEntity', 'address2');
    BuiltValueNullFieldError.checkNotNull(city, r'ClientEntity', 'city');
    BuiltValueNullFieldError.checkNotNull(state, r'ClientEntity', 'state');
    BuiltValueNullFieldError.checkNotNull(
        postalCode, r'ClientEntity', 'postalCode');
    BuiltValueNullFieldError.checkNotNull(
        countryId, r'ClientEntity', 'countryId');
    BuiltValueNullFieldError.checkNotNull(phone, r'ClientEntity', 'phone');
    BuiltValueNullFieldError.checkNotNull(
        privateNotes, r'ClientEntity', 'privateNotes');
    BuiltValueNullFieldError.checkNotNull(
        publicNotes, r'ClientEntity', 'publicNotes');
    BuiltValueNullFieldError.checkNotNull(website, r'ClientEntity', 'website');
    BuiltValueNullFieldError.checkNotNull(
        industryId, r'ClientEntity', 'industryId');
    BuiltValueNullFieldError.checkNotNull(sizeId, r'ClientEntity', 'sizeId');
    BuiltValueNullFieldError.checkNotNull(
        vatNumber, r'ClientEntity', 'vatNumber');
    BuiltValueNullFieldError.checkNotNull(
        idNumber, r'ClientEntity', 'idNumber');
    BuiltValueNullFieldError.checkNotNull(number, r'ClientEntity', 'number');
    BuiltValueNullFieldError.checkNotNull(
        shippingAddress1, r'ClientEntity', 'shippingAddress1');
    BuiltValueNullFieldError.checkNotNull(
        shippingAddress2, r'ClientEntity', 'shippingAddress2');
    BuiltValueNullFieldError.checkNotNull(
        shippingCity, r'ClientEntity', 'shippingCity');
    BuiltValueNullFieldError.checkNotNull(
        shippingState, r'ClientEntity', 'shippingState');
    BuiltValueNullFieldError.checkNotNull(
        shippingPostalCode, r'ClientEntity', 'shippingPostalCode');
    BuiltValueNullFieldError.checkNotNull(
        shippingCountryId, r'ClientEntity', 'shippingCountryId');
    BuiltValueNullFieldError.checkNotNull(
        settings, r'ClientEntity', 'settings');
    BuiltValueNullFieldError.checkNotNull(
        lastLogin, r'ClientEntity', 'lastLogin');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, r'ClientEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, r'ClientEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, r'ClientEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, r'ClientEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        routingId, r'ClientEntity', 'routingId');
    BuiltValueNullFieldError.checkNotNull(
        isTaxExempt, r'ClientEntity', 'isTaxExempt');
    BuiltValueNullFieldError.checkNotNull(
        hasValidVatNumber, r'ClientEntity', 'hasValidVatNumber');
    BuiltValueNullFieldError.checkNotNull(taxData, r'ClientEntity', 'taxData');
    BuiltValueNullFieldError.checkNotNull(
        classification, r'ClientEntity', 'classification');
    BuiltValueNullFieldError.checkNotNull(
        contacts, r'ClientEntity', 'contacts');
    BuiltValueNullFieldError.checkNotNull(
        activities, r'ClientEntity', 'activities');
    BuiltValueNullFieldError.checkNotNull(ledger, r'ClientEntity', 'ledger');
    BuiltValueNullFieldError.checkNotNull(
        gatewayTokens, r'ClientEntity', 'gatewayTokens');
    BuiltValueNullFieldError.checkNotNull(
        documents, r'ClientEntity', 'documents');
    BuiltValueNullFieldError.checkNotNull(
        systemLogs, r'ClientEntity', 'systemLogs');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'ClientEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'ClientEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'ClientEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'ClientEntity', 'id');
  }

  @override
  ClientEntity rebuild(void Function(ClientEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientEntityBuilder toBuilder() => new ClientEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClientEntity &&
        groupId == other.groupId &&
        name == other.name &&
        displayName == other.displayName &&
        balance == other.balance &&
        creditBalance == other.creditBalance &&
        paymentBalance == other.paymentBalance &&
        paidToDate == other.paidToDate &&
        clientHash == other.clientHash &&
        address1 == other.address1 &&
        address2 == other.address2 &&
        city == other.city &&
        state == other.state &&
        postalCode == other.postalCode &&
        countryId == other.countryId &&
        phone == other.phone &&
        privateNotes == other.privateNotes &&
        publicNotes == other.publicNotes &&
        website == other.website &&
        industryId == other.industryId &&
        sizeId == other.sizeId &&
        vatNumber == other.vatNumber &&
        idNumber == other.idNumber &&
        number == other.number &&
        shippingAddress1 == other.shippingAddress1 &&
        shippingAddress2 == other.shippingAddress2 &&
        shippingCity == other.shippingCity &&
        shippingState == other.shippingState &&
        shippingPostalCode == other.shippingPostalCode &&
        shippingCountryId == other.shippingCountryId &&
        settings == other.settings &&
        lastLogin == other.lastLogin &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        routingId == other.routingId &&
        isTaxExempt == other.isTaxExempt &&
        hasValidVatNumber == other.hasValidVatNumber &&
        taxData == other.taxData &&
        classification == other.classification &&
        contacts == other.contacts &&
        activities == other.activities &&
        ledger == other.ledger &&
        gatewayTokens == other.gatewayTokens &&
        documents == other.documents &&
        systemLogs == other.systemLogs &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jc(_$hash, creditBalance.hashCode);
    _$hash = $jc(_$hash, paymentBalance.hashCode);
    _$hash = $jc(_$hash, paidToDate.hashCode);
    _$hash = $jc(_$hash, clientHash.hashCode);
    _$hash = $jc(_$hash, address1.hashCode);
    _$hash = $jc(_$hash, address2.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, postalCode.hashCode);
    _$hash = $jc(_$hash, countryId.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, privateNotes.hashCode);
    _$hash = $jc(_$hash, publicNotes.hashCode);
    _$hash = $jc(_$hash, website.hashCode);
    _$hash = $jc(_$hash, industryId.hashCode);
    _$hash = $jc(_$hash, sizeId.hashCode);
    _$hash = $jc(_$hash, vatNumber.hashCode);
    _$hash = $jc(_$hash, idNumber.hashCode);
    _$hash = $jc(_$hash, number.hashCode);
    _$hash = $jc(_$hash, shippingAddress1.hashCode);
    _$hash = $jc(_$hash, shippingAddress2.hashCode);
    _$hash = $jc(_$hash, shippingCity.hashCode);
    _$hash = $jc(_$hash, shippingState.hashCode);
    _$hash = $jc(_$hash, shippingPostalCode.hashCode);
    _$hash = $jc(_$hash, shippingCountryId.hashCode);
    _$hash = $jc(_$hash, settings.hashCode);
    _$hash = $jc(_$hash, lastLogin.hashCode);
    _$hash = $jc(_$hash, customValue1.hashCode);
    _$hash = $jc(_$hash, customValue2.hashCode);
    _$hash = $jc(_$hash, customValue3.hashCode);
    _$hash = $jc(_$hash, customValue4.hashCode);
    _$hash = $jc(_$hash, routingId.hashCode);
    _$hash = $jc(_$hash, isTaxExempt.hashCode);
    _$hash = $jc(_$hash, hasValidVatNumber.hashCode);
    _$hash = $jc(_$hash, taxData.hashCode);
    _$hash = $jc(_$hash, classification.hashCode);
    _$hash = $jc(_$hash, contacts.hashCode);
    _$hash = $jc(_$hash, activities.hashCode);
    _$hash = $jc(_$hash, ledger.hashCode);
    _$hash = $jc(_$hash, gatewayTokens.hashCode);
    _$hash = $jc(_$hash, documents.hashCode);
    _$hash = $jc(_$hash, systemLogs.hashCode);
    _$hash = $jc(_$hash, isChanged.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdUserId.hashCode);
    _$hash = $jc(_$hash, assignedUserId.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClientEntity')
          ..add('groupId', groupId)
          ..add('loadedAt', loadedAt)
          ..add('name', name)
          ..add('displayName', displayName)
          ..add('balance', balance)
          ..add('creditBalance', creditBalance)
          ..add('paymentBalance', paymentBalance)
          ..add('paidToDate', paidToDate)
          ..add('clientHash', clientHash)
          ..add('address1', address1)
          ..add('address2', address2)
          ..add('city', city)
          ..add('state', state)
          ..add('postalCode', postalCode)
          ..add('countryId', countryId)
          ..add('phone', phone)
          ..add('privateNotes', privateNotes)
          ..add('publicNotes', publicNotes)
          ..add('website', website)
          ..add('industryId', industryId)
          ..add('sizeId', sizeId)
          ..add('vatNumber', vatNumber)
          ..add('idNumber', idNumber)
          ..add('number', number)
          ..add('shippingAddress1', shippingAddress1)
          ..add('shippingAddress2', shippingAddress2)
          ..add('shippingCity', shippingCity)
          ..add('shippingState', shippingState)
          ..add('shippingPostalCode', shippingPostalCode)
          ..add('shippingCountryId', shippingCountryId)
          ..add('settings', settings)
          ..add('lastLogin', lastLogin)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('routingId', routingId)
          ..add('isTaxExempt', isTaxExempt)
          ..add('hasValidVatNumber', hasValidVatNumber)
          ..add('taxData', taxData)
          ..add('classification', classification)
          ..add('contacts', contacts)
          ..add('activities', activities)
          ..add('ledger', ledger)
          ..add('gatewayTokens', gatewayTokens)
          ..add('documents', documents)
          ..add('systemLogs', systemLogs)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('id', id))
        .toString();
  }
}

class ClientEntityBuilder
    implements Builder<ClientEntity, ClientEntityBuilder> {
  _$ClientEntity? _$v;

  String? _groupId;
  String? get groupId => _$this._groupId;
  set groupId(String? groupId) => _$this._groupId = groupId;

  int? _loadedAt;
  int? get loadedAt => _$this._loadedAt;
  set loadedAt(int? loadedAt) => _$this._loadedAt = loadedAt;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  double? _balance;
  double? get balance => _$this._balance;
  set balance(double? balance) => _$this._balance = balance;

  double? _creditBalance;
  double? get creditBalance => _$this._creditBalance;
  set creditBalance(double? creditBalance) =>
      _$this._creditBalance = creditBalance;

  double? _paymentBalance;
  double? get paymentBalance => _$this._paymentBalance;
  set paymentBalance(double? paymentBalance) =>
      _$this._paymentBalance = paymentBalance;

  double? _paidToDate;
  double? get paidToDate => _$this._paidToDate;
  set paidToDate(double? paidToDate) => _$this._paidToDate = paidToDate;

  String? _clientHash;
  String? get clientHash => _$this._clientHash;
  set clientHash(String? clientHash) => _$this._clientHash = clientHash;

  String? _address1;
  String? get address1 => _$this._address1;
  set address1(String? address1) => _$this._address1 = address1;

  String? _address2;
  String? get address2 => _$this._address2;
  set address2(String? address2) => _$this._address2 = address2;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _postalCode;
  String? get postalCode => _$this._postalCode;
  set postalCode(String? postalCode) => _$this._postalCode = postalCode;

  String? _countryId;
  String? get countryId => _$this._countryId;
  set countryId(String? countryId) => _$this._countryId = countryId;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _privateNotes;
  String? get privateNotes => _$this._privateNotes;
  set privateNotes(String? privateNotes) => _$this._privateNotes = privateNotes;

  String? _publicNotes;
  String? get publicNotes => _$this._publicNotes;
  set publicNotes(String? publicNotes) => _$this._publicNotes = publicNotes;

  String? _website;
  String? get website => _$this._website;
  set website(String? website) => _$this._website = website;

  String? _industryId;
  String? get industryId => _$this._industryId;
  set industryId(String? industryId) => _$this._industryId = industryId;

  String? _sizeId;
  String? get sizeId => _$this._sizeId;
  set sizeId(String? sizeId) => _$this._sizeId = sizeId;

  String? _vatNumber;
  String? get vatNumber => _$this._vatNumber;
  set vatNumber(String? vatNumber) => _$this._vatNumber = vatNumber;

  String? _idNumber;
  String? get idNumber => _$this._idNumber;
  set idNumber(String? idNumber) => _$this._idNumber = idNumber;

  String? _number;
  String? get number => _$this._number;
  set number(String? number) => _$this._number = number;

  String? _shippingAddress1;
  String? get shippingAddress1 => _$this._shippingAddress1;
  set shippingAddress1(String? shippingAddress1) =>
      _$this._shippingAddress1 = shippingAddress1;

  String? _shippingAddress2;
  String? get shippingAddress2 => _$this._shippingAddress2;
  set shippingAddress2(String? shippingAddress2) =>
      _$this._shippingAddress2 = shippingAddress2;

  String? _shippingCity;
  String? get shippingCity => _$this._shippingCity;
  set shippingCity(String? shippingCity) => _$this._shippingCity = shippingCity;

  String? _shippingState;
  String? get shippingState => _$this._shippingState;
  set shippingState(String? shippingState) =>
      _$this._shippingState = shippingState;

  String? _shippingPostalCode;
  String? get shippingPostalCode => _$this._shippingPostalCode;
  set shippingPostalCode(String? shippingPostalCode) =>
      _$this._shippingPostalCode = shippingPostalCode;

  String? _shippingCountryId;
  String? get shippingCountryId => _$this._shippingCountryId;
  set shippingCountryId(String? shippingCountryId) =>
      _$this._shippingCountryId = shippingCountryId;

  SettingsEntityBuilder? _settings;
  SettingsEntityBuilder get settings =>
      _$this._settings ??= new SettingsEntityBuilder();
  set settings(SettingsEntityBuilder? settings) => _$this._settings = settings;

  int? _lastLogin;
  int? get lastLogin => _$this._lastLogin;
  set lastLogin(int? lastLogin) => _$this._lastLogin = lastLogin;

  String? _customValue1;
  String? get customValue1 => _$this._customValue1;
  set customValue1(String? customValue1) => _$this._customValue1 = customValue1;

  String? _customValue2;
  String? get customValue2 => _$this._customValue2;
  set customValue2(String? customValue2) => _$this._customValue2 = customValue2;

  String? _customValue3;
  String? get customValue3 => _$this._customValue3;
  set customValue3(String? customValue3) => _$this._customValue3 = customValue3;

  String? _customValue4;
  String? get customValue4 => _$this._customValue4;
  set customValue4(String? customValue4) => _$this._customValue4 = customValue4;

  String? _routingId;
  String? get routingId => _$this._routingId;
  set routingId(String? routingId) => _$this._routingId = routingId;

  bool? _isTaxExempt;
  bool? get isTaxExempt => _$this._isTaxExempt;
  set isTaxExempt(bool? isTaxExempt) => _$this._isTaxExempt = isTaxExempt;

  bool? _hasValidVatNumber;
  bool? get hasValidVatNumber => _$this._hasValidVatNumber;
  set hasValidVatNumber(bool? hasValidVatNumber) =>
      _$this._hasValidVatNumber = hasValidVatNumber;

  TaxDataEntityBuilder? _taxData;
  TaxDataEntityBuilder get taxData =>
      _$this._taxData ??= new TaxDataEntityBuilder();
  set taxData(TaxDataEntityBuilder? taxData) => _$this._taxData = taxData;

  String? _classification;
  String? get classification => _$this._classification;
  set classification(String? classification) =>
      _$this._classification = classification;

  ListBuilder<ClientContactEntity>? _contacts;
  ListBuilder<ClientContactEntity> get contacts =>
      _$this._contacts ??= new ListBuilder<ClientContactEntity>();
  set contacts(ListBuilder<ClientContactEntity>? contacts) =>
      _$this._contacts = contacts;

  ListBuilder<ActivityEntity>? _activities;
  ListBuilder<ActivityEntity> get activities =>
      _$this._activities ??= new ListBuilder<ActivityEntity>();
  set activities(ListBuilder<ActivityEntity>? activities) =>
      _$this._activities = activities;

  ListBuilder<LedgerEntity>? _ledger;
  ListBuilder<LedgerEntity> get ledger =>
      _$this._ledger ??= new ListBuilder<LedgerEntity>();
  set ledger(ListBuilder<LedgerEntity>? ledger) => _$this._ledger = ledger;

  ListBuilder<GatewayTokenEntity>? _gatewayTokens;
  ListBuilder<GatewayTokenEntity> get gatewayTokens =>
      _$this._gatewayTokens ??= new ListBuilder<GatewayTokenEntity>();
  set gatewayTokens(ListBuilder<GatewayTokenEntity>? gatewayTokens) =>
      _$this._gatewayTokens = gatewayTokens;

  ListBuilder<DocumentEntity>? _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity>? documents) =>
      _$this._documents = documents;

  ListBuilder<SystemLogEntity>? _systemLogs;
  ListBuilder<SystemLogEntity> get systemLogs =>
      _$this._systemLogs ??= new ListBuilder<SystemLogEntity>();
  set systemLogs(ListBuilder<SystemLogEntity>? systemLogs) =>
      _$this._systemLogs = systemLogs;

  bool? _isChanged;
  bool? get isChanged => _$this._isChanged;
  set isChanged(bool? isChanged) => _$this._isChanged = isChanged;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  int? _updatedAt;
  int? get updatedAt => _$this._updatedAt;
  set updatedAt(int? updatedAt) => _$this._updatedAt = updatedAt;

  int? _archivedAt;
  int? get archivedAt => _$this._archivedAt;
  set archivedAt(int? archivedAt) => _$this._archivedAt = archivedAt;

  bool? _isDeleted;
  bool? get isDeleted => _$this._isDeleted;
  set isDeleted(bool? isDeleted) => _$this._isDeleted = isDeleted;

  String? _createdUserId;
  String? get createdUserId => _$this._createdUserId;
  set createdUserId(String? createdUserId) =>
      _$this._createdUserId = createdUserId;

  String? _assignedUserId;
  String? get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String? assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ClientEntityBuilder() {
    ClientEntity._initializeBuilder(this);
  }

  ClientEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _groupId = $v.groupId;
      _loadedAt = $v.loadedAt;
      _name = $v.name;
      _displayName = $v.displayName;
      _balance = $v.balance;
      _creditBalance = $v.creditBalance;
      _paymentBalance = $v.paymentBalance;
      _paidToDate = $v.paidToDate;
      _clientHash = $v.clientHash;
      _address1 = $v.address1;
      _address2 = $v.address2;
      _city = $v.city;
      _state = $v.state;
      _postalCode = $v.postalCode;
      _countryId = $v.countryId;
      _phone = $v.phone;
      _privateNotes = $v.privateNotes;
      _publicNotes = $v.publicNotes;
      _website = $v.website;
      _industryId = $v.industryId;
      _sizeId = $v.sizeId;
      _vatNumber = $v.vatNumber;
      _idNumber = $v.idNumber;
      _number = $v.number;
      _shippingAddress1 = $v.shippingAddress1;
      _shippingAddress2 = $v.shippingAddress2;
      _shippingCity = $v.shippingCity;
      _shippingState = $v.shippingState;
      _shippingPostalCode = $v.shippingPostalCode;
      _shippingCountryId = $v.shippingCountryId;
      _settings = $v.settings.toBuilder();
      _lastLogin = $v.lastLogin;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _routingId = $v.routingId;
      _isTaxExempt = $v.isTaxExempt;
      _hasValidVatNumber = $v.hasValidVatNumber;
      _taxData = $v.taxData.toBuilder();
      _classification = $v.classification;
      _contacts = $v.contacts.toBuilder();
      _activities = $v.activities.toBuilder();
      _ledger = $v.ledger.toBuilder();
      _gatewayTokens = $v.gatewayTokens.toBuilder();
      _documents = $v.documents.toBuilder();
      _systemLogs = $v.systemLogs.toBuilder();
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ClientEntity;
  }

  @override
  void update(void Function(ClientEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClientEntity build() => _build();

  _$ClientEntity _build() {
    _$ClientEntity _$result;
    try {
      _$result = _$v ??
          new _$ClientEntity._(
              groupId: BuiltValueNullFieldError.checkNotNull(
                  groupId, r'ClientEntity', 'groupId'),
              loadedAt: loadedAt,
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'ClientEntity', 'name'),
              displayName: BuiltValueNullFieldError.checkNotNull(
                  displayName, r'ClientEntity', 'displayName'),
              balance: BuiltValueNullFieldError.checkNotNull(
                  balance, r'ClientEntity', 'balance'),
              creditBalance: BuiltValueNullFieldError.checkNotNull(
                  creditBalance, r'ClientEntity', 'creditBalance'),
              paymentBalance: BuiltValueNullFieldError.checkNotNull(
                  paymentBalance, r'ClientEntity', 'paymentBalance'),
              paidToDate: BuiltValueNullFieldError.checkNotNull(
                  paidToDate, r'ClientEntity', 'paidToDate'),
              clientHash: BuiltValueNullFieldError.checkNotNull(
                  clientHash, r'ClientEntity', 'clientHash'),
              address1: BuiltValueNullFieldError.checkNotNull(address1, r'ClientEntity', 'address1'),
              address2: BuiltValueNullFieldError.checkNotNull(address2, r'ClientEntity', 'address2'),
              city: BuiltValueNullFieldError.checkNotNull(city, r'ClientEntity', 'city'),
              state: BuiltValueNullFieldError.checkNotNull(state, r'ClientEntity', 'state'),
              postalCode: BuiltValueNullFieldError.checkNotNull(postalCode, r'ClientEntity', 'postalCode'),
              countryId: BuiltValueNullFieldError.checkNotNull(countryId, r'ClientEntity', 'countryId'),
              phone: BuiltValueNullFieldError.checkNotNull(phone, r'ClientEntity', 'phone'),
              privateNotes: BuiltValueNullFieldError.checkNotNull(privateNotes, r'ClientEntity', 'privateNotes'),
              publicNotes: BuiltValueNullFieldError.checkNotNull(publicNotes, r'ClientEntity', 'publicNotes'),
              website: BuiltValueNullFieldError.checkNotNull(website, r'ClientEntity', 'website'),
              industryId: BuiltValueNullFieldError.checkNotNull(industryId, r'ClientEntity', 'industryId'),
              sizeId: BuiltValueNullFieldError.checkNotNull(sizeId, r'ClientEntity', 'sizeId'),
              vatNumber: BuiltValueNullFieldError.checkNotNull(vatNumber, r'ClientEntity', 'vatNumber'),
              idNumber: BuiltValueNullFieldError.checkNotNull(idNumber, r'ClientEntity', 'idNumber'),
              number: BuiltValueNullFieldError.checkNotNull(number, r'ClientEntity', 'number'),
              shippingAddress1: BuiltValueNullFieldError.checkNotNull(shippingAddress1, r'ClientEntity', 'shippingAddress1'),
              shippingAddress2: BuiltValueNullFieldError.checkNotNull(shippingAddress2, r'ClientEntity', 'shippingAddress2'),
              shippingCity: BuiltValueNullFieldError.checkNotNull(shippingCity, r'ClientEntity', 'shippingCity'),
              shippingState: BuiltValueNullFieldError.checkNotNull(shippingState, r'ClientEntity', 'shippingState'),
              shippingPostalCode: BuiltValueNullFieldError.checkNotNull(shippingPostalCode, r'ClientEntity', 'shippingPostalCode'),
              shippingCountryId: BuiltValueNullFieldError.checkNotNull(shippingCountryId, r'ClientEntity', 'shippingCountryId'),
              settings: settings.build(),
              lastLogin: BuiltValueNullFieldError.checkNotNull(lastLogin, r'ClientEntity', 'lastLogin'),
              customValue1: BuiltValueNullFieldError.checkNotNull(customValue1, r'ClientEntity', 'customValue1'),
              customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, r'ClientEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, r'ClientEntity', 'customValue3'),
              customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, r'ClientEntity', 'customValue4'),
              routingId: BuiltValueNullFieldError.checkNotNull(routingId, r'ClientEntity', 'routingId'),
              isTaxExempt: BuiltValueNullFieldError.checkNotNull(isTaxExempt, r'ClientEntity', 'isTaxExempt'),
              hasValidVatNumber: BuiltValueNullFieldError.checkNotNull(hasValidVatNumber, r'ClientEntity', 'hasValidVatNumber'),
              taxData: taxData.build(),
              classification: BuiltValueNullFieldError.checkNotNull(classification, r'ClientEntity', 'classification'),
              contacts: contacts.build(),
              activities: activities.build(),
              ledger: ledger.build(),
              gatewayTokens: gatewayTokens.build(),
              documents: documents.build(),
              systemLogs: systemLogs.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'ClientEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'ClientEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'ClientEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(id, r'ClientEntity', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'settings';
        settings.build();

        _$failedField = 'taxData';
        taxData.build();

        _$failedField = 'contacts';
        contacts.build();
        _$failedField = 'activities';
        activities.build();
        _$failedField = 'ledger';
        ledger.build();
        _$failedField = 'gatewayTokens';
        gatewayTokens.build();
        _$failedField = 'documents';
        documents.build();
        _$failedField = 'systemLogs';
        systemLogs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ClientEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ClientContactEntity extends ClientContactEntity {
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String password;
  @override
  final String phone;
  @override
  final String contactKey;
  @override
  final bool isPrimary;
  @override
  final bool sendEmail;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final int lastLogin;
  @override
  final String link;
  @override
  final bool? isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool? isDeleted;
  @override
  final String? createdUserId;
  @override
  final String? assignedUserId;
  @override
  final String id;

  factory _$ClientContactEntity(
          [void Function(ClientContactEntityBuilder)? updates]) =>
      (new ClientContactEntityBuilder()..update(updates))._build();

  _$ClientContactEntity._(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phone,
      required this.contactKey,
      required this.isPrimary,
      required this.sendEmail,
      required this.customValue1,
      required this.customValue2,
      required this.customValue3,
      required this.customValue4,
      required this.lastLogin,
      required this.link,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firstName, r'ClientContactEntity', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        lastName, r'ClientContactEntity', 'lastName');
    BuiltValueNullFieldError.checkNotNull(
        email, r'ClientContactEntity', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, r'ClientContactEntity', 'password');
    BuiltValueNullFieldError.checkNotNull(
        phone, r'ClientContactEntity', 'phone');
    BuiltValueNullFieldError.checkNotNull(
        contactKey, r'ClientContactEntity', 'contactKey');
    BuiltValueNullFieldError.checkNotNull(
        isPrimary, r'ClientContactEntity', 'isPrimary');
    BuiltValueNullFieldError.checkNotNull(
        sendEmail, r'ClientContactEntity', 'sendEmail');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, r'ClientContactEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, r'ClientContactEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, r'ClientContactEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, r'ClientContactEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        lastLogin, r'ClientContactEntity', 'lastLogin');
    BuiltValueNullFieldError.checkNotNull(link, r'ClientContactEntity', 'link');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'ClientContactEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'ClientContactEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'ClientContactEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'ClientContactEntity', 'id');
  }

  @override
  ClientContactEntity rebuild(
          void Function(ClientContactEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientContactEntityBuilder toBuilder() =>
      new ClientContactEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClientContactEntity &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        password == other.password &&
        phone == other.phone &&
        contactKey == other.contactKey &&
        isPrimary == other.isPrimary &&
        sendEmail == other.sendEmail &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        lastLogin == other.lastLogin &&
        link == other.link &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, contactKey.hashCode);
    _$hash = $jc(_$hash, isPrimary.hashCode);
    _$hash = $jc(_$hash, sendEmail.hashCode);
    _$hash = $jc(_$hash, customValue1.hashCode);
    _$hash = $jc(_$hash, customValue2.hashCode);
    _$hash = $jc(_$hash, customValue3.hashCode);
    _$hash = $jc(_$hash, customValue4.hashCode);
    _$hash = $jc(_$hash, lastLogin.hashCode);
    _$hash = $jc(_$hash, link.hashCode);
    _$hash = $jc(_$hash, isChanged.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdUserId.hashCode);
    _$hash = $jc(_$hash, assignedUserId.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClientContactEntity')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('password', password)
          ..add('phone', phone)
          ..add('contactKey', contactKey)
          ..add('isPrimary', isPrimary)
          ..add('sendEmail', sendEmail)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('lastLogin', lastLogin)
          ..add('link', link)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('id', id))
        .toString();
  }
}

class ClientContactEntityBuilder
    implements Builder<ClientContactEntity, ClientContactEntityBuilder> {
  _$ClientContactEntity? _$v;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _contactKey;
  String? get contactKey => _$this._contactKey;
  set contactKey(String? contactKey) => _$this._contactKey = contactKey;

  bool? _isPrimary;
  bool? get isPrimary => _$this._isPrimary;
  set isPrimary(bool? isPrimary) => _$this._isPrimary = isPrimary;

  bool? _sendEmail;
  bool? get sendEmail => _$this._sendEmail;
  set sendEmail(bool? sendEmail) => _$this._sendEmail = sendEmail;

  String? _customValue1;
  String? get customValue1 => _$this._customValue1;
  set customValue1(String? customValue1) => _$this._customValue1 = customValue1;

  String? _customValue2;
  String? get customValue2 => _$this._customValue2;
  set customValue2(String? customValue2) => _$this._customValue2 = customValue2;

  String? _customValue3;
  String? get customValue3 => _$this._customValue3;
  set customValue3(String? customValue3) => _$this._customValue3 = customValue3;

  String? _customValue4;
  String? get customValue4 => _$this._customValue4;
  set customValue4(String? customValue4) => _$this._customValue4 = customValue4;

  int? _lastLogin;
  int? get lastLogin => _$this._lastLogin;
  set lastLogin(int? lastLogin) => _$this._lastLogin = lastLogin;

  String? _link;
  String? get link => _$this._link;
  set link(String? link) => _$this._link = link;

  bool? _isChanged;
  bool? get isChanged => _$this._isChanged;
  set isChanged(bool? isChanged) => _$this._isChanged = isChanged;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  int? _updatedAt;
  int? get updatedAt => _$this._updatedAt;
  set updatedAt(int? updatedAt) => _$this._updatedAt = updatedAt;

  int? _archivedAt;
  int? get archivedAt => _$this._archivedAt;
  set archivedAt(int? archivedAt) => _$this._archivedAt = archivedAt;

  bool? _isDeleted;
  bool? get isDeleted => _$this._isDeleted;
  set isDeleted(bool? isDeleted) => _$this._isDeleted = isDeleted;

  String? _createdUserId;
  String? get createdUserId => _$this._createdUserId;
  set createdUserId(String? createdUserId) =>
      _$this._createdUserId = createdUserId;

  String? _assignedUserId;
  String? get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String? assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ClientContactEntityBuilder();

  ClientContactEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _password = $v.password;
      _phone = $v.phone;
      _contactKey = $v.contactKey;
      _isPrimary = $v.isPrimary;
      _sendEmail = $v.sendEmail;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _lastLogin = $v.lastLogin;
      _link = $v.link;
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientContactEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ClientContactEntity;
  }

  @override
  void update(void Function(ClientContactEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClientContactEntity build() => _build();

  _$ClientContactEntity _build() {
    final _$result = _$v ??
        new _$ClientContactEntity._(
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'ClientContactEntity', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'ClientContactEntity', 'lastName'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'ClientContactEntity', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'ClientContactEntity', 'password'),
            phone: BuiltValueNullFieldError.checkNotNull(
                phone, r'ClientContactEntity', 'phone'),
            contactKey: BuiltValueNullFieldError.checkNotNull(
                contactKey, r'ClientContactEntity', 'contactKey'),
            isPrimary: BuiltValueNullFieldError.checkNotNull(
                isPrimary, r'ClientContactEntity', 'isPrimary'),
            sendEmail: BuiltValueNullFieldError.checkNotNull(
                sendEmail, r'ClientContactEntity', 'sendEmail'),
            customValue1:
                BuiltValueNullFieldError.checkNotNull(customValue1, r'ClientContactEntity', 'customValue1'),
            customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, r'ClientContactEntity', 'customValue2'),
            customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, r'ClientContactEntity', 'customValue3'),
            customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, r'ClientContactEntity', 'customValue4'),
            lastLogin: BuiltValueNullFieldError.checkNotNull(lastLogin, r'ClientContactEntity', 'lastLogin'),
            link: BuiltValueNullFieldError.checkNotNull(link, r'ClientContactEntity', 'link'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'ClientContactEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'ClientContactEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'ClientContactEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(id, r'ClientContactEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
