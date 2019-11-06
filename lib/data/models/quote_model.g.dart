// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<QuoteListResponse> _$quoteListResponseSerializer =
    new _$QuoteListResponseSerializer();
Serializer<QuoteItemResponse> _$quoteItemResponseSerializer =
    new _$QuoteItemResponseSerializer();
Serializer<QuoteEntity> _$quoteEntitySerializer = new _$QuoteEntitySerializer();
Serializer<InvitationEntity> _$invitationEntitySerializer =
    new _$InvitationEntitySerializer();

class _$QuoteListResponseSerializer
    implements StructuredSerializer<QuoteListResponse> {
  @override
  final Iterable<Type> types = const [QuoteListResponse, _$QuoteListResponse];
  @override
  final String wireName = 'QuoteListResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, QuoteListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(QuoteEntity)])),
    ];

    return result;
  }

  @override
  QuoteListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuoteListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(QuoteEntity)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$QuoteItemResponseSerializer
    implements StructuredSerializer<QuoteItemResponse> {
  @override
  final Iterable<Type> types = const [QuoteItemResponse, _$QuoteItemResponse];
  @override
  final String wireName = 'QuoteItemResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, QuoteItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(QuoteEntity)),
    ];

    return result;
  }

  @override
  QuoteItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuoteItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(QuoteEntity)) as QuoteEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$QuoteEntitySerializer implements StructuredSerializer<QuoteEntity> {
  @override
  final Iterable<Type> types = const [QuoteEntity, _$QuoteEntity];
  @override
  final String wireName = 'QuoteEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, QuoteEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'balance',
      serializers.serialize(object.balance,
          specifiedType: const FullType(double)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
      'status_id',
      serializers.serialize(object.statusId,
          specifiedType: const FullType(String)),
      'discount',
      serializers.serialize(object.discount,
          specifiedType: const FullType(double)),
      'po_number',
      serializers.serialize(object.poNumber,
          specifiedType: const FullType(String)),
      'invoice_date',
      serializers.serialize(object.invoiceDate,
          specifiedType: const FullType(String)),
      'due_date',
      serializers.serialize(object.dueDate,
          specifiedType: const FullType(String)),
      'public_notes',
      serializers.serialize(object.publicNotes,
          specifiedType: const FullType(String)),
      'private_notes',
      serializers.serialize(object.privateNotes,
          specifiedType: const FullType(String)),
      'terms',
      serializers.serialize(object.terms,
          specifiedType: const FullType(String)),
      'footer',
      serializers.serialize(object.footer,
          specifiedType: const FullType(String)),
      'tax_name1',
      serializers.serialize(object.taxName1,
          specifiedType: const FullType(String)),
      'tax_rate1',
      serializers.serialize(object.taxRate1,
          specifiedType: const FullType(double)),
      'tax_name2',
      serializers.serialize(object.taxName2,
          specifiedType: const FullType(String)),
      'tax_rate2',
      serializers.serialize(object.taxRate2,
          specifiedType: const FullType(double)),
      'is_amount_discount',
      serializers.serialize(object.isAmountDiscount,
          specifiedType: const FullType(bool)),
      'partial',
      serializers.serialize(object.partial,
          specifiedType: const FullType(double)),
      'partial_due_date',
      serializers.serialize(object.partialDueDate,
          specifiedType: const FullType(String)),
      'has_tasks',
      serializers.serialize(object.hasTasks,
          specifiedType: const FullType(bool)),
      'auto_bill',
      serializers.serialize(object.autoBill,
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
      'custom_surcharge1',
      serializers.serialize(object.customSurcharge1,
          specifiedType: const FullType(double)),
      'custom_surcharge2',
      serializers.serialize(object.customSurcharge2,
          specifiedType: const FullType(double)),
      'custom_surcharge3',
      serializers.serialize(object.customSurcharge3,
          specifiedType: const FullType(double)),
      'custom_surcharge4',
      serializers.serialize(object.customSurcharge4,
          specifiedType: const FullType(double)),
      'custom_taxes1',
      serializers.serialize(object.customTaxes1,
          specifiedType: const FullType(bool)),
      'custom_taxes2',
      serializers.serialize(object.customTaxes2,
          specifiedType: const FullType(bool)),
      'custom_taxes3',
      serializers.serialize(object.customTaxes3,
          specifiedType: const FullType(bool)),
      'custom_taxes4',
      serializers.serialize(object.customTaxes4,
          specifiedType: const FullType(bool)),
      'has_expenses',
      serializers.serialize(object.hasExpenses,
          specifiedType: const FullType(bool)),
      'quote_invoice_id',
      serializers.serialize(object.quoteInvoiceId,
          specifiedType: const FullType(String)),
      'filename',
      serializers.serialize(object.filename,
          specifiedType: const FullType(String)),
      'settings',
      serializers.serialize(object.settings,
          specifiedType: const FullType(SettingsEntity)),
      'line_items',
      serializers.serialize(object.lineItems,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceItemEntity)])),
      'invitations',
      serializers.serialize(object.invitations,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvitationEntity)])),
    ];
    if (object.invoiceNumber != null) {
      result
        ..add('invoice_number')
        ..add(serializers.serialize(object.invoiceNumber,
            specifiedType: const FullType(String)));
    }
    if (object.designId != null) {
      result
        ..add('design_id')
        ..add(serializers.serialize(object.designId,
            specifiedType: const FullType(String)));
    }
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
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
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  QuoteEntity deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuoteEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status_id':
          result.statusId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_number':
          result.invoiceNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'discount':
          result.discount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'po_number':
          result.poNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_date':
          result.invoiceDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'due_date':
          result.dueDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'public_notes':
          result.publicNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'private_notes':
          result.privateNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'terms':
          result.terms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'footer':
          result.footer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'design_id':
          result.designId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_name1':
          result.taxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate1':
          result.taxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name2':
          result.taxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate2':
          result.taxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'is_amount_discount':
          result.isAmountDiscount = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'partial':
          result.partial = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'partial_due_date':
          result.partialDueDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'has_tasks':
          result.hasTasks = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_bill':
          result.autoBill = serializers.deserialize(value,
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
        case 'custom_surcharge1':
          result.customSurcharge1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'custom_surcharge2':
          result.customSurcharge2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'custom_surcharge3':
          result.customSurcharge3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'custom_surcharge4':
          result.customSurcharge4 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'custom_taxes1':
          result.customTaxes1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_taxes2':
          result.customTaxes2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_taxes3':
          result.customTaxes3 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'custom_taxes4':
          result.customTaxes4 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_expenses':
          result.hasExpenses = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'quote_invoice_id':
          result.quoteInvoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'filename':
          result.filename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'settings':
          result.settings.replace(serializers.deserialize(value,
              specifiedType: const FullType(SettingsEntity)) as SettingsEntity);
          break;
        case 'line_items':
          result.lineItems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceItemEntity)]))
              as BuiltList<dynamic>);
          break;
        case 'invitations':
          result.invitations.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvitationEntity)]))
              as BuiltList<dynamic>);
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

