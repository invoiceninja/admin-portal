import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

class ViewPaymentList implements PersistUI {
  final BuildContext context;
  ViewPaymentList(this.context);
}

class ViewPayment implements PersistUI {
  final int paymentId;
  final BuildContext context;
  ViewPayment({this.paymentId, this.context});
}

class EditPayment implements PersistUI {
  final PaymentEntity payment;
  final BuildContext context;
  final Completer completer;
  final bool trackRoute;
  EditPayment({this.payment, this.context, this.completer, this.trackRoute = true});
}

class UpdatePayment implements PersistUI {
  final PaymentEntity payment;
  UpdatePayment(this.payment);
}

class LoadPayment {
  final Completer completer;
  final int paymentId;
  final bool loadActivities;

  LoadPayment({this.completer, this.paymentId, this.loadActivities = false});
}

class LoadPaymentActivity {
  final Completer completer;
  final int paymentId;

  LoadPaymentActivity({this.completer, this.paymentId});
}

class LoadPayments {
  final Completer completer;
  final bool force;

  LoadPayments({this.completer, this.force = false});
}

class LoadPaymentRequest implements StartLoading {}

class LoadPaymentFailure implements StopLoading {
  final dynamic error;
  LoadPaymentFailure(this.error);

  @override
  String toString() {
    return 'LoadPaymentFailure{error: $error}';
  }
}

class LoadPaymentSuccess implements StopLoading, PersistData {
  final PaymentEntity payment;
  LoadPaymentSuccess(this.payment);

  @override
  String toString() {
    return 'LoadPaymentSuccess{payment: $payment}';
  }
}

class LoadPaymentsRequest implements StartLoading {}

class LoadPaymentsFailure implements StopLoading {
  final dynamic error;
  LoadPaymentsFailure(this.error);

  @override
  String toString() {
    return 'LoadPaymentsFailure{error: $error}';
  }
}

class LoadPaymentsSuccess implements StopLoading, PersistData {
  final BuiltList<PaymentEntity> payments;
  LoadPaymentsSuccess(this.payments);

  @override
  String toString() {
    return 'LoadPaymentsSuccess{payments: $payments}';
  }
}



class SavePaymentRequest implements StartSaving {
  final Completer completer;
  final PaymentEntity payment;
  SavePaymentRequest({this.completer, this.payment});
}

class SavePaymentSuccess implements StopSaving, PersistData, PersistUI {
  final PaymentEntity payment;

  SavePaymentSuccess(this.payment);
}

class AddPaymentSuccess implements StopSaving, PersistData, PersistUI {
  final PaymentEntity payment;
  AddPaymentSuccess(this.payment);
}

class SavePaymentFailure implements StopSaving {
  final Object error;
  SavePaymentFailure (this.error);
}

class ArchivePaymentRequest implements StartSaving {
  final Completer completer;
  final int paymentId;

  ArchivePaymentRequest(this.completer, this.paymentId);
}

class ArchivePaymentSuccess implements StopSaving, PersistData {
  final PaymentEntity payment;
  ArchivePaymentSuccess(this.payment);
}

class ArchivePaymentFailure implements StopSaving {
  final PaymentEntity payment;
  ArchivePaymentFailure(this.payment);
}

class DeletePaymentRequest implements StartSaving {
  final Completer completer;
  final int paymentId;

  DeletePaymentRequest(this.completer, this.paymentId);
}

class DeletePaymentSuccess implements StopSaving, PersistData {
  final PaymentEntity payment;
  DeletePaymentSuccess(this.payment);
}

class DeletePaymentFailure implements StopSaving {
  final PaymentEntity payment;
  DeletePaymentFailure(this.payment);
}

class RestorePaymentRequest implements StartSaving {
  final Completer completer;
  final int paymentId;
  RestorePaymentRequest(this.completer, this.paymentId);
}

class RestorePaymentSuccess implements StopSaving, PersistData {
  final PaymentEntity payment;
  RestorePaymentSuccess(this.payment);
}

class RestorePaymentFailure implements StopSaving {
  final PaymentEntity payment;
  RestorePaymentFailure(this.payment);
}




class FilterPayments {
  final String filter;
  FilterPayments(this.filter);
}

class SortPayments implements PersistUI {
  final String field;
  SortPayments(this.field);
}

class FilterPaymentsByState implements PersistUI {
  final EntityState state;

  FilterPaymentsByState(this.state);
}

class FilterPaymentsByCustom1 implements PersistUI {
  final String value;

  FilterPaymentsByCustom1(this.value);
}

class FilterPaymentsByCustom2 implements PersistUI {
  final String value;

  FilterPaymentsByCustom2(this.value);
}

class FilterPaymentsByClient implements PersistUI {
  final int clientId;

  FilterPaymentsByClient([this.clientId]);
}

