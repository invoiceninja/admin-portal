import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

class ViewPaymentList implements PersistUI, StopLoading {
  ViewPaymentList({this.force = false});

  final bool force;
}

class ViewPayment implements PersistUI, PersistPrefs {
  ViewPayment({
    @required this.paymentId,
    this.force = false,
  });

  final String paymentId;
  final bool force;
}

class EditPayment implements PersistUI, PersistPrefs {
  EditPayment({@required this.payment, this.completer, this.force = false});

  final PaymentEntity payment;
  final Completer completer;
  final bool force;
}

class ViewRefundPayment implements PersistUI, PersistPrefs {
  ViewRefundPayment(
      {@required this.payment, this.completer, this.force = false});

  final PaymentEntity payment;
  final Completer completer;
  final bool force;
}

class UpdatePayment implements PersistUI {
  UpdatePayment(this.payment);

  final PaymentEntity payment;
}

class LoadPayment {
  LoadPayment({this.completer, this.paymentId});

  final Completer completer;
  final String paymentId;
}

class LoadPaymentActivity {
  LoadPaymentActivity({this.completer, this.paymentId});

  final Completer completer;
  final String paymentId;
}

class LoadPayments {
  LoadPayments({this.completer});

  final Completer completer;
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

class LoadPaymentsSuccess implements StopLoading {
  LoadPaymentsSuccess(this.payments);

  final BuiltList<PaymentEntity> payments;

  @override
  String toString() {
    return 'LoadPaymentsSuccess{payments: $payments}';
  }
}

class SavePaymentRequest implements StartSaving {
  SavePaymentRequest({
    @required this.completer,
    @required this.payment,
  });

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

class RefundPaymentRequest implements StartSaving {
  RefundPaymentRequest({
    @required this.completer,
    @required this.payment,
  });

  final Completer completer;
  final PaymentEntity payment;
}

class RefundPaymentSuccess implements StopSaving, PersistData, PersistUI {
  RefundPaymentSuccess(this.payment);

  final PaymentEntity payment;
}

class RefundPaymentFailure implements StopSaving {
  RefundPaymentFailure(this.error);

  final Object error;
}

class ArchivePaymentsRequest implements StartSaving {
  ArchivePaymentsRequest(this.completer, this.paymentIds);

  final Completer completer;
  final List<String> paymentIds;
}

class ArchivePaymentsSuccess implements StopSaving, PersistData {
  ArchivePaymentsSuccess(this.payments);

  final List<PaymentEntity> payments;
}

class ArchivePaymentsFailure implements StopSaving {
  ArchivePaymentsFailure(this.payments);

  final List<PaymentEntity> payments;
}

class DeletePaymentsRequest implements StartSaving {
  DeletePaymentsRequest(this.completer, this.paymentIds);

  final Completer completer;
  final List<String> paymentIds;
}

class DeletePaymentsSuccess implements StopSaving, PersistData {
  DeletePaymentsSuccess(this.payments);

  final List<PaymentEntity> payments;
}

class DeletePaymentsFailure implements StopSaving {
  DeletePaymentsFailure(this.payments);

  final List<PaymentEntity> payments;
}

class RestorePaymentsRequest implements StartSaving {
  RestorePaymentsRequest(this.completer, this.paymentIds);

  final Completer completer;
  final List<String> paymentIds;
}

class RestorePaymentsSuccess implements StopSaving, PersistData {
  RestorePaymentsSuccess(this.payments);

  final List<PaymentEntity> payments;
}

class RestorePaymentsFailure implements StopSaving {
  RestorePaymentsFailure(this.payments);

  final List<PaymentEntity> payments;
}

class EmailPaymentRequest implements StartSaving {
  EmailPaymentRequest(this.completer, this.paymentIds);

  final Completer completer;
  final List<String> paymentIds;
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

class FilterPaymentsByCustom3 implements PersistUI {
  FilterPaymentsByCustom3(this.value);

  final String value;
}

class FilterPaymentsByCustom4 implements PersistUI {
  FilterPaymentsByCustom4(this.value);

  final String value;
}

class StartPaymentMultiselect {}

class AddToPaymentMultiselect {
  AddToPaymentMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromPaymentMultiselect {
  RemoveFromPaymentMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearPaymentMultiselect {}

class UpdatePaymentTab implements PersistUI {
  UpdatePaymentTab({this.tabIndex});

  final int tabIndex;
}

void handlePaymentAction(
    BuildContext context, List<BaseEntity> payments, EntityAction action) {
  if (payments.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final company = store.state.company;
  final localization = AppLocalization.of(context);
  final paymentIds = payments.map((payment) => payment.id).toList();
  var payment = payments.first as PaymentEntity;

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: payment);
      break;
    case EntityAction.apply:
      viewEntity(appContext: context.getAppContext(), entity: payment);
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        editEntity(
            context: context,
            entity: payment.rebuild((b) => b..isApplying = true));
      });
      break;
    case EntityAction.refund:
      viewEntity(appContext: context.getAppContext(), entity: payment);
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        if (payment.invoicePaymentables.length == 1) {
          payment = payment.rebuild((b) => b
            ..invoices.add(PaymentableEntity(
                invoiceId: payment.invoiceId,
                amount: payment.completedAmount)));
        }
        store.dispatch(ViewRefundPayment(
          payment: payment.rebuild((b) =>
              b..sendEmail = company.settings.clientManualPaymentNotification),
        ));
      });
      break;
    case EntityAction.emailPayment:
      store.dispatch(EmailPaymentRequest(
          snackBarCompleter<Null>(context, localization.emailedPayment),
          paymentIds));
      break;
    case EntityAction.restore:
      final message = paymentIds.length > 1
          ? localization.restoredPayments
              .replaceFirst(':value', paymentIds.length.toString())
          : localization.restoredPayment;
      store.dispatch(RestorePaymentsRequest(
          snackBarCompleter<Null>(context, message), paymentIds));
      break;
    case EntityAction.archive:
      final message = paymentIds.length > 1
          ? localization.archivedPayments
              .replaceFirst(':value', paymentIds.length.toString())
          : localization.archivedPayment;
      store.dispatch(ArchivePaymentsRequest(
          snackBarCompleter<Null>(context, message), paymentIds));
      break;
    case EntityAction.delete:
      final message = paymentIds.length > 1
          ? localization.deletedPayments
              .replaceFirst(':value', paymentIds.length.toString())
          : localization.deletedPayment;
      store.dispatch(DeletePaymentsRequest(
          snackBarCompleter<Null>(context, message), paymentIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.paymentListState.isInMultiselect()) {
        store.dispatch(StartPaymentMultiselect());
      }

      if (payments.isEmpty) {
        break;
      }

      for (final payment in payments) {
        if (!store.state.paymentListState.isSelected(payment.id)) {
          store.dispatch(AddToPaymentMultiselect(entity: payment));
        } else {
          store.dispatch(RemoveFromPaymentMultiselect(entity: payment));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [payment],
        context: context,
      );
      break;
  }
}
