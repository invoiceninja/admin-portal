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
      'invoice_status_id',
      serializers.serialize(object.invoiceStatusId,
          specifiedType: const FullType(String)),
      'invoice_number',
      serializers.serialize(object.invoiceNumber,
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
          specifiedType: const FullType(double)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(double)),
      'custom_taxes1',
      serializers.serialize(object.customTaxes1,
          specifiedType: const FullType(bool)),
      'custom_taxes2',
      serializers.serialize(object.customTaxes2,
          specifiedType: const FullType(bool)),
      'has_expenses',
      serializers.serialize(object.hasExpenses,
          specifiedType: const FullType(bool)),
      'quote_invoice_id',
      serializers.serialize(object.quoteInvoiceId,
          specifiedType: const FullType(String)),
      'custom_text_value1',
      serializers.serialize(object.customTextValue1,
          specifiedType: const FullType(String)),
      'custom_text_value2',
      serializers.serialize(object.customTextValue2,
          specifiedType: const FullType(String)),
      'filename',
      serializers.serialize(object.filename,
          specifiedType: const FullType(String)),
      'settings',
      serializers.serialize(object.settings,
          specifiedType: const FullType(SettingsEntity)),
      'invoice_items',
      serializers.serialize(object.invoiceItems,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceItemEntity)])),
      'invitations',
      serializers.serialize(object.invitations,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvitationEntity)])),
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
        case 'invoice_status_id':
          result.invoiceStatusId = serializers.deserialize(value,
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
              specifiedType: const FullType(double)) as double;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
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
        case 'has_expenses':
          result.hasExpenses = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'quote_invoice_id':
          result.quoteInvoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_text_value1':
          result.customTextValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_text_value2':
          result.customTextValue2 = serializers.deserialize(value,
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
        case 'invoice_items':
          result.invoiceItems.replace(serializers.deserialize(value,
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
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
  final String invoiceStatusId;
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
  final double customValue1;
  @override
  final double customValue2;
  @override
  final bool customTaxes1;
  @override
  final bool customTaxes2;
  @override
  final bool hasExpenses;
  @override
  final String quoteInvoiceId;
  @override
  final String customTextValue1;
  @override
  final String customTextValue2;
  @override
  final String filename;
  @override
  final SettingsEntity settings;
  @override
  final BuiltList<InvoiceItemEntity> invoiceItems;
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
  final bool isOwner;
  @override
  final String id;

  factory _$QuoteEntity([void Function(QuoteEntityBuilder) updates]) =>
      (new QuoteEntityBuilder()..update(updates)).build();

  _$QuoteEntity._(
      {this.amount,
      this.balance,
      this.clientId,
      this.invoiceStatusId,
      this.invoiceNumber,
      this.discount,
      this.poNumber,
      this.invoiceDate,
      this.dueDate,
      this.publicNotes,
      this.privateNotes,
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
      this.customTaxes1,
      this.customTaxes2,
      this.hasExpenses,
      this.quoteInvoiceId,
      this.customTextValue1,
      this.customTextValue2,
      this.filename,
      this.settings,
      this.invoiceItems,
      this.invitations,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
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
    if (invoiceStatusId == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'invoiceStatusId');
    }
    if (invoiceNumber == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'invoiceNumber');
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
    if (customTaxes1 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customTaxes1');
    }
    if (customTaxes2 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customTaxes2');
    }
    if (hasExpenses == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'hasExpenses');
    }
    if (quoteInvoiceId == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'quoteInvoiceId');
    }
    if (customTextValue1 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customTextValue1');
    }
    if (customTextValue2 == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'customTextValue2');
    }
    if (filename == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'filename');
    }
    if (settings == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'settings');
    }
    if (invoiceItems == null) {
      throw new BuiltValueNullFieldError('QuoteEntity', 'invoiceItems');
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
        invoiceStatusId == other.invoiceStatusId &&
        invoiceNumber == other.invoiceNumber &&
        discount == other.discount &&
        poNumber == other.poNumber &&
        invoiceDate == other.invoiceDate &&
        dueDate == other.dueDate &&
        publicNotes == other.publicNotes &&
        privateNotes == other.privateNotes &&
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
        customTaxes1 == other.customTaxes1 &&
        customTaxes2 == other.customTaxes2 &&
        hasExpenses == other.hasExpenses &&
        quoteInvoiceId == other.quoteInvoiceId &&
        customTextValue1 == other.customTextValue1 &&
        customTextValue2 == other.customTextValue2 &&
        filename == other.filename &&
        settings == other.settings &&
        invoiceItems == other.invoiceItems &&
        invitations == other.invitations &&
        isChanged == other.isChanged &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, amount.hashCode), balance.hashCode), clientId.hashCode), invoiceStatusId.hashCode), invoiceNumber.hashCode), discount.hashCode), poNumber.hashCode), invoiceDate.hashCode), dueDate.hashCode), publicNotes.hashCode), privateNotes.hashCode), taxName1.hashCode), taxRate1.hashCode), taxName2.hashCode), taxRate2.hashCode), isAmountDiscount.hashCode), partial.hashCode), partialDueDate.hashCode), hasTasks.hashCode), autoBill.hashCode),
                                                                                customValue1.hashCode),
                                                                            customValue2.hashCode),
                                                                        customTaxes1.hashCode),
                                                                    customTaxes2.hashCode),
                                                                hasExpenses.hashCode),
                                                            quoteInvoiceId.hashCode),
                                                        customTextValue1.hashCode),
                                                    customTextValue2.hashCode),
                                                filename.hashCode),
                                            settings.hashCode),
                                        invoiceItems.hashCode),
                                    invitations.hashCode),
                                isChanged.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QuoteEntity')
          ..add('amount', amount)
          ..add('balance', balance)
          ..add('clientId', clientId)
          ..add('invoiceStatusId', invoiceStatusId)
          ..add('invoiceNumber', invoiceNumber)
          ..add('discount', discount)
          ..add('poNumber', poNumber)
          ..add('invoiceDate', invoiceDate)
          ..add('dueDate', dueDate)
          ..add('publicNotes', publicNotes)
          ..add('privateNotes', privateNotes)
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
          ..add('customTaxes1', customTaxes1)
          ..add('customTaxes2', customTaxes2)
          ..add('hasExpenses', hasExpenses)
          ..add('quoteInvoiceId', quoteInvoiceId)
          ..add('customTextValue1', customTextValue1)
          ..add('customTextValue2', customTextValue2)
          ..add('filename', filename)
          ..add('settings', settings)
          ..add('invoiceItems', invoiceItems)
          ..add('invitations', invitations)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
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

  String _invoiceStatusId;
  String get invoiceStatusId => _$this._invoiceStatusId;
  set invoiceStatusId(String invoiceStatusId) =>
      _$this._invoiceStatusId = invoiceStatusId;

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

  double _customValue1;
  double get customValue1 => _$this._customValue1;
  set customValue1(double customValue1) => _$this._customValue1 = customValue1;

  double _customValue2;
  double get customValue2 => _$this._customValue2;
  set customValue2(double customValue2) => _$this._customValue2 = customValue2;

  bool _customTaxes1;
  bool get customTaxes1 => _$this._customTaxes1;
  set customTaxes1(bool customTaxes1) => _$this._customTaxes1 = customTaxes1;

  bool _customTaxes2;
  bool get customTaxes2 => _$this._customTaxes2;
  set customTaxes2(bool customTaxes2) => _$this._customTaxes2 = customTaxes2;

  bool _hasExpenses;
  bool get hasExpenses => _$this._hasExpenses;
  set hasExpenses(bool hasExpenses) => _$this._hasExpenses = hasExpenses;

  String _quoteInvoiceId;
  String get quoteInvoiceId => _$this._quoteInvoiceId;
  set quoteInvoiceId(String quoteInvoiceId) =>
      _$this._quoteInvoiceId = quoteInvoiceId;

  String _customTextValue1;
  String get customTextValue1 => _$this._customTextValue1;
  set customTextValue1(String customTextValue1) =>
      _$this._customTextValue1 = customTextValue1;

  String _customTextValue2;
  String get customTextValue2 => _$this._customTextValue2;
  set customTextValue2(String customTextValue2) =>
      _$this._customTextValue2 = customTextValue2;

  String _filename;
  String get filename => _$this._filename;
  set filename(String filename) => _$this._filename = filename;

  SettingsEntityBuilder _settings;
  SettingsEntityBuilder get settings =>
      _$this._settings ??= new SettingsEntityBuilder();
  set settings(SettingsEntityBuilder settings) => _$this._settings = settings;

  ListBuilder<InvoiceItemEntity> _invoiceItems;
  ListBuilder<InvoiceItemEntity> get invoiceItems =>
      _$this._invoiceItems ??= new ListBuilder<InvoiceItemEntity>();
  set invoiceItems(ListBuilder<InvoiceItemEntity> invoiceItems) =>
      _$this._invoiceItems = invoiceItems;

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

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  QuoteEntityBuilder();

  QuoteEntityBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _balance = _$v.balance;
      _clientId = _$v.clientId;
      _invoiceStatusId = _$v.invoiceStatusId;
      _invoiceNumber = _$v.invoiceNumber;
      _discount = _$v.discount;
      _poNumber = _$v.poNumber;
      _invoiceDate = _$v.invoiceDate;
      _dueDate = _$v.dueDate;
      _publicNotes = _$v.publicNotes;
      _privateNotes = _$v.privateNotes;
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
      _customTaxes1 = _$v.customTaxes1;
      _customTaxes2 = _$v.customTaxes2;
      _hasExpenses = _$v.hasExpenses;
      _quoteInvoiceId = _$v.quoteInvoiceId;
      _customTextValue1 = _$v.customTextValue1;
      _customTextValue2 = _$v.customTextValue2;
      _filename = _$v.filename;
      _settings = _$v.settings?.toBuilder();
      _invoiceItems = _$v.invoiceItems?.toBuilder();
      _invitations = _$v.invitations?.toBuilder();
      _isChanged = _$v.isChanged;
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
              invoiceStatusId: invoiceStatusId,
              invoiceNumber: invoiceNumber,
              discount: discount,
              poNumber: poNumber,
              invoiceDate: invoiceDate,
              dueDate: dueDate,
              publicNotes: publicNotes,
              privateNotes: privateNotes,
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
              customTaxes1: customTaxes1,
              customTaxes2: customTaxes2,
              hasExpenses: hasExpenses,
              quoteInvoiceId: quoteInvoiceId,
              customTextValue1: customTextValue1,
              customTextValue2: customTextValue2,
              filename: filename,
              settings: settings.build(),
              invoiceItems: invoiceItems.build(),
              invitations: invitations.build(),
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              isOwner: isOwner,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'settings';
        settings.build();
        _$failedField = 'invoiceItems';
        invoiceItems.build();
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
  final bool isOwner;
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
      this.isOwner,
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
                                        $jc($jc(0, key.hashCode),
                                            link.hashCode),
                                        sentDate.hashCode),
                                    viewedDate.hashCode),
                                isChanged.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
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
          ..add('isOwner', isOwner)
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

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

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
      _isOwner = _$v.isOwner;
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
            isOwner: isOwner,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
