import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewPaymentList extends AbstractNavigatorAction implements PersistUI {
  ViewPaymentList({@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewPayment extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  ViewPayment({
    @required this.paymentId,
    @required NavigatorState navigator,
    this.force = false,
  }) : super(navigator: navigator);

  final String paymentId;
  final bool force;
}

class EditPayment extends AbstractNavigatorAction
    implements PersistUI, PersistPrefs {
  EditPayment(
      {@required this.payment,
      @required NavigatorState navigator,
      this.completer,
      this.force = false})
      : super(navigator: navigator);

  final PaymentEntity payment;
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
  final String paymentId;
  final bool loadActivities;
}

class LoadPaymentActivity {
  LoadPaymentActivity({this.completer, this.paymentId});

  final Completer completer;
  final String paymentId;
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
  ArchivePaymentRequest(this.completer, this.paymentIds);

  final Completer completer;
  final List<String> paymentIds;
}

class ArchivePaymentSuccess implements StopSaving, PersistData {
  ArchivePaymentSuccess(this.payments);

  final List<PaymentEntity> payments;
}

class ArchivePaymentFailure implements StopSaving {
  ArchivePaymentFailure(this.payments);

  final List<PaymentEntity> payments;
}

class DeletePaymentRequest implements StartSaving {
  DeletePaymentRequest(this.completer, this.paymentIds);

  final Completer completer;
  final List<String> paymentIds;
}

class DeletePaymentSuccess implements StopSaving, PersistData {
  DeletePaymentSuccess(this.payments);

  final List<PaymentEntity> payments;
}

class DeletePaymentFailure implements StopSaving {
  DeletePaymentFailure(this.payments);

  final List<PaymentEntity> payments;
}

class RestorePaymentRequest implements StartSaving {
  RestorePaymentRequest(this.completer, this.paymentIds);

  final Completer completer;
  final List<String> paymentIds;
}

class RestorePaymentSuccess implements StopSaving, PersistData {
  RestorePaymentSuccess(this.payments);

  final List<PaymentEntity> payments;
}

class RestorePaymentFailure implements StopSaving {
  RestorePaymentFailure(this.payments);

  final List<PaymentEntity> payments;
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

class FilterPayments implements PersistUI {
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

  final String entityId;
  final EntityType entityType;
}

void handlePaymentAction(
    BuildContext context, List<BaseEntity> payments, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          payments.length == 1,
      'Cannot perform this action on more than one payment');

  if (payments.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final paymentIds = payments.map((payment) => payment.id).toList();
  final payment = payments.first;

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: payment);
      break;
    case EntityAction.sendEmail:
      store.dispatch(EmailPaymentRequest(
          snackBarCompleter<Null>(context, localization.emailedPayment),
          payment));
      break;
    case EntityAction.restore:
      store.dispatch(RestorePaymentRequest(
          snackBarCompleter<Null>(context, localization.restoredPayment),
          paymentIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchivePaymentRequest(
          snackBarCompleter<Null>(context, localization.archivedPayment),
          paymentIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeletePaymentRequest(
          snackBarCompleter<Null>(context, localization.deletedPayment),
          paymentIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.paymentListState.isInMultiselect()) {
        store.dispatch(StartPaymentMultiselect(context: context));
      }

      if (payments.isEmpty) {
        break;
      }

      for (final payment in payments) {
        if (!store.state.paymentListState.isSelected(payment.id)) {
          store.dispatch(
              AddToPaymentMultiselect(context: context, entity: payment));
        } else {
          store.dispatch(
              RemoveFromPaymentMultiselect(context: context, entity: payment));
        }
      }
      break;
  }
}

class StartPaymentMultiselect {
  StartPaymentMultiselect({@required this.context});

  final BuildContext context;
}

class AddToPaymentMultiselect {
  AddToPaymentMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromPaymentMultiselect {
  RemoveFromPaymentMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearPaymentMultiselect {
  ClearPaymentMultiselect({@required this.context});

  final BuildContext context;
}
