// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

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
  Iterable serialize(Serializers serializers, InvoiceListResponse object,
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
  InvoiceListResponse deserialize(Serializers serializers, Iterable serialized,
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
              as BuiltList);
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
  Iterable serialize(Serializers serializers, InvoiceItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(InvoiceEntity)),
    ];

    return result;
  }

  @override
  InvoiceItemResponse deserialize(Serializers serializers, Iterable serialized,
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
  Iterable serialize(Serializers serializers, InvoiceEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'balance',
      serializers.serialize(object.balance,
          specifiedType: const FullType(double)),
      'is_quote',
      serializers.serialize(object.isQuote,
          specifiedType: const FullType(bool)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(int)),
      'invoice_status_id',
      serializers.serialize(object.invoiceStatusId,
          specifiedType: const FullType(int)),
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
      'terms',
      serializers.serialize(object.terms,
          specifiedType: const FullType(String)),
      'public_notes',
      serializers.serialize(object.publicNotes,
          specifiedType: const FullType(String)),
      'private_notes',
      serializers.serialize(object.privateNotes,
          specifiedType: const FullType(String)),
      'invoice_type_id',
      serializers.serialize(object.invoiceTypeId,
          specifiedType: const FullType(int)),
      'is_recurring',
      serializers.serialize(object.isRecurring,
          specifiedType: const FullType(bool)),
      'frequency_id',
      serializers.serialize(object.frequencyId,
          specifiedType: const FullType(int)),
      'start_date',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(String)),
      'end_date',
      serializers.serialize(object.endDate,
          specifiedType: const FullType(String)),
      'last_sent_date',
      serializers.serialize(object.lastSentDate,
          specifiedType: const FullType(String)),
      'recurring_invoice_id',
      serializers.serialize(object.recurringInvoiceId,
          specifiedType: const FullType(int)),
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
      'invoice_footer',
      serializers.serialize(object.invoiceFooter,
          specifiedType: const FullType(String)),
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
          specifiedType: const FullType(int)),
      'custom_text_value1',
      serializers.serialize(object.customTextValue1,
          specifiedType: const FullType(String)),
      'custom_text_value2',
      serializers.serialize(object.customTextValue2,
          specifiedType: const FullType(String)),
      'is_public',
      serializers.serialize(object.isPublic,
          specifiedType: const FullType(bool)),
      'filename',
      serializers.serialize(object.filename,
          specifiedType: const FullType(String)),
      'invoice_items',
      serializers.serialize(object.invoiceItems,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceItemEntity)])),
      'invitations',
      serializers.serialize(object.invitations,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvitationEntity)])),
    ];
    if (object.designId != null) {
      result
        ..add('invoice_design_id')
        ..add(serializers.serialize(object.designId,
            specifiedType: const FullType(int)));
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
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  InvoiceEntity deserialize(Serializers serializers, Iterable serialized,
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
        case 'is_quote':
          result.isQuote = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_status_id':
          result.invoiceStatusId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
        case 'terms':
          result.terms = serializers.deserialize(value,
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
        case 'invoice_type_id':
          result.invoiceTypeId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_recurring':
          result.isRecurring = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'frequency_id':
          result.frequencyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'start_date':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'end_date':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_sent_date':
          result.lastSentDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'recurring_invoice_id':
          result.recurringInvoiceId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
        case 'invoice_footer':
          result.invoiceFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
              specifiedType: const FullType(int)) as int;
          break;
        case 'custom_text_value1':
          result.customTextValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_text_value2':
          result.customTextValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'is_public':
          result.isPublic = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'filename':
          result.filename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_items':
          result.invoiceItems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceItemEntity)]))
              as BuiltList);
          break;
        case 'invitations':
          result.invitations.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvitationEntity)]))
              as BuiltList);
          break;
        case 'invoice_design_id':
          result.designId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$InvoiceItemEntitySerializer
    implements StructuredSerializer<InvoiceItemEntity> {
  @override
  final Iterable<Type> types = const [InvoiceItemEntity, _$InvoiceItemEntity];
  @override
  final String wireName = 'InvoiceItemEntity';

  @override
  Iterable serialize(Serializers serializers, InvoiceItemEntity object,
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
      'qty',
      serializers.serialize(object.qty, specifiedType: const FullType(double)),
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
      'invoice_item_type_id',
      serializers.serialize(object.invoiceItemTypeId,
          specifiedType: const FullType(int)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'discount',
      serializers.serialize(object.discount,
          specifiedType: const FullType(double)),
    ];
    if (object.taskId != null) {
      result
        ..add('task_public_id')
        ..add(serializers.serialize(object.taskId,
            specifiedType: const FullType(int)));
    }
    if (object.expenseId != null) {
      result
        ..add('expense_public_id')
        ..add(serializers.serialize(object.expenseId,
            specifiedType: const FullType(int)));
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
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  InvoiceItemEntity deserialize(Serializers serializers, Iterable serialized,
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
        case 'qty':
          result.qty = serializers.deserialize(value,
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
        case 'invoice_item_type_id':
          result.invoiceItemTypeId = serializers.deserialize(value,
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
        case 'discount':
          result.discount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'task_public_id':
          result.taskId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'expense_public_id':
          result.expenseId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$InvitationEntitySerializer
    implements StructuredSerializer<InvitationEntity> {
  @override
  final Iterable<Type> types = const [InvitationEntity, _$InvitationEntity];
  @override
  final String wireName = 'InvitationEntity';

  @override
  Iterable serialize(Serializers serializers, InvitationEntity object,
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
  InvitationEntity deserialize(Serializers serializers, Iterable serialized,
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

class _$InvoiceListResponse extends InvoiceListResponse {
  @override
  final BuiltList<InvoiceEntity> data;

  factory _$InvoiceListResponse([void updates(InvoiceListResponseBuilder b)]) =>
      (new InvoiceListResponseBuilder()..update(updates)).build();

  _$InvoiceListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('InvoiceListResponse', 'data');
    }
  }

  @override
  InvoiceListResponse rebuild(void updates(InvoiceListResponseBuilder b)) =>
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
  void update(void updates(InvoiceListResponseBuilder b)) {
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

  factory _$InvoiceItemResponse([void updates(InvoiceItemResponseBuilder b)]) =>
      (new InvoiceItemResponseBuilder()..update(updates)).build();

  _$InvoiceItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('InvoiceItemResponse', 'data');
    }
  }

  @override
  InvoiceItemResponse rebuild(void updates(InvoiceItemResponseBuilder b)) =>
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
  void update(void updates(InvoiceItemResponseBuilder b)) {
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
  final bool isQuote;
  @override
  final int clientId;
  @override
  final int invoiceStatusId;
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
  final String terms;
  @override
  final String publicNotes;
  @override
  final String privateNotes;
  @override
  final int invoiceTypeId;
  @override
  final bool isRecurring;
  @override
  final int frequencyId;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final String lastSentDate;
  @override
  final int recurringInvoiceId;
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
  final String invoiceFooter;
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
  final int quoteInvoiceId;
  @override
  final String customTextValue1;
  @override
  final String customTextValue2;
  @override
  final bool isPublic;
  @override
  final String filename;
  @override
  final BuiltList<InvoiceItemEntity> invoiceItems;
  @override
  final BuiltList<InvitationEntity> invitations;
  @override
  final int designId;
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

  factory _$InvoiceEntity([void updates(InvoiceEntityBuilder b)]) =>
      (new InvoiceEntityBuilder()..update(updates)).build();

  _$InvoiceEntity._(
      {this.amount,
      this.balance,
      this.isQuote,
      this.clientId,
      this.invoiceStatusId,
      this.invoiceNumber,
      this.discount,
      this.poNumber,
      this.invoiceDate,
      this.dueDate,
      this.terms,
      this.publicNotes,
      this.privateNotes,
      this.invoiceTypeId,
      this.isRecurring,
      this.frequencyId,
      this.startDate,
      this.endDate,
      this.lastSentDate,
      this.recurringInvoiceId,
      this.taxName1,
      this.taxRate1,
      this.taxName2,
      this.taxRate2,
      this.isAmountDiscount,
      this.invoiceFooter,
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
      this.isPublic,
      this.filename,
      this.invoiceItems,
      this.invitations,
      this.designId,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
      : super._() {
    if (amount == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'amount');
    }
    if (balance == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'balance');
    }
    if (isQuote == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'isQuote');
    }
    if (clientId == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'clientId');
    }
    if (invoiceStatusId == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'invoiceStatusId');
    }
    if (invoiceNumber == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'invoiceNumber');
    }
    if (discount == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'discount');
    }
    if (poNumber == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'poNumber');
    }
    if (invoiceDate == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'invoiceDate');
    }
    if (dueDate == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'dueDate');
    }
    if (terms == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'terms');
    }
    if (publicNotes == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'publicNotes');
    }
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'privateNotes');
    }
    if (invoiceTypeId == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'invoiceTypeId');
    }
    if (isRecurring == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'isRecurring');
    }
    if (frequencyId == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'frequencyId');
    }
    if (startDate == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'startDate');
    }
    if (endDate == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'endDate');
    }
    if (lastSentDate == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'lastSentDate');
    }
    if (recurringInvoiceId == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'recurringInvoiceId');
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
    if (isAmountDiscount == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'isAmountDiscount');
    }
    if (invoiceFooter == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'invoiceFooter');
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
    if (autoBill == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'autoBill');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customValue2');
    }
    if (customTaxes1 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customTaxes1');
    }
    if (customTaxes2 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customTaxes2');
    }
    if (hasExpenses == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'hasExpenses');
    }
    if (quoteInvoiceId == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'quoteInvoiceId');
    }
    if (customTextValue1 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customTextValue1');
    }
    if (customTextValue2 == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'customTextValue2');
    }
    if (isPublic == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'isPublic');
    }
    if (filename == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'filename');
    }
    if (invoiceItems == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'invoiceItems');
    }
    if (invitations == null) {
      throw new BuiltValueNullFieldError('InvoiceEntity', 'invitations');
    }
  }

  @override
  InvoiceEntity rebuild(void updates(InvoiceEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceEntityBuilder toBuilder() => new InvoiceEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceEntity &&
        amount == other.amount &&
        balance == other.balance &&
        isQuote == other.isQuote &&
        clientId == other.clientId &&
        invoiceStatusId == other.invoiceStatusId &&
        invoiceNumber == other.invoiceNumber &&
        discount == other.discount &&
        poNumber == other.poNumber &&
        invoiceDate == other.invoiceDate &&
        dueDate == other.dueDate &&
        terms == other.terms &&
        publicNotes == other.publicNotes &&
        privateNotes == other.privateNotes &&
        invoiceTypeId == other.invoiceTypeId &&
        isRecurring == other.isRecurring &&
        frequencyId == other.frequencyId &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        lastSentDate == other.lastSentDate &&
        recurringInvoiceId == other.recurringInvoiceId &&
        taxName1 == other.taxName1 &&
        taxRate1 == other.taxRate1 &&
        taxName2 == other.taxName2 &&
        taxRate2 == other.taxRate2 &&
        isAmountDiscount == other.isAmountDiscount &&
        invoiceFooter == other.invoiceFooter &&
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
        isPublic == other.isPublic &&
        filename == other.filename &&
        invoiceItems == other.invoiceItems &&
        invitations == other.invitations &&
        designId == other.designId &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, amount.hashCode), balance.hashCode), isQuote.hashCode), clientId.hashCode), invoiceStatusId.hashCode), invoiceNumber.hashCode), discount.hashCode), poNumber.hashCode), invoiceDate.hashCode), dueDate.hashCode), terms.hashCode), publicNotes.hashCode), privateNotes.hashCode), invoiceTypeId.hashCode), isRecurring.hashCode), frequencyId.hashCode), startDate.hashCode), endDate.hashCode), lastSentDate.hashCode), recurringInvoiceId.hashCode), taxName1.hashCode), taxRate1.hashCode), taxName2.hashCode), taxRate2.hashCode), isAmountDiscount.hashCode), invoiceFooter.hashCode), partial.hashCode), partialDueDate.hashCode), hasTasks.hashCode), autoBill.hashCode),
                                                                                customValue1.hashCode),
                                                                            customValue2.hashCode),
                                                                        customTaxes1.hashCode),
                                                                    customTaxes2.hashCode),
                                                                hasExpenses.hashCode),
                                                            quoteInvoiceId.hashCode),
                                                        customTextValue1.hashCode),
                                                    customTextValue2.hashCode),
                                                isPublic.hashCode),
                                            filename.hashCode),
                                        invoiceItems.hashCode),
                                    invitations.hashCode),
                                designId.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceEntity')
          ..add('amount', amount)
          ..add('balance', balance)
          ..add('isQuote', isQuote)
          ..add('clientId', clientId)
          ..add('invoiceStatusId', invoiceStatusId)
          ..add('invoiceNumber', invoiceNumber)
          ..add('discount', discount)
          ..add('poNumber', poNumber)
          ..add('invoiceDate', invoiceDate)
          ..add('dueDate', dueDate)
          ..add('terms', terms)
          ..add('publicNotes', publicNotes)
          ..add('privateNotes', privateNotes)
          ..add('invoiceTypeId', invoiceTypeId)
          ..add('isRecurring', isRecurring)
          ..add('frequencyId', frequencyId)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('lastSentDate', lastSentDate)
          ..add('recurringInvoiceId', recurringInvoiceId)
          ..add('taxName1', taxName1)
          ..add('taxRate1', taxRate1)
          ..add('taxName2', taxName2)
          ..add('taxRate2', taxRate2)
          ..add('isAmountDiscount', isAmountDiscount)
          ..add('invoiceFooter', invoiceFooter)
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
          ..add('isPublic', isPublic)
          ..add('filename', filename)
          ..add('invoiceItems', invoiceItems)
          ..add('invitations', invitations)
          ..add('designId', designId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
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

  bool _isQuote;
  bool get isQuote => _$this._isQuote;
  set isQuote(bool isQuote) => _$this._isQuote = isQuote;

  int _clientId;
  int get clientId => _$this._clientId;
  set clientId(int clientId) => _$this._clientId = clientId;

  int _invoiceStatusId;
  int get invoiceStatusId => _$this._invoiceStatusId;
  set invoiceStatusId(int invoiceStatusId) =>
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

  String _terms;
  String get terms => _$this._terms;
  set terms(String terms) => _$this._terms = terms;

  String _publicNotes;
  String get publicNotes => _$this._publicNotes;
  set publicNotes(String publicNotes) => _$this._publicNotes = publicNotes;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

  int _invoiceTypeId;
  int get invoiceTypeId => _$this._invoiceTypeId;
  set invoiceTypeId(int invoiceTypeId) => _$this._invoiceTypeId = invoiceTypeId;

  bool _isRecurring;
  bool get isRecurring => _$this._isRecurring;
  set isRecurring(bool isRecurring) => _$this._isRecurring = isRecurring;

  int _frequencyId;
  int get frequencyId => _$this._frequencyId;
  set frequencyId(int frequencyId) => _$this._frequencyId = frequencyId;

  String _startDate;
  String get startDate => _$this._startDate;
  set startDate(String startDate) => _$this._startDate = startDate;

  String _endDate;
  String get endDate => _$this._endDate;
  set endDate(String endDate) => _$this._endDate = endDate;

  String _lastSentDate;
  String get lastSentDate => _$this._lastSentDate;
  set lastSentDate(String lastSentDate) => _$this._lastSentDate = lastSentDate;

  int _recurringInvoiceId;
  int get recurringInvoiceId => _$this._recurringInvoiceId;
  set recurringInvoiceId(int recurringInvoiceId) =>
      _$this._recurringInvoiceId = recurringInvoiceId;

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

  String _invoiceFooter;
  String get invoiceFooter => _$this._invoiceFooter;
  set invoiceFooter(String invoiceFooter) =>
      _$this._invoiceFooter = invoiceFooter;

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

  int _quoteInvoiceId;
  int get quoteInvoiceId => _$this._quoteInvoiceId;
  set quoteInvoiceId(int quoteInvoiceId) =>
      _$this._quoteInvoiceId = quoteInvoiceId;

  String _customTextValue1;
  String get customTextValue1 => _$this._customTextValue1;
  set customTextValue1(String customTextValue1) =>
      _$this._customTextValue1 = customTextValue1;

  String _customTextValue2;
  String get customTextValue2 => _$this._customTextValue2;
  set customTextValue2(String customTextValue2) =>
      _$this._customTextValue2 = customTextValue2;

  bool _isPublic;
  bool get isPublic => _$this._isPublic;
  set isPublic(bool isPublic) => _$this._isPublic = isPublic;

  String _filename;
  String get filename => _$this._filename;
  set filename(String filename) => _$this._filename = filename;

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

  int _designId;
  int get designId => _$this._designId;
  set designId(int designId) => _$this._designId = designId;

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

  InvoiceEntityBuilder();

  InvoiceEntityBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _balance = _$v.balance;
      _isQuote = _$v.isQuote;
      _clientId = _$v.clientId;
      _invoiceStatusId = _$v.invoiceStatusId;
      _invoiceNumber = _$v.invoiceNumber;
      _discount = _$v.discount;
      _poNumber = _$v.poNumber;
      _invoiceDate = _$v.invoiceDate;
      _dueDate = _$v.dueDate;
      _terms = _$v.terms;
      _publicNotes = _$v.publicNotes;
      _privateNotes = _$v.privateNotes;
      _invoiceTypeId = _$v.invoiceTypeId;
      _isRecurring = _$v.isRecurring;
      _frequencyId = _$v.frequencyId;
      _startDate = _$v.startDate;
      _endDate = _$v.endDate;
      _lastSentDate = _$v.lastSentDate;
      _recurringInvoiceId = _$v.recurringInvoiceId;
      _taxName1 = _$v.taxName1;
      _taxRate1 = _$v.taxRate1;
      _taxName2 = _$v.taxName2;
      _taxRate2 = _$v.taxRate2;
      _isAmountDiscount = _$v.isAmountDiscount;
      _invoiceFooter = _$v.invoiceFooter;
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
      _isPublic = _$v.isPublic;
      _filename = _$v.filename;
      _invoiceItems = _$v.invoiceItems?.toBuilder();
      _invitations = _$v.invitations?.toBuilder();
      _designId = _$v.designId;
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
  void replace(InvoiceEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceEntity;
  }

  @override
  void update(void updates(InvoiceEntityBuilder b)) {
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
              isQuote: isQuote,
              clientId: clientId,
              invoiceStatusId: invoiceStatusId,
              invoiceNumber: invoiceNumber,
              discount: discount,
              poNumber: poNumber,
              invoiceDate: invoiceDate,
              dueDate: dueDate,
              terms: terms,
              publicNotes: publicNotes,
              privateNotes: privateNotes,
              invoiceTypeId: invoiceTypeId,
              isRecurring: isRecurring,
              frequencyId: frequencyId,
              startDate: startDate,
              endDate: endDate,
              lastSentDate: lastSentDate,
              recurringInvoiceId: recurringInvoiceId,
              taxName1: taxName1,
              taxRate1: taxRate1,
              taxName2: taxName2,
              taxRate2: taxRate2,
              isAmountDiscount: isAmountDiscount,
              invoiceFooter: invoiceFooter,
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
              isPublic: isPublic,
              filename: filename,
              invoiceItems: invoiceItems.build(),
              invitations: invitations.build(),
              designId: designId,
              createdAt: createdAt,
              updatedAt: updatedAt,
              archivedAt: archivedAt,
              isDeleted: isDeleted,
              isOwner: isOwner,
              id: id);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'invoiceItems';
        invoiceItems.build();
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
  final double qty;
  @override
  final String taxName1;
  @override
  final double taxRate1;
  @override
  final String taxName2;
  @override
  final double taxRate2;
  @override
  final int invoiceItemTypeId;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final double discount;
  @override
  final int taskId;
  @override
  final int expenseId;
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

  factory _$InvoiceItemEntity([void updates(InvoiceItemEntityBuilder b)]) =>
      (new InvoiceItemEntityBuilder()..update(updates)).build();

  _$InvoiceItemEntity._(
      {this.productKey,
      this.notes,
      this.cost,
      this.qty,
      this.taxName1,
      this.taxRate1,
      this.taxName2,
      this.taxRate2,
      this.invoiceItemTypeId,
      this.customValue1,
      this.customValue2,
      this.discount,
      this.taskId,
      this.expenseId,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
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
    if (qty == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'qty');
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
    if (invoiceItemTypeId == null) {
      throw new BuiltValueNullFieldError(
          'InvoiceItemEntity', 'invoiceItemTypeId');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'customValue2');
    }
    if (discount == null) {
      throw new BuiltValueNullFieldError('InvoiceItemEntity', 'discount');
    }
  }

  @override
  InvoiceItemEntity rebuild(void updates(InvoiceItemEntityBuilder b)) =>
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
        qty == other.qty &&
        taxName1 == other.taxName1 &&
        taxRate1 == other.taxRate1 &&
        taxName2 == other.taxName2 &&
        taxRate2 == other.taxRate2 &&
        invoiceItemTypeId == other.invoiceItemTypeId &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        discount == other.discount &&
        taskId == other.taskId &&
        expenseId == other.expenseId &&
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
                                                                            $jc($jc(0, productKey.hashCode),
                                                                                notes.hashCode),
                                                                            cost.hashCode),
                                                                        qty.hashCode),
                                                                    taxName1.hashCode),
                                                                taxRate1.hashCode),
                                                            taxName2.hashCode),
                                                        taxRate2.hashCode),
                                                    invoiceItemTypeId.hashCode),
                                                customValue1.hashCode),
                                            customValue2.hashCode),
                                        discount.hashCode),
                                    taskId.hashCode),
                                expenseId.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvoiceItemEntity')
          ..add('productKey', productKey)
          ..add('notes', notes)
          ..add('cost', cost)
          ..add('qty', qty)
          ..add('taxName1', taxName1)
          ..add('taxRate1', taxRate1)
          ..add('taxName2', taxName2)
          ..add('taxRate2', taxRate2)
          ..add('invoiceItemTypeId', invoiceItemTypeId)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('discount', discount)
          ..add('taskId', taskId)
          ..add('expenseId', expenseId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
          ..add('id', id))
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

  double _qty;
  double get qty => _$this._qty;
  set qty(double qty) => _$this._qty = qty;

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

  int _invoiceItemTypeId;
  int get invoiceItemTypeId => _$this._invoiceItemTypeId;
  set invoiceItemTypeId(int invoiceItemTypeId) =>
      _$this._invoiceItemTypeId = invoiceItemTypeId;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  double _discount;
  double get discount => _$this._discount;
  set discount(double discount) => _$this._discount = discount;

  int _taskId;
  int get taskId => _$this._taskId;
  set taskId(int taskId) => _$this._taskId = taskId;

  int _expenseId;
  int get expenseId => _$this._expenseId;
  set expenseId(int expenseId) => _$this._expenseId = expenseId;

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

  InvoiceItemEntityBuilder();

  InvoiceItemEntityBuilder get _$this {
    if (_$v != null) {
      _productKey = _$v.productKey;
      _notes = _$v.notes;
      _cost = _$v.cost;
      _qty = _$v.qty;
      _taxName1 = _$v.taxName1;
      _taxRate1 = _$v.taxRate1;
      _taxName2 = _$v.taxName2;
      _taxRate2 = _$v.taxRate2;
      _invoiceItemTypeId = _$v.invoiceItemTypeId;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _discount = _$v.discount;
      _taskId = _$v.taskId;
      _expenseId = _$v.expenseId;
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
  void replace(InvoiceItemEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvoiceItemEntity;
  }

  @override
  void update(void updates(InvoiceItemEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$InvoiceItemEntity build() {
    final _$result = _$v ??
        new _$InvoiceItemEntity._(
            productKey: productKey,
            notes: notes,
            cost: cost,
            qty: qty,
            taxName1: taxName1,
            taxRate1: taxRate1,
            taxName2: taxName2,
            taxRate2: taxRate2,
            invoiceItemTypeId: invoiceItemTypeId,
            customValue1: customValue1,
            customValue2: customValue2,
            discount: discount,
            taskId: taskId,
            expenseId: expenseId,
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

  factory _$InvitationEntity([void updates(InvitationEntityBuilder b)]) =>
      (new InvitationEntityBuilder()..update(updates)).build();

  _$InvitationEntity._(
      {this.key,
      this.link,
      this.sentDate,
      this.viewedDate,
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
  InvitationEntity rebuild(void updates(InvitationEntityBuilder b)) =>
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
                                $jc($jc($jc(0, key.hashCode), link.hashCode),
                                    sentDate.hashCode),
                                viewedDate.hashCode),
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

  InvitationEntityBuilder();

  InvitationEntityBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _link = _$v.link;
      _sentDate = _$v.sentDate;
      _viewedDate = _$v.viewedDate;
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
  void update(void updates(InvitationEntityBuilder b)) {
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
