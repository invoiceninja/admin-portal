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
Serializer<ContactEntity> _$contactEntitySerializer =
    new _$ContactEntitySerializer();

class _$ClientListResponseSerializer
    implements StructuredSerializer<ClientListResponse> {
  @override
  final Iterable<Type> types = const [ClientListResponse, _$ClientListResponse];
  @override
  final String wireName = 'ClientListResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, ClientListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ClientEntity)])),
    ];

    return result;
  }

  @override
  ClientListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ClientEntity)]))
              as BuiltList<Object>);
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
  Iterable<Object> serialize(Serializers serializers, ClientItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ClientEntity)),
    ];

    return result;
  }

  @override
  ClientItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientEntity)) as ClientEntity);
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
  Iterable<Object> serialize(Serializers serializers, ClientEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
      'contacts',
      serializers.serialize(object.contacts,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ContactEntity)])),
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
    if (object.loadedAt != null) {
      result
        ..add('loadedAt')
        ..add(serializers.serialize(object.loadedAt,
            specifiedType: const FullType(int)));
    }
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.createdUserId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.createdUserId,
            specifiedType: const FullType(String)));
    }
    if (object.assignedUserId != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(object.assignedUserId,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ClientEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'group_settings_id':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'loadedAt':
          result.loadedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'credit_balance':
          result.creditBalance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'paid_to_date':
          result.paidToDate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'client_hash':
          result.clientHash = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address1':
          result.address1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address2':
          result.address2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'postal_code':
          result.postalCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country_id':
          result.countryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'private_notes':
          result.privateNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'public_notes':
          result.publicNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'industry_id':
          result.industryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'size_id':
          result.sizeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vat_number':
          result.vatNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id_number':
          result.idNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shipping_address1':
          result.shippingAddress1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shipping_address2':
          result.shippingAddress2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shipping_city':
          result.shippingCity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shipping_state':
          result.shippingState = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shipping_postal_code':
          result.shippingPostalCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shipping_country_id':
          result.shippingCountryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'settings':
          result.settings.replace(serializers.deserialize(value,
              specifiedType: const FullType(SettingsEntity)) as SettingsEntity);
          break;
        case 'last_login':
          result.lastLogin = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contacts':
          result.contacts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ContactEntity)]))
              as BuiltList<Object>);
          break;
        case 'activities':
          result.activities.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ActivityEntity)]))
              as BuiltList<Object>);
          break;
        case 'ledger':
          result.ledger.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(LedgerEntity)]))
              as BuiltList<Object>);
          break;
        case 'gateway_tokens':
          result.gatewayTokens.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GatewayTokenEntity)]))
              as BuiltList<Object>);
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))
              as BuiltList<Object>);
          break;
        case 'system_logs':
          result.systemLogs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SystemLogEntity)]))
              as BuiltList<Object>);
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ContactEntitySerializer implements StructuredSerializer<ContactEntity> {
  @override
  final Iterable<Type> types = const [ContactEntity, _$ContactEntity];
  @override
  final String wireName = 'ContactEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, ContactEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.createdUserId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.createdUserId,
            specifiedType: const FullType(String)));
    }
    if (object.assignedUserId != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(object.assignedUserId,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ContactEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ContactEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contact_key':
          result.contactKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_primary':
          result.isPrimary = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'send_email':
          result.sendEmail = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_login':
          result.lastLogin = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'link':
          result.link = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
          [void Function(ClientListResponseBuilder) updates]) =>
      (new ClientListResponseBuilder()..update(updates)).build();

  _$ClientListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ClientListResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ClientListResponse')
          ..add('data', data))
        .toString();
  }
}

