// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InvoiceListResponse> _$invoiceListResponseSerializer =
    new _$InvoiceListResponseSerializer();
Serializer<InvoiceItemResponse> _$invoiceItemResponseSerializer =
    new _$InvoiceItemResponseSerializer();
Serializer<InvoiceEntity> _$invoiceEntitySerializer =
    new _$InvoiceEntitySerializer();
Serializer<InvoiceItemEntity> _$invoiceItemEntitySerializer =
    new _$InvoiceItemEntitySerializer();
Serializer<InvitationEntity> _$invitationEntitySerializer =
    new _$InvitationEntitySerializer();

class _$InvoiceListResponseSerializer
    implements StructuredSerializer<InvoiceListResponse> {
  @override
  final Iterable<Type> types = const [
    InvoiceListResponse,
    _$InvoiceListResponse
  ];
  @override
  final String wireName = 'InvoiceListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, InvoiceListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(InvoiceEntity)])),
    ];

    return result;
  }

  @override
  InvoiceListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$InvoiceItemResponseSerializer
    implements StructuredSerializer<InvoiceItemResponse> {
  @override
  final Iterable<Type> types = const [
    InvoiceItemResponse,
    _$InvoiceItemResponse
  ];
  @override
  final String wireName = 'InvoiceItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, InvoiceItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(InvoiceEntity)),
    ];

    return result;
  }

  @override
  InvoiceItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceEntity)) as InvoiceEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$InvoiceEntitySerializer implements StructuredSerializer<InvoiceEntity> {
  @override
  final Iterable<Type> types = const [InvoiceEntity, _$InvoiceEntity];
  @override
  final String wireName = 'InvoiceEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, InvoiceEntity object,
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
      'number',
      serializers.serialize(object.number,
          specifiedType: const FullType(String)),
      'discount',
      serializers.serialize(object.discount,
          specifiedType: const FullType(double)),
      'po_number',
      serializers.serialize(object.poNumber,
          specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
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
      'design_id',
      serializers.serialize(object.designId,
          specifiedType: const FullType(String)),
      'uses_inclusive_taxes',
      serializers.serialize(object.usesInclusiveTaxes,
          specifiedType: const FullType(bool)),
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
      'tax_name3',
      serializers.serialize(object.taxName3,
          specifiedType: const FullType(String)),
      'tax_rate3',
      serializers.serialize(object.taxRate3,
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
      'has_expenses',
      serializers.serialize(object.hasExpenses,
          specifiedType: const FullType(bool)),
      'line_items',
      serializers.serialize(object.lineItems,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceItemEntity)])),
      'invitations',
      serializers.serialize(object.invitations,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvitationEntity)])),
    ];
    if (object.autoBill != null) {
      result
        ..add('auto_bill')
        ..add(serializers.serialize(object.autoBill,
            specifiedType: const FullType(bool)));
    }
    if (object.customTaxes1 != null) {
      result
        ..add('custom_taxes1')
        ..add(serializers.serialize(object.customTaxes1,
            specifiedType: const FullType(bool)));
    }
    if (object.customTaxes2 != null) {
      result
        ..add('custom_taxes2')
        ..add(serializers.serialize(object.customTaxes2,
            specifiedType: const FullType(bool)));
    }
    if (object.customTaxes3 != null) {
      result
        ..add('custom_taxes3')
        ..add(serializers.serialize(object.customTaxes3,
            specifiedType: const FullType(bool)));
    }
    if (object.customTaxes4 != null) {
      result
        ..add('custom_taxes4')
        ..add(serializers.serialize(object.customTaxes4,
            specifiedType: const FullType(bool)));
    }
    if (object.invoiceId != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(object.invoiceId,
            specifiedType: const FullType(String)));
    }
    if (object.filename != null) {
      result
        ..add('filename')
        ..add(serializers.serialize(object.filename,
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
    if (object.subEntityType != null) {
      result
        ..add('entity_type')
        ..add(serializers.serialize(object.subEntityType,
            specifiedType: const FullType(EntityType)));
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
  InvoiceEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceEntityBuilder();

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
        case 'number':
          result.number = serializers.deserialize(value,
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
        case 'date':
          result.date = serializers.deserialize(value,
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
        case 'uses_inclusive_taxes':
          result.usesInclusiveTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
        case 'tax_name3':
          result.taxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate3':
          result.taxRate3 = serializers.deserialize(value,
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
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'filename':
          result.filename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'line_items':
          result.lineItems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceItemEntity)]))
              as BuiltList<Object>);
          break;
        case 'invitations':
          result.invitations.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvitationEntity)]))
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
        case 'entity_type':
          result.subEntityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
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

