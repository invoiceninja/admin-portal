import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class PaymentViewScreen extends StatelessWidget {
  const PaymentViewScreen({Key key}) : super(key: key);

  static const String route = '/payment/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentViewVM>(
      converter: (Store<AppState> store) {
        return PaymentViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return PaymentView(
          viewModel: vm,
        );
      },
    );
  }
}

class PaymentViewVM {
  PaymentViewVM({
    @required this.payment,
    @required this.company,
    @required this.onEntityAction,
    @required this.onEditPressed,
    @required this.onClientPressed,
    @required this.onInvoicePressed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory PaymentViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final payment = state.paymentState.map[state.paymentUIState.selectedId] ??
        PaymentEntity(id: state.paymentUIState.selectedId);
    final client = paymentClientSelector(payment.id, state) ?? ClientEntity();
    final invoice =
        paymentInvoiceSelector(payment.id, state) ?? InvoiceEntity();
    final user = state.user;

    return PaymentViewVM(
      company: state.selectedCompany,
      isSaving: state.isSaving,
      isDirty: payment.isNew,
      isLoading: state.isLoading,
      payment: payment,
      onEditPressed: (BuildContext context) {
        store.dispatch(EditPayment(payment: payment, context: context));
      },
      onClientPressed: (context, [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
              user: user,
              context: context,
              entity: client,
              onEntityAction: (BuildContext context, BaseEntity client,
                      EntityAction action) =>
                  handleClientAction(context, client, action));
        } else {
          store.dispatch(ViewClient(clientId: client.id, context: context));
        }
      },
      onInvoicePressed: (context, [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
              user: user,
              context: context,
              entity: invoice,
              client: client,
              onEntityAction: (BuildContext context, BaseEntity invoice,
                      EntityAction action) =>
                  handleInvoiceAction(context, invoice, action));
        } else {
          store.dispatch(ViewInvoice(invoiceId: invoice.id, context: context));
        }
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handlePaymentAction(context, payment, action),
    );
  }

  final PaymentEntity payment;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onEditPressed;
  final Function(BuildContext, [bool]) onInvoicePressed;
  final Function(BuildContext, [bool]) onClientPressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
