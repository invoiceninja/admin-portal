// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_invoice_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EInvoiceFieldEntity> _$eInvoiceFieldEntitySerializer =
    _$EInvoiceFieldEntitySerializer();
Serializer<EInvoiceElementEntity> _$eInvoiceElementEntitySerializer =
    _$EInvoiceElementEntitySerializer();
Serializer<EInvoiceEntity> _$eInvoiceEntitySerializer =
    _$EInvoiceEntitySerializer();
Serializer<EInvoiceInvoiceEntity> _$eInvoiceInvoiceEntitySerializer =
    _$EInvoiceInvoiceEntitySerializer();
Serializer<EInvoiceInvoicePeriodEntity>
_$eInvoiceInvoicePeriodEntitySerializer =
    _$EInvoiceInvoicePeriodEntitySerializer();
Serializer<EInvoiceDeliveryEntity> _$eInvoiceDeliveryEntitySerializer =
    _$EInvoiceDeliveryEntitySerializer();
Serializer<EInvoicePaymentMeansEntity> _$eInvoicePaymentMeansEntitySerializer =
    _$EInvoicePaymentMeansEntitySerializer();
Serializer<EInvoiceValueEntity> _$eInvoiceValueEntitySerializer =
    _$EInvoiceValueEntitySerializer();
Serializer<EInvoicePayeeFinancialAccountEntity>
_$eInvoicePayeeFinancialAccountEntitySerializer =
    _$EInvoicePayeeFinancialAccountEntitySerializer();
Serializer<EInvoiceFinancialInstitutionBranchEntity>
_$eInvoiceFinancialInstitutionBranchEntitySerializer =
    _$EInvoiceFinancialInstitutionBranchEntitySerializer();
Serializer<EInvoiceFinancialInstitutionEntity>
_$eInvoiceFinancialInstitutionEntitySerializer =
    _$EInvoiceFinancialInstitutionEntitySerializer();
Serializer<EInvoiceCreditNoteEntity> _$eInvoiceCreditNoteEntitySerializer =
    _$EInvoiceCreditNoteEntitySerializer();
Serializer<EInvoiceBillingReferenceEntity>
_$eInvoiceBillingReferenceEntitySerializer =
    _$EInvoiceBillingReferenceEntitySerializer();
Serializer<EInvoiceDocumentReferenceEntity>
_$eInvoiceDocumentReferenceEntitySerializer =
    _$EInvoiceDocumentReferenceEntitySerializer();

