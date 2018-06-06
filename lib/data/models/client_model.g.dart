// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<ClientListResponse> _$clientListResponseSerializer =
    new _$ClientListResponseSerializer();
Serializer<ClientItemResponse> _$clientItemResponseSerializer =
    new _$ClientItemResponseSerializer();
Serializer<ClientEntity> _$clientEntitySerializer =
    new _$ClientEntitySerializer();

class _$ClientListResponseSerializer
    implements StructuredSerializer<ClientListResponse> {
  @override
  final Iterable<Type> types = const [ClientListResponse, _$ClientListResponse];
  @override
  final String wireName = 'ClientListResponse';

  @override
  Iterable serialize(Serializers serializers, ClientListResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ClientEntity)])),
    ];

    return result;
  }

  @override
  ClientListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
              as BuiltList);
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
  Iterable serialize(Serializers serializers, ClientItemResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ClientEntity)),
    ];

    return result;
  }

  @override
  ClientItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
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
  Iterable serialize(Serializers serializers, ClientEntity object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.displayName != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(object.displayName,
            specifiedType: const FullType(String)));
    }
    if (object.balance != null) {
      result
        ..add('balance')
        ..add(serializers.serialize(object.balance,
            specifiedType: const FullType(double)));
    }
    if (object.paidToDate != null) {
      result
        ..add('paid_to_date')
        ..add(serializers.serialize(object.paidToDate,
            specifiedType: const FullType(double)));
    }
    if (object.address1 != null) {
      result
        ..add('address1')
        ..add(serializers.serialize(object.address1,
            specifiedType: const FullType(String)));
    }
    if (object.address2 != null) {
      result
        ..add('address2')
        ..add(serializers.serialize(object.address2,
            specifiedType: const FullType(String)));
    }
    if (object.city != null) {
      result
        ..add('city')
        ..add(serializers.serialize(object.city,
            specifiedType: const FullType(String)));
    }
    if (object.state != null) {
      result
        ..add('state')
        ..add(serializers.serialize(object.state,
            specifiedType: const FullType(String)));
    }
    if (object.postalCode != null) {
      result
        ..add('postal_code')
        ..add(serializers.serialize(object.postalCode,
            specifiedType: const FullType(String)));
    }
    if (object.countryId != null) {
      result
        ..add('country_id')
        ..add(serializers.serialize(object.countryId,
            specifiedType: const FullType(int)));
    }
    if (object.workPhone != null) {
      result
        ..add('work_phone')
        ..add(serializers.serialize(object.workPhone,
            specifiedType: const FullType(String)));
    }
    if (object.privateNotes != null) {
      result
        ..add('private_notes')
        ..add(serializers.serialize(object.privateNotes,
            specifiedType: const FullType(String)));
    }
    if (object.publicNotes != null) {
      result
        ..add('public_notes')
        ..add(serializers.serialize(object.publicNotes,
            specifiedType: const FullType(String)));
    }
    if (object.website != null) {
      result
        ..add('website')
        ..add(serializers.serialize(object.website,
            specifiedType: const FullType(String)));
    }
    if (object.industryId != null) {
      result
        ..add('industry_id')
        ..add(serializers.serialize(object.industryId,
            specifiedType: const FullType(int)));
    }
    if (object.sizeId != null) {
      result
        ..add('size_id')
        ..add(serializers.serialize(object.sizeId,
            specifiedType: const FullType(int)));
    }
    if (object.paymentTerms != null) {
      result
        ..add('payment_terms')
        ..add(serializers.serialize(object.paymentTerms,
            specifiedType: const FullType(int)));
    }
    if (object.vatNumber != null) {
      result
        ..add('vat_number')
        ..add(serializers.serialize(object.vatNumber,
            specifiedType: const FullType(String)));
    }
    if (object.idNumber != null) {
      result
        ..add('id_number')
        ..add(serializers.serialize(object.idNumber,
            specifiedType: const FullType(String)));
    }
    if (object.languageId != null) {
      result
        ..add('language_id')
        ..add(serializers.serialize(object.languageId,
            specifiedType: const FullType(int)));
    }
    if (object.currencyId != null) {
      result
        ..add('currency_id')
        ..add(serializers.serialize(object.currencyId,
            specifiedType: const FullType(int)));
    }
    if (object.invoiceNumberCounter != null) {
      result
        ..add('invoice_number_counter')
        ..add(serializers.serialize(object.invoiceNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.quoteNumberCounter != null) {
      result
        ..add('quote_number_counter')
        ..add(serializers.serialize(object.quoteNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.taskRate != null) {
      result
        ..add('task_rate')
        ..add(serializers.serialize(object.taskRate,
            specifiedType: const FullType(double)));
    }
    if (object.shippingAddress1 != null) {
      result
        ..add('shipping_address1')
        ..add(serializers.serialize(object.shippingAddress1,
            specifiedType: const FullType(String)));
    }
    if (object.shippingAddress2 != null) {
      result
        ..add('shipping_address2')
        ..add(serializers.serialize(object.shippingAddress2,
            specifiedType: const FullType(String)));
    }
    if (object.shippingCity != null) {
      result
        ..add('shipping_city')
        ..add(serializers.serialize(object.shippingCity,
            specifiedType: const FullType(String)));
    }
    if (object.shippingState != null) {
      result
        ..add('shipping_state')
        ..add(serializers.serialize(object.shippingState,
            specifiedType: const FullType(String)));
    }
    if (object.shippingPostalCode != null) {
      result
        ..add('shipping_postal_code')
        ..add(serializers.serialize(object.shippingPostalCode,
            specifiedType: const FullType(String)));
    }
    if (object.shippingCountryId != null) {
      result
        ..add('shipping_country_id')
        ..add(serializers.serialize(object.shippingCountryId,
            specifiedType: const FullType(int)));
    }
    if (object.showTasksInPortal != null) {
      result
        ..add('show_tasks_in_portal')
        ..add(serializers.serialize(object.showTasksInPortal,
            specifiedType: const FullType(bool)));
    }
    if (object.sendReminders != null) {
      result
        ..add('send_reminders')
        ..add(serializers.serialize(object.sendReminders,
            specifiedType: const FullType(bool)));
    }
    if (object.creditNumberCounter != null) {
      result
        ..add('credit_number_counter')
        ..add(serializers.serialize(object.creditNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.customValue1 != null) {
      result
        ..add('custom_value1')
        ..add(serializers.serialize(object.customValue1,
            specifiedType: const FullType(String)));
    }
    if (object.customValue2 != null) {
      result
        ..add('custom_value2')
        ..add(serializers.serialize(object.customValue2,
            specifiedType: const FullType(String)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
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

    return result;
  }

  @override
  ClientEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ClientEntityBuilder();

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
        case 'display_name':
          result.displayName = serializers.deserialize(value,
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
              specifiedType: const FullType(int)) as int;
          break;
        case 'size_id':
          result.sizeId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'payment_terms':
          result.paymentTerms = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'vat_number':
          result.vatNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id_number':
          result.idNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'language_id':
          result.languageId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_number_counter':
          result.invoiceNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'quote_number_counter':
          result.quoteNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'task_rate':
          result.taskRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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
              specifiedType: const FullType(int)) as int;
          break;
        case 'show_tasks_in_portal':
          result.showTasksInPortal = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'send_reminders':
          result.sendReminders = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'credit_number_counter':
          result.creditNumberCounter = serializers.deserialize(value,
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
        case 'id':
          result.id = serializers.deserialize(value,
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
      }
    }

    return result.build();
  }
}

class _$ClientListResponse extends ClientListResponse {
  @override
  final BuiltList<ClientEntity> data;

  factory _$ClientListResponse([void updates(ClientListResponseBuilder b)]) =>
      (new ClientListResponseBuilder()..update(updates)).build();

  _$ClientListResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('ClientListResponse', 'data');
  }

  @override
  ClientListResponse rebuild(void updates(ClientListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientListResponseBuilder toBuilder() =>
      new ClientListResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ClientListResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ClientListResponse;
  }

  @override
  void update(void updates(ClientListResponseBuilder b)) {
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

  factory _$ClientItemResponse([void updates(ClientItemResponseBuilder b)]) =>
      (new ClientItemResponseBuilder()..update(updates)).build();

  _$ClientItemResponse._({this.data}) : super._() {
    if (data == null)
      throw new BuiltValueNullFieldError('ClientItemResponse', 'data');
  }

  @override
  ClientItemResponse rebuild(void updates(ClientItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientItemResponseBuilder toBuilder() =>
      new ClientItemResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ClientItemResponse) return false;
    return data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ClientItemResponse;
  }

  @override
  void update(void updates(ClientItemResponseBuilder b)) {
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
  final String name;
  @override
  final String displayName;
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
  final String publicNotes;
  @override
  final String website;
  @override
  final int industryId;
  @override
  final int sizeId;
  @override
  final int paymentTerms;
  @override
  final String vatNumber;
  @override
  final String idNumber;
  @override
  final int languageId;
  @override
  final int currencyId;
  @override
  final int invoiceNumberCounter;
  @override
  final int quoteNumberCounter;
  @override
  final double taskRate;
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
  final int shippingCountryId;
  @override
  final bool showTasksInPortal;
  @override
  final bool sendReminders;
  @override
  final int creditNumberCounter;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final int id;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;

  factory _$ClientEntity([void updates(ClientEntityBuilder b)]) =>
      (new ClientEntityBuilder()..update(updates)).build();

  _$ClientEntity._(
      {this.name,
      this.displayName,
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
      this.publicNotes,
      this.website,
      this.industryId,
      this.sizeId,
      this.paymentTerms,
      this.vatNumber,
      this.idNumber,
      this.languageId,
      this.currencyId,
      this.invoiceNumberCounter,
      this.quoteNumberCounter,
      this.taskRate,
      this.shippingAddress1,
      this.shippingAddress2,
      this.shippingCity,
      this.shippingState,
      this.shippingPostalCode,
      this.shippingCountryId,
      this.showTasksInPortal,
      this.sendReminders,
      this.creditNumberCounter,
      this.customValue1,
      this.customValue2,
      this.id,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted})
      : super._();

  @override
  ClientEntity rebuild(void updates(ClientEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientEntityBuilder toBuilder() => new ClientEntityBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ClientEntity) return false;
    return name == other.name &&
        displayName == other.displayName &&
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
        publicNotes == other.publicNotes &&
        website == other.website &&
        industryId == other.industryId &&
        sizeId == other.sizeId &&
        paymentTerms == other.paymentTerms &&
        vatNumber == other.vatNumber &&
        idNumber == other.idNumber &&
        languageId == other.languageId &&
        currencyId == other.currencyId &&
        invoiceNumberCounter == other.invoiceNumberCounter &&
        quoteNumberCounter == other.quoteNumberCounter &&
        taskRate == other.taskRate &&
        shippingAddress1 == other.shippingAddress1 &&
        shippingAddress2 == other.shippingAddress2 &&
        shippingCity == other.shippingCity &&
        shippingState == other.shippingState &&
        shippingPostalCode == other.shippingPostalCode &&
        shippingCountryId == other.shippingCountryId &&
        showTasksInPortal == other.showTasksInPortal &&
        sendReminders == other.sendReminders &&
        creditNumberCounter == other.creditNumberCounter &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        id == other.id &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted;
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, name.hashCode), displayName.hashCode), balance.hashCode), paidToDate.hashCode), address1.hashCode), address2.hashCode), city.hashCode), state.hashCode), postalCode.hashCode), countryId.hashCode), workPhone.hashCode), privateNotes.hashCode), publicNotes.hashCode), website.hashCode), industryId.hashCode), sizeId.hashCode), paymentTerms.hashCode), vatNumber.hashCode), idNumber.hashCode), languageId.hashCode),
                                                                                currencyId.hashCode),
                                                                            invoiceNumberCounter.hashCode),
                                                                        quoteNumberCounter.hashCode),
                                                                    taskRate.hashCode),
                                                                shippingAddress1.hashCode),
                                                            shippingAddress2.hashCode),
                                                        shippingCity.hashCode),
                                                    shippingState.hashCode),
                                                shippingPostalCode.hashCode),
                                            shippingCountryId.hashCode),
                                        showTasksInPortal.hashCode),
                                    sendReminders.hashCode),
                                creditNumberCounter.hashCode),
                            customValue1.hashCode),
                        customValue2.hashCode),
                    id.hashCode),
                updatedAt.hashCode),
            archivedAt.hashCode),
        isDeleted.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ClientEntity')
          ..add('name', name)
          ..add('displayName', displayName)
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
          ..add('publicNotes', publicNotes)
          ..add('website', website)
          ..add('industryId', industryId)
          ..add('sizeId', sizeId)
          ..add('paymentTerms', paymentTerms)
          ..add('vatNumber', vatNumber)
          ..add('idNumber', idNumber)
          ..add('languageId', languageId)
          ..add('currencyId', currencyId)
          ..add('invoiceNumberCounter', invoiceNumberCounter)
          ..add('quoteNumberCounter', quoteNumberCounter)
          ..add('taskRate', taskRate)
          ..add('shippingAddress1', shippingAddress1)
          ..add('shippingAddress2', shippingAddress2)
          ..add('shippingCity', shippingCity)
          ..add('shippingState', shippingState)
          ..add('shippingPostalCode', shippingPostalCode)
          ..add('shippingCountryId', shippingCountryId)
          ..add('showTasksInPortal', showTasksInPortal)
          ..add('sendReminders', sendReminders)
          ..add('creditNumberCounter', creditNumberCounter)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('id', id)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted))
        .toString();
  }
}

