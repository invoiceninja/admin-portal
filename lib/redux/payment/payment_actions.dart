import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewPaymentList implements PersistUI {
  ViewPaymentList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewPayment implements PersistUI {
  ViewPayment({
    @required this.paymentId,
    @required this.context,
    this.force = false,
  });

  final int paymentId;
  final BuildContext context;
  final bool force;
}

class EditPayment implements PersistUI {
  EditPayment(
      {@required this.payment,
      @required this.context,
      this.completer,
      this.force = false});

  final PaymentEntity payment;
  final BuildContext context;
  final Completer completer;
  final bool force;
}

class UpdatePayment implements PersistUI {
  UpdatePayment(this.payment);

  final PaymentEntity payment;
}

class LoadPayment {
  LoadPayment({this.completer, this.paymentId, this.loadActivities = false});

  final Completer completer;
  final int paymentId;
  final bool loadActivities;
}

class LoadPaymentActivity {
  LoadPaymentActivity({this.completer, this.paymentId});

  final Completer completer;
  final int paymentId;
}

class LoadPayments {
  LoadPayments({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadPaymentRequest implements StartLoading {}

class LoadPaymentFailure implements StopLoading {
  LoadPaymentFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadPaymentFailure{error: $error}';
  }
}

class LoadPaymentSuccess implements StopLoading, PersistData {
  LoadPaymentSuccess(this.payment);

  final PaymentEntity payment;

  @override
  String toString() {
    return 'LoadPaymentSuccess{payment: $payment}';
  }
}

class LoadPaymentsRequest implements StartLoading {}

class LoadPaymentsFailure implements StopLoading {
  LoadPaymentsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadPaymentsFailure{error: $error}';
  }
}

class LoadPaymentsSuccess implements StopLoading, PersistData {
  LoadPaymentsSuccess(this.payments);

  final BuiltList<PaymentEntity> payments;

  @override
  String toString() {
    return 'LoadPaymentsSuccess{payments: $payments}';
  }
}

class SavePaymentRequest implements StartSaving {
  SavePaymentRequest({this.completer, this.payment});

  final Completer completer;
  final PaymentEntity payment;
}

class SavePaymentSuccess implements StopSaving, PersistData, PersistUI {
  SavePaymentSuccess(this.payment);

  final PaymentEntity payment;
}

class AddPaymentSuccess implements StopSaving, PersistData, PersistUI {
  AddPaymentSuccess(this.payment);

  final PaymentEntity payment;
}

class SavePaymentFailure implements StopSaving {
  SavePaymentFailure(this.error);

  final Object error;
}

class ArchivePaymentRequest implements StartSaving {
  ArchivePaymentRequest(this.completer, this.paymentId);

  final Completer completer;
  final int paymentId;
}

class ArchivePaymentSuccess implements StopSaving, PersistData {
  ArchivePaymentSuccess(this.payment);

  final PaymentEntity payment;
}

class ArchivePaymentFailure implements StopSaving {
  ArchivePaymentFailure(this.payment);

  final PaymentEntity payment;
}

class DeletePaymentRequest implements StartSaving {
  DeletePaymentRequest(this.completer, this.paymentId);

  final Completer completer;
  final int paymentId;
}

class DeletePaymentSuccess implements StopSaving, PersistData {
  DeletePaymentSuccess(this.payment);

  final PaymentEntity payment;
}

class DeletePaymentFailure implements StopSaving {
  DeletePaymentFailure(this.payment);

  final PaymentEntity payment;
}

class RestorePaymentRequest implements StartSaving {
  RestorePaymentRequest(this.completer, this.paymentId);

  final Completer completer;
  final int paymentId;
}

class RestorePaymentSuccess implements StopSaving, PersistData {
  RestorePaymentSuccess(this.payment);

  final PaymentEntity payment;
}

class RestorePaymentFailure implements StopSaving {
  RestorePaymentFailure(this.payment);

  final PaymentEntity payment;
}

class EmailPaymentRequest implements StartSaving {
  EmailPaymentRequest(this.completer, this.payment);

  final Completer completer;
  final PaymentEntity payment;
}

class EmailPaymentSuccess implements StopSaving, PersistData {}

class EmailPaymentFailure implements StopSaving {
  EmailPaymentFailure(this.error);

  final dynamic error;
}

class FilterPayments {
  FilterPayments(this.filter);

  final String filter;
}

class SortPayments implements PersistUI {
  SortPayments(this.field);

  final String field;
}

class FilterPaymentsByState implements PersistUI {
  FilterPaymentsByState(this.state);

  final EntityState state;
}

class FilterPaymentsByCustom1 implements PersistUI {
  FilterPaymentsByCustom1(this.value);

  final String value;
}

class FilterPaymentsByCustom2 implements PersistUI {
  FilterPaymentsByCustom2(this.value);

  final String value;
}

class FilterPaymentsByEntity implements PersistUI {
  FilterPaymentsByEntity({this.entityId, this.entityType});

  final int entityId;
  final EntityType entityType;
}

void handlePaymentAction(
    BuildContext context, PaymentEntity payment, EntityAction action) {
  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);

  switch (action) {
    case EntityAction.edit:
      store.dispatch(EditPayment(context: context, payment: payment));
      break;
    case EntityAction.sendEmail:
      store.dispatch(EmailPaymentRequest(
          snackBarCompleter(context, localization.emailedPayment), payment));
      break;
    case EntityAction.restore:
      store.dispatch(RestorePaymentRequest(
          snackBarCompleter(context, localization.restoredPayment),
          payment.id));
      break;
    case EntityAction.archive:
      store.dispatch(ArchivePaymentRequest(
          snackBarCompleter(context, localization.archivedPayment),
          payment.id));
      break;
    case EntityAction.delete:
      store.dispatch(DeletePaymentRequest(
          snackBarCompleter(context, localization.deletedPayment), payment.id));
      break;
  }
}
