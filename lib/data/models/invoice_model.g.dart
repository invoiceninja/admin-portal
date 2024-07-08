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
Serializer<InvoiceScheduleEntity> _$invoiceScheduleEntitySerializer =
    new _$InvoiceScheduleEntitySerializer();
Serializer<InvoiceHistoryEntity> _$invoiceHistoryEntitySerializer =
    new _$InvoiceHistoryEntitySerializer();

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
  Iterable<Object?> serialize(
      Serializers serializers, InvoiceListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(InvoiceEntity)])),
    ];

    return result;
  }

  @override
  InvoiceListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceEntity)]))!
              as BuiltList<Object?>);
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
  Iterable<Object?> serialize(
      Serializers serializers, InvoiceItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(InvoiceEntity)),
    ];

    return result;
  }

  @override
  InvoiceItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(InvoiceEntity))! as InvoiceEntity);
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
  Iterable<Object?> serialize(Serializers serializers, InvoiceEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'balance',
      serializers.serialize(object.balance,
          specifiedType: const FullType(double)),
      'paid_to_date',
      serializers.serialize(object.paidToDate,
          specifiedType: const FullType(double)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
      'project_id',
      serializers.serialize(object.projectId,
          specifiedType: const FullType(String)),
      'expense_id',
      serializers.serialize(object.expenseId,
          specifiedType: const FullType(String)),
      'vendor_id',
      serializers.serialize(object.vendorId,
          specifiedType: const FullType(String)),
      'subscription_id',
      serializers.serialize(object.subscriptionId,
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
      'total_taxes',
      serializers.serialize(object.taxAmount,
          specifiedType: const FullType(double)),
      'partial_due_date',
      serializers.serialize(object.partialDueDate,
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
      'custom_surcharge_tax1',
      serializers.serialize(object.customTaxes1,
          specifiedType: const FullType(bool)),
      'custom_surcharge_tax2',
      serializers.serialize(object.customTaxes2,
          specifiedType: const FullType(bool)),
      'custom_surcharge_tax3',
      serializers.serialize(object.customTaxes3,
          specifiedType: const FullType(bool)),
      'custom_surcharge_tax4',
      serializers.serialize(object.customTaxes4,
          specifiedType: const FullType(bool)),
      'exchange_rate',
      serializers.serialize(object.exchangeRate,
          specifiedType: const FullType(double)),
      'last_sent_date',
      serializers.serialize(object.lastSentDate,
          specifiedType: const FullType(String)),
      'next_send_date',
      serializers.serialize(object.nextSendDate,
          specifiedType: const FullType(String)),
      'next_send_datetime',
      serializers.serialize(object.nextSendDatetime,
          specifiedType: const FullType(String)),
      'auto_bill_enabled',
      serializers.serialize(object.autoBillEnabled,
          specifiedType: const FullType(bool)),
      'line_items',
      serializers.serialize(object.lineItems,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvoiceItemEntity)])),
      'invitations',
      serializers.serialize(object.invitations,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvitationEntity)])),
      'documents',
      serializers.serialize(object.documents,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
      'activities',
      serializers.serialize(object.activities,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ActivityEntity)])),
      'tax_info',
      serializers.serialize(object.taxData,
          specifiedType: const FullType(TaxDataEntity)),
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
    value = object.idempotencyKey;
    if (value != null) {
      result
        ..add('idempotency_key')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.autoBill;
    if (value != null) {
      result
        ..add('auto_bill')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reminder1Sent;
    if (value != null) {
      result
        ..add('reminder1_sent')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reminder2Sent;
    if (value != null) {
      result
        ..add('reminder2_sent')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reminder3Sent;
    if (value != null) {
      result
        ..add('reminder3_sent')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reminderLastSent;
    if (value != null) {
      result
        ..add('reminder_last_sent')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.frequencyId;
    if (value != null) {
      result
        ..add('frequency_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.remainingCycles;
    if (value != null) {
      result
        ..add('remaining_cycles')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.dueDateDays;
    if (value != null) {
      result
        ..add('due_date_days')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.invoiceId;
    if (value != null) {
      result
        ..add('invoice_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.recurringId;
    if (value != null) {
      result
        ..add('recurring_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.recurringDates;
    if (value != null) {
      result
        ..add('recurring_dates')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(InvoiceScheduleEntity)])));
    }
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
    value = object.entityType;
    if (value != null) {
      result
        ..add('entity_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(EntityType)));
    }
    return result;
  }

  @override
  InvoiceEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'idempotency_key':
          result.idempotencyKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'paid_to_date':
          result.paidToDate = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'project_id':
          result.projectId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'expense_id':
          result.expenseId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'vendor_id':
          result.vendorId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'subscription_id':
          result.subscriptionId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status_id':
          result.statusId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'discount':
          result.discount = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'po_number':
          result.poNumber = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'due_date':
          result.dueDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'public_notes':
          result.publicNotes = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'private_notes':
          result.privateNotes = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'terms':
          result.terms = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'footer':
          result.footer = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'design_id':
          result.designId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'uses_inclusive_taxes':
          result.usesInclusiveTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'tax_name1':
          result.taxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_rate1':
          result.taxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tax_name2':
          result.taxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_rate2':
          result.taxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tax_name3':
          result.taxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_rate3':
          result.taxRate3 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'is_amount_discount':
          result.isAmountDiscount = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'partial':
          result.partial = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'total_taxes':
          result.taxAmount = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'partial_due_date':
          result.partialDueDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'auto_bill':
          result.autoBill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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
        case 'custom_surcharge1':
          result.customSurcharge1 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'custom_surcharge2':
          result.customSurcharge2 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'custom_surcharge3':
          result.customSurcharge3 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'custom_surcharge4':
          result.customSurcharge4 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'custom_surcharge_tax1':
          result.customTaxes1 = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'custom_surcharge_tax2':
          result.customTaxes2 = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'custom_surcharge_tax3':
          result.customTaxes3 = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'custom_surcharge_tax4':
          result.customTaxes4 = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'exchange_rate':
          result.exchangeRate = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'reminder1_sent':
          result.reminder1Sent = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'reminder2_sent':
          result.reminder2Sent = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'reminder3_sent':
          result.reminder3Sent = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'reminder_last_sent':
          result.reminderLastSent = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'frequency_id':
          result.frequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'last_sent_date':
          result.lastSentDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'next_send_date':
          result.nextSendDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'next_send_datetime':
          result.nextSendDatetime = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'remaining_cycles':
          result.remainingCycles = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'due_date_days':
          result.dueDateDays = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'invoice_id':
          result.invoiceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'recurring_id':
          result.recurringId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'auto_bill_enabled':
          result.autoBillEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'recurring_dates':
          result.recurringDates.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(InvoiceScheduleEntity)
              ]))! as BuiltList<Object?>);
          break;
        case 'line_items':
          result.lineItems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvoiceItemEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'invitations':
          result.invitations.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvitationEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'activities':
          result.activities.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ActivityEntity)]))!
              as BuiltList<Object?>);
          break;
        case 'tax_info':
          result.taxData.replace(serializers.deserialize(value,
              specifiedType: const FullType(TaxDataEntity))! as TaxDataEntity);
          break;
        case 'loadedAt':
          result.loadedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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
        case 'entity_type':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType?;
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

class _$InvoiceItemEntitySerializer
    implements StructuredSerializer<InvoiceItemEntity> {
  @override
  final Iterable<Type> types = const [InvoiceItemEntity, _$InvoiceItemEntity];
  @override
  final String wireName = 'InvoiceItemEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, InvoiceItemEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'product_key',
      serializers.serialize(object.productKey,
          specifiedType: const FullType(String)),
      'notes',
      serializers.serialize(object.notes,
          specifiedType: const FullType(String)),
      'cost',
      serializers.serialize(object.cost, specifiedType: const FullType(double)),
      'product_cost',
      serializers.serialize(object.productCost,
          specifiedType: const FullType(double)),
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
      'tax_id',
      serializers.serialize(object.taxCategoryId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.typeId;
    if (value != null) {
      result
        ..add('type_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.taskId;
    if (value != null) {
      result
        ..add('task_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.expenseId;
    if (value != null) {
      result
        ..add('expense_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  InvoiceItemEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceItemEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'product_key':
          result.productKey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'notes':
          result.notes = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'cost':
          result.cost = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'product_cost':
          result.productCost = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tax_name1':
          result.taxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_rate1':
          result.taxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tax_name2':
          result.taxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_rate2':
          result.taxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tax_name3':
          result.taxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tax_rate3':
          result.taxRate3 = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'type_id':
          result.typeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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
        case 'discount':
          result.discount = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'task_id':
          result.taskId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'expense_id':
          result.expenseId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'tax_id':
          result.taxCategoryId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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
  Iterable<Object?> serialize(Serializers serializers, InvitationEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'key',
      serializers.serialize(object.key, specifiedType: const FullType(String)),
      'link',
      serializers.serialize(object.link, specifiedType: const FullType(String)),
      'client_contact_id',
      serializers.serialize(object.clientContactId,
          specifiedType: const FullType(String)),
      'vendor_contact_id',
      serializers.serialize(object.vendorContactId,
          specifiedType: const FullType(String)),
      'sent_date',
      serializers.serialize(object.sentDate,
          specifiedType: const FullType(String)),
      'viewed_date',
      serializers.serialize(object.viewedDate,
          specifiedType: const FullType(String)),
      'opened_date',
      serializers.serialize(object.openedDate,
          specifiedType: const FullType(String)),
      'email_status',
      serializers.serialize(object.emailStatus,
          specifiedType: const FullType(String)),
      'email_error',
      serializers.serialize(object.emailError,
          specifiedType: const FullType(String)),
      'message_id',
      serializers.serialize(object.messageId,
          specifiedType: const FullType(String)),
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
    value = object.entityType;
    if (value != null) {
      result
        ..add('entity_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(EntityType)));
    }
    return result;
  }

  @override
  InvitationEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvitationEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'key':
          result.key = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'link':
          result.link = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'client_contact_id':
          result.clientContactId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'vendor_contact_id':
          result.vendorContactId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sent_date':
          result.sentDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'viewed_date':
          result.viewedDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'opened_date':
          result.openedDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email_status':
          result.emailStatus = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email_error':
          result.emailError = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'message_id':
          result.messageId = serializers.deserialize(value,
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
        case 'entity_type':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType)) as EntityType?;
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

class _$InvoiceScheduleEntitySerializer
    implements StructuredSerializer<InvoiceScheduleEntity> {
  @override
  final Iterable<Type> types = const [
    InvoiceScheduleEntity,
    _$InvoiceScheduleEntity
  ];
  @override
  final String wireName = 'InvoiceScheduleEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, InvoiceScheduleEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'send_date',
      serializers.serialize(object.sendDate,
          specifiedType: const FullType(String)),
      'due_date',
      serializers.serialize(object.dueDate,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  InvoiceScheduleEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceScheduleEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'send_date':
          result.sendDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'due_date':
          result.dueDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$InvoiceHistoryEntitySerializer
    implements StructuredSerializer<InvoiceHistoryEntity> {
  @override
  final Iterable<Type> types = const [
    InvoiceHistoryEntity,
    _$InvoiceHistoryEntity
  ];
  @override
  final String wireName = 'InvoiceHistoryEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, InvoiceHistoryEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'activity_id',
      serializers.serialize(object.activityId,
          specifiedType: const FullType(String)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  InvoiceHistoryEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvoiceHistoryEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'activity_id':
          result.activityId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
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
          [void Function(InvoiceListResponseBuilder)? updates]) =>
      (new InvoiceListResponseBuilder()..update(updates))._build();

  _$InvoiceListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'InvoiceListResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'InvoiceListResponse')
          ..add('data', data))
        .toString();
  }
}

class InvoiceListResponseBuilder
    implements Builder<InvoiceListResponse, InvoiceListResponseBuilder> {
  _$InvoiceListResponse? _$v;

  ListBuilder<InvoiceEntity>? _data;
  ListBuilder<InvoiceEntity> get data =>
      _$this._data ??= new ListBuilder<InvoiceEntity>();
  set data(ListBuilder<InvoiceEntity>? data) => _$this._data = data;

  InvoiceListResponseBuilder();

  InvoiceListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InvoiceListResponse;
  }

  @override
  void update(void Function(InvoiceListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvoiceListResponse build() => _build();

  _$InvoiceListResponse _build() {
    _$InvoiceListResponse _$result;
    try {
      _$result = _$v ?? new _$InvoiceListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'InvoiceListResponse', _$failedField, e.toString());
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
          [void Function(InvoiceItemResponseBuilder)? updates]) =>
      (new InvoiceItemResponseBuilder()..update(updates))._build();

  _$InvoiceItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'InvoiceItemResponse', 'data');
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
    return (newBuiltValueToStringHelper(r'InvoiceItemResponse')
          ..add('data', data))
        .toString();
  }
}

class InvoiceItemResponseBuilder
    implements Builder<InvoiceItemResponse, InvoiceItemResponseBuilder> {
  _$InvoiceItemResponse? _$v;

  InvoiceEntityBuilder? _data;
  InvoiceEntityBuilder get data => _$this._data ??= new InvoiceEntityBuilder();
  set data(InvoiceEntityBuilder? data) => _$this._data = data;

  InvoiceItemResponseBuilder();

  InvoiceItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InvoiceItemResponse;
  }

  @override
  void update(void Function(InvoiceItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvoiceItemResponse build() => _build();

  _$InvoiceItemResponse _build() {
    _$InvoiceItemResponse _$result;
    try {
      _$result = _$v ?? new _$InvoiceItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'InvoiceItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceEntity extends InvoiceEntity {
  @override
  final String? idempotencyKey;
  @override
  final double amount;
  @override
  final double balance;
  @override
  final double paidToDate;
  @override
  final String clientId;
  @override
  final String projectId;
  @override
  final String expenseId;
  @override
  final String vendorId;
  @override
  final String subscriptionId;
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
  final double taxAmount;
  @override
  final String partialDueDate;
  @override
  final String? autoBill;
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
  final double exchangeRate;
  @override
  final String? reminder1Sent;
  @override
  final String? reminder2Sent;
  @override
  final String? reminder3Sent;
  @override
  final String? reminderLastSent;
  @override
  final String? frequencyId;
  @override
  final String lastSentDate;
  @override
  final String nextSendDate;
  @override
  final String nextSendDatetime;
  @override
  final int? remainingCycles;
  @override
  final String? dueDateDays;
  @override
  final String? invoiceId;
  @override
  final String? recurringId;
  @override
  final bool autoBillEnabled;
  @override
  final BuiltList<InvoiceScheduleEntity>? recurringDates;
  @override
  final BuiltList<InvoiceItemEntity> lineItems;
  @override
  final BuiltList<InvitationEntity> invitations;
  @override
  final BuiltList<DocumentEntity> documents;
  @override
  final BuiltList<ActivityEntity> activities;
  @override
  final bool saveDefaultTerms;
  @override
  final bool saveDefaultFooter;
  @override
  final TaxDataEntity taxData;
  @override
  final int? loadedAt;
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
  final EntityType? entityType;
  @override
  final String id;

  factory _$InvoiceEntity([void Function(InvoiceEntityBuilder)? updates]) =>
      (new InvoiceEntityBuilder()..update(updates))._build();

  _$InvoiceEntity._(
      {this.idempotencyKey,
      required this.amount,
      required this.balance,
      required this.paidToDate,
      required this.clientId,
      required this.projectId,
      required this.expenseId,
      required this.vendorId,
      required this.subscriptionId,
      required this.statusId,
      required this.number,
      required this.discount,
      required this.poNumber,
      required this.date,
      required this.dueDate,
      required this.publicNotes,
      required this.privateNotes,
      required this.terms,
      required this.footer,
      required this.designId,
      required this.usesInclusiveTaxes,
      required this.taxName1,
      required this.taxRate1,
      required this.taxName2,
      required this.taxRate2,
      required this.taxName3,
      required this.taxRate3,
      required this.isAmountDiscount,
      required this.partial,
      required this.taxAmount,
      required this.partialDueDate,
      this.autoBill,
      required this.customValue1,
      required this.customValue2,
      required this.customValue3,
      required this.customValue4,
      required this.customSurcharge1,
      required this.customSurcharge2,
      required this.customSurcharge3,
      required this.customSurcharge4,
      required this.customTaxes1,
      required this.customTaxes2,
      required this.customTaxes3,
      required this.customTaxes4,
      required this.exchangeRate,
      this.reminder1Sent,
      this.reminder2Sent,
      this.reminder3Sent,
      this.reminderLastSent,
      this.frequencyId,
      required this.lastSentDate,
      required this.nextSendDate,
      required this.nextSendDatetime,
      this.remainingCycles,
      this.dueDateDays,
      this.invoiceId,
      this.recurringId,
      required this.autoBillEnabled,
      this.recurringDates,
      required this.lineItems,
      required this.invitations,
      required this.documents,
      required this.activities,
      required this.saveDefaultTerms,
      required this.saveDefaultFooter,
      required this.taxData,
      this.loadedAt,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.entityType,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(amount, r'InvoiceEntity', 'amount');
    BuiltValueNullFieldError.checkNotNull(balance, r'InvoiceEntity', 'balance');
    BuiltValueNullFieldError.checkNotNull(
        paidToDate, r'InvoiceEntity', 'paidToDate');
    BuiltValueNullFieldError.checkNotNull(
        clientId, r'InvoiceEntity', 'clientId');
    BuiltValueNullFieldError.checkNotNull(
        projectId, r'InvoiceEntity', 'projectId');
    BuiltValueNullFieldError.checkNotNull(
        expenseId, r'InvoiceEntity', 'expenseId');
    BuiltValueNullFieldError.checkNotNull(
        vendorId, r'InvoiceEntity', 'vendorId');
    BuiltValueNullFieldError.checkNotNull(
        subscriptionId, r'InvoiceEntity', 'subscriptionId');
    BuiltValueNullFieldError.checkNotNull(
        statusId, r'InvoiceEntity', 'statusId');
    BuiltValueNullFieldError.checkNotNull(number, r'InvoiceEntity', 'number');
    BuiltValueNullFieldError.checkNotNull(
        discount, r'InvoiceEntity', 'discount');
    BuiltValueNullFieldError.checkNotNull(
        poNumber, r'InvoiceEntity', 'poNumber');
    BuiltValueNullFieldError.checkNotNull(date, r'InvoiceEntity', 'date');
    BuiltValueNullFieldError.checkNotNull(dueDate, r'InvoiceEntity', 'dueDate');
    BuiltValueNullFieldError.checkNotNull(
        publicNotes, r'InvoiceEntity', 'publicNotes');
    BuiltValueNullFieldError.checkNotNull(
        privateNotes, r'InvoiceEntity', 'privateNotes');
    BuiltValueNullFieldError.checkNotNull(terms, r'InvoiceEntity', 'terms');
    BuiltValueNullFieldError.checkNotNull(footer, r'InvoiceEntity', 'footer');
    BuiltValueNullFieldError.checkNotNull(
        designId, r'InvoiceEntity', 'designId');
    BuiltValueNullFieldError.checkNotNull(
        usesInclusiveTaxes, r'InvoiceEntity', 'usesInclusiveTaxes');
    BuiltValueNullFieldError.checkNotNull(
        taxName1, r'InvoiceEntity', 'taxName1');
    BuiltValueNullFieldError.checkNotNull(
        taxRate1, r'InvoiceEntity', 'taxRate1');
    BuiltValueNullFieldError.checkNotNull(
        taxName2, r'InvoiceEntity', 'taxName2');
    BuiltValueNullFieldError.checkNotNull(
        taxRate2, r'InvoiceEntity', 'taxRate2');
    BuiltValueNullFieldError.checkNotNull(
        taxName3, r'InvoiceEntity', 'taxName3');
    BuiltValueNullFieldError.checkNotNull(
        taxRate3, r'InvoiceEntity', 'taxRate3');
    BuiltValueNullFieldError.checkNotNull(
        isAmountDiscount, r'InvoiceEntity', 'isAmountDiscount');
    BuiltValueNullFieldError.checkNotNull(partial, r'InvoiceEntity', 'partial');
    BuiltValueNullFieldError.checkNotNull(
        taxAmount, r'InvoiceEntity', 'taxAmount');
    BuiltValueNullFieldError.checkNotNull(
        partialDueDate, r'InvoiceEntity', 'partialDueDate');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, r'InvoiceEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, r'InvoiceEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, r'InvoiceEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, r'InvoiceEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        customSurcharge1, r'InvoiceEntity', 'customSurcharge1');
    BuiltValueNullFieldError.checkNotNull(
        customSurcharge2, r'InvoiceEntity', 'customSurcharge2');
    BuiltValueNullFieldError.checkNotNull(
        customSurcharge3, r'InvoiceEntity', 'customSurcharge3');
    BuiltValueNullFieldError.checkNotNull(
        customSurcharge4, r'InvoiceEntity', 'customSurcharge4');
    BuiltValueNullFieldError.checkNotNull(
        customTaxes1, r'InvoiceEntity', 'customTaxes1');
    BuiltValueNullFieldError.checkNotNull(
        customTaxes2, r'InvoiceEntity', 'customTaxes2');
    BuiltValueNullFieldError.checkNotNull(
        customTaxes3, r'InvoiceEntity', 'customTaxes3');
    BuiltValueNullFieldError.checkNotNull(
        customTaxes4, r'InvoiceEntity', 'customTaxes4');
    BuiltValueNullFieldError.checkNotNull(
        exchangeRate, r'InvoiceEntity', 'exchangeRate');
    BuiltValueNullFieldError.checkNotNull(
        lastSentDate, r'InvoiceEntity', 'lastSentDate');
    BuiltValueNullFieldError.checkNotNull(
        nextSendDate, r'InvoiceEntity', 'nextSendDate');
    BuiltValueNullFieldError.checkNotNull(
        nextSendDatetime, r'InvoiceEntity', 'nextSendDatetime');
    BuiltValueNullFieldError.checkNotNull(
        autoBillEnabled, r'InvoiceEntity', 'autoBillEnabled');
    BuiltValueNullFieldError.checkNotNull(
        lineItems, r'InvoiceEntity', 'lineItems');
    BuiltValueNullFieldError.checkNotNull(
        invitations, r'InvoiceEntity', 'invitations');
    BuiltValueNullFieldError.checkNotNull(
        documents, r'InvoiceEntity', 'documents');
    BuiltValueNullFieldError.checkNotNull(
        activities, r'InvoiceEntity', 'activities');
    BuiltValueNullFieldError.checkNotNull(
        saveDefaultTerms, r'InvoiceEntity', 'saveDefaultTerms');
    BuiltValueNullFieldError.checkNotNull(
        saveDefaultFooter, r'InvoiceEntity', 'saveDefaultFooter');
    BuiltValueNullFieldError.checkNotNull(taxData, r'InvoiceEntity', 'taxData');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'InvoiceEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'InvoiceEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'InvoiceEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'InvoiceEntity', 'id');
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
        idempotencyKey == other.idempotencyKey &&
        amount == other.amount &&
        balance == other.balance &&
        paidToDate == other.paidToDate &&
        clientId == other.clientId &&
        projectId == other.projectId &&
        expenseId == other.expenseId &&
        vendorId == other.vendorId &&
        subscriptionId == other.subscriptionId &&
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
        taxAmount == other.taxAmount &&
        partialDueDate == other.partialDueDate &&
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
        exchangeRate == other.exchangeRate &&
        reminder1Sent == other.reminder1Sent &&
        reminder2Sent == other.reminder2Sent &&
        reminder3Sent == other.reminder3Sent &&
        reminderLastSent == other.reminderLastSent &&
        frequencyId == other.frequencyId &&
        lastSentDate == other.lastSentDate &&
        nextSendDate == other.nextSendDate &&
        nextSendDatetime == other.nextSendDatetime &&
        remainingCycles == other.remainingCycles &&
        dueDateDays == other.dueDateDays &&
        invoiceId == other.invoiceId &&
        recurringId == other.recurringId &&
        autoBillEnabled == other.autoBillEnabled &&
        recurringDates == other.recurringDates &&
        lineItems == other.lineItems &&
        invitations == other.invitations &&
        documents == other.documents &&
        saveDefaultTerms == other.saveDefaultTerms &&
        saveDefaultFooter == other.saveDefaultFooter &&
        taxData == other.taxData &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        entityType == other.entityType &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jc(_$hash, paidToDate.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, projectId.hashCode);
    _$hash = $jc(_$hash, expenseId.hashCode);
    _$hash = $jc(_$hash, vendorId.hashCode);
    _$hash = $jc(_$hash, subscriptionId.hashCode);
    _$hash = $jc(_$hash, statusId.hashCode);
    _$hash = $jc(_$hash, number.hashCode);
    _$hash = $jc(_$hash, discount.hashCode);
    _$hash = $jc(_$hash, poNumber.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, publicNotes.hashCode);
    _$hash = $jc(_$hash, privateNotes.hashCode);
    _$hash = $jc(_$hash, terms.hashCode);
    _$hash = $jc(_$hash, footer.hashCode);
    _$hash = $jc(_$hash, designId.hashCode);
    _$hash = $jc(_$hash, usesInclusiveTaxes.hashCode);
    _$hash = $jc(_$hash, taxName1.hashCode);
    _$hash = $jc(_$hash, taxRate1.hashCode);
    _$hash = $jc(_$hash, taxName2.hashCode);
    _$hash = $jc(_$hash, taxRate2.hashCode);
    _$hash = $jc(_$hash, taxName3.hashCode);
    _$hash = $jc(_$hash, taxRate3.hashCode);
    _$hash = $jc(_$hash, isAmountDiscount.hashCode);
    _$hash = $jc(_$hash, partial.hashCode);
    _$hash = $jc(_$hash, taxAmount.hashCode);
    _$hash = $jc(_$hash, partialDueDate.hashCode);
    _$hash = $jc(_$hash, autoBill.hashCode);
    _$hash = $jc(_$hash, customValue1.hashCode);
    _$hash = $jc(_$hash, customValue2.hashCode);
    _$hash = $jc(_$hash, customValue3.hashCode);
    _$hash = $jc(_$hash, customValue4.hashCode);
    _$hash = $jc(_$hash, customSurcharge1.hashCode);
    _$hash = $jc(_$hash, customSurcharge2.hashCode);
    _$hash = $jc(_$hash, customSurcharge3.hashCode);
    _$hash = $jc(_$hash, customSurcharge4.hashCode);
    _$hash = $jc(_$hash, customTaxes1.hashCode);
    _$hash = $jc(_$hash, customTaxes2.hashCode);
    _$hash = $jc(_$hash, customTaxes3.hashCode);
    _$hash = $jc(_$hash, customTaxes4.hashCode);
    _$hash = $jc(_$hash, exchangeRate.hashCode);
    _$hash = $jc(_$hash, reminder1Sent.hashCode);
    _$hash = $jc(_$hash, reminder2Sent.hashCode);
    _$hash = $jc(_$hash, reminder3Sent.hashCode);
    _$hash = $jc(_$hash, reminderLastSent.hashCode);
    _$hash = $jc(_$hash, frequencyId.hashCode);
    _$hash = $jc(_$hash, lastSentDate.hashCode);
    _$hash = $jc(_$hash, nextSendDate.hashCode);
    _$hash = $jc(_$hash, nextSendDatetime.hashCode);
    _$hash = $jc(_$hash, remainingCycles.hashCode);
    _$hash = $jc(_$hash, dueDateDays.hashCode);
    _$hash = $jc(_$hash, invoiceId.hashCode);
    _$hash = $jc(_$hash, recurringId.hashCode);
    _$hash = $jc(_$hash, autoBillEnabled.hashCode);
    _$hash = $jc(_$hash, recurringDates.hashCode);
    _$hash = $jc(_$hash, lineItems.hashCode);
    _$hash = $jc(_$hash, invitations.hashCode);
    _$hash = $jc(_$hash, documents.hashCode);
    _$hash = $jc(_$hash, saveDefaultTerms.hashCode);
    _$hash = $jc(_$hash, saveDefaultFooter.hashCode);
    _$hash = $jc(_$hash, taxData.hashCode);
    _$hash = $jc(_$hash, isChanged.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdUserId.hashCode);
    _$hash = $jc(_$hash, assignedUserId.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvoiceEntity')
          ..add('idempotencyKey', idempotencyKey)
          ..add('amount', amount)
          ..add('balance', balance)
          ..add('paidToDate', paidToDate)
          ..add('clientId', clientId)
          ..add('projectId', projectId)
          ..add('expenseId', expenseId)
          ..add('vendorId', vendorId)
          ..add('subscriptionId', subscriptionId)
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
          ..add('taxAmount', taxAmount)
          ..add('partialDueDate', partialDueDate)
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
          ..add('exchangeRate', exchangeRate)
          ..add('reminder1Sent', reminder1Sent)
          ..add('reminder2Sent', reminder2Sent)
          ..add('reminder3Sent', reminder3Sent)
          ..add('reminderLastSent', reminderLastSent)
          ..add('frequencyId', frequencyId)
          ..add('lastSentDate', lastSentDate)
          ..add('nextSendDate', nextSendDate)
          ..add('nextSendDatetime', nextSendDatetime)
          ..add('remainingCycles', remainingCycles)
          ..add('dueDateDays', dueDateDays)
          ..add('invoiceId', invoiceId)
          ..add('recurringId', recurringId)
          ..add('autoBillEnabled', autoBillEnabled)
          ..add('recurringDates', recurringDates)
          ..add('lineItems', lineItems)
          ..add('invitations', invitations)
          ..add('documents', documents)
          ..add('activities', activities)
          ..add('saveDefaultTerms', saveDefaultTerms)
          ..add('saveDefaultFooter', saveDefaultFooter)
          ..add('taxData', taxData)
          ..add('loadedAt', loadedAt)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('entityType', entityType)
          ..add('id', id))
        .toString();
  }
}

class InvoiceEntityBuilder
    implements Builder<InvoiceEntity, InvoiceEntityBuilder> {
  _$InvoiceEntity? _$v;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  double? _balance;
  double? get balance => _$this._balance;
  set balance(double? balance) => _$this._balance = balance;

  double? _paidToDate;
  double? get paidToDate => _$this._paidToDate;
  set paidToDate(double? paidToDate) => _$this._paidToDate = paidToDate;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _projectId;
  String? get projectId => _$this._projectId;
  set projectId(String? projectId) => _$this._projectId = projectId;

  String? _expenseId;
  String? get expenseId => _$this._expenseId;
  set expenseId(String? expenseId) => _$this._expenseId = expenseId;

  String? _vendorId;
  String? get vendorId => _$this._vendorId;
  set vendorId(String? vendorId) => _$this._vendorId = vendorId;

  String? _subscriptionId;
  String? get subscriptionId => _$this._subscriptionId;
  set subscriptionId(String? subscriptionId) =>
      _$this._subscriptionId = subscriptionId;

  String? _statusId;
  String? get statusId => _$this._statusId;
  set statusId(String? statusId) => _$this._statusId = statusId;

  String? _number;
  String? get number => _$this._number;
  set number(String? number) => _$this._number = number;

  double? _discount;
  double? get discount => _$this._discount;
  set discount(double? discount) => _$this._discount = discount;

  String? _poNumber;
  String? get poNumber => _$this._poNumber;
  set poNumber(String? poNumber) => _$this._poNumber = poNumber;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  String? _dueDate;
  String? get dueDate => _$this._dueDate;
  set dueDate(String? dueDate) => _$this._dueDate = dueDate;

  String? _publicNotes;
  String? get publicNotes => _$this._publicNotes;
  set publicNotes(String? publicNotes) => _$this._publicNotes = publicNotes;

  String? _privateNotes;
  String? get privateNotes => _$this._privateNotes;
  set privateNotes(String? privateNotes) => _$this._privateNotes = privateNotes;

  String? _terms;
  String? get terms => _$this._terms;
  set terms(String? terms) => _$this._terms = terms;

  String? _footer;
  String? get footer => _$this._footer;
  set footer(String? footer) => _$this._footer = footer;

  String? _designId;
  String? get designId => _$this._designId;
  set designId(String? designId) => _$this._designId = designId;

  bool? _usesInclusiveTaxes;
  bool? get usesInclusiveTaxes => _$this._usesInclusiveTaxes;
  set usesInclusiveTaxes(bool? usesInclusiveTaxes) =>
      _$this._usesInclusiveTaxes = usesInclusiveTaxes;

  String? _taxName1;
  String? get taxName1 => _$this._taxName1;
  set taxName1(String? taxName1) => _$this._taxName1 = taxName1;

  double? _taxRate1;
  double? get taxRate1 => _$this._taxRate1;
  set taxRate1(double? taxRate1) => _$this._taxRate1 = taxRate1;

  String? _taxName2;
  String? get taxName2 => _$this._taxName2;
  set taxName2(String? taxName2) => _$this._taxName2 = taxName2;

  double? _taxRate2;
  double? get taxRate2 => _$this._taxRate2;
  set taxRate2(double? taxRate2) => _$this._taxRate2 = taxRate2;

  String? _taxName3;
  String? get taxName3 => _$this._taxName3;
  set taxName3(String? taxName3) => _$this._taxName3 = taxName3;

  double? _taxRate3;
  double? get taxRate3 => _$this._taxRate3;
  set taxRate3(double? taxRate3) => _$this._taxRate3 = taxRate3;

  bool? _isAmountDiscount;
  bool? get isAmountDiscount => _$this._isAmountDiscount;
  set isAmountDiscount(bool? isAmountDiscount) =>
      _$this._isAmountDiscount = isAmountDiscount;

  double? _partial;
  double? get partial => _$this._partial;
  set partial(double? partial) => _$this._partial = partial;

  double? _taxAmount;
  double? get taxAmount => _$this._taxAmount;
  set taxAmount(double? taxAmount) => _$this._taxAmount = taxAmount;

  String? _partialDueDate;
  String? get partialDueDate => _$this._partialDueDate;
  set partialDueDate(String? partialDueDate) =>
      _$this._partialDueDate = partialDueDate;

  String? _autoBill;
  String? get autoBill => _$this._autoBill;
  set autoBill(String? autoBill) => _$this._autoBill = autoBill;

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

  double? _customSurcharge1;
  double? get customSurcharge1 => _$this._customSurcharge1;
  set customSurcharge1(double? customSurcharge1) =>
      _$this._customSurcharge1 = customSurcharge1;

  double? _customSurcharge2;
  double? get customSurcharge2 => _$this._customSurcharge2;
  set customSurcharge2(double? customSurcharge2) =>
      _$this._customSurcharge2 = customSurcharge2;

  double? _customSurcharge3;
  double? get customSurcharge3 => _$this._customSurcharge3;
  set customSurcharge3(double? customSurcharge3) =>
      _$this._customSurcharge3 = customSurcharge3;

  double? _customSurcharge4;
  double? get customSurcharge4 => _$this._customSurcharge4;
  set customSurcharge4(double? customSurcharge4) =>
      _$this._customSurcharge4 = customSurcharge4;

  bool? _customTaxes1;
  bool? get customTaxes1 => _$this._customTaxes1;
  set customTaxes1(bool? customTaxes1) => _$this._customTaxes1 = customTaxes1;

  bool? _customTaxes2;
  bool? get customTaxes2 => _$this._customTaxes2;
  set customTaxes2(bool? customTaxes2) => _$this._customTaxes2 = customTaxes2;

  bool? _customTaxes3;
  bool? get customTaxes3 => _$this._customTaxes3;
  set customTaxes3(bool? customTaxes3) => _$this._customTaxes3 = customTaxes3;

  bool? _customTaxes4;
  bool? get customTaxes4 => _$this._customTaxes4;
  set customTaxes4(bool? customTaxes4) => _$this._customTaxes4 = customTaxes4;

  double? _exchangeRate;
  double? get exchangeRate => _$this._exchangeRate;
  set exchangeRate(double? exchangeRate) => _$this._exchangeRate = exchangeRate;

  String? _reminder1Sent;
  String? get reminder1Sent => _$this._reminder1Sent;
  set reminder1Sent(String? reminder1Sent) =>
      _$this._reminder1Sent = reminder1Sent;

  String? _reminder2Sent;
  String? get reminder2Sent => _$this._reminder2Sent;
  set reminder2Sent(String? reminder2Sent) =>
      _$this._reminder2Sent = reminder2Sent;

  String? _reminder3Sent;
  String? get reminder3Sent => _$this._reminder3Sent;
  set reminder3Sent(String? reminder3Sent) =>
      _$this._reminder3Sent = reminder3Sent;

  String? _reminderLastSent;
  String? get reminderLastSent => _$this._reminderLastSent;
  set reminderLastSent(String? reminderLastSent) =>
      _$this._reminderLastSent = reminderLastSent;

  String? _frequencyId;
  String? get frequencyId => _$this._frequencyId;
  set frequencyId(String? frequencyId) => _$this._frequencyId = frequencyId;

  String? _lastSentDate;
  String? get lastSentDate => _$this._lastSentDate;
  set lastSentDate(String? lastSentDate) => _$this._lastSentDate = lastSentDate;

  String? _nextSendDate;
  String? get nextSendDate => _$this._nextSendDate;
  set nextSendDate(String? nextSendDate) => _$this._nextSendDate = nextSendDate;

  String? _nextSendDatetime;
  String? get nextSendDatetime => _$this._nextSendDatetime;
  set nextSendDatetime(String? nextSendDatetime) =>
      _$this._nextSendDatetime = nextSendDatetime;

  int? _remainingCycles;
  int? get remainingCycles => _$this._remainingCycles;
  set remainingCycles(int? remainingCycles) =>
      _$this._remainingCycles = remainingCycles;

  String? _dueDateDays;
  String? get dueDateDays => _$this._dueDateDays;
  set dueDateDays(String? dueDateDays) => _$this._dueDateDays = dueDateDays;

  String? _invoiceId;
  String? get invoiceId => _$this._invoiceId;
  set invoiceId(String? invoiceId) => _$this._invoiceId = invoiceId;

  String? _recurringId;
  String? get recurringId => _$this._recurringId;
  set recurringId(String? recurringId) => _$this._recurringId = recurringId;

  bool? _autoBillEnabled;
  bool? get autoBillEnabled => _$this._autoBillEnabled;
  set autoBillEnabled(bool? autoBillEnabled) =>
      _$this._autoBillEnabled = autoBillEnabled;

  ListBuilder<InvoiceScheduleEntity>? _recurringDates;
  ListBuilder<InvoiceScheduleEntity> get recurringDates =>
      _$this._recurringDates ??= new ListBuilder<InvoiceScheduleEntity>();
  set recurringDates(ListBuilder<InvoiceScheduleEntity>? recurringDates) =>
      _$this._recurringDates = recurringDates;

  ListBuilder<InvoiceItemEntity>? _lineItems;
  ListBuilder<InvoiceItemEntity> get lineItems =>
      _$this._lineItems ??= new ListBuilder<InvoiceItemEntity>();
  set lineItems(ListBuilder<InvoiceItemEntity>? lineItems) =>
      _$this._lineItems = lineItems;

  ListBuilder<InvitationEntity>? _invitations;
  ListBuilder<InvitationEntity> get invitations =>
      _$this._invitations ??= new ListBuilder<InvitationEntity>();
  set invitations(ListBuilder<InvitationEntity>? invitations) =>
      _$this._invitations = invitations;

  ListBuilder<DocumentEntity>? _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity>? documents) =>
      _$this._documents = documents;

  ListBuilder<ActivityEntity>? _activities;
  ListBuilder<ActivityEntity> get activities =>
      _$this._activities ??= new ListBuilder<ActivityEntity>();
  set activities(ListBuilder<ActivityEntity>? activities) =>
      _$this._activities = activities;

  bool? _saveDefaultTerms;
  bool? get saveDefaultTerms => _$this._saveDefaultTerms;
  set saveDefaultTerms(bool? saveDefaultTerms) =>
      _$this._saveDefaultTerms = saveDefaultTerms;

  bool? _saveDefaultFooter;
  bool? get saveDefaultFooter => _$this._saveDefaultFooter;
  set saveDefaultFooter(bool? saveDefaultFooter) =>
      _$this._saveDefaultFooter = saveDefaultFooter;

  TaxDataEntityBuilder? _taxData;
  TaxDataEntityBuilder get taxData =>
      _$this._taxData ??= new TaxDataEntityBuilder();
  set taxData(TaxDataEntityBuilder? taxData) => _$this._taxData = taxData;

  int? _loadedAt;
  int? get loadedAt => _$this._loadedAt;
  set loadedAt(int? loadedAt) => _$this._loadedAt = loadedAt;

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

  EntityType? _entityType;
  EntityType? get entityType => _$this._entityType;
  set entityType(EntityType? entityType) => _$this._entityType = entityType;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  InvoiceEntityBuilder() {
    InvoiceEntity._initializeBuilder(this);
  }

  InvoiceEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idempotencyKey = $v.idempotencyKey;
      _amount = $v.amount;
      _balance = $v.balance;
      _paidToDate = $v.paidToDate;
      _clientId = $v.clientId;
      _projectId = $v.projectId;
      _expenseId = $v.expenseId;
      _vendorId = $v.vendorId;
      _subscriptionId = $v.subscriptionId;
      _statusId = $v.statusId;
      _number = $v.number;
      _discount = $v.discount;
      _poNumber = $v.poNumber;
      _date = $v.date;
      _dueDate = $v.dueDate;
      _publicNotes = $v.publicNotes;
      _privateNotes = $v.privateNotes;
      _terms = $v.terms;
      _footer = $v.footer;
      _designId = $v.designId;
      _usesInclusiveTaxes = $v.usesInclusiveTaxes;
      _taxName1 = $v.taxName1;
      _taxRate1 = $v.taxRate1;
      _taxName2 = $v.taxName2;
      _taxRate2 = $v.taxRate2;
      _taxName3 = $v.taxName3;
      _taxRate3 = $v.taxRate3;
      _isAmountDiscount = $v.isAmountDiscount;
      _partial = $v.partial;
      _taxAmount = $v.taxAmount;
      _partialDueDate = $v.partialDueDate;
      _autoBill = $v.autoBill;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _customSurcharge1 = $v.customSurcharge1;
      _customSurcharge2 = $v.customSurcharge2;
      _customSurcharge3 = $v.customSurcharge3;
      _customSurcharge4 = $v.customSurcharge4;
      _customTaxes1 = $v.customTaxes1;
      _customTaxes2 = $v.customTaxes2;
      _customTaxes3 = $v.customTaxes3;
      _customTaxes4 = $v.customTaxes4;
      _exchangeRate = $v.exchangeRate;
      _reminder1Sent = $v.reminder1Sent;
      _reminder2Sent = $v.reminder2Sent;
      _reminder3Sent = $v.reminder3Sent;
      _reminderLastSent = $v.reminderLastSent;
      _frequencyId = $v.frequencyId;
      _lastSentDate = $v.lastSentDate;
      _nextSendDate = $v.nextSendDate;
      _nextSendDatetime = $v.nextSendDatetime;
      _remainingCycles = $v.remainingCycles;
      _dueDateDays = $v.dueDateDays;
      _invoiceId = $v.invoiceId;
      _recurringId = $v.recurringId;
      _autoBillEnabled = $v.autoBillEnabled;
      _recurringDates = $v.recurringDates?.toBuilder();
      _lineItems = $v.lineItems.toBuilder();
      _invitations = $v.invitations.toBuilder();
      _documents = $v.documents.toBuilder();
      _activities = $v.activities.toBuilder();
      _saveDefaultTerms = $v.saveDefaultTerms;
      _saveDefaultFooter = $v.saveDefaultFooter;
      _taxData = $v.taxData.toBuilder();
      _loadedAt = $v.loadedAt;
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _entityType = $v.entityType;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InvoiceEntity;
  }

  @override
  void update(void Function(InvoiceEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvoiceEntity build() => _build();

  _$InvoiceEntity _build() {
    _$InvoiceEntity _$result;
    try {
      _$result = _$v ??
          new _$InvoiceEntity._(
              idempotencyKey: idempotencyKey,
              amount: BuiltValueNullFieldError.checkNotNull(
                  amount, r'InvoiceEntity', 'amount'),
              balance: BuiltValueNullFieldError.checkNotNull(
                  balance, r'InvoiceEntity', 'balance'),
              paidToDate: BuiltValueNullFieldError.checkNotNull(
                  paidToDate, r'InvoiceEntity', 'paidToDate'),
              clientId: BuiltValueNullFieldError.checkNotNull(
                  clientId, r'InvoiceEntity', 'clientId'),
              projectId: BuiltValueNullFieldError.checkNotNull(
                  projectId, r'InvoiceEntity', 'projectId'),
              expenseId: BuiltValueNullFieldError.checkNotNull(
                  expenseId, r'InvoiceEntity', 'expenseId'),
              vendorId: BuiltValueNullFieldError.checkNotNull(
                  vendorId, r'InvoiceEntity', 'vendorId'),
              subscriptionId: BuiltValueNullFieldError.checkNotNull(
                  subscriptionId, r'InvoiceEntity', 'subscriptionId'),
              statusId: BuiltValueNullFieldError.checkNotNull(statusId, r'InvoiceEntity', 'statusId'),
              number: BuiltValueNullFieldError.checkNotNull(number, r'InvoiceEntity', 'number'),
              discount: BuiltValueNullFieldError.checkNotNull(discount, r'InvoiceEntity', 'discount'),
              poNumber: BuiltValueNullFieldError.checkNotNull(poNumber, r'InvoiceEntity', 'poNumber'),
              date: BuiltValueNullFieldError.checkNotNull(date, r'InvoiceEntity', 'date'),
              dueDate: BuiltValueNullFieldError.checkNotNull(dueDate, r'InvoiceEntity', 'dueDate'),
              publicNotes: BuiltValueNullFieldError.checkNotNull(publicNotes, r'InvoiceEntity', 'publicNotes'),
              privateNotes: BuiltValueNullFieldError.checkNotNull(privateNotes, r'InvoiceEntity', 'privateNotes'),
              terms: BuiltValueNullFieldError.checkNotNull(terms, r'InvoiceEntity', 'terms'),
              footer: BuiltValueNullFieldError.checkNotNull(footer, r'InvoiceEntity', 'footer'),
              designId: BuiltValueNullFieldError.checkNotNull(designId, r'InvoiceEntity', 'designId'),
              usesInclusiveTaxes: BuiltValueNullFieldError.checkNotNull(usesInclusiveTaxes, r'InvoiceEntity', 'usesInclusiveTaxes'),
              taxName1: BuiltValueNullFieldError.checkNotNull(taxName1, r'InvoiceEntity', 'taxName1'),
              taxRate1: BuiltValueNullFieldError.checkNotNull(taxRate1, r'InvoiceEntity', 'taxRate1'),
              taxName2: BuiltValueNullFieldError.checkNotNull(taxName2, r'InvoiceEntity', 'taxName2'),
              taxRate2: BuiltValueNullFieldError.checkNotNull(taxRate2, r'InvoiceEntity', 'taxRate2'),
              taxName3: BuiltValueNullFieldError.checkNotNull(taxName3, r'InvoiceEntity', 'taxName3'),
              taxRate3: BuiltValueNullFieldError.checkNotNull(taxRate3, r'InvoiceEntity', 'taxRate3'),
              isAmountDiscount: BuiltValueNullFieldError.checkNotNull(isAmountDiscount, r'InvoiceEntity', 'isAmountDiscount'),
              partial: BuiltValueNullFieldError.checkNotNull(partial, r'InvoiceEntity', 'partial'),
              taxAmount: BuiltValueNullFieldError.checkNotNull(taxAmount, r'InvoiceEntity', 'taxAmount'),
              partialDueDate: BuiltValueNullFieldError.checkNotNull(partialDueDate, r'InvoiceEntity', 'partialDueDate'),
              autoBill: autoBill,
              customValue1: BuiltValueNullFieldError.checkNotNull(customValue1, r'InvoiceEntity', 'customValue1'),
              customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, r'InvoiceEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, r'InvoiceEntity', 'customValue3'),
              customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, r'InvoiceEntity', 'customValue4'),
              customSurcharge1: BuiltValueNullFieldError.checkNotNull(customSurcharge1, r'InvoiceEntity', 'customSurcharge1'),
              customSurcharge2: BuiltValueNullFieldError.checkNotNull(customSurcharge2, r'InvoiceEntity', 'customSurcharge2'),
              customSurcharge3: BuiltValueNullFieldError.checkNotNull(customSurcharge3, r'InvoiceEntity', 'customSurcharge3'),
              customSurcharge4: BuiltValueNullFieldError.checkNotNull(customSurcharge4, r'InvoiceEntity', 'customSurcharge4'),
              customTaxes1: BuiltValueNullFieldError.checkNotNull(customTaxes1, r'InvoiceEntity', 'customTaxes1'),
              customTaxes2: BuiltValueNullFieldError.checkNotNull(customTaxes2, r'InvoiceEntity', 'customTaxes2'),
              customTaxes3: BuiltValueNullFieldError.checkNotNull(customTaxes3, r'InvoiceEntity', 'customTaxes3'),
              customTaxes4: BuiltValueNullFieldError.checkNotNull(customTaxes4, r'InvoiceEntity', 'customTaxes4'),
              exchangeRate: BuiltValueNullFieldError.checkNotNull(exchangeRate, r'InvoiceEntity', 'exchangeRate'),
              reminder1Sent: reminder1Sent,
              reminder2Sent: reminder2Sent,
              reminder3Sent: reminder3Sent,
              reminderLastSent: reminderLastSent,
              frequencyId: frequencyId,
              lastSentDate: BuiltValueNullFieldError.checkNotNull(lastSentDate, r'InvoiceEntity', 'lastSentDate'),
              nextSendDate: BuiltValueNullFieldError.checkNotNull(nextSendDate, r'InvoiceEntity', 'nextSendDate'),
              nextSendDatetime: BuiltValueNullFieldError.checkNotNull(nextSendDatetime, r'InvoiceEntity', 'nextSendDatetime'),
              remainingCycles: remainingCycles,
              dueDateDays: dueDateDays,
              invoiceId: invoiceId,
              recurringId: recurringId,
              autoBillEnabled: BuiltValueNullFieldError.checkNotNull(autoBillEnabled, r'InvoiceEntity', 'autoBillEnabled'),
              recurringDates: _recurringDates?.build(),
              lineItems: lineItems.build(),
              invitations: invitations.build(),
              documents: documents.build(),
              activities: activities.build(),
              saveDefaultTerms: BuiltValueNullFieldError.checkNotNull(saveDefaultTerms, r'InvoiceEntity', 'saveDefaultTerms'),
              saveDefaultFooter: BuiltValueNullFieldError.checkNotNull(saveDefaultFooter, r'InvoiceEntity', 'saveDefaultFooter'),
              taxData: taxData.build(),
              loadedAt: loadedAt,
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'InvoiceEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'InvoiceEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'InvoiceEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              entityType: entityType,
              id: BuiltValueNullFieldError.checkNotNull(id, r'InvoiceEntity', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recurringDates';
        _recurringDates?.build();
        _$failedField = 'lineItems';
        lineItems.build();
        _$failedField = 'invitations';
        invitations.build();
        _$failedField = 'documents';
        documents.build();
        _$failedField = 'activities';
        activities.build();

        _$failedField = 'taxData';
        taxData.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'InvoiceEntity', _$failedField, e.toString());
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
  final double productCost;
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
  final String? typeId;
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
  final String? taskId;
  @override
  final String? expenseId;
  @override
  final int? createdAt;
  @override
  final String taxCategoryId;

  factory _$InvoiceItemEntity(
          [void Function(InvoiceItemEntityBuilder)? updates]) =>
      (new InvoiceItemEntityBuilder()..update(updates))._build();

  _$InvoiceItemEntity._(
      {required this.productKey,
      required this.notes,
      required this.cost,
      required this.productCost,
      required this.quantity,
      required this.taxName1,
      required this.taxRate1,
      required this.taxName2,
      required this.taxRate2,
      required this.taxName3,
      required this.taxRate3,
      this.typeId,
      required this.customValue1,
      required this.customValue2,
      required this.customValue3,
      required this.customValue4,
      required this.discount,
      this.taskId,
      this.expenseId,
      this.createdAt,
      required this.taxCategoryId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        productKey, r'InvoiceItemEntity', 'productKey');
    BuiltValueNullFieldError.checkNotNull(notes, r'InvoiceItemEntity', 'notes');
    BuiltValueNullFieldError.checkNotNull(cost, r'InvoiceItemEntity', 'cost');
    BuiltValueNullFieldError.checkNotNull(
        productCost, r'InvoiceItemEntity', 'productCost');
    BuiltValueNullFieldError.checkNotNull(
        quantity, r'InvoiceItemEntity', 'quantity');
    BuiltValueNullFieldError.checkNotNull(
        taxName1, r'InvoiceItemEntity', 'taxName1');
    BuiltValueNullFieldError.checkNotNull(
        taxRate1, r'InvoiceItemEntity', 'taxRate1');
    BuiltValueNullFieldError.checkNotNull(
        taxName2, r'InvoiceItemEntity', 'taxName2');
    BuiltValueNullFieldError.checkNotNull(
        taxRate2, r'InvoiceItemEntity', 'taxRate2');
    BuiltValueNullFieldError.checkNotNull(
        taxName3, r'InvoiceItemEntity', 'taxName3');
    BuiltValueNullFieldError.checkNotNull(
        taxRate3, r'InvoiceItemEntity', 'taxRate3');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, r'InvoiceItemEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, r'InvoiceItemEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, r'InvoiceItemEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, r'InvoiceItemEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(
        discount, r'InvoiceItemEntity', 'discount');
    BuiltValueNullFieldError.checkNotNull(
        taxCategoryId, r'InvoiceItemEntity', 'taxCategoryId');
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
        productCost == other.productCost &&
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
        createdAt == other.createdAt &&
        taxCategoryId == other.taxCategoryId;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, productKey.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, cost.hashCode);
    _$hash = $jc(_$hash, productCost.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, taxName1.hashCode);
    _$hash = $jc(_$hash, taxRate1.hashCode);
    _$hash = $jc(_$hash, taxName2.hashCode);
    _$hash = $jc(_$hash, taxRate2.hashCode);
    _$hash = $jc(_$hash, taxName3.hashCode);
    _$hash = $jc(_$hash, taxRate3.hashCode);
    _$hash = $jc(_$hash, typeId.hashCode);
    _$hash = $jc(_$hash, customValue1.hashCode);
    _$hash = $jc(_$hash, customValue2.hashCode);
    _$hash = $jc(_$hash, customValue3.hashCode);
    _$hash = $jc(_$hash, customValue4.hashCode);
    _$hash = $jc(_$hash, discount.hashCode);
    _$hash = $jc(_$hash, taskId.hashCode);
    _$hash = $jc(_$hash, expenseId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, taxCategoryId.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvoiceItemEntity')
          ..add('productKey', productKey)
          ..add('notes', notes)
          ..add('cost', cost)
          ..add('productCost', productCost)
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
          ..add('createdAt', createdAt)
          ..add('taxCategoryId', taxCategoryId))
        .toString();
  }
}

class InvoiceItemEntityBuilder
    implements Builder<InvoiceItemEntity, InvoiceItemEntityBuilder> {
  _$InvoiceItemEntity? _$v;

  String? _productKey;
  String? get productKey => _$this._productKey;
  set productKey(String? productKey) => _$this._productKey = productKey;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  double? _cost;
  double? get cost => _$this._cost;
  set cost(double? cost) => _$this._cost = cost;

  double? _productCost;
  double? get productCost => _$this._productCost;
  set productCost(double? productCost) => _$this._productCost = productCost;

  double? _quantity;
  double? get quantity => _$this._quantity;
  set quantity(double? quantity) => _$this._quantity = quantity;

  String? _taxName1;
  String? get taxName1 => _$this._taxName1;
  set taxName1(String? taxName1) => _$this._taxName1 = taxName1;

  double? _taxRate1;
  double? get taxRate1 => _$this._taxRate1;
  set taxRate1(double? taxRate1) => _$this._taxRate1 = taxRate1;

  String? _taxName2;
  String? get taxName2 => _$this._taxName2;
  set taxName2(String? taxName2) => _$this._taxName2 = taxName2;

  double? _taxRate2;
  double? get taxRate2 => _$this._taxRate2;
  set taxRate2(double? taxRate2) => _$this._taxRate2 = taxRate2;

  String? _taxName3;
  String? get taxName3 => _$this._taxName3;
  set taxName3(String? taxName3) => _$this._taxName3 = taxName3;

  double? _taxRate3;
  double? get taxRate3 => _$this._taxRate3;
  set taxRate3(double? taxRate3) => _$this._taxRate3 = taxRate3;

  String? _typeId;
  String? get typeId => _$this._typeId;
  set typeId(String? typeId) => _$this._typeId = typeId;

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

  double? _discount;
  double? get discount => _$this._discount;
  set discount(double? discount) => _$this._discount = discount;

  String? _taskId;
  String? get taskId => _$this._taskId;
  set taskId(String? taskId) => _$this._taskId = taskId;

  String? _expenseId;
  String? get expenseId => _$this._expenseId;
  set expenseId(String? expenseId) => _$this._expenseId = expenseId;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  String? _taxCategoryId;
  String? get taxCategoryId => _$this._taxCategoryId;
  set taxCategoryId(String? taxCategoryId) =>
      _$this._taxCategoryId = taxCategoryId;

  InvoiceItemEntityBuilder() {
    InvoiceItemEntity._initializeBuilder(this);
  }

  InvoiceItemEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productKey = $v.productKey;
      _notes = $v.notes;
      _cost = $v.cost;
      _productCost = $v.productCost;
      _quantity = $v.quantity;
      _taxName1 = $v.taxName1;
      _taxRate1 = $v.taxRate1;
      _taxName2 = $v.taxName2;
      _taxRate2 = $v.taxRate2;
      _taxName3 = $v.taxName3;
      _taxRate3 = $v.taxRate3;
      _typeId = $v.typeId;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _discount = $v.discount;
      _taskId = $v.taskId;
      _expenseId = $v.expenseId;
      _createdAt = $v.createdAt;
      _taxCategoryId = $v.taxCategoryId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceItemEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InvoiceItemEntity;
  }

  @override
  void update(void Function(InvoiceItemEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvoiceItemEntity build() => _build();

  _$InvoiceItemEntity _build() {
    final _$result = _$v ??
        new _$InvoiceItemEntity._(
            productKey: BuiltValueNullFieldError.checkNotNull(
                productKey, r'InvoiceItemEntity', 'productKey'),
            notes: BuiltValueNullFieldError.checkNotNull(
                notes, r'InvoiceItemEntity', 'notes'),
            cost: BuiltValueNullFieldError.checkNotNull(
                cost, r'InvoiceItemEntity', 'cost'),
            productCost: BuiltValueNullFieldError.checkNotNull(
                productCost, r'InvoiceItemEntity', 'productCost'),
            quantity: BuiltValueNullFieldError.checkNotNull(
                quantity, r'InvoiceItemEntity', 'quantity'),
            taxName1: BuiltValueNullFieldError.checkNotNull(
                taxName1, r'InvoiceItemEntity', 'taxName1'),
            taxRate1: BuiltValueNullFieldError.checkNotNull(
                taxRate1, r'InvoiceItemEntity', 'taxRate1'),
            taxName2: BuiltValueNullFieldError.checkNotNull(
                taxName2, r'InvoiceItemEntity', 'taxName2'),
            taxRate2:
                BuiltValueNullFieldError.checkNotNull(taxRate2, r'InvoiceItemEntity', 'taxRate2'),
            taxName3: BuiltValueNullFieldError.checkNotNull(taxName3, r'InvoiceItemEntity', 'taxName3'),
            taxRate3: BuiltValueNullFieldError.checkNotNull(taxRate3, r'InvoiceItemEntity', 'taxRate3'),
            typeId: typeId,
            customValue1: BuiltValueNullFieldError.checkNotNull(customValue1, r'InvoiceItemEntity', 'customValue1'),
            customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, r'InvoiceItemEntity', 'customValue2'),
            customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, r'InvoiceItemEntity', 'customValue3'),
            customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, r'InvoiceItemEntity', 'customValue4'),
            discount: BuiltValueNullFieldError.checkNotNull(discount, r'InvoiceItemEntity', 'discount'),
            taskId: taskId,
            expenseId: expenseId,
            createdAt: createdAt,
            taxCategoryId: BuiltValueNullFieldError.checkNotNull(taxCategoryId, r'InvoiceItemEntity', 'taxCategoryId'));
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
  final String clientContactId;
  @override
  final String vendorContactId;
  @override
  final String sentDate;
  @override
  final String viewedDate;
  @override
  final String openedDate;
  @override
  final String emailStatus;
  @override
  final String emailError;
  @override
  final String messageId;
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
  final EntityType? entityType;
  @override
  final String id;

  factory _$InvitationEntity(
          [void Function(InvitationEntityBuilder)? updates]) =>
      (new InvitationEntityBuilder()..update(updates))._build();

  _$InvitationEntity._(
      {required this.key,
      required this.link,
      required this.clientContactId,
      required this.vendorContactId,
      required this.sentDate,
      required this.viewedDate,
      required this.openedDate,
      required this.emailStatus,
      required this.emailError,
      required this.messageId,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.entityType,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(key, r'InvitationEntity', 'key');
    BuiltValueNullFieldError.checkNotNull(link, r'InvitationEntity', 'link');
    BuiltValueNullFieldError.checkNotNull(
        clientContactId, r'InvitationEntity', 'clientContactId');
    BuiltValueNullFieldError.checkNotNull(
        vendorContactId, r'InvitationEntity', 'vendorContactId');
    BuiltValueNullFieldError.checkNotNull(
        sentDate, r'InvitationEntity', 'sentDate');
    BuiltValueNullFieldError.checkNotNull(
        viewedDate, r'InvitationEntity', 'viewedDate');
    BuiltValueNullFieldError.checkNotNull(
        openedDate, r'InvitationEntity', 'openedDate');
    BuiltValueNullFieldError.checkNotNull(
        emailStatus, r'InvitationEntity', 'emailStatus');
    BuiltValueNullFieldError.checkNotNull(
        emailError, r'InvitationEntity', 'emailError');
    BuiltValueNullFieldError.checkNotNull(
        messageId, r'InvitationEntity', 'messageId');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'InvitationEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'InvitationEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'InvitationEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'InvitationEntity', 'id');
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
        clientContactId == other.clientContactId &&
        vendorContactId == other.vendorContactId &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        entityType == other.entityType &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, link.hashCode);
    _$hash = $jc(_$hash, clientContactId.hashCode);
    _$hash = $jc(_$hash, vendorContactId.hashCode);
    _$hash = $jc(_$hash, isChanged.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdUserId.hashCode);
    _$hash = $jc(_$hash, assignedUserId.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvitationEntity')
          ..add('key', key)
          ..add('link', link)
          ..add('clientContactId', clientContactId)
          ..add('vendorContactId', vendorContactId)
          ..add('sentDate', sentDate)
          ..add('viewedDate', viewedDate)
          ..add('openedDate', openedDate)
          ..add('emailStatus', emailStatus)
          ..add('emailError', emailError)
          ..add('messageId', messageId)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('entityType', entityType)
          ..add('id', id))
        .toString();
  }
}

class InvitationEntityBuilder
    implements Builder<InvitationEntity, InvitationEntityBuilder> {
  _$InvitationEntity? _$v;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _link;
  String? get link => _$this._link;
  set link(String? link) => _$this._link = link;

  String? _clientContactId;
  String? get clientContactId => _$this._clientContactId;
  set clientContactId(String? clientContactId) =>
      _$this._clientContactId = clientContactId;

  String? _vendorContactId;
  String? get vendorContactId => _$this._vendorContactId;
  set vendorContactId(String? vendorContactId) =>
      _$this._vendorContactId = vendorContactId;

  String? _sentDate;
  String? get sentDate => _$this._sentDate;
  set sentDate(String? sentDate) => _$this._sentDate = sentDate;

  String? _viewedDate;
  String? get viewedDate => _$this._viewedDate;
  set viewedDate(String? viewedDate) => _$this._viewedDate = viewedDate;

  String? _openedDate;
  String? get openedDate => _$this._openedDate;
  set openedDate(String? openedDate) => _$this._openedDate = openedDate;

  String? _emailStatus;
  String? get emailStatus => _$this._emailStatus;
  set emailStatus(String? emailStatus) => _$this._emailStatus = emailStatus;

  String? _emailError;
  String? get emailError => _$this._emailError;
  set emailError(String? emailError) => _$this._emailError = emailError;

  String? _messageId;
  String? get messageId => _$this._messageId;
  set messageId(String? messageId) => _$this._messageId = messageId;

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

  EntityType? _entityType;
  EntityType? get entityType => _$this._entityType;
  set entityType(EntityType? entityType) => _$this._entityType = entityType;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  InvitationEntityBuilder() {
    InvitationEntity._initializeBuilder(this);
  }

  InvitationEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _link = $v.link;
      _clientContactId = $v.clientContactId;
      _vendorContactId = $v.vendorContactId;
      _sentDate = $v.sentDate;
      _viewedDate = $v.viewedDate;
      _openedDate = $v.openedDate;
      _emailStatus = $v.emailStatus;
      _emailError = $v.emailError;
      _messageId = $v.messageId;
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _entityType = $v.entityType;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvitationEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InvitationEntity;
  }

  @override
  void update(void Function(InvitationEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvitationEntity build() => _build();

  _$InvitationEntity _build() {
    final _$result = _$v ??
        new _$InvitationEntity._(
            key: BuiltValueNullFieldError.checkNotNull(
                key, r'InvitationEntity', 'key'),
            link: BuiltValueNullFieldError.checkNotNull(
                link, r'InvitationEntity', 'link'),
            clientContactId: BuiltValueNullFieldError.checkNotNull(
                clientContactId, r'InvitationEntity', 'clientContactId'),
            vendorContactId: BuiltValueNullFieldError.checkNotNull(
                vendorContactId, r'InvitationEntity', 'vendorContactId'),
            sentDate: BuiltValueNullFieldError.checkNotNull(
                sentDate, r'InvitationEntity', 'sentDate'),
            viewedDate: BuiltValueNullFieldError.checkNotNull(
                viewedDate, r'InvitationEntity', 'viewedDate'),
            openedDate: BuiltValueNullFieldError.checkNotNull(
                openedDate, r'InvitationEntity', 'openedDate'),
            emailStatus: BuiltValueNullFieldError.checkNotNull(
                emailStatus, r'InvitationEntity', 'emailStatus'),
            emailError:
                BuiltValueNullFieldError.checkNotNull(emailError, r'InvitationEntity', 'emailError'),
            messageId: BuiltValueNullFieldError.checkNotNull(messageId, r'InvitationEntity', 'messageId'),
            isChanged: isChanged,
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'InvitationEntity', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, r'InvitationEntity', 'updatedAt'),
            archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, r'InvitationEntity', 'archivedAt'),
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId,
            entityType: entityType,
            id: BuiltValueNullFieldError.checkNotNull(id, r'InvitationEntity', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceScheduleEntity extends InvoiceScheduleEntity {
  @override
  final String sendDate;
  @override
  final String dueDate;

  factory _$InvoiceScheduleEntity(
          [void Function(InvoiceScheduleEntityBuilder)? updates]) =>
      (new InvoiceScheduleEntityBuilder()..update(updates))._build();

  _$InvoiceScheduleEntity._({required this.sendDate, required this.dueDate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        sendDate, r'InvoiceScheduleEntity', 'sendDate');
    BuiltValueNullFieldError.checkNotNull(
        dueDate, r'InvoiceScheduleEntity', 'dueDate');
  }

  @override
  InvoiceScheduleEntity rebuild(
          void Function(InvoiceScheduleEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceScheduleEntityBuilder toBuilder() =>
      new InvoiceScheduleEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceScheduleEntity &&
        sendDate == other.sendDate &&
        dueDate == other.dueDate;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, sendDate.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvoiceScheduleEntity')
          ..add('sendDate', sendDate)
          ..add('dueDate', dueDate))
        .toString();
  }
}

class InvoiceScheduleEntityBuilder
    implements Builder<InvoiceScheduleEntity, InvoiceScheduleEntityBuilder> {
  _$InvoiceScheduleEntity? _$v;

  String? _sendDate;
  String? get sendDate => _$this._sendDate;
  set sendDate(String? sendDate) => _$this._sendDate = sendDate;

  String? _dueDate;
  String? get dueDate => _$this._dueDate;
  set dueDate(String? dueDate) => _$this._dueDate = dueDate;

  InvoiceScheduleEntityBuilder();

  InvoiceScheduleEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sendDate = $v.sendDate;
      _dueDate = $v.dueDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceScheduleEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InvoiceScheduleEntity;
  }

  @override
  void update(void Function(InvoiceScheduleEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvoiceScheduleEntity build() => _build();

  _$InvoiceScheduleEntity _build() {
    final _$result = _$v ??
        new _$InvoiceScheduleEntity._(
            sendDate: BuiltValueNullFieldError.checkNotNull(
                sendDate, r'InvoiceScheduleEntity', 'sendDate'),
            dueDate: BuiltValueNullFieldError.checkNotNull(
                dueDate, r'InvoiceScheduleEntity', 'dueDate'));
    replace(_$result);
    return _$result;
  }
}

class _$InvoiceHistoryEntity extends InvoiceHistoryEntity {
  @override
  final String id;
  @override
  final String activityId;
  @override
  final int createdAt;
  @override
  final double amount;

  factory _$InvoiceHistoryEntity(
          [void Function(InvoiceHistoryEntityBuilder)? updates]) =>
      (new InvoiceHistoryEntityBuilder()..update(updates))._build();

  _$InvoiceHistoryEntity._(
      {required this.id,
      required this.activityId,
      required this.createdAt,
      required this.amount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'InvoiceHistoryEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(
        activityId, r'InvoiceHistoryEntity', 'activityId');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'InvoiceHistoryEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        amount, r'InvoiceHistoryEntity', 'amount');
  }

  @override
  InvoiceHistoryEntity rebuild(
          void Function(InvoiceHistoryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceHistoryEntityBuilder toBuilder() =>
      new InvoiceHistoryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceHistoryEntity &&
        id == other.id &&
        activityId == other.activityId &&
        createdAt == other.createdAt &&
        amount == other.amount;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, activityId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvoiceHistoryEntity')
          ..add('id', id)
          ..add('activityId', activityId)
          ..add('createdAt', createdAt)
          ..add('amount', amount))
        .toString();
  }
}

class InvoiceHistoryEntityBuilder
    implements Builder<InvoiceHistoryEntity, InvoiceHistoryEntityBuilder> {
  _$InvoiceHistoryEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _activityId;
  String? get activityId => _$this._activityId;
  set activityId(String? activityId) => _$this._activityId = activityId;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  InvoiceHistoryEntityBuilder();

  InvoiceHistoryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _activityId = $v.activityId;
      _createdAt = $v.createdAt;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceHistoryEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InvoiceHistoryEntity;
  }

  @override
  void update(void Function(InvoiceHistoryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvoiceHistoryEntity build() => _build();

  _$InvoiceHistoryEntity _build() {
    final _$result = _$v ??
        new _$InvoiceHistoryEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'InvoiceHistoryEntity', 'id'),
            activityId: BuiltValueNullFieldError.checkNotNull(
                activityId, r'InvoiceHistoryEntity', 'activityId'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'InvoiceHistoryEntity', 'createdAt'),
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'InvoiceHistoryEntity', 'amount'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
