// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<VendorListResponse> _$vendorListResponseSerializer =
    new _$VendorListResponseSerializer();
Serializer<VendorItemResponse> _$vendorItemResponseSerializer =
    new _$VendorItemResponseSerializer();
Serializer<VendorEntity> _$vendorEntitySerializer =
    new _$VendorEntitySerializer();
Serializer<VendorContactEntity> _$vendorContactEntitySerializer =
    new _$VendorContactEntitySerializer();

class _$VendorListResponseSerializer
    implements StructuredSerializer<VendorListResponse> {
  @override
  final Iterable<Type> types = const [VendorListResponse, _$VendorListResponse];
  @override
  final String wireName = 'VendorListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, VendorListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(VendorEntity)])),
    ];

    return result;
  }

  @override
  VendorListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(VendorEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$VendorItemResponseSerializer
    implements StructuredSerializer<VendorItemResponse> {
  @override
  final Iterable<Type> types = const [VendorItemResponse, _$VendorItemResponse];
  @override
  final String wireName = 'VendorItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, VendorItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(VendorEntity)),
    ];

    return result;
  }

  @override
  VendorItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(VendorEntity))! as VendorEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$VendorEntitySerializer implements StructuredSerializer<VendorEntity> {
  @override
  final Iterable<Type> types = const [VendorEntity, _$VendorEntity];
  @override
  final String wireName = 'VendorEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, VendorEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'display_name',
      serializers.serialize(object.displayName,
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
      'language_id',
      serializers.serialize(object.languageId,
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
      'number',
      serializers.serialize(object.number,
          specifiedType: const FullType(String)),
      'vat_number',
      serializers.serialize(object.vatNumber,
          specifiedType: const FullType(String)),
      'id_number',
      serializers.serialize(object.idNumber,
          specifiedType: const FullType(String)),
      'currency_id',
      serializers.serialize(object.currencyId,
          specifiedType: const FullType(String)),
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
      'classification',
      serializers.serialize(object.classification,
          specifiedType: const FullType(String)),
      'contacts',
      serializers.serialize(object.contacts,
          specifiedType: const FullType(
              BuiltList, const [const FullType(VendorContactEntity)])),
      'activities',
      serializers.serialize(object.activities,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ActivityEntity)])),
      'documents',
      serializers.serialize(object.documents,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
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
  VendorEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
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
        case 'language_id':
          result.languageId = serializers.deserialize(value,
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
        case 'number':
          result.number = serializers.deserialize(value,
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
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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
        case 'classification':
          result.classification = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'contacts':
          result.contacts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(VendorContactEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'activities':
          result.activities.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ActivityEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))!
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

class _$VendorContactEntitySerializer
    implements StructuredSerializer<VendorContactEntity> {
  @override
  final Iterable<Type> types = const [
    VendorContactEntity,
    _$VendorContactEntity
  ];
  @override
  final String wireName = 'VendorContactEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, VendorContactEntity object,
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
      'is_primary',
      serializers.serialize(object.isPrimary,
          specifiedType: const FullType(bool)),
      'send_email',
      serializers.serialize(object.sendEmail,
          specifiedType: const FullType(bool)),
      'phone',
      serializers.serialize(object.phone,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
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
  VendorContactEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorContactEntityBuilder();

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
        case 'is_primary':
          result.isPrimary = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'send_email':
          result.sendEmail = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

class _$VendorListResponse extends VendorListResponse {
  @override
  final BuiltList<VendorEntity> data;

  factory _$VendorListResponse(
          [void Function(VendorListResponseBuilder)? updates]) =>
      (new VendorListResponseBuilder()..update(updates))._build();

  _$VendorListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'VendorListResponse', 'data');
  }

  @override
  VendorListResponse rebuild(
          void Function(VendorListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorListResponseBuilder toBuilder() =>
      new VendorListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VendorListResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'VendorListResponse')
          ..add('data', data))
        .toString();
  }
}

class VendorListResponseBuilder
    implements Builder<VendorListResponse, VendorListResponseBuilder> {
  _$VendorListResponse? _$v;

  ListBuilder<VendorEntity>? _data;
  ListBuilder<VendorEntity> get data =>
      _$this._data ??= new ListBuilder<VendorEntity>();
  set data(ListBuilder<VendorEntity>? data) => _$this._data = data;

  VendorListResponseBuilder();

  VendorListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VendorListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VendorListResponse;
  }

  @override
  void update(void Function(VendorListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VendorListResponse build() => _build();

  _$VendorListResponse _build() {
    _$VendorListResponse _$result;
    try {
      _$result = _$v ?? new _$VendorListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'VendorListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$VendorItemResponse extends VendorItemResponse {
  @override
  final VendorEntity data;

  factory _$VendorItemResponse(
          [void Function(VendorItemResponseBuilder)? updates]) =>
      (new VendorItemResponseBuilder()..update(updates))._build();

  _$VendorItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'VendorItemResponse', 'data');
  }

  @override
  VendorItemResponse rebuild(
          void Function(VendorItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorItemResponseBuilder toBuilder() =>
      new VendorItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VendorItemResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'VendorItemResponse')
          ..add('data', data))
        .toString();
  }
}

class VendorItemResponseBuilder
    implements Builder<VendorItemResponse, VendorItemResponseBuilder> {
  _$VendorItemResponse? _$v;

  VendorEntityBuilder? _data;
  VendorEntityBuilder get data => _$this._data ??= new VendorEntityBuilder();
  set data(VendorEntityBuilder? data) => _$this._data = data;

  VendorItemResponseBuilder();

  VendorItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VendorItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VendorItemResponse;
  }

  @override
  void update(void Function(VendorItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VendorItemResponse build() => _build();

  _$VendorItemResponse _build() {
    _$VendorItemResponse _$result;
    try {
      _$result = _$v ?? new _$VendorItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'VendorItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$VendorEntity extends VendorEntity {
  @override
  final int? loadedAt;
  @override
  final String name;
  @override
  final String displayName;
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
  final String languageId;
  @override
  final String phone;
  @override
  final String privateNotes;
  @override
  final String publicNotes;
  @override
  final String website;
  @override
  final String number;
  @override
  final String vatNumber;
  @override
  final String idNumber;
  @override
  final String currencyId;
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
  final String classification;
  @override
  final BuiltList<VendorContactEntity> contacts;
  @override
  final BuiltList<ActivityEntity> activities;
  @override
  final BuiltList<DocumentEntity> documents;
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

  factory _$VendorEntity([void Function(VendorEntityBuilder)? updates]) =>
      (new VendorEntityBuilder()..update(updates))._build();

  _$VendorEntity._(
      {this.loadedAt,
      required this.name,
      required this.displayName,
      required this.address1,
      required this.address2,
      required this.city,
      required this.state,
      required this.postalCode,
      required this.countryId,
      required this.languageId,
      required this.phone,
      required this.privateNotes,
      required this.publicNotes,
      required this.website,
      required this.number,
      required this.vatNumber,
      required this.idNumber,
      required this.currencyId,
      required this.customValue1,
      required this.customValue2,
      required this.customValue3,
      required this.customValue4,
      required this.lastLogin,
      required this.classification,
      required this.contacts,
      required this.activities,
      required this.documents,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'VendorEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        displayName, r'VendorEntity', 'displayName');
    BuiltValueNullFieldError.checkNotNull(
        address1, r'VendorEntity', 'address1');
    BuiltValueNullFieldError.checkNotNull(
        address2, r'VendorEntity', 'address2');
    BuiltValueNullFieldError.checkNotNull(city, r'VendorEntity', 'city');
    BuiltValueNullFieldError.checkNotNull(state, r'VendorEntity', 'state');
    BuiltValueNullFieldError.checkNotNull(
        postalCode, r'VendorEntity', 'postalCode');
    BuiltValueNullFieldError.checkNotNull(
        countryId, r'VendorEntity', 'countryId');
    BuiltValueNullFieldError.checkNotNull(
        languageId, r'VendorEntity', 'languageId');
    BuiltValueNullFieldError.checkNotNull(phone, r'VendorEntity', 'phone');
    BuiltValueNullFieldError.checkNotNull(
        privateNotes, r'VendorEntity', 'privateNotes');
    BuiltValueNullFieldError.checkNotNull(
        publicNotes, r'VendorEntity', 'publicNotes');
    BuiltValueNullFieldError.checkNotNull(website, r'VendorEntity', 'website');
    BuiltValueNullFieldError.checkNotNull(number, r'VendorEntity', 'number');
    BuiltValueNullFieldError.checkNotNull(
        vatNumber, r'VendorEntity', 'vatNumber');
    BuiltValueNullFieldError.checkNotNull(
        idNumber, r'VendorEntity', 'idNumber');
    BuiltValueNullFieldError.checkNotNull(
        currencyId, r'VendorEntity', 'currencyId');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, r'VendorEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, r'VendorEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, r'VendorEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, r'VendorEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        lastLogin, r'VendorEntity', 'lastLogin');
    BuiltValueNullFieldError.checkNotNull(
        classification, r'VendorEntity', 'classification');
    BuiltValueNullFieldError.checkNotNull(
        contacts, r'VendorEntity', 'contacts');
    BuiltValueNullFieldError.checkNotNull(
        activities, r'VendorEntity', 'activities');
    BuiltValueNullFieldError.checkNotNull(
        documents, r'VendorEntity', 'documents');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'VendorEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'VendorEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'VendorEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'VendorEntity', 'id');
  }

  @override
  VendorEntity rebuild(void Function(VendorEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorEntityBuilder toBuilder() => new VendorEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VendorEntity &&
        name == other.name &&
        displayName == other.displayName &&
        address1 == other.address1 &&
        address2 == other.address2 &&
        city == other.city &&
        state == other.state &&
        postalCode == other.postalCode &&
        countryId == other.countryId &&
        languageId == other.languageId &&
        phone == other.phone &&
        privateNotes == other.privateNotes &&
        publicNotes == other.publicNotes &&
        website == other.website &&
        number == other.number &&
        vatNumber == other.vatNumber &&
        idNumber == other.idNumber &&
        currencyId == other.currencyId &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        lastLogin == other.lastLogin &&
        classification == other.classification &&
        contacts == other.contacts &&
        activities == other.activities &&
        documents == other.documents &&
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
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, address1.hashCode);
    _$hash = $jc(_$hash, address2.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, postalCode.hashCode);
    _$hash = $jc(_$hash, countryId.hashCode);
    _$hash = $jc(_$hash, languageId.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, privateNotes.hashCode);
    _$hash = $jc(_$hash, publicNotes.hashCode);
    _$hash = $jc(_$hash, website.hashCode);
    _$hash = $jc(_$hash, number.hashCode);
    _$hash = $jc(_$hash, vatNumber.hashCode);
    _$hash = $jc(_$hash, idNumber.hashCode);
    _$hash = $jc(_$hash, currencyId.hashCode);
    _$hash = $jc(_$hash, customValue1.hashCode);
    _$hash = $jc(_$hash, customValue2.hashCode);
    _$hash = $jc(_$hash, customValue3.hashCode);
    _$hash = $jc(_$hash, customValue4.hashCode);
    _$hash = $jc(_$hash, lastLogin.hashCode);
    _$hash = $jc(_$hash, classification.hashCode);
    _$hash = $jc(_$hash, contacts.hashCode);
    _$hash = $jc(_$hash, activities.hashCode);
    _$hash = $jc(_$hash, documents.hashCode);
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
    return (newBuiltValueToStringHelper(r'VendorEntity')
          ..add('loadedAt', loadedAt)
          ..add('name', name)
          ..add('displayName', displayName)
          ..add('address1', address1)
          ..add('address2', address2)
          ..add('city', city)
          ..add('state', state)
          ..add('postalCode', postalCode)
          ..add('countryId', countryId)
          ..add('languageId', languageId)
          ..add('phone', phone)
          ..add('privateNotes', privateNotes)
          ..add('publicNotes', publicNotes)
          ..add('website', website)
          ..add('number', number)
          ..add('vatNumber', vatNumber)
          ..add('idNumber', idNumber)
          ..add('currencyId', currencyId)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('lastLogin', lastLogin)
          ..add('classification', classification)
          ..add('contacts', contacts)
          ..add('activities', activities)
          ..add('documents', documents)
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

class VendorEntityBuilder
    implements Builder<VendorEntity, VendorEntityBuilder> {
  _$VendorEntity? _$v;

  int? _loadedAt;
  int? get loadedAt => _$this._loadedAt;
  set loadedAt(int? loadedAt) => _$this._loadedAt = loadedAt;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

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

  String? _languageId;
  String? get languageId => _$this._languageId;
  set languageId(String? languageId) => _$this._languageId = languageId;

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

  String? _number;
  String? get number => _$this._number;
  set number(String? number) => _$this._number = number;

  String? _vatNumber;
  String? get vatNumber => _$this._vatNumber;
  set vatNumber(String? vatNumber) => _$this._vatNumber = vatNumber;

  String? _idNumber;
  String? get idNumber => _$this._idNumber;
  set idNumber(String? idNumber) => _$this._idNumber = idNumber;

  String? _currencyId;
  String? get currencyId => _$this._currencyId;
  set currencyId(String? currencyId) => _$this._currencyId = currencyId;

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

  String? _classification;
  String? get classification => _$this._classification;
  set classification(String? classification) =>
      _$this._classification = classification;

  ListBuilder<VendorContactEntity>? _contacts;
  ListBuilder<VendorContactEntity> get contacts =>
      _$this._contacts ??= new ListBuilder<VendorContactEntity>();
  set contacts(ListBuilder<VendorContactEntity>? contacts) =>
      _$this._contacts = contacts;

  ListBuilder<ActivityEntity>? _activities;
  ListBuilder<ActivityEntity> get activities =>
      _$this._activities ??= new ListBuilder<ActivityEntity>();
  set activities(ListBuilder<ActivityEntity>? activities) =>
      _$this._activities = activities;

  ListBuilder<DocumentEntity>? _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity>? documents) =>
      _$this._documents = documents;

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

  VendorEntityBuilder() {
    VendorEntity._initializeBuilder(this);
  }

  VendorEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _loadedAt = $v.loadedAt;
      _name = $v.name;
      _displayName = $v.displayName;
      _address1 = $v.address1;
      _address2 = $v.address2;
      _city = $v.city;
      _state = $v.state;
      _postalCode = $v.postalCode;
      _countryId = $v.countryId;
      _languageId = $v.languageId;
      _phone = $v.phone;
      _privateNotes = $v.privateNotes;
      _publicNotes = $v.publicNotes;
      _website = $v.website;
      _number = $v.number;
      _vatNumber = $v.vatNumber;
      _idNumber = $v.idNumber;
      _currencyId = $v.currencyId;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _lastLogin = $v.lastLogin;
      _classification = $v.classification;
      _contacts = $v.contacts.toBuilder();
      _activities = $v.activities.toBuilder();
      _documents = $v.documents.toBuilder();
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
  void replace(VendorEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VendorEntity;
  }

  @override
  void update(void Function(VendorEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VendorEntity build() => _build();

  _$VendorEntity _build() {
    _$VendorEntity _$result;
    try {
      _$result = _$v ??
          new _$VendorEntity._(
              loadedAt: loadedAt,
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'VendorEntity', 'name'),
              displayName: BuiltValueNullFieldError.checkNotNull(
                  displayName, r'VendorEntity', 'displayName'),
              address1: BuiltValueNullFieldError.checkNotNull(
                  address1, r'VendorEntity', 'address1'),
              address2: BuiltValueNullFieldError.checkNotNull(
                  address2, r'VendorEntity', 'address2'),
              city: BuiltValueNullFieldError.checkNotNull(
                  city, r'VendorEntity', 'city'),
              state: BuiltValueNullFieldError.checkNotNull(
                  state, r'VendorEntity', 'state'),
              postalCode: BuiltValueNullFieldError.checkNotNull(
                  postalCode, r'VendorEntity', 'postalCode'),
              countryId: BuiltValueNullFieldError.checkNotNull(
                  countryId, r'VendorEntity', 'countryId'),
              languageId:
                  BuiltValueNullFieldError.checkNotNull(languageId, r'VendorEntity', 'languageId'),
              phone: BuiltValueNullFieldError.checkNotNull(phone, r'VendorEntity', 'phone'),
              privateNotes: BuiltValueNullFieldError.checkNotNull(privateNotes, r'VendorEntity', 'privateNotes'),
              publicNotes: BuiltValueNullFieldError.checkNotNull(publicNotes, r'VendorEntity', 'publicNotes'),
              website: BuiltValueNullFieldError.checkNotNull(website, r'VendorEntity', 'website'),
              number: BuiltValueNullFieldError.checkNotNull(number, r'VendorEntity', 'number'),
              vatNumber: BuiltValueNullFieldError.checkNotNull(vatNumber, r'VendorEntity', 'vatNumber'),
              idNumber: BuiltValueNullFieldError.checkNotNull(idNumber, r'VendorEntity', 'idNumber'),
              currencyId: BuiltValueNullFieldError.checkNotNull(currencyId, r'VendorEntity', 'currencyId'),
              customValue1: BuiltValueNullFieldError.checkNotNull(customValue1, r'VendorEntity', 'customValue1'),
              customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, r'VendorEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, r'VendorEntity', 'customValue3'),
              customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, r'VendorEntity', 'customValue4'),
              lastLogin: BuiltValueNullFieldError.checkNotNull(lastLogin, r'VendorEntity', 'lastLogin'),
              classification: BuiltValueNullFieldError.checkNotNull(classification, r'VendorEntity', 'classification'),
              contacts: contacts.build(),
              activities: activities.build(),
              documents: documents.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'VendorEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'VendorEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'VendorEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(id, r'VendorEntity', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'contacts';
        contacts.build();
        _$failedField = 'activities';
        activities.build();
        _$failedField = 'documents';
        documents.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'VendorEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$VendorContactEntity extends VendorContactEntity {
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final bool isPrimary;
  @override
  final bool sendEmail;
  @override
  final String phone;
  @override
  final String password;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
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

  factory _$VendorContactEntity(
          [void Function(VendorContactEntityBuilder)? updates]) =>
      (new VendorContactEntityBuilder()..update(updates))._build();

  _$VendorContactEntity._(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.isPrimary,
      required this.sendEmail,
      required this.phone,
      required this.password,
      required this.customValue1,
      required this.customValue2,
      required this.customValue3,
      required this.customValue4,
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
        firstName, r'VendorContactEntity', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        lastName, r'VendorContactEntity', 'lastName');
    BuiltValueNullFieldError.checkNotNull(
        email, r'VendorContactEntity', 'email');
    BuiltValueNullFieldError.checkNotNull(
        isPrimary, r'VendorContactEntity', 'isPrimary');
    BuiltValueNullFieldError.checkNotNull(
        sendEmail, r'VendorContactEntity', 'sendEmail');
    BuiltValueNullFieldError.checkNotNull(
        phone, r'VendorContactEntity', 'phone');
    BuiltValueNullFieldError.checkNotNull(
        password, r'VendorContactEntity', 'password');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, r'VendorContactEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, r'VendorContactEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, r'VendorContactEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, r'VendorContactEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(link, r'VendorContactEntity', 'link');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'VendorContactEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'VendorContactEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'VendorContactEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'VendorContactEntity', 'id');
  }

  @override
  VendorContactEntity rebuild(
          void Function(VendorContactEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorContactEntityBuilder toBuilder() =>
      new VendorContactEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VendorContactEntity &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        isPrimary == other.isPrimary &&
        sendEmail == other.sendEmail &&
        phone == other.phone &&
        password == other.password &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
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
    _$hash = $jc(_$hash, isPrimary.hashCode);
    _$hash = $jc(_$hash, sendEmail.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, customValue1.hashCode);
    _$hash = $jc(_$hash, customValue2.hashCode);
    _$hash = $jc(_$hash, customValue3.hashCode);
    _$hash = $jc(_$hash, customValue4.hashCode);
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
    return (newBuiltValueToStringHelper(r'VendorContactEntity')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('isPrimary', isPrimary)
          ..add('sendEmail', sendEmail)
          ..add('phone', phone)
          ..add('password', password)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
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

class VendorContactEntityBuilder
    implements Builder<VendorContactEntity, VendorContactEntityBuilder> {
  _$VendorContactEntity? _$v;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _isPrimary;
  bool? get isPrimary => _$this._isPrimary;
  set isPrimary(bool? isPrimary) => _$this._isPrimary = isPrimary;

  bool? _sendEmail;
  bool? get sendEmail => _$this._sendEmail;
  set sendEmail(bool? sendEmail) => _$this._sendEmail = sendEmail;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

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

  VendorContactEntityBuilder() {
    VendorContactEntity._initializeBuilder(this);
  }

  VendorContactEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _isPrimary = $v.isPrimary;
      _sendEmail = $v.sendEmail;
      _phone = $v.phone;
      _password = $v.password;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
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
  void replace(VendorContactEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VendorContactEntity;
  }

  @override
  void update(void Function(VendorContactEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VendorContactEntity build() => _build();

  _$VendorContactEntity _build() {
    final _$result = _$v ??
        new _$VendorContactEntity._(
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'VendorContactEntity', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'VendorContactEntity', 'lastName'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'VendorContactEntity', 'email'),
            isPrimary: BuiltValueNullFieldError.checkNotNull(
                isPrimary, r'VendorContactEntity', 'isPrimary'),
            sendEmail: BuiltValueNullFieldError.checkNotNull(
                sendEmail, r'VendorContactEntity', 'sendEmail'),
            phone: BuiltValueNullFieldError.checkNotNull(
                phone, r'VendorContactEntity', 'phone'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'VendorContactEntity', 'password'),
            customValue1: BuiltValueNullFieldError.checkNotNull(
                customValue1, r'VendorContactEntity', 'customValue1'),
            customValue2:
                BuiltValueNullFieldError.checkNotNull(customValue2, r'VendorContactEntity', 'customValue2'),
            customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, r'VendorContactEntity', 'customValue3'),
            customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, r'VendorContactEntity', 'customValue4'),
            link: BuiltValueNullFieldError.checkNotNull(link, r'VendorContactEntity', 'link'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'VendorContactEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'VendorContactEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'VendorContactEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            id: BuiltValueNullFieldError.checkNotNull(id, r'VendorContactEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
