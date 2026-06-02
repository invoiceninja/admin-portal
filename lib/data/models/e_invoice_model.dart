// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'e_invoice_model.g.dart';

abstract class EInvoiceFieldEntity
    implements Built<EInvoiceFieldEntity, EInvoiceFieldEntityBuilder> {
  factory EInvoiceFieldEntity() {
    return _$EInvoiceFieldEntity._(
      type: '',
      help: '',
      choices: BuiltList<String>(),
      elements: BuiltMap<String, EInvoiceElementEntity>(),
    );
  }
  EInvoiceFieldEntity._();

  @override
  @memoized
  int get hashCode;

  String get type;

  String get help;

  BuiltList<String> get choices;

  BuiltMap<String, EInvoiceElementEntity> get elements;

  static Serializer<EInvoiceFieldEntity> get serializer =>
      _$eInvoiceFieldEntitySerializer;
}

abstract class EInvoiceElementEntity
    implements Built<EInvoiceElementEntity, EInvoiceElementEntityBuilder> {
  factory EInvoiceElementEntity() {
    return _$EInvoiceElementEntity._(
      baseType: '',
      help: '',
      name: '',
      maxOccurs: 0,
      minOccurs: 0,
      resource: BuiltList<String>(),
    );
  }

  EInvoiceElementEntity._();

  @override
  @memoized
  int get hashCode;

  String get name;

  @BuiltValueField(wireName: 'base_type')
  String get baseType;

  BuiltList<String> get resource;

  @BuiltValueField(wireName: 'min_length')
  int? get minLength;

  @BuiltValueField(wireName: 'max_length')
  int? get maxLength;

  @BuiltValueField(wireName: 'min_occurs')
  int get minOccurs;

  @BuiltValueField(wireName: 'max_occurs')
  int get maxOccurs;

  String? get pattern;

  String? get help;

  static Serializer<EInvoiceElementEntity> get serializer =>
      _$eInvoiceElementEntitySerializer;
}

abstract class EInvoiceEntity
    implements Built<EInvoiceEntity, EInvoiceEntityBuilder> {
  factory EInvoiceEntity() {
    return _$EInvoiceEntity._(invoice: null, creditNote: null);
  }

  EInvoiceEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'Invoice')
  EInvoiceInvoiceEntity? get invoice;

  @BuiltValueField(wireName: 'CreditNote')
  EInvoiceCreditNoteEntity? get creditNote;

  static Serializer<EInvoiceEntity> get serializer =>
      _$eInvoiceEntitySerializer;
}

abstract class EInvoiceInvoiceEntity
    implements Built<EInvoiceInvoiceEntity, EInvoiceInvoiceEntityBuilder> {
  factory EInvoiceInvoiceEntity() {
    return _$EInvoiceInvoiceEntity._(
      invoicePeriod: BuiltList<EInvoiceInvoicePeriodEntity>(),
      delivery: BuiltList<EInvoiceDeliveryEntity>(),
      paymentMeans: BuiltList<EInvoicePaymentMeansEntity>(),
    );
  }

  EInvoiceInvoiceEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'InvoicePeriod')
  BuiltList<EInvoiceInvoicePeriodEntity> get invoicePeriod;

  @BuiltValueField(wireName: 'Delivery')
  BuiltList<EInvoiceDeliveryEntity> get delivery;

  @BuiltValueField(wireName: 'PaymentMeans')
  BuiltList<EInvoicePaymentMeansEntity> get paymentMeans;

  static Serializer<EInvoiceInvoiceEntity> get serializer =>
      _$eInvoiceInvoiceEntitySerializer;
}

abstract class EInvoiceInvoicePeriodEntity
    implements
        Built<EInvoiceInvoicePeriodEntity, EInvoiceInvoicePeriodEntityBuilder> {
  factory EInvoiceInvoicePeriodEntity() {
    return _$EInvoiceInvoicePeriodEntity._();
  }

  EInvoiceInvoicePeriodEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'StartDate')
  String? get startDate;

  @BuiltValueField(wireName: 'EndDate')
  String? get endDate;

  @BuiltValueField(wireName: 'Description')
  String? get description;

  static Serializer<EInvoiceInvoicePeriodEntity> get serializer =>
      _$eInvoiceInvoicePeriodEntitySerializer;
}

abstract class EInvoiceDeliveryEntity
    implements Built<EInvoiceDeliveryEntity, EInvoiceDeliveryEntityBuilder> {
  factory EInvoiceDeliveryEntity() {
    return _$EInvoiceDeliveryEntity._();
  }

  EInvoiceDeliveryEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'ActualDeliveryDate')
  String? get actualDeliveryDate;

  static Serializer<EInvoiceDeliveryEntity> get serializer =>
      _$eInvoiceDeliveryEntitySerializer;
}