class _$InvitationEntitySerializer
    implements StructuredSerializer<InvitationEntity> {
  @override
  final Iterable<Type> types = const [InvitationEntity, _$InvitationEntity];
  @override
  final String wireName = 'InvitationEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, InvitationEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'key',
      serializers.serialize(object.key, specifiedType: const FullType(String)),
      'link',
      serializers.serialize(object.link, specifiedType: const FullType(String)),
      'sent_date',
      serializers.serialize(object.sentDate,
          specifiedType: const FullType(String)),
      'viewed_date',
      serializers.serialize(object.viewedDate,
          specifiedType: const FullType(String)),
    ];
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
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
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  InvitationEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvitationEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'key':
          result.key = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'link':
          result.link = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sent_date':
          result.sentDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'viewed_date':
          result.viewedDate = serializers.deserialize(value,
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

class _$QuoteListResponse extends QuoteListResponse {
  @override
  final BuiltList<QuoteEntity> data;

  factory _$QuoteListResponse(
          [void Function(QuoteListResponseBuilder) updates]) =>
      (new QuoteListResponseBuilder()..update(updates)).build();

  _$QuoteListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('QuoteListResponse', 'data');
    }
  }

  @override
  QuoteListResponse rebuild(void Function(QuoteListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuoteListResponseBuilder toBuilder() =>
      new QuoteListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuoteListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QuoteListResponse')..add('data', data))
        .toString();
  }
}