class ClientListResponseBuilder
    implements Builder<ClientListResponse, ClientListResponseBuilder> {
  _$ClientListResponse _$v;

  ListBuilder<ClientEntity> _data;
  ListBuilder<ClientEntity> get data =>
      _$this._data ??= new ListBuilder<ClientEntity>();
  set data(ListBuilder<ClientEntity> data) => _$this._data = data;

  ClientListResponseBuilder();

  ClientListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ClientListResponse;
  }

  @override
  void update(void Function(ClientListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ClientListResponse build() {
    _$ClientListResponse _$result;
    try {
      _$result = _$v ?? new _$ClientListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ClientListResponse', _$failedField, e.toString());
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
          [void Function(ClientItemResponseBuilder) updates]) =>
      (new ClientItemResponseBuilder()..update(updates)).build();

  _$ClientItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ClientItemResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ClientItemResponse')
          ..add('data', data))
        .toString();
  }
}

class ClientItemResponseBuilder
    implements Builder<ClientItemResponse, ClientItemResponseBuilder> {
  _$ClientItemResponse _$v;

  ClientEntityBuilder _data;
  ClientEntityBuilder get data => _$this._data ??= new ClientEntityBuilder();
  set data(ClientEntityBuilder data) => _$this._data = data;

  ClientItemResponseBuilder();

  ClientItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ClientItemResponse;
  }

  @override
  void update(void Function(ClientItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ClientItemResponse build() {
    _$ClientItemResponse _$result;
    try {
      _$result = _$v ?? new _$ClientItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ClientItemResponse', _$failedField, e.toString());
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
  final int loadedAt;
  @override
  final String name;
  @override
  final String displayName;
  @override
  final double balance;
  @override
  final double creditBalance;
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
  final BuiltList<ContactEntity> contacts;
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
  final bool isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final String createdUserId;
  @override
  final String assignedUserId;
  @override
  final String id;

  factory _$ClientEntity([void Function(ClientEntityBuilder) updates]) =>
      (new ClientEntityBuilder()..update(updates)).build();

  _$ClientEntity._(
      {this.groupId,
      this.loadedAt,
      this.name,
      this.displayName,
      this.balance,
      this.creditBalance,
      this.paidToDate,
      this.clientHash,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postalCode,
      this.countryId,
      this.phone,
      this.privateNotes,
      this.publicNotes,
      this.website,
      this.industryId,
      this.sizeId,
      this.vatNumber,
      this.idNumber,
      this.number,
      this.shippingAddress1,
      this.shippingAddress2,
      this.shippingCity,
      this.shippingState,
      this.shippingPostalCode,
      this.shippingCountryId,
      this.settings,
      this.lastLogin,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.contacts,
      this.activities,
      this.ledger,
      this.gatewayTokens,
      this.documents,
      this.systemLogs,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (groupId == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'groupId');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'name');
    }
    if (displayName == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'displayName');
    }
    if (balance == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'balance');
    }
    if (creditBalance == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'creditBalance');
    }
    if (paidToDate == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'paidToDate');
    }
    if (clientHash == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'clientHash');
    }
    if (address1 == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'address1');
    }
    if (address2 == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'address2');
    }
    if (city == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'city');
    }
    if (state == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'state');
    }
    if (postalCode == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'postalCode');
    }
    if (countryId == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'countryId');
    }
    if (phone == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'phone');
    }
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'privateNotes');
    }
    if (publicNotes == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'publicNotes');
    }
    if (website == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'website');
    }
    if (industryId == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'industryId');
    }
    if (sizeId == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'sizeId');
    }
    if (vatNumber == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'vatNumber');
    }
    if (idNumber == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'idNumber');
    }
    if (number == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'number');
    }
    if (shippingAddress1 == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'shippingAddress1');
    }
    if (shippingAddress2 == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'shippingAddress2');
    }
    if (shippingCity == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'shippingCity');
    }
    if (shippingState == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'shippingState');
    }
    if (shippingPostalCode == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'shippingPostalCode');
    }
    if (shippingCountryId == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'shippingCountryId');
    }
    if (settings == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'settings');
    }
    if (lastLogin == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'lastLogin');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'customValue4');
    }
    if (contacts == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'contacts');
    }
    if (activities == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'activities');
    }
    if (ledger == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'ledger');
    }
    if (gatewayTokens == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'gatewayTokens');
    }
    if (documents == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'documents');
    }
    if (systemLogs == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'systemLogs');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('ClientEntity', 'id');
    }
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
        loadedAt == other.loadedAt &&
        name == other.name &&
        displayName == other.displayName &&
        balance == other.balance &&
        creditBalance == other.creditBalance &&
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, groupId.hashCode), loadedAt.hashCode), name.hashCode), displayName.hashCode), balance.hashCode), creditBalance.hashCode), paidToDate.hashCode), clientHash.hashCode), address1.hashCode), address2.hashCode), city.hashCode), state.hashCode), postalCode.hashCode), countryId.hashCode), phone.hashCode), privateNotes.hashCode), publicNotes.hashCode), website.hashCode), industryId.hashCode), sizeId.hashCode), vatNumber.hashCode), idNumber.hashCode), number.hashCode), shippingAddress1.hashCode), shippingAddress2.hashCode), shippingCity.hashCode), shippingState.hashCode), shippingPostalCode.hashCode), shippingCountryId.hashCode), settings.hashCode),
                                                                                lastLogin.hashCode),
                                                                            customValue1.hashCode),
                                                                        customValue2.hashCode),
                                                                    customValue3.hashCode),
                                                                customValue4.hashCode),
                                                            contacts.hashCode),
                                                        activities.hashCode),
                                                    ledger.hashCode),
                                                gatewayTokens.hashCode),
                                            documents.hashCode),
                                        systemLogs.hashCode),
                                    isChanged.hashCode),
                                createdAt.hashCode),
                            updatedAt.hashCode),
                        archivedAt.hashCode),
                    isDeleted.hashCode),
                createdUserId.hashCode),
            assignedUserId.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ClientEntity')
          ..add('groupId', groupId)
          ..add('loadedAt', loadedAt)
          ..add('name', name)
          ..add('displayName', displayName)
          ..add('balance', balance)
          ..add('creditBalance', creditBalance)
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
  _$ClientEntity _$v;

  String _groupId;
  String get groupId => _$this._groupId;
  set groupId(String groupId) => _$this._groupId = groupId;

  int _loadedAt;
  int get loadedAt => _$this._loadedAt;
  set loadedAt(int loadedAt) => _$this._loadedAt = loadedAt;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  double _balance;
  double get balance => _$this._balance;
  set balance(double balance) => _$this._balance = balance;

  double _creditBalance;
  double get creditBalance => _$this._creditBalance;
  set creditBalance(double creditBalance) =>
      _$this._creditBalance = creditBalance;

  double _paidToDate;
  double get paidToDate => _$this._paidToDate;
  set paidToDate(double paidToDate) => _$this._paidToDate = paidToDate;

  String _clientHash;
  String get clientHash => _$this._clientHash;
  set clientHash(String clientHash) => _$this._clientHash = clientHash;

  String _address1;
  String get address1 => _$this._address1;
  set address1(String address1) => _$this._address1 = address1;

  String _address2;
  String get address2 => _$this._address2;
  set address2(String address2) => _$this._address2 = address2;

  String _city;
  String get city => _$this._city;
  set city(String city) => _$this._city = city;

  String _state;
  String get state => _$this._state;
  set state(String state) => _$this._state = state;

  String _postalCode;
  String get postalCode => _$this._postalCode;
  set postalCode(String postalCode) => _$this._postalCode = postalCode;

  String _countryId;
  String get countryId => _$this._countryId;
  set countryId(String countryId) => _$this._countryId = countryId;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

  String _publicNotes;
  String get publicNotes => _$this._publicNotes;
  set publicNotes(String publicNotes) => _$this._publicNotes = publicNotes;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  String _industryId;
  String get industryId => _$this._industryId;
  set industryId(String industryId) => _$this._industryId = industryId;

  String _sizeId;
  String get sizeId => _$this._sizeId;
  set sizeId(String sizeId) => _$this._sizeId = sizeId;

  String _vatNumber;
  String get vatNumber => _$this._vatNumber;
  set vatNumber(String vatNumber) => _$this._vatNumber = vatNumber;

  String _idNumber;
  String get idNumber => _$this._idNumber;
  set idNumber(String idNumber) => _$this._idNumber = idNumber;

  String _number;
  String get number => _$this._number;
  set number(String number) => _$this._number = number;

  String _shippingAddress1;
  String get shippingAddress1 => _$this._shippingAddress1;
  set shippingAddress1(String shippingAddress1) =>
      _$this._shippingAddress1 = shippingAddress1;

  String _shippingAddress2;
  String get shippingAddress2 => _$this._shippingAddress2;
  set shippingAddress2(String shippingAddress2) =>
      _$this._shippingAddress2 = shippingAddress2;

  String _shippingCity;
  String get shippingCity => _$this._shippingCity;
  set shippingCity(String shippingCity) => _$this._shippingCity = shippingCity;

  String _shippingState;
  String get shippingState => _$this._shippingState;
  set shippingState(String shippingState) =>
      _$this._shippingState = shippingState;

  String _shippingPostalCode;
  String get shippingPostalCode => _$this._shippingPostalCode;
  set shippingPostalCode(String shippingPostalCode) =>
      _$this._shippingPostalCode = shippingPostalCode;

  String _shippingCountryId;
  String get shippingCountryId => _$this._shippingCountryId;
  set shippingCountryId(String shippingCountryId) =>
      _$this._shippingCountryId = shippingCountryId;

  SettingsEntityBuilder _settings;
  SettingsEntityBuilder get settings =>
      _$this._settings ??= new SettingsEntityBuilder();
  set settings(SettingsEntityBuilder settings) => _$this._settings = settings;

  int _lastLogin;
  int get lastLogin => _$this._lastLogin;
  set lastLogin(int lastLogin) => _$this._lastLogin = lastLogin;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  String _customValue3;
  String get customValue3 => _$this._customValue3;
  set customValue3(String customValue3) => _$this._customValue3 = customValue3;

  String _customValue4;
  String get customValue4 => _$this._customValue4;
  set customValue4(String customValue4) => _$this._customValue4 = customValue4;

  ListBuilder<ContactEntity> _contacts;
  ListBuilder<ContactEntity> get contacts =>
      _$this._contacts ??= new ListBuilder<ContactEntity>();
  set contacts(ListBuilder<ContactEntity> contacts) =>
      _$this._contacts = contacts;

  ListBuilder<ActivityEntity> _activities;
  ListBuilder<ActivityEntity> get activities =>
      _$this._activities ??= new ListBuilder<ActivityEntity>();
  set activities(ListBuilder<ActivityEntity> activities) =>
      _$this._activities = activities;

  ListBuilder<LedgerEntity> _ledger;
  ListBuilder<LedgerEntity> get ledger =>
      _$this._ledger ??= new ListBuilder<LedgerEntity>();
  set ledger(ListBuilder<LedgerEntity> ledger) => _$this._ledger = ledger;

  ListBuilder<GatewayTokenEntity> _gatewayTokens;
  ListBuilder<GatewayTokenEntity> get gatewayTokens =>
      _$this._gatewayTokens ??= new ListBuilder<GatewayTokenEntity>();
  set gatewayTokens(ListBuilder<GatewayTokenEntity> gatewayTokens) =>
      _$this._gatewayTokens = gatewayTokens;

  ListBuilder<DocumentEntity> _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity> documents) =>
      _$this._documents = documents;

  ListBuilder<SystemLogEntity> _systemLogs;
  ListBuilder<SystemLogEntity> get systemLogs =>
      _$this._systemLogs ??= new ListBuilder<SystemLogEntity>();
  set systemLogs(ListBuilder<SystemLogEntity> systemLogs) =>
      _$this._systemLogs = systemLogs;

  bool _isChanged;
  bool get isChanged => _$this._isChanged;
  set isChanged(bool isChanged) => _$this._isChanged = isChanged;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  String _createdUserId;
  String get createdUserId => _$this._createdUserId;
  set createdUserId(String createdUserId) =>
      _$this._createdUserId = createdUserId;

  String _assignedUserId;
  String get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  ClientEntityBuilder() {
    ClientEntity._initializeBuilder(this);
  }

  ClientEntityBuilder get _$this {
    if (_$v != null) {
      _groupId = _$v.groupId;
      _loadedAt = _$v.loadedAt;
      _name = _$v.name;
      _displayName = _$v.displayName;
      _balance = _$v.balance;
      _creditBalance = _$v.creditBalance;
      _paidToDate = _$v.paidToDate;
      _clientHash = _$v.clientHash;
      _address1 = _$v.address1;
      _address2 = _$v.address2;
      _city = _$v.city;
      _state = _$v.state;
      _postalCode = _$v.postalCode;
      _countryId = _$v.countryId;
      _phone = _$v.phone;
      _privateNotes = _$v.privateNotes;
      _publicNotes = _$v.publicNotes;
      _website = _$v.website;
      _industryId = _$v.industryId;
      _sizeId = _$v.sizeId;
      _vatNumber = _$v.vatNumber;
      _idNumber = _$v.idNumber;
      _number = _$v.number;
      _shippingAddress1 = _$v.shippingAddress1;
      _shippingAddress2 = _$v.shippingAddress2;
      _shippingCity = _$v.shippingCity;
      _shippingState = _$v.shippingState;
      _shippingPostalCode = _$v.shippingPostalCode;
      _shippingCountryId = _$v.shippingCountryId;
      _settings = _$v.settings?.toBuilder();
      _lastLogin = _$v.lastLogin;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _contacts = _$v.contacts?.toBuilder();
      _activities = _$v.activities?.toBuilder();
      _ledger = _$v.ledger?.toBuilder();
      _gatewayTokens = _$v.gatewayTokens?.toBuilder();
      _documents = _$v.documents?.toBuilder();
      _systemLogs = _$v.systemLogs?.toBuilder();
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ClientEntity;
  }

  @override
  void update(void Function(ClientEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ClientEntity build() {
    _$ClientEntity _$result;
    try {
      _$result = _$v ??
          new _$ClientEntity._(
              groupId: groupId,
              loadedAt: loadedAt,
              name: name,
              displayName: displayName,
              balance: balance,
              creditBalance: creditBalance,
              paidToDate: paidToDate,
              clientHash: clientHash,
              address1: address1,
              address2: address2,
              city: city,
              state: state,
              postalCode: postalCode,
              countryId: countryId,
              phone: phone,
              privateNotes: privateNotes,
              publicNotes: publicNotes,
              website: website,
              industryId: industryId,
              sizeId: sizeId,
              vatNumber: vatNumber,
              idNumber: idNumber,
              number: number,
              shippingAddress1: shippingAddress1,
              shippingAddress2: shippingAddress2,
              shippingCity: shippingCity,
              shippingState: shippingState,
              shippingPostalCode: shippingPostalCode,
              shippingCountryId: shippingCountryId,
              settings: settings.build(),
              lastLogin: lastLogin,
              customValue1: customValue1,
              customValue2: customValue2,
              customValue3: customValue3,
              customValue4: customValue4,
              contacts: contacts.build(),
              activities: activities.build(),
              ledger: ledger.build(),
              gatewayTokens: gatewayTokens.build(),
              documents: documents.build(),
              systemLogs: systemLogs.build(),
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'settings';
        settings.build();

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
            'ClientEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ContactEntity extends ContactEntity {
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
  final bool isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final String createdUserId;
  @override
  final String assignedUserId;
  @override
  final String id;

  factory _$ContactEntity([void Function(ContactEntityBuilder) updates]) =>
      (new ContactEntityBuilder()..update(updates)).build();

  _$ContactEntity._(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phone,
      this.contactKey,
      this.isPrimary,
      this.sendEmail,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.lastLogin,
      this.link,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (firstName == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'firstName');
    }
    if (lastName == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'lastName');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'email');
    }
    if (password == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'password');
    }
    if (phone == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'phone');
    }
    if (contactKey == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'contactKey');
    }
    if (isPrimary == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'isPrimary');
    }
    if (sendEmail == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'sendEmail');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'customValue4');
    }
    if (lastLogin == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'lastLogin');
    }
    if (link == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'link');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'archivedAt');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('ContactEntity', 'id');
    }
  }

  @override
  ContactEntity rebuild(void Function(ContactEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContactEntityBuilder toBuilder() => new ContactEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContactEntity &&
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc(0, firstName.hashCode), lastName.hashCode), email.hashCode),
                                                                                password.hashCode),
                                                                            phone.hashCode),
                                                                        contactKey.hashCode),
                                                                    isPrimary.hashCode),
                                                                sendEmail.hashCode),
                                                            customValue1.hashCode),
                                                        customValue2.hashCode),
                                                    customValue3.hashCode),
                                                customValue4.hashCode),
                                            lastLogin.hashCode),
                                        link.hashCode),
                                    isChanged.hashCode),
                                createdAt.hashCode),
                            updatedAt.hashCode),
                        archivedAt.hashCode),
                    isDeleted.hashCode),
                createdUserId.hashCode),
            assignedUserId.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ContactEntity')
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

