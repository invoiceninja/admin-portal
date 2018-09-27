// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

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
  Iterable serialize(Serializers serializers, VendorListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(VendorEntity)])),
    ];

    return result;
  }

  @override
  VendorListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(VendorEntity)]))
              as BuiltList);
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
  Iterable serialize(Serializers serializers, VendorItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(VendorEntity)),
    ];

    return result;
  }

  @override
  VendorItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(VendorEntity)) as VendorEntity);
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
  Iterable serialize(Serializers serializers, VendorEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'balance',
      serializers.serialize(object.balance,
          specifiedType: const FullType(double)),
      'paid_to_date',
      serializers.serialize(object.paidToDate,
          specifiedType: const FullType(double)),
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
          specifiedType: const FullType(int)),
      'work_phone',
      serializers.serialize(object.workPhone,
          specifiedType: const FullType(String)),
      'private_notes',
      serializers.serialize(object.privateNotes,
          specifiedType: const FullType(String)),
      'last_login',
      serializers.serialize(object.lastLogin,
          specifiedType: const FullType(String)),
      'website',
      serializers.serialize(object.website,
          specifiedType: const FullType(String)),
      'vat_number',
      serializers.serialize(object.vatNumber,
          specifiedType: const FullType(String)),
      'id_number',
      serializers.serialize(object.idNumber,
          specifiedType: const FullType(String)),
      'currency_id',
      serializers.serialize(object.currencyId,
          specifiedType: const FullType(int)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'vendor_contacts',
      serializers.serialize(object.vendorContacts,
          specifiedType: const FullType(
              BuiltList, const [const FullType(VendorContactEntity)])),
    ];
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(int)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }
    if (object.archivedAt != null) {
      result
        ..add('archived_at')
        ..add(serializers.serialize(object.archivedAt,
            specifiedType: const FullType(int)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.isOwner != null) {
      result
        ..add('is_owner')
        ..add(serializers.serialize(object.isOwner,
            specifiedType: const FullType(bool)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  VendorEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'paid_to_date':
          result.paidToDate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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
              specifiedType: const FullType(int)) as int;
          break;
        case 'work_phone':
          result.workPhone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'private_notes':
          result.privateNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_login':
          result.lastLogin = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
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
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
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
        case 'vendor_contacts':
          result.vendorContacts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(VendorContactEntity)]))
              as BuiltList);
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
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
  Iterable serialize(Serializers serializers, VendorContactEntity object,
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
      'is_primary',
      serializers.serialize(object.isPrimary,
          specifiedType: const FullType(bool)),
      'phone',
      serializers.serialize(object.phone,
          specifiedType: const FullType(String)),
    ];
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(int)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }
    if (object.archivedAt != null) {
      result
        ..add('archived_at')
        ..add(serializers.serialize(object.archivedAt,
            specifiedType: const FullType(int)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.isOwner != null) {
      result
        ..add('is_owner')
        ..add(serializers.serialize(object.isOwner,
            specifiedType: const FullType(bool)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  VendorContactEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorContactEntityBuilder();

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
        case 'is_primary':
          result.isPrimary = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$VendorListResponse extends VendorListResponse {
  @override
  final BuiltList<VendorEntity> data;

  factory _$VendorListResponse([void updates(VendorListResponseBuilder b)]) =>
      (new VendorListResponseBuilder()..update(updates)).build();

  _$VendorListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('VendorListResponse', 'data');
    }
  }

  @override
  VendorListResponse rebuild(void updates(VendorListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorListResponseBuilder toBuilder() =>
      new VendorListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VendorListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VendorListResponse')
          ..add('data', data))
        .toString();
  }
}

class VendorListResponseBuilder
    implements Builder<VendorListResponse, VendorListResponseBuilder> {
  _$VendorListResponse _$v;

  ListBuilder<VendorEntity> _data;
  ListBuilder<VendorEntity> get data =>
      _$this._data ??= new ListBuilder<VendorEntity>();
  set data(ListBuilder<VendorEntity> data) => _$this._data = data;

  VendorListResponseBuilder();

  VendorListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VendorListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VendorListResponse;
  }

  @override
  void update(void updates(VendorListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$VendorListResponse build() {
    _$VendorListResponse _$result;
    try {
      _$result = _$v ?? new _$VendorListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'VendorListResponse', _$failedField, e.toString());
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

  factory _$VendorItemResponse([void updates(VendorItemResponseBuilder b)]) =>
      (new VendorItemResponseBuilder()..update(updates)).build();

  _$VendorItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('VendorItemResponse', 'data');
    }
  }

  @override
  VendorItemResponse rebuild(void updates(VendorItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorItemResponseBuilder toBuilder() =>
      new VendorItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VendorItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VendorItemResponse')
          ..add('data', data))
        .toString();
  }
}

class VendorItemResponseBuilder
    implements Builder<VendorItemResponse, VendorItemResponseBuilder> {
  _$VendorItemResponse _$v;

  VendorEntityBuilder _data;
  VendorEntityBuilder get data => _$this._data ??= new VendorEntityBuilder();
  set data(VendorEntityBuilder data) => _$this._data = data;

  VendorItemResponseBuilder();

  VendorItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VendorItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VendorItemResponse;
  }

  @override
  void update(void updates(VendorItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$VendorItemResponse build() {
    _$VendorItemResponse _$result;
    try {
      _$result = _$v ?? new _$VendorItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'VendorItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$VendorEntity extends VendorEntity {
  @override
  final String name;
  @override
  final double balance;
  @override
  final double paidToDate;
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
  final int countryId;
  @override
  final String workPhone;
  @override
  final String privateNotes;
  @override
  final String lastLogin;
  @override
  final String website;
  @override
  final String vatNumber;
  @override
  final String idNumber;
  @override
  final int currencyId;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final BuiltList<VendorContactEntity> vendorContacts;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final bool isOwner;
  @override
  final int id;

  factory _$VendorEntity([void updates(VendorEntityBuilder b)]) =>
      (new VendorEntityBuilder()..update(updates)).build();

  _$VendorEntity._(
      {this.name,
      this.balance,
      this.paidToDate,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postalCode,
      this.countryId,
      this.workPhone,
      this.privateNotes,
      this.lastLogin,
      this.website,
      this.vatNumber,
      this.idNumber,
      this.currencyId,
      this.customValue1,
      this.customValue2,
      this.vendorContacts,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'name');
    }
    if (balance == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'balance');
    }
    if (paidToDate == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'paidToDate');
    }
    if (address1 == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'address1');
    }
    if (address2 == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'address2');
    }
    if (city == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'city');
    }
    if (state == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'state');
    }
    if (postalCode == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'postalCode');
    }
    if (countryId == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'countryId');
    }
    if (workPhone == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'workPhone');
    }
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'privateNotes');
    }
    if (lastLogin == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'lastLogin');
    }
    if (website == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'website');
    }
    if (vatNumber == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'vatNumber');
    }
    if (idNumber == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'idNumber');
    }
    if (currencyId == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'currencyId');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'customValue2');
    }
    if (vendorContacts == null) {
      throw new BuiltValueNullFieldError('VendorEntity', 'vendorContacts');
    }
  }

  @override
  VendorEntity rebuild(void updates(VendorEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorEntityBuilder toBuilder() => new VendorEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VendorEntity &&
        name == other.name &&
        balance == other.balance &&
        paidToDate == other.paidToDate &&
        address1 == other.address1 &&
        address2 == other.address2 &&
        city == other.city &&
        state == other.state &&
        postalCode == other.postalCode &&
        countryId == other.countryId &&
        workPhone == other.workPhone &&
        privateNotes == other.privateNotes &&
        lastLogin == other.lastLogin &&
        website == other.website &&
        vatNumber == other.vatNumber &&
        idNumber == other.idNumber &&
        currencyId == other.currencyId &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        vendorContacts == other.vendorContacts &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        isOwner == other.isOwner &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
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
                                                                            $jc($jc($jc($jc($jc($jc($jc(0, name.hashCode), balance.hashCode), paidToDate.hashCode), address1.hashCode), address2.hashCode), city.hashCode),
                                                                                state.hashCode),
                                                                            postalCode.hashCode),
                                                                        countryId.hashCode),
                                                                    workPhone.hashCode),
                                                                privateNotes.hashCode),
                                                            lastLogin.hashCode),
                                                        website.hashCode),
                                                    vatNumber.hashCode),
                                                idNumber.hashCode),
                                            currencyId.hashCode),
                                        customValue1.hashCode),
                                    customValue2.hashCode),
                                vendorContacts.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VendorEntity')
          ..add('name', name)
          ..add('balance', balance)
          ..add('paidToDate', paidToDate)
          ..add('address1', address1)
          ..add('address2', address2)
          ..add('city', city)
          ..add('state', state)
          ..add('postalCode', postalCode)
          ..add('countryId', countryId)
          ..add('workPhone', workPhone)
          ..add('privateNotes', privateNotes)
          ..add('lastLogin', lastLogin)
          ..add('website', website)
          ..add('vatNumber', vatNumber)
          ..add('idNumber', idNumber)
          ..add('currencyId', currencyId)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('vendorContacts', vendorContacts)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
          ..add('id', id))
        .toString();
  }
}