class _$InvoiceItemEntitySerializer
    implements StructuredSerializer<InvoiceItemEntity> {
  @override
  final Iterable<Type> types = const [InvoiceItemEntity, _$InvoiceItemEntity];
  @override
  final String wireName = 'InvoiceItemEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, InvoiceItemEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'product_key',
      serializers.serialize(object.productKey,
          specifiedType: const FullType(String)),
      'notes',
      serializers.serialize(object.notes,
          specifiedType: const FullType(String)),
      'cost',
      serializers.serialize(object.cost, specifiedType: const FullType(double)),
      'quantity',
      serializers.serialize(object.quantity,
          specifiedType: const FullType(double)),
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
      'tax_name3',
      serializers.serialize(object.taxName3,
          specifiedType: const FullType(String)),
      'tax_rate3',
      serializers.serialize(object.taxRate3,
          specifiedType: const FullType(double)),
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
      'discount',
      serializers.serialize(object.discount,
          specifiedType: const FullType(double)),
    ];
    if (object.typeId != null) {
      result
        ..add('type_id')
        ..add(serializers.serialize(object.typeId,
            specifiedType: const FullType(String)));
    }
    if (object.taskId != null) {
      result
        ..add('task_public_id')
        ..add(serializers.serialize(object.taskId,
            specifiedType: const FullType(String)));
    }
    if (object.expenseId != null) {
      result
        ..add('expense_public_id')
        ..add(serializers.serialize(object.expenseId,
            specifiedType: const FullType(String)));
    }
    if (object.createdAt != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  InvoiceItemEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceItemEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'product_key':
          result.productKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'notes':
          result.notes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cost':
          result.cost = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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
        case 'tax_name3':
          result.taxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate3':
          result.taxRate3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'type_id':
          result.typeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
        case 'discount':
          result.discount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'task_public_id':
          result.taskId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expense_public_id':
          result.expenseId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
      'client_contact_id',
      serializers.serialize(object.contactId,
          specifiedType: const FullType(String)),
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
    if (object.subEntityType != null) {
      result
        ..add('entity_type')
        ..add(serializers.serialize(object.subEntityType,
            specifiedType: const FullType(EntityType)));
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
        case 'client_contact_id':
          result.contactId = serializers.deserialize(value,
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
        case 'entity_type':
          result.subEntityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType;
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

class _$InvoiceListResponse extends InvoiceListResponse {
  @override
  final BuiltList<InvoiceEntity> data;

  factory _$InvoiceListResponse(
          [void Function(InvoiceListResponseBuilder) updates]) =>
      (new InvoiceListResponseBuilder()..update(updates)).build();

  _$InvoiceListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('InvoiceListResponse', 'data');
    }
  }

  @override
  InvoiceListResponse rebuild(
          void Function(InvoiceListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceListResponseBuilder toBuilder() =>
      new InvoiceListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceListResponse')
          ..add('data', data))
        .toString();
  }
}

class InvoiceListResponseBuilder
    implements Builder<InvoiceListResponse, InvoiceListResponseBuilder> {
  _$InvoiceListResponse _$v;

  ListBuilder<InvoiceEntity> _data;
  ListBuilder<InvoiceEntity> get data =>
      _$this._data ??= new ListBuilder<InvoiceEntity>();
  set data(ListBuilder<InvoiceEntity> data) => _$this._data = data;

  InvoiceListResponseBuilder();

  InvoiceListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceListResponse;
  }

  @override
  void update(void Function(InvoiceListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceListResponse build() {
    _$InvoiceListResponse _$result;
    try {
      _$result = _$v ?? new _$InvoiceListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvoiceListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceItemResponse extends InvoiceItemResponse {
  @override
  final InvoiceEntity data;

  factory _$InvoiceItemResponse(
          [void Function(InvoiceItemResponseBuilder) updates]) =>
      (new InvoiceItemResponseBuilder()..update(updates)).build();

  _$InvoiceItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('InvoiceItemResponse', 'data');
    }
  }

  @override
  InvoiceItemResponse rebuild(
          void Function(InvoiceItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceItemResponseBuilder toBuilder() =>
      new InvoiceItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceItemResponse')
          ..add('data', data))
        .toString();
  }
}

class InvoiceItemResponseBuilder
    implements Builder<InvoiceItemResponse, InvoiceItemResponseBuilder> {
  _$InvoiceItemResponse _$v;

  InvoiceEntityBuilder _data;
  InvoiceEntityBuilder get data => _$this._data ??= new InvoiceEntityBuilder();
  set data(InvoiceEntityBuilder data) => _$this._data = data;

  InvoiceItemResponseBuilder();

  InvoiceItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceItemResponse;
  }

  @override
  void update(void Function(InvoiceItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceItemResponse build() {
    _$InvoiceItemResponse _$result;
    try {
      _$result = _$v ?? new _$InvoiceItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvoiceItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceEntity extends InvoiceEntity {
  @override
  final double amount;
  @override
  final double balance;
  @override
  final String clientId;
  @override
  final String statusId;
  @override
  final String number;
  @override
  final double discount;
  @override
  final String poNumber;
  @override
  final String date;
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
  final bool usesInclusiveTaxes;
  @override
  final String taxName1;
  @override
  final double taxRate1;
  @override
  final String taxName2;
  @override
  final double taxRate2;
  @override
  final String taxName3;
  @override
  final double taxRate3;
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
  final String invoiceId;
  @override
  final String filename;
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
  final EntityType subEntityType;
  @override
  final String id;

  factory _$InvoiceEntity([void Function(InvoiceEntityBuilder) updates]) =>
      (new InvoiceEntityBuilder()..update(updates)).build();

  _$InvoiceEntity._(
      {this.amount,
      this.balance,
      this.clientId,
      this.statusId,
      this.number,
      this.discount,
      this.poNumber,
      this.date,
      this.dueDate,
      this.publicNotes,
      this.privateNotes,
      this.terms,
      this.footer,
      this.designId,
      this.usesInclusiveTaxes,
      this.taxName1,
      this.taxRate1,
      this.taxName2,
      this.taxRate2,
      this.taxName3,
      this.taxRate3,
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
      this.invoiceId,
      this.filename,
      this.lineItems,
      this.invitations,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.subEntityType,
      this.id})
      : super._() {
    if (amount == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'amount');
    }
    if (balance == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'balance');
    }
    if (clientId == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'clientId');
    }
    if (statusId == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'statusId');
    }
    if (number == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'number');
    }
    if (discount == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'discount');
    }
    if (poNumber == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'poNumber');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'date');
    }
    if (dueDate == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'dueDate');
    }
    if (publicNotes == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'publicNotes');
    }
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'privateNotes');
    }
    if (terms == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'terms');
    }
    if (footer == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'footer');
    }
    if (designId == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'designId');
    }
    if (usesInclusiveTaxes == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'usesInclusiveTaxes');
    }
    if (taxName1 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'taxName1');
    }
    if (taxRate1 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'taxRate1');
    }
    if (taxName2 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'taxName2');
    }
    if (taxRate2 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'taxRate2');
    }
    if (taxName3 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'taxName3');
    }
    if (taxRate3 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'taxRate3');
    }
    if (isAmountDiscount == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'isAmountDiscount');
    }
    if (partial == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'partial');
    }
    if (partialDueDate == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'partialDueDate');
    }
    if (hasTasks == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'hasTasks');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customValue4');
    }
    if (customSurcharge1 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customSurcharge1');
    }
    if (customSurcharge2 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customSurcharge2');
    }
    if (customSurcharge3 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customSurcharge3');
    }
    if (customSurcharge4 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customSurcharge4');
    }
    if (hasExpenses == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'hasExpenses');
    }
    if (lineItems == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'lineItems');
    }
    if (invitations == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'invitations');
    }
  }

  @override
  InvoiceEntity rebuild(void Function(InvoiceEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceEntityBuilder toBuilder() => new InvoiceEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceEntity &&
        amount == other.amount &&
        balance == other.balance &&
        clientId == other.clientId &&
        statusId == other.statusId &&
        number == other.number &&
        discount == other.discount &&
        poNumber == other.poNumber &&
        date == other.date &&
        dueDate == other.dueDate &&
        publicNotes == other.publicNotes &&
        privateNotes == other.privateNotes &&
        terms == other.terms &&
        footer == other.footer &&
        designId == other.designId &&
        usesInclusiveTaxes == other.usesInclusiveTaxes &&
        taxName1 == other.taxName1 &&
        taxRate1 == other.taxRate1 &&
        taxName2 == other.taxName2 &&
        taxRate2 == other.taxRate2 &&
        taxName3 == other.taxName3 &&
        taxRate3 == other.taxRate3 &&
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
        invoiceId == other.invoiceId &&
        filename == other.filename &&
        lineItems == other.lineItems &&
        invitations == other.invitations &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        subEntityType == other.subEntityType &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, amount.hashCode), balance.hashCode), clientId.hashCode), statusId.hashCode), number.hashCode), discount.hashCode), poNumber.hashCode), date.hashCode), dueDate.hashCode), publicNotes.hashCode), privateNotes.hashCode), terms.hashCode), footer.hashCode), designId.hashCode), usesInclusiveTaxes.hashCode), taxName1.hashCode), taxRate1.hashCode), taxName2.hashCode), taxRate2.hashCode), taxName3.hashCode), taxRate3.hashCode), isAmountDiscount.hashCode), partial.hashCode), partialDueDate.hashCode), hasTasks.hashCode), autoBill.hashCode), customValue1.hashCode), customValue2.hashCode), customValue3.hashCode), customValue4.hashCode), customSurcharge1.hashCode), customSurcharge2.hashCode), customSurcharge3.hashCode),
                                                                                customSurcharge4.hashCode),
                                                                            customTaxes1.hashCode),
                                                                        customTaxes2.hashCode),
                                                                    customTaxes3.hashCode),
                                                                customTaxes4.hashCode),
                                                            hasExpenses.hashCode),
                                                        invoiceId.hashCode),
                                                    filename.hashCode),
                                                lineItems.hashCode),
                                            invitations.hashCode),
                                        isChanged.hashCode),
                                    createdAt.hashCode),
                                updatedAt.hashCode),
                            archivedAt.hashCode),
                        isDeleted.hashCode),
                    createdUserId.hashCode),
                assignedUserId.hashCode),
            subEntityType.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceEntity')
          ..add('amount', amount)
          ..add('balance', balance)
          ..add('clientId', clientId)
          ..add('statusId', statusId)
          ..add('number', number)
          ..add('discount', discount)
          ..add('poNumber', poNumber)
          ..add('date', date)
          ..add('dueDate', dueDate)
          ..add('publicNotes', publicNotes)
          ..add('privateNotes', privateNotes)
          ..add('terms', terms)
          ..add('footer', footer)
          ..add('designId', designId)
          ..add('usesInclusiveTaxes', usesInclusiveTaxes)
          ..add('taxName1', taxName1)
          ..add('taxRate1', taxRate1)
          ..add('taxName2', taxName2)
          ..add('taxRate2', taxRate2)
          ..add('taxName3', taxName3)
          ..add('taxRate3', taxRate3)
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
          ..add('invoiceId', invoiceId)
          ..add('filename', filename)
          ..add('lineItems', lineItems)
          ..add('invitations', invitations)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('subEntityType', subEntityType)
          ..add('id', id))
        .toString();
  }
}