abstract class EInvoicePaymentMeansEntity
    implements
        Built<EInvoicePaymentMeansEntity, EInvoicePaymentMeansEntityBuilder> {
  factory EInvoicePaymentMeansEntity() {
    return _$EInvoicePaymentMeansEntity._(
      paymentMeansCode: null,
      payeeFinancialAccount: null,
    );
  }

  EInvoicePaymentMeansEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'PaymentMeansCode')
  EInvoiceValueEntity? get paymentMeansCode;

  @BuiltValueField(wireName: 'PayeeFinancialAccount')
  EInvoicePayeeFinancialAccountEntity? get payeeFinancialAccount;

  static Serializer<EInvoicePaymentMeansEntity> get serializer =>
      _$eInvoicePaymentMeansEntitySerializer;
}

abstract class EInvoiceValueEntity
    implements Built<EInvoiceValueEntity, EInvoiceValueEntityBuilder> {
  factory EInvoiceValueEntity() {
    return _$EInvoiceValueEntity._();
  }

  EInvoiceValueEntity._();

  @override
  @memoized
  int get hashCode;

  String? get value;

  static Serializer<EInvoiceValueEntity> get serializer =>
      _$eInvoiceValueEntitySerializer;
}

abstract class EInvoicePayeeFinancialAccountEntity
    implements
        Built<EInvoicePayeeFinancialAccountEntity,
            EInvoicePayeeFinancialAccountEntityBuilder> {
  factory EInvoicePayeeFinancialAccountEntity() {
    return _$EInvoicePayeeFinancialAccountEntity._(
      id: null,
      name: null,
      financialInstitutionBranch: null,
    );
  }

  EInvoicePayeeFinancialAccountEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'ID')
  EInvoiceValueEntity? get id;

  @BuiltValueField(wireName: 'Name')
  String? get name;

  @BuiltValueField(wireName: 'FinancialInstitutionBranch')
  EInvoiceFinancialInstitutionBranchEntity? get financialInstitutionBranch;

  static Serializer<EInvoicePayeeFinancialAccountEntity> get serializer =>
      _$eInvoicePayeeFinancialAccountEntitySerializer;
}

abstract class EInvoiceFinancialInstitutionBranchEntity
    implements
        Built<EInvoiceFinancialInstitutionBranchEntity,
            EInvoiceFinancialInstitutionBranchEntityBuilder> {
  factory EInvoiceFinancialInstitutionBranchEntity() {
    return _$EInvoiceFinancialInstitutionBranchEntity._(
      financialInstitution: null,
    );
  }

  EInvoiceFinancialInstitutionBranchEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'FinancialInstitution')
  EInvoiceFinancialInstitutionEntity? get financialInstitution;

  static Serializer<EInvoiceFinancialInstitutionBranchEntity> get serializer =>
      _$eInvoiceFinancialInstitutionBranchEntitySerializer;
}

abstract class EInvoiceFinancialInstitutionEntity
    implements
        Built<EInvoiceFinancialInstitutionEntity,
            EInvoiceFinancialInstitutionEntityBuilder> {
  factory EInvoiceFinancialInstitutionEntity() {
    return _$EInvoiceFinancialInstitutionEntity._(id: null);
  }

  EInvoiceFinancialInstitutionEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'ID')
  EInvoiceValueEntity? get id;

  static Serializer<EInvoiceFinancialInstitutionEntity> get serializer =>
      _$eInvoiceFinancialInstitutionEntitySerializer;
}

abstract class EInvoiceCreditNoteEntity
    implements
        Built<EInvoiceCreditNoteEntity, EInvoiceCreditNoteEntityBuilder> {
  factory EInvoiceCreditNoteEntity() {
    return _$EInvoiceCreditNoteEntity._(
      billingReference: BuiltList<EInvoiceBillingReferenceEntity>(),
    );
  }

  EInvoiceCreditNoteEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'BillingReference')
  BuiltList<EInvoiceBillingReferenceEntity> get billingReference;

  static Serializer<EInvoiceCreditNoteEntity> get serializer =>
      _$eInvoiceCreditNoteEntitySerializer;
}

abstract class EInvoiceBillingReferenceEntity
    implements
        Built<EInvoiceBillingReferenceEntity,
            EInvoiceBillingReferenceEntityBuilder> {
  factory EInvoiceBillingReferenceEntity() {
    return _$EInvoiceBillingReferenceEntity._(invoiceDocumentReference: null);
  }

  EInvoiceBillingReferenceEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'InvoiceDocumentReference')
  EInvoiceDocumentReferenceEntity? get invoiceDocumentReference;

  static Serializer<EInvoiceBillingReferenceEntity> get serializer =>
      _$eInvoiceBillingReferenceEntitySerializer;
}

abstract class EInvoiceDocumentReferenceEntity
    implements
        Built<EInvoiceDocumentReferenceEntity,
            EInvoiceDocumentReferenceEntityBuilder> {
  factory EInvoiceDocumentReferenceEntity() {
    return _$EInvoiceDocumentReferenceEntity._();
  }

  EInvoiceDocumentReferenceEntity._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'ID')
  String? get id;

  @BuiltValueField(wireName: 'IssueDate')
  String? get issueDate;

  static Serializer<EInvoiceDocumentReferenceEntity> get serializer =>
      _$eInvoiceDocumentReferenceEntitySerializer;
}