class ClientEntityBuilder
    implements Builder<ClientEntity, ClientEntityBuilder> {
  _$ClientEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

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

  String _publicNotes;
  String get publicNotes => _$this._publicNotes;
  set publicNotes(String publicNotes) => _$this._publicNotes = publicNotes;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  int _industryId;
  int get industryId => _$this._industryId;
  set industryId(int industryId) => _$this._industryId = industryId;

  int _sizeId;
  int get sizeId => _$this._sizeId;
  set sizeId(int sizeId) => _$this._sizeId = sizeId;

  int _paymentTerms;
  int get paymentTerms => _$this._paymentTerms;
  set paymentTerms(int paymentTerms) => _$this._paymentTerms = paymentTerms;

  String _vatNumber;
  String get vatNumber => _$this._vatNumber;
  set vatNumber(String vatNumber) => _$this._vatNumber = vatNumber;

  String _idNumber;
  String get idNumber => _$this._idNumber;
  set idNumber(String idNumber) => _$this._idNumber = idNumber;

  int _languageId;
  int get languageId => _$this._languageId;
  set languageId(int languageId) => _$this._languageId = languageId;

  int _currencyId;
  int get currencyId => _$this._currencyId;
  set currencyId(int currencyId) => _$this._currencyId = currencyId;

  int _invoiceNumberCounter;
  int get invoiceNumberCounter => _$this._invoiceNumberCounter;
  set invoiceNumberCounter(int invoiceNumberCounter) =>
      _$this._invoiceNumberCounter = invoiceNumberCounter;

  int _quoteNumberCounter;
  int get quoteNumberCounter => _$this._quoteNumberCounter;
  set quoteNumberCounter(int quoteNumberCounter) =>
      _$this._quoteNumberCounter = quoteNumberCounter;

  double _taskRate;
  double get taskRate => _$this._taskRate;
  set taskRate(double taskRate) => _$this._taskRate = taskRate;

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

  int _shippingCountryId;
  int get shippingCountryId => _$this._shippingCountryId;
  set shippingCountryId(int shippingCountryId) =>
      _$this._shippingCountryId = shippingCountryId;

  bool _showTasksInPortal;
  bool get showTasksInPortal => _$this._showTasksInPortal;
  set showTasksInPortal(bool showTasksInPortal) =>
      _$this._showTasksInPortal = showTasksInPortal;

  bool _sendReminders;
  bool get sendReminders => _$this._sendReminders;
  set sendReminders(bool sendReminders) =>
      _$this._sendReminders = sendReminders;

  int _creditNumberCounter;
  int get creditNumberCounter => _$this._creditNumberCounter;
  set creditNumberCounter(int creditNumberCounter) =>
      _$this._creditNumberCounter = creditNumberCounter;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  ClientEntityBuilder();

  ClientEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _displayName = _$v.displayName;
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
      _publicNotes = _$v.publicNotes;
      _website = _$v.website;
      _industryId = _$v.industryId;
      _sizeId = _$v.sizeId;
      _paymentTerms = _$v.paymentTerms;
      _vatNumber = _$v.vatNumber;
      _idNumber = _$v.idNumber;
      _languageId = _$v.languageId;
      _currencyId = _$v.currencyId;
      _invoiceNumberCounter = _$v.invoiceNumberCounter;
      _quoteNumberCounter = _$v.quoteNumberCounter;
      _taskRate = _$v.taskRate;
      _shippingAddress1 = _$v.shippingAddress1;
      _shippingAddress2 = _$v.shippingAddress2;
      _shippingCity = _$v.shippingCity;
      _shippingState = _$v.shippingState;
      _shippingPostalCode = _$v.shippingPostalCode;
      _shippingCountryId = _$v.shippingCountryId;
      _showTasksInPortal = _$v.showTasksInPortal;
      _sendReminders = _$v.sendReminders;
      _creditNumberCounter = _$v.creditNumberCounter;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _id = _$v.id;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientEntity other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$ClientEntity;
  }

  @override
  void update(void updates(ClientEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ClientEntity build() {
    final _$result = _$v ??
        new _$ClientEntity._(
            name: name,
            displayName: displayName,
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
            publicNotes: publicNotes,
            website: website,
            industryId: industryId,
            sizeId: sizeId,
            paymentTerms: paymentTerms,
            vatNumber: vatNumber,
            idNumber: idNumber,
            languageId: languageId,
            currencyId: currencyId,
            invoiceNumberCounter: invoiceNumberCounter,
            quoteNumberCounter: quoteNumberCounter,
            taskRate: taskRate,
            shippingAddress1: shippingAddress1,
            shippingAddress2: shippingAddress2,
            shippingCity: shippingCity,
            shippingState: shippingState,
            shippingPostalCode: shippingPostalCode,
            shippingCountryId: shippingCountryId,
            showTasksInPortal: showTasksInPortal,
            sendReminders: sendReminders,
            creditNumberCounter: creditNumberCounter,
            customValue1: customValue1,
            customValue2: customValue2,
            id: id,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted);
    replace(_$result);
    return _$result;
  }
}
