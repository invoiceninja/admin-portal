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
    with BaseEntity, SelectableEntity
    implements Built<PaymentEntity, PaymentEntityBuilder> {
  factory PaymentEntity({String id, AppState state}) {
    return _$PaymentEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      amount: 0.0,
      transactionReference: '',
      paymentDate: convertDateTimeToSqlDate(),
      paymentTypeId: state?.company != null &&
              (state.company.settings.defaultPaymentTypeId ?? '').isNotEmpty
          ? state.company.settings.defaultPaymentTypeId
          : '',
      invoiceId: '',
      clientId: '',
      privateNotes: '',
      exchangeRate: 0.0,
      exchangeCurrencyId: '',
      refunded: 0.0,
      paymentStatusId: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  PaymentEntity._();

  @override
  EntityType get entityType {
    return EntityType.payment;
  }

  double get amount;

  @nullable
  double get refunded;

  @nullable
  String get number;

  @nullable
  @BuiltValueField(wireName: 'payment_status_id')
  String get paymentStatusId;

  @BuiltValueField(wireName: 'transaction_reference')
  String get transactionReference;

  @BuiltValueField(wireName: 'payment_date')
  String get paymentDate;

  @BuiltValueField(wireName: 'payment_type_id')
  String get paymentTypeId;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @nullable
  @BuiltValueField(wireName: 'private_notes')
  String get privateNotes;

  @nullable
  @BuiltValueField(wireName: 'exchange_rate')
  double get exchangeRate;

  @nullable
  @BuiltValueField(wireName: 'exchange_currency_id')
  String get exchangeCurrencyId;

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
        response = paymentA.paymentDate.compareTo(paymentB.paymentDate);
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
    }

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

      if (userCompany.canEditEntity(this) && client.hasEmailAddress) {
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
    return startDate.compareTo(paymentDate) <= 0 &&
        endDate.compareTo(paymentDate) >= 0;
  }

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  double get completedAmount {
    if ([kPaymentStatusVoided, kPaymentStatusFailed]
        .contains(paymentStatusId)) {
      return 0.0;
    }

    return amount - refunded;
  }

  static Serializer<PaymentEntity> get serializer => _$paymentEntitySerializer;
}
