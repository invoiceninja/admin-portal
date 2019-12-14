import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

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
    @required this.state,
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
    final client = state.clientState.map[payment.clientId] ??
        ClientEntity(id: payment.clientId);
    final invoice =
        paymentInvoiceSelector(payment.id, state) ?? InvoiceEntity();

    return PaymentViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: payment.isNew,
      isLoading: state.isLoading,
      payment: payment,
      onEditPressed: (BuildContext context) {
        editEntity(
            context: context,
            entity: payment,
            completer: snackBarCompleter<PaymentEntity>(
                context, AppLocalization.of(context).updatedProduct));
      },
      onClientPressed: (context, [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(context: context, entities: [client]);
        } else {
          viewEntity(context: context, entity: client);
        }
      },
      onInvoicePressed: (context, [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
            context: context,
            entities: [invoice],
            client: client,
          );
        } else {
          viewEntity(context: context, entity: invoice);
        }
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handlePaymentAction(context, [payment], action),
    );
  }

  final AppState state;
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