class VendorEntityBuilder
    implements Builder<VendorEntity, VendorEntityBuilder> {
  _$VendorEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  double _balance;
  double get balance => _$this._balance;
  set balance(double balance) => _$this._balance = balance;

  double _paidToDate;
  double get paidToDate => _$this._paidToDate;
  set paidToDate(double paidToDate) => _$this._paidToDate = paidToDate;

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

  int _countryId;
  int get countryId => _$this._countryId;
  set countryId(int countryId) => _$this._countryId = countryId;

  String _workPhone;
  String get workPhone => _$this._workPhone;
  set workPhone(String workPhone) => _$this._workPhone = workPhone;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

  String _lastLogin;
  String get lastLogin => _$this._lastLogin;
  set lastLogin(String lastLogin) => _$this._lastLogin = lastLogin;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  String _vatNumber;
  String get vatNumber => _$this._vatNumber;
  set vatNumber(String vatNumber) => _$this._vatNumber = vatNumber;

  String _idNumber;
  String get idNumber => _$this._idNumber;
  set idNumber(String idNumber) => _$this._idNumber = idNumber;

  int _currencyId;
  int get currencyId => _$this._currencyId;
  set currencyId(int currencyId) => _$this._currencyId = currencyId;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  ListBuilder<VendorContactEntity> _vendorContacts;
  ListBuilder<VendorContactEntity> get vendorContacts =>
      _$this._vendorContacts ??= new ListBuilder<VendorContactEntity>();
  set vendorContacts(ListBuilder<VendorContactEntity> vendorContacts) =>
      _$this._vendorContacts = vendorContacts;

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

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  VendorEntityBuilder();

  VendorEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _balance = _$v.balance;
      _paidToDate = _$v.paidToDate;
      _address1 = _$v.address1;
      _address2 = _$v.address2;
      _city = _$v.city;
      _state = _$v.state;
      _postalCode = _$v.postalCode;
      _countryId = _$v.countryId;
      _workPhone = _$v.workPhone;
      _privateNotes = _$v.privateNotes;
      _lastLogin = _$v.lastLogin;
      _website = _$v.website;
      _vatNumber = _$v.vatNumber;
      _idNumber = _$v.idNumber;
      _currencyId = _$v.currencyId;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _vendorContacts = _$v.vendorContacts?.toBuilder();
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _isOwner = _$v.isOwner;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VendorEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VendorEntity;
  }

  @override
  void update(void updates(VendorEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$VendorEntity build() {
    _$VendorEntity _$result;
    try {
      _$result = _$v ??
          new _$VendorEntity._(
              name: name,
              balance: balance,
              paidToDate: paidToDate,
              address1: address1,
              address2: address2,
              city: city,
              state: state,
              postalCode: postalCode,
              countryId: countryId,
              workPhone: workPhone,
              privateNotes: privateNotes,
              lastLogin: lastLogin,
              website: website,
              vatNumber: vatNumber,
              idNumber: idNumber,
              currencyId: currencyId,
              customValue1: customValue1,
              customValue2: customValue2,
              vendorContacts: vendorContacts.build(),
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              isOwner: isOwner,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'vendorContacts';
        vendorContacts.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'VendorEntity', _$failedField, e.toString());
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
  final String phone;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final bool isOwner;
  @override
  final int id;

  factory _$VendorContactEntity([void updates(VendorContactEntityBuilder b)]) =>
      (new VendorContactEntityBuilder()..update(updates)).build();

  _$VendorContactEntity._(
      {this.firstName,
      this.lastName,
      this.email,
      this.isPrimary,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
      : super._() {
    if (firstName == null) {
      throw new BuiltValueNullFieldError('VendorContactEntity', 'firstName');
    }
    if (lastName == null) {
      throw new BuiltValueNullFieldError('VendorContactEntity', 'lastName');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('VendorContactEntity', 'email');
    }
    if (isPrimary == null) {
      throw new BuiltValueNullFieldError('VendorContactEntity', 'isPrimary');
    }
    if (phone == null) {
      throw new BuiltValueNullFieldError('VendorContactEntity', 'phone');
    }
  }

  @override
  VendorContactEntity rebuild(void updates(VendorContactEntityBuilder b)) =>
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
        phone == other.phone &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        isOwner == other.isOwner &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, firstName.hashCode),
                                            lastName.hashCode),
                                        email.hashCode),
                                    isPrimary.hashCode),
                                phone.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VendorContactEntity')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('isPrimary', isPrimary)
          ..add('phone', phone)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
          ..add('id', id))
        .toString();
  }
}

class VendorContactEntityBuilder
    implements Builder<VendorContactEntity, VendorContactEntityBuilder> {
  _$VendorContactEntity _$v;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  bool _isPrimary;
  bool get isPrimary => _$this._isPrimary;
  set isPrimary(bool isPrimary) => _$this._isPrimary = isPrimary;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

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

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  VendorContactEntityBuilder();

  VendorContactEntityBuilder get _$this {
    if (_$v != null) {
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _email = _$v.email;
      _isPrimary = _$v.isPrimary;
      _phone = _$v.phone;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _isOwner = _$v.isOwner;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VendorContactEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VendorContactEntity;
  }

  @override
  void update(void updates(VendorContactEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$VendorContactEntity build() {
    final _$result = _$v ??
        new _$VendorContactEntity._(
            firstName: firstName,
            lastName: lastName,
            email: email,
            isPrimary: isPrimary,
            phone: phone,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            isOwner: isOwner,
            id: id);
    replace(_$result);
    return _$result;
  }
}