class QuoteListResponseBuilder
    implements Builder<QuoteListResponse, QuoteListResponseBuilder> {
  _$QuoteListResponse _$v;

  ListBuilder<QuoteEntity> _data;
  ListBuilder<QuoteEntity> get data =>
      _$this._data ??= new ListBuilder<QuoteEntity>();
  set data(ListBuilder<QuoteEntity> data) => _$this._data = data;

  QuoteListResponseBuilder();

  QuoteListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuoteListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QuoteListResponse;
  }

  @override
  void update(void Function(QuoteListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QuoteListResponse build() {
    _$QuoteListResponse _$result;
    try {
      _$result = _$v ?? new _$QuoteListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QuoteListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$QuoteItemResponse extends QuoteItemResponse {
  @override
  final QuoteEntity data;

  factory _$QuoteItemResponse(
          [void Function(QuoteItemResponseBuilder) updates]) =>
      (new QuoteItemResponseBuilder()..update(updates)).build();

  _$QuoteItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('QuoteItemResponse', 'data');
    }
  }

  @override
  QuoteItemResponse rebuild(void Function(QuoteItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuoteItemResponseBuilder toBuilder() =>
      new QuoteItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuoteItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QuoteItemResponse')..add('data', data))
        .toString();
  }
}

class QuoteItemResponseBuilder
    implements Builder<QuoteItemResponse, QuoteItemResponseBuilder> {
  _$QuoteItemResponse _$v;

  QuoteEntityBuilder _data;
  QuoteEntityBuilder get data => _$this._data ??= new QuoteEntityBuilder();
  set data(QuoteEntityBuilder data) => _$this._data = data;

  QuoteItemResponseBuilder();

  QuoteItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuoteItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QuoteItemResponse;
  }

  @override
  void update(void Function(QuoteItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QuoteItemResponse build() {
    _$QuoteItemResponse _$result;
    try {
      _$result = _$v ?? new _$QuoteItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QuoteItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$QuoteEntity extends QuoteEntity {
  @override
  final double amount;
  @override
  final double balance;
  @override
  final String clientId;
  @override
  final String statusId;
  @override
  final String invoiceNumber;
  @override
  final double discount;
  @override
  final String poNumber;
  @override
  final String invoiceDate;
  @override
  final String dueDate;
  @override
  final String publicNotes;
  @override
  final String privateNotes;
  @override
  final String terms;
  @override
  final String footer;
  @override
  final String designId;
  @override
  final String taxName1;
  @override
  final double taxRate1;
  @override
  final String taxName2;
  @override
  final double taxRate2;
  @override
  final bool isAmountDiscount;
  @override
  final double partial;
  @override
  final String partialDueDate;
  @override
  final bool hasTasks;
  @override
  final bool autoBill;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final double customSurcharge1;
  @override
  final double customSurcharge2;
  @override
  final double customSurcharge3;
  @override
  final double customSurcharge4;
  @override
  final bool customTaxes1;
  @override
  final bool customTaxes2;
  @override
  final bool customTaxes3;
  @override
  final bool customTaxes4;
  @override
  final bool hasExpenses;
  @override
  final String quoteInvoiceId;
  @override
  final String filename;
  @override
  final SettingsEntity settings;
  @override
  final BuiltList<InvoiceItemEntity> lineItems;
  @override
  final BuiltList<InvitationEntity> invitations;
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

  factory _$QuoteEntity([void Function(QuoteEntityBuilder) updates]) =>
      (new QuoteEntityBuilder()..update(updates)).build();

  _$QuoteEntity._(
      {this.amount,
      this.balance,
      this.clientId,
      this.statusId,
      this.invoiceNumber,
      this.discount,
      this.poNumber,
      this.invoiceDate,
      this.dueDate,
      this.publicNotes,
      this.privateNotes,
      this.terms,
      this.footer,
      this.designId,
      this.taxName1,
      this.taxRate1,
      this.taxName2,
      this.taxRate2,
      this.isAmountDiscount,
      this.partial,
      this.partialDueDate,
      this.hasTasks,
      this.autoBill,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.customSurcharge1,
      this.customSurcharge2,
      this.customSurcharge3,
      this.customSurcharge4,
      this.customTaxes1,
      this.customTaxes2,
      this.customTaxes3,
      this.customTaxes4,
      this.hasExpenses,
      this.quoteInvoiceId,
      this.filename,
      this.settings,
      this.lineItems,
      this.invitations,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (amount == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'amount');
    }
    if (balance == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'balance');
    }
    if (clientId == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'clientId');
    }
    if (statusId == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'statusId');
    }
    if (discount == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'discount');
    }
    if (poNumber == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'poNumber');
    }
    if (invoiceDate == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'invoiceDate');
    }
    if (dueDate == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'dueDate');
    }
    if (publicNotes == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'publicNotes');
    }
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'privateNotes');
    }
    if (terms == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'terms');
    }
    if (footer == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'footer');
    }
    if (taxName1 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'taxName1');
    }
    if (taxRate1 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'taxRate1');
    }
    if (taxName2 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'taxName2');
    }
    if (taxRate2 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'taxRate2');
    }
    if (isAmountDiscount == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'isAmountDiscount');
    }
    if (partial == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'partial');
    }
    if (partialDueDate == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'partialDueDate');
    }
    if (hasTasks == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'hasTasks');
    }
    if (autoBill == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'autoBill');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customValue4');
    }
    if (customSurcharge1 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customSurcharge1');
    }
    if (customSurcharge2 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customSurcharge2');
    }
    if (customSurcharge3 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customSurcharge3');
    }
    if (customSurcharge4 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customSurcharge4');
    }
    if (customTaxes1 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customTaxes1');
    }
    if (customTaxes2 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customTaxes2');
    }
    if (customTaxes3 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customTaxes3');
    }
    if (customTaxes4 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customTaxes4');
    }
    if (hasExpenses == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'hasExpenses');
    }
    if (quoteInvoiceId == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'quoteInvoiceId');
    }
    if (filename == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'filename');
    }
    if (settings == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'settings');
    }
    if (lineItems == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'lineItems');
    }
    if (invitations == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'invitations');
    }
  }

  @override
  QuoteEntity rebuild(void Function(QuoteEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuoteEntityBuilder toBuilder() => new QuoteEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuoteEntity &&
        amount == other.amount &&
        balance == other.balance &&
        clientId == other.clientId &&
        statusId == other.statusId &&
        invoiceNumber == other.invoiceNumber &&
        discount == other.discount &&
        poNumber == other.poNumber &&
        invoiceDate == other.invoiceDate &&
        dueDate == other.dueDate &&
        publicNotes == other.publicNotes &&
        privateNotes == other.privateNotes &&
        terms == other.terms &&
        footer == other.footer &&
        designId == other.designId &&
        taxName1 == other.taxName1 &&
        taxRate1 == other.taxRate1 &&
        taxName2 == other.taxName2 &&
        taxRate2 == other.taxRate2 &&
        isAmountDiscount == other.isAmountDiscount &&
        partial == other.partial &&
        partialDueDate == other.partialDueDate &&
        hasTasks == other.hasTasks &&
        autoBill == other.autoBill &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        customSurcharge1 == other.customSurcharge1 &&
        customSurcharge2 == other.customSurcharge2 &&
        customSurcharge3 == other.customSurcharge3 &&
        customSurcharge4 == other.customSurcharge4 &&
        customTaxes1 == other.customTaxes1 &&
        customTaxes2 == other.customTaxes2 &&
        customTaxes3 == other.customTaxes3 &&
        customTaxes4 == other.customTaxes4 &&
        hasExpenses == other.hasExpenses &&
        quoteInvoiceId == other.quoteInvoiceId &&
        filename == other.filename &&
        settings == other.settings &&
        lineItems == other.lineItems &&
        invitations == other.invitations &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, amount.hashCode), balance.hashCode), clientId.hashCode), statusId.hashCode), invoiceNumber.hashCode), discount.hashCode), poNumber.hashCode), invoiceDate.hashCode), dueDate.hashCode), publicNotes.hashCode), privateNotes.hashCode), terms.hashCode), footer.hashCode), designId.hashCode), taxName1.hashCode), taxRate1.hashCode), taxName2.hashCode), taxRate2.hashCode), isAmountDiscount.hashCode), partial.hashCode), partialDueDate.hashCode), hasTasks.hashCode), autoBill.hashCode), customValue1.hashCode), customValue2.hashCode), customValue3.hashCode), customValue4.hashCode), customSurcharge1.hashCode), customSurcharge2.hashCode), customSurcharge3.hashCode),
                                                                                customSurcharge4.hashCode),
                                                                            customTaxes1.hashCode),
                                                                        customTaxes2.hashCode),
                                                                    customTaxes3.hashCode),
                                                                customTaxes4.hashCode),
                                                            hasExpenses.hashCode),
                                                        quoteInvoiceId.hashCode),
                                                    filename.hashCode),
                                                settings.hashCode),
                                            lineItems.hashCode),
                                        invitations.hashCode),
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
    return (newBuiltValueToStringHelper('QuoteEntity')
          ..add('amount', amount)
          ..add('balance', balance)
          ..add('clientId', clientId)
          ..add('statusId', statusId)
          ..add('invoiceNumber', invoiceNumber)
          ..add('discount', discount)
          ..add('poNumber', poNumber)
          ..add('invoiceDate', invoiceDate)
          ..add('dueDate', dueDate)
          ..add('publicNotes', publicNotes)
          ..add('privateNotes', privateNotes)
          ..add('terms', terms)
          ..add('footer', footer)
          ..add('designId', designId)
          ..add('taxName1', taxName1)
          ..add('taxRate1', taxRate1)
          ..add('taxName2', taxName2)
          ..add('taxRate2', taxRate2)
          ..add('isAmountDiscount', isAmountDiscount)
          ..add('partial', partial)
          ..add('partialDueDate', partialDueDate)
          ..add('hasTasks', hasTasks)
          ..add('autoBill', autoBill)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('customSurcharge1', customSurcharge1)
          ..add('customSurcharge2', customSurcharge2)
          ..add('customSurcharge3', customSurcharge3)
          ..add('customSurcharge4', customSurcharge4)
          ..add('customTaxes1', customTaxes1)
          ..add('customTaxes2', customTaxes2)
          ..add('customTaxes3', customTaxes3)
          ..add('customTaxes4', customTaxes4)
          ..add('hasExpenses', hasExpenses)
          ..add('quoteInvoiceId', quoteInvoiceId)
          ..add('filename', filename)
          ..add('settings', settings)
          ..add('lineItems', lineItems)
          ..add('invitations', invitations)
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

class QuoteEntityBuilder implements Builder<QuoteEntity, QuoteEntityBuilder> {
  _$QuoteEntity _$v;

  double _amount;
  double get amount => _$this._amount;
  set amount(double amount) => _$this._amount = amount;

  double _balance;
  double get balance => _$this._balance;
  set balance(double balance) => _$this._balance = balance;

  String _clientId;
  String get clientId => _$this._clientId;
  set clientId(String clientId) => _$this._clientId = clientId;

  String _statusId;
  String get statusId => _$this._statusId;
  set statusId(String statusId) => _$this._statusId = statusId;

  String _invoiceNumber;
  String get invoiceNumber => _$this._invoiceNumber;
  set invoiceNumber(String invoiceNumber) =>
      _$this._invoiceNumber = invoiceNumber;

  double _discount;
  double get discount => _$this._discount;
  set discount(double discount) => _$this._discount = discount;

  String _poNumber;
  String get poNumber => _$this._poNumber;
  set poNumber(String poNumber) => _$this._poNumber = poNumber;

  String _invoiceDate;
  String get invoiceDate => _$this._invoiceDate;
  set invoiceDate(String invoiceDate) => _$this._invoiceDate = invoiceDate;

  String _dueDate;
  String get dueDate => _$this._dueDate;
  set dueDate(String dueDate) => _$this._dueDate = dueDate;

  String _publicNotes;
  String get publicNotes => _$this._publicNotes;
  set publicNotes(String publicNotes) => _$this._publicNotes = publicNotes;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

  String _terms;
  String get terms => _$this._terms;
  set terms(String terms) => _$this._terms = terms;

  String _footer;
  String get footer => _$this._footer;
  set footer(String footer) => _$this._footer = footer;

  String _designId;
  String get designId => _$this._designId;
  set designId(String designId) => _$this._designId = designId;

  String _taxName1;
  String get taxName1 => _$this._taxName1;
  set taxName1(String taxName1) => _$this._taxName1 = taxName1;

  double _taxRate1;
  double get taxRate1 => _$this._taxRate1;
  set taxRate1(double taxRate1) => _$this._taxRate1 = taxRate1;

  String _taxName2;
  String get taxName2 => _$this._taxName2;
  set taxName2(String taxName2) => _$this._taxName2 = taxName2;

  double _taxRate2;
  double get taxRate2 => _$this._taxRate2;
  set taxRate2(double taxRate2) => _$this._taxRate2 = taxRate2;

  bool _isAmountDiscount;
  bool get isAmountDiscount => _$this._isAmountDiscount;
  set isAmountDiscount(bool isAmountDiscount) =>
      _$this._isAmountDiscount = isAmountDiscount;

  double _partial;
  double get partial => _$this._partial;
  set partial(double partial) => _$this._partial = partial;

  String _partialDueDate;
  String get partialDueDate => _$this._partialDueDate;
  set partialDueDate(String partialDueDate) =>
      _$this._partialDueDate = partialDueDate;

  bool _hasTasks;
  bool get hasTasks => _$this._hasTasks;
  set hasTasks(bool hasTasks) => _$this._hasTasks = hasTasks;

  bool _autoBill;
  bool get autoBill => _$this._autoBill;
  set autoBill(bool autoBill) => _$this._autoBill = autoBill;

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

  double _customSurcharge1;
  double get customSurcharge1 => _$this._customSurcharge1;
  set customSurcharge1(double customSurcharge1) =>
      _$this._customSurcharge1 = customSurcharge1;

  double _customSurcharge2;
  double get customSurcharge2 => _$this._customSurcharge2;
  set customSurcharge2(double customSurcharge2) =>
      _$this._customSurcharge2 = customSurcharge2;

  double _customSurcharge3;
  double get customSurcharge3 => _$this._customSurcharge3;
  set customSurcharge3(double customSurcharge3) =>
      _$this._customSurcharge3 = customSurcharge3;

  double _customSurcharge4;
  double get customSurcharge4 => _$this._customSurcharge4;
  set customSurcharge4(double customSurcharge4) =>
      _$this._customSurcharge4 = customSurcharge4;

  bool _customTaxes1;
  bool get customTaxes1 => _$this._customTaxes1;
  set customTaxes1(bool customTaxes1) => _$this._customTaxes1 = customTaxes1;

  bool _customTaxes2;
  bool get customTaxes2 => _$this._customTaxes2;
  set customTaxes2(bool customTaxes2) => _$this._customTaxes2 = customTaxes2;

  bool _customTaxes3;
  bool get customTaxes3 => _$this._customTaxes3;
  set customTaxes3(bool customTaxes3) => _$this._customTaxes3 = customTaxes3;

  bool _customTaxes4;
  bool get customTaxes4 => _$this._customTaxes4;
  set customTaxes4(bool customTaxes4) => _$this._customTaxes4 = customTaxes4;

  bool _hasExpenses;
  bool get hasExpenses => _$this._hasExpenses;
  set hasExpenses(bool hasExpenses) => _$this._hasExpenses = hasExpenses;

  String _quoteInvoiceId;
  String get quoteInvoiceId => _$this._quoteInvoiceId;
  set quoteInvoiceId(String quoteInvoiceId) =>
      _$this._quoteInvoiceId = quoteInvoiceId;

  String _filename;
  String get filename => _$this._filename;
  set filename(String filename) => _$this._filename = filename;

  SettingsEntityBuilder _settings;
  SettingsEntityBuilder get settings =>
      _$this._settings ??= new SettingsEntityBuilder();
  set settings(SettingsEntityBuilder settings) => _$this._settings = settings;

  ListBuilder<InvoiceItemEntity> _lineItems;
  ListBuilder<InvoiceItemEntity> get lineItems =>
      _$this._lineItems ??= new ListBuilder<InvoiceItemEntity>();
  set lineItems(ListBuilder<InvoiceItemEntity> lineItems) =>
      _$this._lineItems = lineItems;

  ListBuilder<InvitationEntity> _invitations;
  ListBuilder<InvitationEntity> get invitations =>
      _$this._invitations ??= new ListBuilder<InvitationEntity>();
  set invitations(ListBuilder<InvitationEntity> invitations) =>
      _$this._invitations = invitations;

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

  QuoteEntityBuilder();

  QuoteEntityBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _balance = _$v.balance;
      _clientId = _$v.clientId;
      _statusId = _$v.statusId;
      _invoiceNumber = _$v.invoiceNumber;
      _discount = _$v.discount;
      _poNumber = _$v.poNumber;
      _invoiceDate = _$v.invoiceDate;
      _dueDate = _$v.dueDate;
      _publicNotes = _$v.publicNotes;
      _privateNotes = _$v.privateNotes;
      _terms = _$v.terms;
      _footer = _$v.footer;
      _designId = _$v.designId;
      _taxName1 = _$v.taxName1;
      _taxRate1 = _$v.taxRate1;
      _taxName2 = _$v.taxName2;
      _taxRate2 = _$v.taxRate2;
      _isAmountDiscount = _$v.isAmountDiscount;
      _partial = _$v.partial;
      _partialDueDate = _$v.partialDueDate;
      _hasTasks = _$v.hasTasks;
      _autoBill = _$v.autoBill;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _customSurcharge1 = _$v.customSurcharge1;
      _customSurcharge2 = _$v.customSurcharge2;
      _customSurcharge3 = _$v.customSurcharge3;
      _customSurcharge4 = _$v.customSurcharge4;
      _customTaxes1 = _$v.customTaxes1;
      _customTaxes2 = _$v.customTaxes2;
      _customTaxes3 = _$v.customTaxes3;
      _customTaxes4 = _$v.customTaxes4;
      _hasExpenses = _$v.hasExpenses;
      _quoteInvoiceId = _$v.quoteInvoiceId;
      _filename = _$v.filename;
      _settings = _$v.settings?.toBuilder();
      _lineItems = _$v.lineItems?.toBuilder();
      _invitations = _$v.invitations?.toBuilder();
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
  void replace(QuoteEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QuoteEntity;
  }

  @override
  void update(void Function(QuoteEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QuoteEntity build() {
    _$QuoteEntity _$result;
    try {
      _$result = _$v ??
          new _$QuoteEntity._(
              amount: amount,
              balance: balance,
              clientId: clientId,
              statusId: statusId,
              invoiceNumber: invoiceNumber,
              discount: discount,
              poNumber: poNumber,
              invoiceDate: invoiceDate,
              dueDate: dueDate,
              publicNotes: publicNotes,
              privateNotes: privateNotes,
              terms: terms,
              footer: footer,
              designId: designId,
              taxName1: taxName1,
              taxRate1: taxRate1,
              taxName2: taxName2,
              taxRate2: taxRate2,
              isAmountDiscount: isAmountDiscount,
              partial: partial,
              partialDueDate: partialDueDate,
              hasTasks: hasTasks,
              autoBill: autoBill,
              customValue1: customValue1,
              customValue2: customValue2,
              customValue3: customValue3,
              customValue4: customValue4,
              customSurcharge1: customSurcharge1,
              customSurcharge2: customSurcharge2,
              customSurcharge3: customSurcharge3,
              customSurcharge4: customSurcharge4,
              customTaxes1: customTaxes1,
              customTaxes2: customTaxes2,
              customTaxes3: customTaxes3,
              customTaxes4: customTaxes4,
              hasExpenses: hasExpenses,
              quoteInvoiceId: quoteInvoiceId,
              filename: filename,
              settings: settings.build(),
              lineItems: lineItems.build(),
              invitations: invitations.build(),
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
        _$failedField = 'lineItems';
        lineItems.build();
        _$failedField = 'invitations';
        invitations.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QuoteEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvitationEntity extends InvitationEntity {
  @override
  final String key;
  @override
  final String link;
  @override
  final String sentDate;
  @override
  final String viewedDate;
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

  factory _$InvitationEntity(
          [void Function(InvitationEntityBuilder) updates]) =>
      (new InvitationEntityBuilder()..update(updates)).build();

  _$InvitationEntity._(
      {this.key,
      this.link,
      this.sentDate,
      this.viewedDate,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.id})
      : super._() {
    if (key == null) {
      throw new BuiltValueNullFieldError('InvitationEntity', 'key');
    }
    if (link == null) {
      throw new BuiltValueNullFieldError('InvitationEntity', 'link');
    }
    if (sentDate == null) {
      throw new BuiltValueNullFieldError('InvitationEntity', 'sentDate');
    }
    if (viewedDate == null) {
      throw new BuiltValueNullFieldError('InvitationEntity', 'viewedDate');
    }
  }

  @override
  InvitationEntity rebuild(void Function(InvitationEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvitationEntityBuilder toBuilder() =>
      new InvitationEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvitationEntity &&
        key == other.key &&
        link == other.link &&
        sentDate == other.sentDate &&
        viewedDate == other.viewedDate &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
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
                                            $jc($jc(0, key.hashCode),
                                                link.hashCode),
                                            sentDate.hashCode),
                                        viewedDate.hashCode),
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
    return (newBuiltValueToStringHelper('InvitationEntity')
          ..add('key', key)
          ..add('link', link)
          ..add('sentDate', sentDate)
          ..add('viewedDate', viewedDate)
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

class InvitationEntityBuilder
    implements Builder<InvitationEntity, InvitationEntityBuilder> {
  _$InvitationEntity _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _link;
  String get link => _$this._link;
  set link(String link) => _$this._link = link;

  String _sentDate;
  String get sentDate => _$this._sentDate;
  set sentDate(String sentDate) => _$this._sentDate = sentDate;

  String _viewedDate;
  String get viewedDate => _$this._viewedDate;
  set viewedDate(String viewedDate) => _$this._viewedDate = viewedDate;

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

  InvitationEntityBuilder();

  InvitationEntityBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _link = _$v.link;
      _sentDate = _$v.sentDate;
      _viewedDate = _$v.viewedDate;
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
  void replace(InvitationEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvitationEntity;
  }

  @override
  void update(void Function(InvitationEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvitationEntity build() {
    final _$result = _$v ??
        new _$InvitationEntity._(
            key: key,
            link: link,
            sentDate: sentDate,
            viewedDate: viewedDate,
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