class _$EInvoiceFieldEntitySerializer
    implements StructuredSerializer<EInvoiceFieldEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceFieldEntity,
    _$EInvoiceFieldEntity,
  ];
  @override
  final String wireName = 'EInvoiceFieldEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceFieldEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'help',
      serializers.serialize(object.help, specifiedType: const FullType(String)),
      'choices',
      serializers.serialize(
        object.choices,
        specifiedType: const FullType(BuiltList, const [
          const FullType(String),
        ]),
      ),
      'elements',
      serializers.serialize(
        object.elements,
        specifiedType: const FullType(BuiltMap, const [
          const FullType(String),
          const FullType(EInvoiceElementEntity),
        ]),
      ),
    ];

    return result;
  }

  @override
  EInvoiceFieldEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceFieldEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'type':
          result.type =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'help':
          result.help =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'choices':
          result.choices.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'elements':
          result.elements.replace(
            serializers.deserialize(
              value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(EInvoiceElementEntity),
              ]),
            )!,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceElementEntitySerializer
    implements StructuredSerializer<EInvoiceElementEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceElementEntity,
    _$EInvoiceElementEntity,
  ];
  @override
  final String wireName = 'EInvoiceElementEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceElementEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'base_type',
      serializers.serialize(
        object.baseType,
        specifiedType: const FullType(String),
      ),
      'resource',
      serializers.serialize(
        object.resource,
        specifiedType: const FullType(BuiltList, const [
          const FullType(String),
        ]),
      ),
      'min_occurs',
      serializers.serialize(
        object.minOccurs,
        specifiedType: const FullType(int),
      ),
      'max_occurs',
      serializers.serialize(
        object.maxOccurs,
        specifiedType: const FullType(int),
      ),
    ];
    Object? value;
    value = object.minLength;
    if (value != null) {
      result
        ..add('min_length')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.maxLength;
    if (value != null) {
      result
        ..add('max_length')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.pattern;
    if (value != null) {
      result
        ..add('pattern')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.help;
    if (value != null) {
      result
        ..add('help')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  EInvoiceElementEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceElementEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'base_type':
          result.baseType =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'resource':
          result.resource.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'min_length':
          result.minLength =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'max_length':
          result.maxLength =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'min_occurs':
          result.minOccurs =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'max_occurs':
          result.maxOccurs =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'pattern':
          result.pattern =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'help':
          result.help =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceEntitySerializer
    implements StructuredSerializer<EInvoiceEntity> {
  @override
  final Iterable<Type> types = const [EInvoiceEntity, _$EInvoiceEntity];
  @override
  final String wireName = 'EInvoiceEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.invoice;
    if (value != null) {
      result
        ..add('Invoice')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(EInvoiceInvoiceEntity),
          ),
        );
    }
    value = object.creditNote;
    if (value != null) {
      result
        ..add('CreditNote')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(EInvoiceCreditNoteEntity),
          ),
        );
    }
    return result;
  }

  @override
  EInvoiceEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'Invoice':
          result.invoice.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(EInvoiceInvoiceEntity),
                )!
                as EInvoiceInvoiceEntity,
          );
          break;
        case 'CreditNote':
          result.creditNote.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(EInvoiceCreditNoteEntity),
                )!
                as EInvoiceCreditNoteEntity,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceInvoiceEntitySerializer
    implements StructuredSerializer<EInvoiceInvoiceEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceInvoiceEntity,
    _$EInvoiceInvoiceEntity,
  ];
  @override
  final String wireName = 'EInvoiceInvoiceEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceInvoiceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'InvoicePeriod',
      serializers.serialize(
        object.invoicePeriod,
        specifiedType: const FullType(BuiltList, const [
          const FullType(EInvoiceInvoicePeriodEntity),
        ]),
      ),
      'Delivery',
      serializers.serialize(
        object.delivery,
        specifiedType: const FullType(BuiltList, const [
          const FullType(EInvoiceDeliveryEntity),
        ]),
      ),
      'PaymentMeans',
      serializers.serialize(
        object.paymentMeans,
        specifiedType: const FullType(BuiltList, const [
          const FullType(EInvoicePaymentMeansEntity),
        ]),
      ),
    ];

    return result;
  }

  @override
  EInvoiceInvoiceEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceInvoiceEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'InvoicePeriod':
          result.invoicePeriod.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(EInvoiceInvoicePeriodEntity),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'Delivery':
          result.delivery.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(EInvoiceDeliveryEntity),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'PaymentMeans':
          result.paymentMeans.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(EInvoicePaymentMeansEntity),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceInvoicePeriodEntitySerializer
    implements StructuredSerializer<EInvoiceInvoicePeriodEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceInvoicePeriodEntity,
    _$EInvoiceInvoicePeriodEntity,
  ];
  @override
  final String wireName = 'EInvoiceInvoicePeriodEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceInvoicePeriodEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.startDate;
    if (value != null) {
      result
        ..add('StartDate')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.endDate;
    if (value != null) {
      result
        ..add('EndDate')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.description;
    if (value != null) {
      result
        ..add('Description')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  EInvoiceInvoicePeriodEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceInvoicePeriodEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'StartDate':
          result.startDate =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'EndDate':
          result.endDate =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'Description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceDeliveryEntitySerializer
    implements StructuredSerializer<EInvoiceDeliveryEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceDeliveryEntity,
    _$EInvoiceDeliveryEntity,
  ];
  @override
  final String wireName = 'EInvoiceDeliveryEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceDeliveryEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.actualDeliveryDate;
    if (value != null) {
      result
        ..add('ActualDeliveryDate')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  EInvoiceDeliveryEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceDeliveryEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'ActualDeliveryDate':
          result.actualDeliveryDate =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoicePaymentMeansEntitySerializer
    implements StructuredSerializer<EInvoicePaymentMeansEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoicePaymentMeansEntity,
    _$EInvoicePaymentMeansEntity,
  ];
  @override
  final String wireName = 'EInvoicePaymentMeansEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoicePaymentMeansEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.paymentMeansCode;
    if (value != null) {
      result
        ..add('PaymentMeansCode')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(EInvoiceValueEntity),
          ),
        );
    }
    value = object.payeeFinancialAccount;
    if (value != null) {
      result
        ..add('PayeeFinancialAccount')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(EInvoicePayeeFinancialAccountEntity),
          ),
        );
    }
    return result;
  }

  @override
  EInvoicePaymentMeansEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoicePaymentMeansEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'PaymentMeansCode':
          result.paymentMeansCode.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(EInvoiceValueEntity),
                )!
                as EInvoiceValueEntity,
          );
          break;
        case 'PayeeFinancialAccount':
          result.payeeFinancialAccount.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    EInvoicePayeeFinancialAccountEntity,
                  ),
                )!
                as EInvoicePayeeFinancialAccountEntity,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceValueEntitySerializer
    implements StructuredSerializer<EInvoiceValueEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceValueEntity,
    _$EInvoiceValueEntity,
  ];
  @override
  final String wireName = 'EInvoiceValueEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceValueEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.value;
    if (value != null) {
      result
        ..add('value')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  EInvoiceValueEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceValueEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'value':
          result.value =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoicePayeeFinancialAccountEntitySerializer
    implements StructuredSerializer<EInvoicePayeeFinancialAccountEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoicePayeeFinancialAccountEntity,
    _$EInvoicePayeeFinancialAccountEntity,
  ];
  @override
  final String wireName = 'EInvoicePayeeFinancialAccountEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoicePayeeFinancialAccountEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('ID')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(EInvoiceValueEntity),
          ),
        );
    }
    value = object.name;
    if (value != null) {
      result
        ..add('Name')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.financialInstitutionBranch;
    if (value != null) {
      result
        ..add('FinancialInstitutionBranch')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              EInvoiceFinancialInstitutionBranchEntity,
            ),
          ),
        );
    }
    return result;
  }

  @override
  EInvoicePayeeFinancialAccountEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoicePayeeFinancialAccountEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'ID':
          result.id.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(EInvoiceValueEntity),
                )!
                as EInvoiceValueEntity,
          );
          break;
        case 'Name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'FinancialInstitutionBranch':
          result.financialInstitutionBranch.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    EInvoiceFinancialInstitutionBranchEntity,
                  ),
                )!
                as EInvoiceFinancialInstitutionBranchEntity,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceFinancialInstitutionBranchEntitySerializer
    implements StructuredSerializer<EInvoiceFinancialInstitutionBranchEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceFinancialInstitutionBranchEntity,
    _$EInvoiceFinancialInstitutionBranchEntity,
  ];
  @override
  final String wireName = 'EInvoiceFinancialInstitutionBranchEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceFinancialInstitutionBranchEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.financialInstitution;
    if (value != null) {
      result
        ..add('FinancialInstitution')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(EInvoiceFinancialInstitutionEntity),
          ),
        );
    }
    return result;
  }

  @override
  EInvoiceFinancialInstitutionBranchEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceFinancialInstitutionBranchEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'FinancialInstitution':
          result.financialInstitution.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    EInvoiceFinancialInstitutionEntity,
                  ),
                )!
                as EInvoiceFinancialInstitutionEntity,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceFinancialInstitutionEntitySerializer
    implements StructuredSerializer<EInvoiceFinancialInstitutionEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceFinancialInstitutionEntity,
    _$EInvoiceFinancialInstitutionEntity,
  ];
  @override
  final String wireName = 'EInvoiceFinancialInstitutionEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceFinancialInstitutionEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('ID')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(EInvoiceValueEntity),
          ),
        );
    }
    return result;
  }

  @override
  EInvoiceFinancialInstitutionEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceFinancialInstitutionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'ID':
          result.id.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(EInvoiceValueEntity),
                )!
                as EInvoiceValueEntity,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceCreditNoteEntitySerializer
    implements StructuredSerializer<EInvoiceCreditNoteEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceCreditNoteEntity,
    _$EInvoiceCreditNoteEntity,
  ];
  @override
  final String wireName = 'EInvoiceCreditNoteEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceCreditNoteEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'BillingReference',
      serializers.serialize(
        object.billingReference,
        specifiedType: const FullType(BuiltList, const [
          const FullType(EInvoiceBillingReferenceEntity),
        ]),
      ),
    ];

    return result;
  }

  @override
  EInvoiceCreditNoteEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceCreditNoteEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'BillingReference':
          result.billingReference.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(EInvoiceBillingReferenceEntity),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceBillingReferenceEntitySerializer
    implements StructuredSerializer<EInvoiceBillingReferenceEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceBillingReferenceEntity,
    _$EInvoiceBillingReferenceEntity,
  ];
  @override
  final String wireName = 'EInvoiceBillingReferenceEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceBillingReferenceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.invoiceDocumentReference;
    if (value != null) {
      result
        ..add('InvoiceDocumentReference')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(EInvoiceDocumentReferenceEntity),
          ),
        );
    }
    return result;
  }

  @override
  EInvoiceBillingReferenceEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceBillingReferenceEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'InvoiceDocumentReference':
          result.invoiceDocumentReference.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    EInvoiceDocumentReferenceEntity,
                  ),
                )!
                as EInvoiceDocumentReferenceEntity,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceDocumentReferenceEntitySerializer
    implements StructuredSerializer<EInvoiceDocumentReferenceEntity> {
  @override
  final Iterable<Type> types = const [
    EInvoiceDocumentReferenceEntity,
    _$EInvoiceDocumentReferenceEntity,
  ];
  @override
  final String wireName = 'EInvoiceDocumentReferenceEntity';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EInvoiceDocumentReferenceEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('ID')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.issueDate;
    if (value != null) {
      result
        ..add('IssueDate')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  EInvoiceDocumentReferenceEntity deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EInvoiceDocumentReferenceEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'ID':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'IssueDate':
          result.issueDate =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$EInvoiceFieldEntity extends EInvoiceFieldEntity {
  @override
  final String type;
  @override
  final String help;
  @override
  final BuiltList<String> choices;
  @override
  final BuiltMap<String, EInvoiceElementEntity> elements;

  factory _$EInvoiceFieldEntity([
    void Function(EInvoiceFieldEntityBuilder)? updates,
  ]) => (EInvoiceFieldEntityBuilder()..update(updates))._build();

  _$EInvoiceFieldEntity._({
    required this.type,
    required this.help,
    required this.choices,
    required this.elements,
  }) : super._();
  @override
  EInvoiceFieldEntity rebuild(
    void Function(EInvoiceFieldEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceFieldEntityBuilder toBuilder() =>
      EInvoiceFieldEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceFieldEntity &&
        type == other.type &&
        help == other.help &&
        choices == other.choices &&
        elements == other.elements;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, help.hashCode);
    _$hash = $jc(_$hash, choices.hashCode);
    _$hash = $jc(_$hash, elements.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoiceFieldEntity')
          ..add('type', type)
          ..add('help', help)
          ..add('choices', choices)
          ..add('elements', elements))
        .toString();
  }
}

class EInvoiceFieldEntityBuilder
    implements Builder<EInvoiceFieldEntity, EInvoiceFieldEntityBuilder> {
  _$EInvoiceFieldEntity? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _help;
  String? get help => _$this._help;
  set help(String? help) => _$this._help = help;

  ListBuilder<String>? _choices;
  ListBuilder<String> get choices => _$this._choices ??= ListBuilder<String>();
  set choices(ListBuilder<String>? choices) => _$this._choices = choices;

  MapBuilder<String, EInvoiceElementEntity>? _elements;
  MapBuilder<String, EInvoiceElementEntity> get elements =>
      _$this._elements ??= MapBuilder<String, EInvoiceElementEntity>();
  set elements(MapBuilder<String, EInvoiceElementEntity>? elements) =>
      _$this._elements = elements;

  EInvoiceFieldEntityBuilder();

  EInvoiceFieldEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _help = $v.help;
      _choices = $v.choices.toBuilder();
      _elements = $v.elements.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceFieldEntity other) {
    _$v = other as _$EInvoiceFieldEntity;
  }

  @override
  void update(void Function(EInvoiceFieldEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceFieldEntity build() => _build();

  _$EInvoiceFieldEntity _build() {
    _$EInvoiceFieldEntity _$result;
    try {
      _$result =
          _$v ??
          _$EInvoiceFieldEntity._(
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'EInvoiceFieldEntity',
              'type',
            ),
            help: BuiltValueNullFieldError.checkNotNull(
              help,
              r'EInvoiceFieldEntity',
              'help',
            ),
            choices: choices.build(),
            elements: elements.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'choices';
        choices.build();
        _$failedField = 'elements';
        elements.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoiceFieldEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceElementEntity extends EInvoiceElementEntity {
  @override
  final String name;
  @override
  final String baseType;
  @override
  final BuiltList<String> resource;
  @override
  final int? minLength;
  @override
  final int? maxLength;
  @override
  final int minOccurs;
  @override
  final int maxOccurs;
  @override
  final String? pattern;
  @override
  final String? help;

  factory _$EInvoiceElementEntity([
    void Function(EInvoiceElementEntityBuilder)? updates,
  ]) => (EInvoiceElementEntityBuilder()..update(updates))._build();

  _$EInvoiceElementEntity._({
    required this.name,
    required this.baseType,
    required this.resource,
    this.minLength,
    this.maxLength,
    required this.minOccurs,
    required this.maxOccurs,
    this.pattern,
    this.help,
  }) : super._();
  @override
  EInvoiceElementEntity rebuild(
    void Function(EInvoiceElementEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceElementEntityBuilder toBuilder() =>
      EInvoiceElementEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceElementEntity &&
        name == other.name &&
        baseType == other.baseType &&
        resource == other.resource &&
        minLength == other.minLength &&
        maxLength == other.maxLength &&
        minOccurs == other.minOccurs &&
        maxOccurs == other.maxOccurs &&
        pattern == other.pattern &&
        help == other.help;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, baseType.hashCode);
    _$hash = $jc(_$hash, resource.hashCode);
    _$hash = $jc(_$hash, minLength.hashCode);
    _$hash = $jc(_$hash, maxLength.hashCode);
    _$hash = $jc(_$hash, minOccurs.hashCode);
    _$hash = $jc(_$hash, maxOccurs.hashCode);
    _$hash = $jc(_$hash, pattern.hashCode);
    _$hash = $jc(_$hash, help.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoiceElementEntity')
          ..add('name', name)
          ..add('baseType', baseType)
          ..add('resource', resource)
          ..add('minLength', minLength)
          ..add('maxLength', maxLength)
          ..add('minOccurs', minOccurs)
          ..add('maxOccurs', maxOccurs)
          ..add('pattern', pattern)
          ..add('help', help))
        .toString();
  }
}

class EInvoiceElementEntityBuilder
    implements Builder<EInvoiceElementEntity, EInvoiceElementEntityBuilder> {
  _$EInvoiceElementEntity? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _baseType;
  String? get baseType => _$this._baseType;
  set baseType(String? baseType) => _$this._baseType = baseType;

  ListBuilder<String>? _resource;
  ListBuilder<String> get resource =>
      _$this._resource ??= ListBuilder<String>();
  set resource(ListBuilder<String>? resource) => _$this._resource = resource;

  int? _minLength;
  int? get minLength => _$this._minLength;
  set minLength(int? minLength) => _$this._minLength = minLength;

  int? _maxLength;
  int? get maxLength => _$this._maxLength;
  set maxLength(int? maxLength) => _$this._maxLength = maxLength;

  int? _minOccurs;
  int? get minOccurs => _$this._minOccurs;
  set minOccurs(int? minOccurs) => _$this._minOccurs = minOccurs;

  int? _maxOccurs;
  int? get maxOccurs => _$this._maxOccurs;
  set maxOccurs(int? maxOccurs) => _$this._maxOccurs = maxOccurs;

  String? _pattern;
  String? get pattern => _$this._pattern;
  set pattern(String? pattern) => _$this._pattern = pattern;

  String? _help;
  String? get help => _$this._help;
  set help(String? help) => _$this._help = help;

  EInvoiceElementEntityBuilder();

  EInvoiceElementEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _baseType = $v.baseType;
      _resource = $v.resource.toBuilder();
      _minLength = $v.minLength;
      _maxLength = $v.maxLength;
      _minOccurs = $v.minOccurs;
      _maxOccurs = $v.maxOccurs;
      _pattern = $v.pattern;
      _help = $v.help;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceElementEntity other) {
    _$v = other as _$EInvoiceElementEntity;
  }

  @override
  void update(void Function(EInvoiceElementEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceElementEntity build() => _build();

  _$EInvoiceElementEntity _build() {
    _$EInvoiceElementEntity _$result;
    try {
      _$result =
          _$v ??
          _$EInvoiceElementEntity._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'EInvoiceElementEntity',
              'name',
            ),
            baseType: BuiltValueNullFieldError.checkNotNull(
              baseType,
              r'EInvoiceElementEntity',
              'baseType',
            ),
            resource: resource.build(),
            minLength: minLength,
            maxLength: maxLength,
            minOccurs: BuiltValueNullFieldError.checkNotNull(
              minOccurs,
              r'EInvoiceElementEntity',
              'minOccurs',
            ),
            maxOccurs: BuiltValueNullFieldError.checkNotNull(
              maxOccurs,
              r'EInvoiceElementEntity',
              'maxOccurs',
            ),
            pattern: pattern,
            help: help,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'resource';
        resource.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoiceElementEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceEntity extends EInvoiceEntity {
  @override
  final EInvoiceInvoiceEntity? invoice;
  @override
  final EInvoiceCreditNoteEntity? creditNote;

  factory _$EInvoiceEntity([void Function(EInvoiceEntityBuilder)? updates]) =>
      (EInvoiceEntityBuilder()..update(updates))._build();

  _$EInvoiceEntity._({this.invoice, this.creditNote}) : super._();
  @override
  EInvoiceEntity rebuild(void Function(EInvoiceEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EInvoiceEntityBuilder toBuilder() => EInvoiceEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceEntity &&
        invoice == other.invoice &&
        creditNote == other.creditNote;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, invoice.hashCode);
    _$hash = $jc(_$hash, creditNote.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoiceEntity')
          ..add('invoice', invoice)
          ..add('creditNote', creditNote))
        .toString();
  }
}

class EInvoiceEntityBuilder
    implements Builder<EInvoiceEntity, EInvoiceEntityBuilder> {
  _$EInvoiceEntity? _$v;

  EInvoiceInvoiceEntityBuilder? _invoice;
  EInvoiceInvoiceEntityBuilder get invoice =>
      _$this._invoice ??= EInvoiceInvoiceEntityBuilder();
  set invoice(EInvoiceInvoiceEntityBuilder? invoice) =>
      _$this._invoice = invoice;

  EInvoiceCreditNoteEntityBuilder? _creditNote;
  EInvoiceCreditNoteEntityBuilder get creditNote =>
      _$this._creditNote ??= EInvoiceCreditNoteEntityBuilder();
  set creditNote(EInvoiceCreditNoteEntityBuilder? creditNote) =>
      _$this._creditNote = creditNote;

  EInvoiceEntityBuilder();

  EInvoiceEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _invoice = $v.invoice?.toBuilder();
      _creditNote = $v.creditNote?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceEntity other) {
    _$v = other as _$EInvoiceEntity;
  }

  @override
  void update(void Function(EInvoiceEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceEntity build() => _build();

  _$EInvoiceEntity _build() {
    _$EInvoiceEntity _$result;
    try {
      _$result =
          _$v ??
          _$EInvoiceEntity._(
            invoice: _invoice?.build(),
            creditNote: _creditNote?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'invoice';
        _invoice?.build();
        _$failedField = 'creditNote';
        _creditNote?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoiceEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceInvoiceEntity extends EInvoiceInvoiceEntity {
  @override
  final BuiltList<EInvoiceInvoicePeriodEntity> invoicePeriod;
  @override
  final BuiltList<EInvoiceDeliveryEntity> delivery;
  @override
  final BuiltList<EInvoicePaymentMeansEntity> paymentMeans;

  factory _$EInvoiceInvoiceEntity([
    void Function(EInvoiceInvoiceEntityBuilder)? updates,
  ]) => (EInvoiceInvoiceEntityBuilder()..update(updates))._build();

  _$EInvoiceInvoiceEntity._({
    required this.invoicePeriod,
    required this.delivery,
    required this.paymentMeans,
  }) : super._();
  @override
  EInvoiceInvoiceEntity rebuild(
    void Function(EInvoiceInvoiceEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceInvoiceEntityBuilder toBuilder() =>
      EInvoiceInvoiceEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceInvoiceEntity &&
        invoicePeriod == other.invoicePeriod &&
        delivery == other.delivery &&
        paymentMeans == other.paymentMeans;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, invoicePeriod.hashCode);
    _$hash = $jc(_$hash, delivery.hashCode);
    _$hash = $jc(_$hash, paymentMeans.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoiceInvoiceEntity')
          ..add('invoicePeriod', invoicePeriod)
          ..add('delivery', delivery)
          ..add('paymentMeans', paymentMeans))
        .toString();
  }
}

class EInvoiceInvoiceEntityBuilder
    implements Builder<EInvoiceInvoiceEntity, EInvoiceInvoiceEntityBuilder> {
  _$EInvoiceInvoiceEntity? _$v;

  ListBuilder<EInvoiceInvoicePeriodEntity>? _invoicePeriod;
  ListBuilder<EInvoiceInvoicePeriodEntity> get invoicePeriod =>
      _$this._invoicePeriod ??= ListBuilder<EInvoiceInvoicePeriodEntity>();
  set invoicePeriod(ListBuilder<EInvoiceInvoicePeriodEntity>? invoicePeriod) =>
      _$this._invoicePeriod = invoicePeriod;

  ListBuilder<EInvoiceDeliveryEntity>? _delivery;
  ListBuilder<EInvoiceDeliveryEntity> get delivery =>
      _$this._delivery ??= ListBuilder<EInvoiceDeliveryEntity>();
  set delivery(ListBuilder<EInvoiceDeliveryEntity>? delivery) =>
      _$this._delivery = delivery;

  ListBuilder<EInvoicePaymentMeansEntity>? _paymentMeans;
  ListBuilder<EInvoicePaymentMeansEntity> get paymentMeans =>
      _$this._paymentMeans ??= ListBuilder<EInvoicePaymentMeansEntity>();
  set paymentMeans(ListBuilder<EInvoicePaymentMeansEntity>? paymentMeans) =>
      _$this._paymentMeans = paymentMeans;

  EInvoiceInvoiceEntityBuilder();

  EInvoiceInvoiceEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _invoicePeriod = $v.invoicePeriod.toBuilder();
      _delivery = $v.delivery.toBuilder();
      _paymentMeans = $v.paymentMeans.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceInvoiceEntity other) {
    _$v = other as _$EInvoiceInvoiceEntity;
  }

  @override
  void update(void Function(EInvoiceInvoiceEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceInvoiceEntity build() => _build();

  _$EInvoiceInvoiceEntity _build() {
    _$EInvoiceInvoiceEntity _$result;
    try {
      _$result =
          _$v ??
          _$EInvoiceInvoiceEntity._(
            invoicePeriod: invoicePeriod.build(),
            delivery: delivery.build(),
            paymentMeans: paymentMeans.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'invoicePeriod';
        invoicePeriod.build();
        _$failedField = 'delivery';
        delivery.build();
        _$failedField = 'paymentMeans';
        paymentMeans.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoiceInvoiceEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceInvoicePeriodEntity extends EInvoiceInvoicePeriodEntity {
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? description;

  factory _$EInvoiceInvoicePeriodEntity([
    void Function(EInvoiceInvoicePeriodEntityBuilder)? updates,
  ]) => (EInvoiceInvoicePeriodEntityBuilder()..update(updates))._build();

  _$EInvoiceInvoicePeriodEntity._({
    this.startDate,
    this.endDate,
    this.description,
  }) : super._();
  @override
  EInvoiceInvoicePeriodEntity rebuild(
    void Function(EInvoiceInvoicePeriodEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceInvoicePeriodEntityBuilder toBuilder() =>
      EInvoiceInvoicePeriodEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceInvoicePeriodEntity &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        description == other.description;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoiceInvoicePeriodEntity')
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('description', description))
        .toString();
  }
}

class EInvoiceInvoicePeriodEntityBuilder
    implements
        Builder<
          EInvoiceInvoicePeriodEntity,
          EInvoiceInvoicePeriodEntityBuilder
        > {
  _$EInvoiceInvoicePeriodEntity? _$v;

  String? _startDate;
  String? get startDate => _$this._startDate;
  set startDate(String? startDate) => _$this._startDate = startDate;

  String? _endDate;
  String? get endDate => _$this._endDate;
  set endDate(String? endDate) => _$this._endDate = endDate;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  EInvoiceInvoicePeriodEntityBuilder();

  EInvoiceInvoicePeriodEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceInvoicePeriodEntity other) {
    _$v = other as _$EInvoiceInvoicePeriodEntity;
  }

  @override
  void update(void Function(EInvoiceInvoicePeriodEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceInvoicePeriodEntity build() => _build();

  _$EInvoiceInvoicePeriodEntity _build() {
    final _$result =
        _$v ??
        _$EInvoiceInvoicePeriodEntity._(
          startDate: startDate,
          endDate: endDate,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceDeliveryEntity extends EInvoiceDeliveryEntity {
  @override
  final String? actualDeliveryDate;

  factory _$EInvoiceDeliveryEntity([
    void Function(EInvoiceDeliveryEntityBuilder)? updates,
  ]) => (EInvoiceDeliveryEntityBuilder()..update(updates))._build();

  _$EInvoiceDeliveryEntity._({this.actualDeliveryDate}) : super._();
  @override
  EInvoiceDeliveryEntity rebuild(
    void Function(EInvoiceDeliveryEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceDeliveryEntityBuilder toBuilder() =>
      EInvoiceDeliveryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceDeliveryEntity &&
        actualDeliveryDate == other.actualDeliveryDate;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, actualDeliveryDate.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'EInvoiceDeliveryEntity',
    )..add('actualDeliveryDate', actualDeliveryDate)).toString();
  }
}

class EInvoiceDeliveryEntityBuilder
    implements Builder<EInvoiceDeliveryEntity, EInvoiceDeliveryEntityBuilder> {
  _$EInvoiceDeliveryEntity? _$v;

  String? _actualDeliveryDate;
  String? get actualDeliveryDate => _$this._actualDeliveryDate;
  set actualDeliveryDate(String? actualDeliveryDate) =>
      _$this._actualDeliveryDate = actualDeliveryDate;

  EInvoiceDeliveryEntityBuilder();

  EInvoiceDeliveryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _actualDeliveryDate = $v.actualDeliveryDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceDeliveryEntity other) {
    _$v = other as _$EInvoiceDeliveryEntity;
  }

  @override
  void update(void Function(EInvoiceDeliveryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceDeliveryEntity build() => _build();

  _$EInvoiceDeliveryEntity _build() {
    final _$result =
        _$v ??
        _$EInvoiceDeliveryEntity._(actualDeliveryDate: actualDeliveryDate);
    replace(_$result);
    return _$result;
  }
}

class _$EInvoicePaymentMeansEntity extends EInvoicePaymentMeansEntity {
  @override
  final EInvoiceValueEntity? paymentMeansCode;
  @override
  final EInvoicePayeeFinancialAccountEntity? payeeFinancialAccount;

  factory _$EInvoicePaymentMeansEntity([
    void Function(EInvoicePaymentMeansEntityBuilder)? updates,
  ]) => (EInvoicePaymentMeansEntityBuilder()..update(updates))._build();

  _$EInvoicePaymentMeansEntity._({
    this.paymentMeansCode,
    this.payeeFinancialAccount,
  }) : super._();
  @override
  EInvoicePaymentMeansEntity rebuild(
    void Function(EInvoicePaymentMeansEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoicePaymentMeansEntityBuilder toBuilder() =>
      EInvoicePaymentMeansEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoicePaymentMeansEntity &&
        paymentMeansCode == other.paymentMeansCode &&
        payeeFinancialAccount == other.payeeFinancialAccount;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, paymentMeansCode.hashCode);
    _$hash = $jc(_$hash, payeeFinancialAccount.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoicePaymentMeansEntity')
          ..add('paymentMeansCode', paymentMeansCode)
          ..add('payeeFinancialAccount', payeeFinancialAccount))
        .toString();
  }
}

class EInvoicePaymentMeansEntityBuilder
    implements
        Builder<EInvoicePaymentMeansEntity, EInvoicePaymentMeansEntityBuilder> {
  _$EInvoicePaymentMeansEntity? _$v;

  EInvoiceValueEntityBuilder? _paymentMeansCode;
  EInvoiceValueEntityBuilder get paymentMeansCode =>
      _$this._paymentMeansCode ??= EInvoiceValueEntityBuilder();
  set paymentMeansCode(EInvoiceValueEntityBuilder? paymentMeansCode) =>
      _$this._paymentMeansCode = paymentMeansCode;

  EInvoicePayeeFinancialAccountEntityBuilder? _payeeFinancialAccount;
  EInvoicePayeeFinancialAccountEntityBuilder get payeeFinancialAccount =>
      _$this._payeeFinancialAccount ??=
          EInvoicePayeeFinancialAccountEntityBuilder();
  set payeeFinancialAccount(
    EInvoicePayeeFinancialAccountEntityBuilder? payeeFinancialAccount,
  ) => _$this._payeeFinancialAccount = payeeFinancialAccount;

  EInvoicePaymentMeansEntityBuilder();

  EInvoicePaymentMeansEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _paymentMeansCode = $v.paymentMeansCode?.toBuilder();
      _payeeFinancialAccount = $v.payeeFinancialAccount?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoicePaymentMeansEntity other) {
    _$v = other as _$EInvoicePaymentMeansEntity;
  }

  @override
  void update(void Function(EInvoicePaymentMeansEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoicePaymentMeansEntity build() => _build();

  _$EInvoicePaymentMeansEntity _build() {
    _$EInvoicePaymentMeansEntity _$result;
    try {
      _$result =
          _$v ??
          _$EInvoicePaymentMeansEntity._(
            paymentMeansCode: _paymentMeansCode?.build(),
            payeeFinancialAccount: _payeeFinancialAccount?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'paymentMeansCode';
        _paymentMeansCode?.build();
        _$failedField = 'payeeFinancialAccount';
        _payeeFinancialAccount?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoicePaymentMeansEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceValueEntity extends EInvoiceValueEntity {
  @override
  final String? value;

  factory _$EInvoiceValueEntity([
    void Function(EInvoiceValueEntityBuilder)? updates,
  ]) => (EInvoiceValueEntityBuilder()..update(updates))._build();

  _$EInvoiceValueEntity._({this.value}) : super._();
  @override
  EInvoiceValueEntity rebuild(
    void Function(EInvoiceValueEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceValueEntityBuilder toBuilder() =>
      EInvoiceValueEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceValueEntity && value == other.value;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'EInvoiceValueEntity',
    )..add('value', value)).toString();
  }
}

class EInvoiceValueEntityBuilder
    implements Builder<EInvoiceValueEntity, EInvoiceValueEntityBuilder> {
  _$EInvoiceValueEntity? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  EInvoiceValueEntityBuilder();

  EInvoiceValueEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceValueEntity other) {
    _$v = other as _$EInvoiceValueEntity;
  }

  @override
  void update(void Function(EInvoiceValueEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceValueEntity build() => _build();

  _$EInvoiceValueEntity _build() {
    final _$result = _$v ?? _$EInvoiceValueEntity._(value: value);
    replace(_$result);
    return _$result;
  }
}

class _$EInvoicePayeeFinancialAccountEntity
    extends EInvoicePayeeFinancialAccountEntity {
  @override
  final EInvoiceValueEntity? id;
  @override
  final String? name;
  @override
  final EInvoiceFinancialInstitutionBranchEntity? financialInstitutionBranch;

  factory _$EInvoicePayeeFinancialAccountEntity([
    void Function(EInvoicePayeeFinancialAccountEntityBuilder)? updates,
  ]) =>
      (EInvoicePayeeFinancialAccountEntityBuilder()..update(updates))._build();

  _$EInvoicePayeeFinancialAccountEntity._({
    this.id,
    this.name,
    this.financialInstitutionBranch,
  }) : super._();
  @override
  EInvoicePayeeFinancialAccountEntity rebuild(
    void Function(EInvoicePayeeFinancialAccountEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoicePayeeFinancialAccountEntityBuilder toBuilder() =>
      EInvoicePayeeFinancialAccountEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoicePayeeFinancialAccountEntity &&
        id == other.id &&
        name == other.name &&
        financialInstitutionBranch == other.financialInstitutionBranch;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, financialInstitutionBranch.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoicePayeeFinancialAccountEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('financialInstitutionBranch', financialInstitutionBranch))
        .toString();
  }
}

class EInvoicePayeeFinancialAccountEntityBuilder
    implements
        Builder<
          EInvoicePayeeFinancialAccountEntity,
          EInvoicePayeeFinancialAccountEntityBuilder
        > {
  _$EInvoicePayeeFinancialAccountEntity? _$v;

  EInvoiceValueEntityBuilder? _id;
  EInvoiceValueEntityBuilder get id =>
      _$this._id ??= EInvoiceValueEntityBuilder();
  set id(EInvoiceValueEntityBuilder? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  EInvoiceFinancialInstitutionBranchEntityBuilder? _financialInstitutionBranch;
  EInvoiceFinancialInstitutionBranchEntityBuilder
  get financialInstitutionBranch => _$this._financialInstitutionBranch ??=
      EInvoiceFinancialInstitutionBranchEntityBuilder();
  set financialInstitutionBranch(
    EInvoiceFinancialInstitutionBranchEntityBuilder? financialInstitutionBranch,
  ) => _$this._financialInstitutionBranch = financialInstitutionBranch;

  EInvoicePayeeFinancialAccountEntityBuilder();

  EInvoicePayeeFinancialAccountEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id?.toBuilder();
      _name = $v.name;
      _financialInstitutionBranch = $v.financialInstitutionBranch?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoicePayeeFinancialAccountEntity other) {
    _$v = other as _$EInvoicePayeeFinancialAccountEntity;
  }

  @override
  void update(
    void Function(EInvoicePayeeFinancialAccountEntityBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  EInvoicePayeeFinancialAccountEntity build() => _build();

  _$EInvoicePayeeFinancialAccountEntity _build() {
    _$EInvoicePayeeFinancialAccountEntity _$result;
    try {
      _$result =
          _$v ??
          _$EInvoicePayeeFinancialAccountEntity._(
            id: _id?.build(),
            name: name,
            financialInstitutionBranch: _financialInstitutionBranch?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'id';
        _id?.build();

        _$failedField = 'financialInstitutionBranch';
        _financialInstitutionBranch?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoicePayeeFinancialAccountEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceFinancialInstitutionBranchEntity
    extends EInvoiceFinancialInstitutionBranchEntity {
  @override
  final EInvoiceFinancialInstitutionEntity? financialInstitution;

  factory _$EInvoiceFinancialInstitutionBranchEntity([
    void Function(EInvoiceFinancialInstitutionBranchEntityBuilder)? updates,
  ]) => (EInvoiceFinancialInstitutionBranchEntityBuilder()..update(updates))
      ._build();

  _$EInvoiceFinancialInstitutionBranchEntity._({this.financialInstitution})
    : super._();
  @override
  EInvoiceFinancialInstitutionBranchEntity rebuild(
    void Function(EInvoiceFinancialInstitutionBranchEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceFinancialInstitutionBranchEntityBuilder toBuilder() =>
      EInvoiceFinancialInstitutionBranchEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceFinancialInstitutionBranchEntity &&
        financialInstitution == other.financialInstitution;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, financialInstitution.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'EInvoiceFinancialInstitutionBranchEntity',
    )..add('financialInstitution', financialInstitution)).toString();
  }
}

class EInvoiceFinancialInstitutionBranchEntityBuilder
    implements
        Builder<
          EInvoiceFinancialInstitutionBranchEntity,
          EInvoiceFinancialInstitutionBranchEntityBuilder
        > {
  _$EInvoiceFinancialInstitutionBranchEntity? _$v;

  EInvoiceFinancialInstitutionEntityBuilder? _financialInstitution;
  EInvoiceFinancialInstitutionEntityBuilder get financialInstitution =>
      _$this._financialInstitution ??=
          EInvoiceFinancialInstitutionEntityBuilder();
  set financialInstitution(
    EInvoiceFinancialInstitutionEntityBuilder? financialInstitution,
  ) => _$this._financialInstitution = financialInstitution;

  EInvoiceFinancialInstitutionBranchEntityBuilder();

  EInvoiceFinancialInstitutionBranchEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _financialInstitution = $v.financialInstitution?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceFinancialInstitutionBranchEntity other) {
    _$v = other as _$EInvoiceFinancialInstitutionBranchEntity;
  }

  @override
  void update(
    void Function(EInvoiceFinancialInstitutionBranchEntityBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceFinancialInstitutionBranchEntity build() => _build();

  _$EInvoiceFinancialInstitutionBranchEntity _build() {
    _$EInvoiceFinancialInstitutionBranchEntity _$result;
    try {
      _$result =
          _$v ??
          _$EInvoiceFinancialInstitutionBranchEntity._(
            financialInstitution: _financialInstitution?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'financialInstitution';
        _financialInstitution?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoiceFinancialInstitutionBranchEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceFinancialInstitutionEntity
    extends EInvoiceFinancialInstitutionEntity {
  @override
  final EInvoiceValueEntity? id;

  factory _$EInvoiceFinancialInstitutionEntity([
    void Function(EInvoiceFinancialInstitutionEntityBuilder)? updates,
  ]) => (EInvoiceFinancialInstitutionEntityBuilder()..update(updates))._build();

  _$EInvoiceFinancialInstitutionEntity._({this.id}) : super._();
  @override
  EInvoiceFinancialInstitutionEntity rebuild(
    void Function(EInvoiceFinancialInstitutionEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceFinancialInstitutionEntityBuilder toBuilder() =>
      EInvoiceFinancialInstitutionEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceFinancialInstitutionEntity && id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'EInvoiceFinancialInstitutionEntity',
    )..add('id', id)).toString();
  }
}

class EInvoiceFinancialInstitutionEntityBuilder
    implements
        Builder<
          EInvoiceFinancialInstitutionEntity,
          EInvoiceFinancialInstitutionEntityBuilder
        > {
  _$EInvoiceFinancialInstitutionEntity? _$v;

  EInvoiceValueEntityBuilder? _id;
  EInvoiceValueEntityBuilder get id =>
      _$this._id ??= EInvoiceValueEntityBuilder();
  set id(EInvoiceValueEntityBuilder? id) => _$this._id = id;

  EInvoiceFinancialInstitutionEntityBuilder();

  EInvoiceFinancialInstitutionEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceFinancialInstitutionEntity other) {
    _$v = other as _$EInvoiceFinancialInstitutionEntity;
  }

  @override
  void update(
    void Function(EInvoiceFinancialInstitutionEntityBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceFinancialInstitutionEntity build() => _build();

  _$EInvoiceFinancialInstitutionEntity _build() {
    _$EInvoiceFinancialInstitutionEntity _$result;
    try {
      _$result =
          _$v ?? _$EInvoiceFinancialInstitutionEntity._(id: _id?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'id';
        _id?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoiceFinancialInstitutionEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceCreditNoteEntity extends EInvoiceCreditNoteEntity {
  @override
  final BuiltList<EInvoiceBillingReferenceEntity> billingReference;

  factory _$EInvoiceCreditNoteEntity([
    void Function(EInvoiceCreditNoteEntityBuilder)? updates,
  ]) => (EInvoiceCreditNoteEntityBuilder()..update(updates))._build();

  _$EInvoiceCreditNoteEntity._({required this.billingReference}) : super._();
  @override
  EInvoiceCreditNoteEntity rebuild(
    void Function(EInvoiceCreditNoteEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceCreditNoteEntityBuilder toBuilder() =>
      EInvoiceCreditNoteEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceCreditNoteEntity &&
        billingReference == other.billingReference;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, billingReference.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'EInvoiceCreditNoteEntity',
    )..add('billingReference', billingReference)).toString();
  }
}

class EInvoiceCreditNoteEntityBuilder
    implements
        Builder<EInvoiceCreditNoteEntity, EInvoiceCreditNoteEntityBuilder> {
  _$EInvoiceCreditNoteEntity? _$v;

  ListBuilder<EInvoiceBillingReferenceEntity>? _billingReference;
  ListBuilder<EInvoiceBillingReferenceEntity> get billingReference =>
      _$this._billingReference ??=
          ListBuilder<EInvoiceBillingReferenceEntity>();
  set billingReference(
    ListBuilder<EInvoiceBillingReferenceEntity>? billingReference,
  ) => _$this._billingReference = billingReference;

  EInvoiceCreditNoteEntityBuilder();

  EInvoiceCreditNoteEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _billingReference = $v.billingReference.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceCreditNoteEntity other) {
    _$v = other as _$EInvoiceCreditNoteEntity;
  }

  @override
  void update(void Function(EInvoiceCreditNoteEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceCreditNoteEntity build() => _build();

  _$EInvoiceCreditNoteEntity _build() {
    _$EInvoiceCreditNoteEntity _$result;
    try {
      _$result =
          _$v ??
          _$EInvoiceCreditNoteEntity._(
            billingReference: billingReference.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'billingReference';
        billingReference.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoiceCreditNoteEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceBillingReferenceEntity extends EInvoiceBillingReferenceEntity {
  @override
  final EInvoiceDocumentReferenceEntity? invoiceDocumentReference;

  factory _$EInvoiceBillingReferenceEntity([
    void Function(EInvoiceBillingReferenceEntityBuilder)? updates,
  ]) => (EInvoiceBillingReferenceEntityBuilder()..update(updates))._build();

  _$EInvoiceBillingReferenceEntity._({this.invoiceDocumentReference})
    : super._();
  @override
  EInvoiceBillingReferenceEntity rebuild(
    void Function(EInvoiceBillingReferenceEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceBillingReferenceEntityBuilder toBuilder() =>
      EInvoiceBillingReferenceEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceBillingReferenceEntity &&
        invoiceDocumentReference == other.invoiceDocumentReference;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, invoiceDocumentReference.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'EInvoiceBillingReferenceEntity',
    )..add('invoiceDocumentReference', invoiceDocumentReference)).toString();
  }
}

class EInvoiceBillingReferenceEntityBuilder
    implements
        Builder<
          EInvoiceBillingReferenceEntity,
          EInvoiceBillingReferenceEntityBuilder
        > {
  _$EInvoiceBillingReferenceEntity? _$v;

  EInvoiceDocumentReferenceEntityBuilder? _invoiceDocumentReference;
  EInvoiceDocumentReferenceEntityBuilder get invoiceDocumentReference =>
      _$this._invoiceDocumentReference ??=
          EInvoiceDocumentReferenceEntityBuilder();
  set invoiceDocumentReference(
    EInvoiceDocumentReferenceEntityBuilder? invoiceDocumentReference,
  ) => _$this._invoiceDocumentReference = invoiceDocumentReference;

  EInvoiceBillingReferenceEntityBuilder();

  EInvoiceBillingReferenceEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _invoiceDocumentReference = $v.invoiceDocumentReference?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceBillingReferenceEntity other) {
    _$v = other as _$EInvoiceBillingReferenceEntity;
  }

  @override
  void update(void Function(EInvoiceBillingReferenceEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceBillingReferenceEntity build() => _build();

  _$EInvoiceBillingReferenceEntity _build() {
    _$EInvoiceBillingReferenceEntity _$result;
    try {
      _$result =
          _$v ??
          _$EInvoiceBillingReferenceEntity._(
            invoiceDocumentReference: _invoiceDocumentReference?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'invoiceDocumentReference';
        _invoiceDocumentReference?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EInvoiceBillingReferenceEntity',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EInvoiceDocumentReferenceEntity
    extends EInvoiceDocumentReferenceEntity {
  @override
  final String? id;
  @override
  final String? issueDate;

  factory _$EInvoiceDocumentReferenceEntity([
    void Function(EInvoiceDocumentReferenceEntityBuilder)? updates,
  ]) => (EInvoiceDocumentReferenceEntityBuilder()..update(updates))._build();

  _$EInvoiceDocumentReferenceEntity._({this.id, this.issueDate}) : super._();
  @override
  EInvoiceDocumentReferenceEntity rebuild(
    void Function(EInvoiceDocumentReferenceEntityBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EInvoiceDocumentReferenceEntityBuilder toBuilder() =>
      EInvoiceDocumentReferenceEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EInvoiceDocumentReferenceEntity &&
        id == other.id &&
        issueDate == other.issueDate;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, issueDate.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EInvoiceDocumentReferenceEntity')
          ..add('id', id)
          ..add('issueDate', issueDate))
        .toString();
  }
}

class EInvoiceDocumentReferenceEntityBuilder
    implements
        Builder<
          EInvoiceDocumentReferenceEntity,
          EInvoiceDocumentReferenceEntityBuilder
        > {
  _$EInvoiceDocumentReferenceEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _issueDate;
  String? get issueDate => _$this._issueDate;
  set issueDate(String? issueDate) => _$this._issueDate = issueDate;

  EInvoiceDocumentReferenceEntityBuilder();

  EInvoiceDocumentReferenceEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _issueDate = $v.issueDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EInvoiceDocumentReferenceEntity other) {
    _$v = other as _$EInvoiceDocumentReferenceEntity;
  }

  @override
  void update(void Function(EInvoiceDocumentReferenceEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EInvoiceDocumentReferenceEntity build() => _build();

  _$EInvoiceDocumentReferenceEntity _build() {
    final _$result =
        _$v ??
        _$EInvoiceDocumentReferenceEntity._(id: id, issueDate: issueDate);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