class InvoiceEntityBuilder
    implements Builder<InvoiceEntity, InvoiceEntityBuilder> {
  _$InvoiceEntity _$v;

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

  String _number;
  String get number => _$this._number;
  set number(String number) => _$this._number = number;

  double _discount;
  double get discount => _$this._discount;
  set discount(double discount) => _$this._discount = discount;

  String _poNumber;
  String get poNumber => _$this._poNumber;
  set poNumber(String poNumber) => _$this._poNumber = poNumber;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

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

  bool _usesInclusiveTaxes;
  bool get usesInclusiveTaxes => _$this._usesInclusiveTaxes;
  set usesInclusiveTaxes(bool usesInclusiveTaxes) =>
      _$this._usesInclusiveTaxes = usesInclusiveTaxes;

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

  String _taxName3;
  String get taxName3 => _$this._taxName3;
  set taxName3(String taxName3) => _$this._taxName3 = taxName3;

  double _taxRate3;
  double get taxRate3 => _$this._taxRate3;
  set taxRate3(double taxRate3) => _$this._taxRate3 = taxRate3;

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

  String _invoiceId;
  String get invoiceId => _$this._invoiceId;
  set invoiceId(String invoiceId) => _$this._invoiceId = invoiceId;

  String _filename;
  String get filename => _$this._filename;
  set filename(String filename) => _$this._filename = filename;

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

  EntityType _subEntityType;
  EntityType get subEntityType => _$this._subEntityType;
  set subEntityType(EntityType subEntityType) =>
      _$this._subEntityType = subEntityType;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  InvoiceEntityBuilder();

  InvoiceEntityBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _balance = _$v.balance;
      _clientId = _$v.clientId;
      _statusId = _$v.statusId;
      _number = _$v.number;
      _discount = _$v.discount;
      _poNumber = _$v.poNumber;
      _date = _$v.date;
      _dueDate = _$v.dueDate;
      _publicNotes = _$v.publicNotes;
      _privateNotes = _$v.privateNotes;
      _terms = _$v.terms;
      _footer = _$v.footer;
      _designId = _$v.designId;
      _usesInclusiveTaxes = _$v.usesInclusiveTaxes;
      _taxName1 = _$v.taxName1;
      _taxRate1 = _$v.taxRate1;
      _taxName2 = _$v.taxName2;
      _taxRate2 = _$v.taxRate2;
      _taxName3 = _$v.taxName3;
      _taxRate3 = _$v.taxRate3;
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
      _invoiceId = _$v.invoiceId;
      _filename = _$v.filename;
      _lineItems = _$v.lineItems?.toBuilder();
      _invitations = _$v.invitations?.toBuilder();
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
      _subEntityType = _$v.subEntityType;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceEntity;
  }

  @override
  void update(void Function(InvoiceEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceEntity build() {
    _$InvoiceEntity _$result;
    try {
      _$result = _$v ??
          new _$InvoiceEntity._(
              amount: amount,
              balance: balance,
              clientId: clientId,
              statusId: statusId,
              number: number,
              discount: discount,
              poNumber: poNumber,
              date: date,
              dueDate: dueDate,
              publicNotes: publicNotes,
              privateNotes: privateNotes,
              terms: terms,
              footer: footer,
              designId: designId,
              usesInclusiveTaxes: usesInclusiveTaxes,
              taxName1: taxName1,
              taxRate1: taxRate1,
              taxName2: taxName2,
              taxRate2: taxRate2,
              taxName3: taxName3,
              taxRate3: taxRate3,
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
              invoiceId: invoiceId,
              filename: filename,
              lineItems: lineItems.build(),
              invitations: invitations.build(),
              isChanged: isChanged,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              subEntityType: subEntityType,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'lineItems';
        lineItems.build();
        _$failedField = 'invitations';
        invitations.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvoiceEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceItemEntity extends InvoiceItemEntity {
  @override
  final String productKey;
  @override
  final String notes;
  @override
  final double cost;
  @override
  final double quantity;
  @override
  final String taxName1;
  @override
  final double taxRate1;
  @override
  final String taxName2;
  @override
  final double taxRate2;
  @override
  final String taxName3;
  @override
  final double taxRate3;
  @override
  final String typeId;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final double discount;
  @override
  final String taskId;
  @override
  final String expenseId;
  @override
  final int createdAt;

  factory _$InvoiceItemEntity(
          [void Function(InvoiceItemEntityBuilder) updates]) =>
      (new InvoiceItemEntityBuilder()..update(updates)).build();

  _$InvoiceItemEntity._(
      {this.productKey,
      this.notes,
      this.cost,
      this.quantity,
      this.taxName1,
      this.taxRate1,
      this.taxName2,
      this.taxRate2,
      this.taxName3,
      this.taxRate3,
      this.typeId,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.discount,
      this.taskId,
      this.expenseId,
      this.createdAt})
      : super._() {
    if (productKey == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'productKey');
    }
    if (notes == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'notes');
    }
    if (cost == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'cost');
    }
    if (quantity == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'quantity');
    }
    if (taxName1 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'taxName1');
    }
    if (taxRate1 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'taxRate1');
    }
    if (taxName2 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'taxName2');
    }
    if (taxRate2 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'taxRate2');
    }
    if (taxName3 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'taxName3');
    }
    if (taxRate3 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'taxRate3');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'customValue2');
    }
    if (customValue3 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'customValue3');
    }
    if (customValue4 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'customValue4');
    }
    if (discount == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'discount');
    }
  }

  @override
  InvoiceItemEntity rebuild(void Function(InvoiceItemEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceItemEntityBuilder toBuilder() =>
      new InvoiceItemEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceItemEntity &&
        productKey == other.productKey &&
        notes == other.notes &&
        cost == other.cost &&
        quantity == other.quantity &&
        taxName1 == other.taxName1 &&
        taxRate1 == other.taxRate1 &&
        taxName2 == other.taxName2 &&
        taxRate2 == other.taxRate2 &&
        taxName3 == other.taxName3 &&
        taxRate3 == other.taxRate3 &&
        typeId == other.typeId &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        discount == other.discount &&
        taskId == other.taskId &&
        expenseId == other.expenseId &&
        createdAt == other.createdAt;
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
                                                                            $jc(
                                                                                0,
                                                                                productKey
                                                                                    .hashCode),
                                                                            notes
                                                                                .hashCode),
                                                                        cost
                                                                            .hashCode),
                                                                    quantity
                                                                        .hashCode),
                                                                taxName1
                                                                    .hashCode),
                                                            taxRate1.hashCode),
                                                        taxName2.hashCode),
                                                    taxRate2.hashCode),
                                                taxName3.hashCode),
                                            taxRate3.hashCode),
                                        typeId.hashCode),
                                    customValue1.hashCode),
                                customValue2.hashCode),
                            customValue3.hashCode),
                        customValue4.hashCode),
                    discount.hashCode),
                taskId.hashCode),
            expenseId.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceItemEntity')
          ..add('productKey', productKey)
          ..add('notes', notes)
          ..add('cost', cost)
          ..add('quantity', quantity)
          ..add('taxName1', taxName1)
          ..add('taxRate1', taxRate1)
          ..add('taxName2', taxName2)
          ..add('taxRate2', taxRate2)
          ..add('taxName3', taxName3)
          ..add('taxRate3', taxRate3)
          ..add('typeId', typeId)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('discount', discount)
          ..add('taskId', taskId)
          ..add('expenseId', expenseId)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class InvoiceItemEntityBuilder
    implements Builder<InvoiceItemEntity, InvoiceItemEntityBuilder> {
  _$InvoiceItemEntity _$v;

  String _productKey;
  String get productKey => _$this._productKey;
  set productKey(String productKey) => _$this._productKey = productKey;

  String _notes;
  String get notes => _$this._notes;
  set notes(String notes) => _$this._notes = notes;

  double _cost;
  double get cost => _$this._cost;
  set cost(double cost) => _$this._cost = cost;

  double _quantity;
  double get quantity => _$this._quantity;
  set quantity(double quantity) => _$this._quantity = quantity;

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

  String _taxName3;
  String get taxName3 => _$this._taxName3;
  set taxName3(String taxName3) => _$this._taxName3 = taxName3;

  double _taxRate3;
  double get taxRate3 => _$this._taxRate3;
  set taxRate3(double taxRate3) => _$this._taxRate3 = taxRate3;

  String _typeId;
  String get typeId => _$this._typeId;
  set typeId(String typeId) => _$this._typeId = typeId;

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

  double _discount;
  double get discount => _$this._discount;
  set discount(double discount) => _$this._discount = discount;

  String _taskId;
  String get taskId => _$this._taskId;
  set taskId(String taskId) => _$this._taskId = taskId;

  String _expenseId;
  String get expenseId => _$this._expenseId;
  set expenseId(String expenseId) => _$this._expenseId = expenseId;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  InvoiceItemEntityBuilder();

  InvoiceItemEntityBuilder get _$this {
    if (_$v != null) {
      _productKey = _$v.productKey;
      _notes = _$v.notes;
      _cost = _$v.cost;
      _quantity = _$v.quantity;
      _taxName1 = _$v.taxName1;
      _taxRate1 = _$v.taxRate1;
      _taxName2 = _$v.taxName2;
      _taxRate2 = _$v.taxRate2;
      _taxName3 = _$v.taxName3;
      _taxRate3 = _$v.taxRate3;
      _typeId = _$v.typeId;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _discount = _$v.discount;
      _taskId = _$v.taskId;
      _expenseId = _$v.expenseId;
      _createdAt = _$v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceItemEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceItemEntity;
  }

  @override
  void update(void Function(InvoiceItemEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceItemEntity build() {
    final _$result = _$v ??
        new _$InvoiceItemEntity._(
            productKey: productKey,
            notes: notes,
            cost: cost,
            quantity: quantity,
            taxName1: taxName1,
            taxRate1: taxRate1,
            taxName2: taxName2,
            taxRate2: taxRate2,
            taxName3: taxName3,
            taxRate3: taxRate3,
            typeId: typeId,
            customValue1: customValue1,
            customValue2: customValue2,
            customValue3: customValue3,
            customValue4: customValue4,
            discount: discount,
            taskId: taskId,
            expenseId: expenseId,
            createdAt: createdAt);
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
  final String contactId;
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
  final EntityType subEntityType;
  @override
  final String id;

  factory _$InvitationEntity(
          [void Function(InvitationEntityBuilder) updates]) =>
      (new InvitationEntityBuilder()..update(updates)).build();

  _$InvitationEntity._(
      {this.key,
      this.link,
      this.contactId,
      this.sentDate,
      this.viewedDate,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.subEntityType,
      this.id})
      : super._() {
    if (key == null) {
      throw new BuiltValueNullFieldError('InvitationEntity', 'key');
    }
    if (link == null) {
      throw new BuiltValueNullFieldError('InvitationEntity', 'link');
    }
    if (contactId == null) {
      throw new BuiltValueNullFieldError('InvitationEntity', 'contactId');
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
        contactId == other.contactId &&
        sentDate == other.sentDate &&
        viewedDate == other.viewedDate &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        subEntityType == other.subEntityType &&
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
                                                    $jc($jc(0, key.hashCode),
                                                        link.hashCode),
                                                    contactId.hashCode),
                                                sentDate.hashCode),
                                            viewedDate.hashCode),
                                        isChanged.hashCode),
                                    createdAt.hashCode),
                                updatedAt.hashCode),
                            archivedAt.hashCode),
                        isDeleted.hashCode),
                    createdUserId.hashCode),
                assignedUserId.hashCode),
            subEntityType.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvitationEntity')
          ..add('key', key)
          ..add('link', link)
          ..add('contactId', contactId)
          ..add('sentDate', sentDate)
          ..add('viewedDate', viewedDate)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('subEntityType', subEntityType)
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

  String _contactId;
  String get contactId => _$this._contactId;
  set contactId(String contactId) => _$this._contactId = contactId;

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

  EntityType _subEntityType;
  EntityType get subEntityType => _$this._subEntityType;
  set subEntityType(EntityType subEntityType) =>
      _$this._subEntityType = subEntityType;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  InvitationEntityBuilder();

  InvitationEntityBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _link = _$v.link;
      _contactId = _$v.contactId;
      _sentDate = _$v.sentDate;
      _viewedDate = _$v.viewedDate;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
      _subEntityType = _$v.subEntityType;
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
            contactId: contactId,
            sentDate: sentDate,
            viewedDate: viewedDate,
            isChanged: isChanged,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            subEntityType: subEntityType,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