class ContactEntityBuilder
    implements Builder<ContactEntity, ContactEntityBuilder> {
  _$ContactEntity _$v;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _contactKey;
  String get contactKey => _$this._contactKey;
  set contactKey(String contactKey) => _$this._contactKey = contactKey;

  bool _isPrimary;
  bool get isPrimary => _$this._isPrimary;
  set isPrimary(bool isPrimary) => _$this._isPrimary = isPrimary;

  bool _sendEmail;
  bool get sendEmail => _$this._sendEmail;
  set sendEmail(bool sendEmail) => _$this._sendEmail = sendEmail;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  String _customValue3;
  String get customValue3 => _$this._customValue3;
  set customValue3(String customValue3) => _$this._customValue3 = customValue3;

  String _customValue4;
  String get customValue4 => _$this._customValue4;
  set customValue4(String customValue4) => _$this._customValue4 = customValue4;

  int _lastLogin;
  int get lastLogin => _$this._lastLogin;
  set lastLogin(int lastLogin) => _$this._lastLogin = lastLogin;

  String _link;
  String get link => _$this._link;
  set link(String link) => _$this._link = link;

  bool _isChanged;
  bool get isChanged => _$this._isChanged;
  set isChanged(bool isChanged) => _$this._isChanged = isChanged;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  String _createdUserId;
  String get createdUserId => _$this._createdUserId;
  set createdUserId(String createdUserId) =>
      _$this._createdUserId = createdUserId;

  String _assignedUserId;
  String get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  ContactEntityBuilder();

  ContactEntityBuilder get _$this {
    if (_$v != null) {
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _email = _$v.email;
      _password = _$v.password;
      _phone = _$v.phone;
      _contactKey = _$v.contactKey;
      _isPrimary = _$v.isPrimary;
      _sendEmail = _$v.sendEmail;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _lastLogin = _$v.lastLogin;
      _link = _$v.link;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContactEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ContactEntity;
  }

  @override
  void update(void Function(ContactEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ContactEntity build() {
    final _$result = _$v ??
        new _$ContactEntity._(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            phone: phone,
            contactKey: contactKey,
            isPrimary: isPrimary,
            sendEmail: sendEmail,
            customValue1: customValue1,
            customValue2: customValue2,
            customValue3: customValue3,
            customValue4: customValue4,
            lastLogin: lastLogin,
            link: link,
            isChanged: isChanged,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
