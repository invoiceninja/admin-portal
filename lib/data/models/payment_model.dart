import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'payment_model.g.dart';

abstract class PaymentListResponse
    implements Built<PaymentListResponse, PaymentListResponseBuilder> {
  factory PaymentListResponse([void updates(PaymentListResponseBuilder b)]) =
      _$PaymentListResponse;

  PaymentListResponse._();

  BuiltList<PaymentEntity> get data;

  static Serializer<PaymentListResponse> get serializer =>
      _$paymentListResponseSerializer;
}

abstract class PaymentItemResponse
    implements Built<PaymentItemResponse, PaymentItemResponseBuilder> {
  factory PaymentItemResponse([void updates(PaymentItemResponseBuilder b)]) =
      _$PaymentItemResponse;

  PaymentItemResponse._();

  PaymentEntity get data;

  static Serializer<PaymentItemResponse> get serializer =>
      _$paymentItemResponseSerializer;
}

class PaymentFields {
  static const String amount = 'amount';
  static const String transactionReference = 'transactionReference';
  static const String paymentDate = 'paymentDate';
  static const String paymentTypeId = 'paymentTypeId';
  static const String invoiceId = 'invoiceId';
  static const String invoiceNumber = 'invoiceNumber';
  static const String privateNotes = 'privateNotes';
  static const String exchangeRate = 'exchangeRate';
  static const String exchangeCurrencyId = 'exchangeCurrencyId';
  static const String paymentStatusId = 'paymentStatusId';

  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
}

abstract class PaymentEntity extends Object
    with BaseEntity, SelectableEntity, BelongsToClient
    implements Built<PaymentEntity, PaymentEntityBuilder> {
  factory PaymentEntity({String id, AppState state}) {
    return _$PaymentEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      amount: 0.0,
      transactionReference: '',
      date: convertDateTimeToSqlDate(),
      typeId: state?.company != null &&
              (state.company.settings.defaultPaymentTypeId ?? '').isNotEmpty
          ? state.company.settings.defaultPaymentTypeId
          : '',
      invoiceId: '',
      clientId: '',
      privateNotes: '',
      exchangeRate: 0.0,
      exchangeCurrencyId: '',
      refunded: 0.0,
      applied: 0,
      statusId: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      isManual: true,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      paymentables: BuiltList<PaymentableEntity>(),
      invoices: BuiltList<PaymentableEntity>(),
      credits: BuiltList<PaymentableEntity>(),
    );
  }

  PaymentEntity._();

  @override
  EntityType get entityType {
    return EntityType.payment;
  }

  double get amount;

  double get applied;

  double get refunded;

  @nullable
  String get number;

  @nullable
  @override
  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @nullable
  @BuiltValueField(wireName: 'status_id')
  String get statusId;

  @BuiltValueField(wireName: 'transaction_reference')
  String get transactionReference;

  @BuiltValueField(wireName: 'date')
  String get date;

  @BuiltValueField(wireName: 'type_id')
  String get typeId;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @nullable
  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @nullable
  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @nullable
  @BuiltValueField(wireName: 'exchange_currency_id')
  String get exchangeCurrencyId;

  @BuiltValueField(wireName: 'is_manual')
  bool get isManual;

  @nullable
  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @nullable
  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  BuiltList<PaymentableEntity> get paymentables;

  BuiltList<PaymentableEntity> get invoices;

  BuiltList<PaymentableEntity> get credits;

  int compareTo(PaymentEntity credit, String sortField, bool sortAscending) {
    int response = 0;
    final PaymentEntity paymentA = sortAscending ? this : credit;
    final PaymentEntity paymentB = sortAscending ? credit : this;

    switch (sortField) {
      case PaymentFields.amount:
        response = paymentA.amount.compareTo(paymentB.amount);
        break;
      case PaymentFields.transactionReference:
        response = paymentA.transactionReference
            .compareTo(paymentB.transactionReference);
        break;
      case PaymentFields.paymentDate:
        response = paymentA.date.compareTo(paymentB.date);
        break;
      case PaymentFields.updatedAt:
        response = paymentA.updatedAt.compareTo(paymentB.updatedAt);
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    if (transactionReference.toLowerCase().contains(filter)) {
      return true;
    } else if (privateNotes.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue3.isNotEmpty &&
        customValue3.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue4.isNotEmpty &&
        customValue4.toLowerCase().contains(filter)) {
      return true;
    }
    /*
    } else if (customValue1.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return customValue2;
    }
    */

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    if (transactionReference.toLowerCase().contains(filter)) {
      return transactionReference;
    } else if (privateNotes.toLowerCase().contains(filter)) {
      return privateNotes;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return customValue1;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return customValue2;
    } else if (customValue3.isNotEmpty &&
        customValue3.toLowerCase().contains(filter)) {
      return customValue3;
    } else if (customValue4.isNotEmpty &&
        customValue4.toLowerCase().contains(filter)) {
      return customValue4;
    }

    return null;
  }

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany.canEditEntity(this) &&
          client != null &&
          client.hasEmailAddress) {
        actions.add(EntityAction.sendEmail);
      }
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  @override
  String get listDisplayName => number ?? '';

  @override
  double get listDisplayAmount => amount;

  bool isBetween(String startDate, String endDate) {
    return startDate.compareTo(date) <= 0 && endDate.compareTo(date) >= 0;
  }

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  double get completedAmount {
    if ([kPaymentStatusVoided, kPaymentStatusFailed].contains(statusId)) {
      return 0.0;
    }

    return amount - (refunded ?? 0);
  }

  static Serializer<PaymentEntity> get serializer => _$paymentEntitySerializer;
}

abstract class PaymentableEntity extends Object
    with SelectableEntity
    implements Built<PaymentableEntity, PaymentableEntityBuilder> {
  factory PaymentableEntity(
      {String id, String invoiceId, String creditId, double amount}) {
    return _$PaymentableEntity._(
      id: id ?? BaseEntity.nextId,
      invoiceId: invoiceId ?? '',
      creditId: creditId ?? '',
      amount: amount ?? 0,
    );
  }

  factory PaymentableEntity.fromInvoice(InvoiceEntity invoice) {
    return PaymentableEntity(
      invoiceId: invoice.id,
      amount: invoice.balance,
    );
  }

  PaymentableEntity._();

  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @BuiltValueField(wireName: 'credit_id')
  String get creditId;

  double get amount;

  bool get isEmpty => (invoiceId ?? '').isEmpty && amount == 0;

  /*
  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double get listDisplayAmount => null;

*/

  static Serializer<PaymentableEntity> get serializer =>
      _$paymentableEntitySerializer;
}
