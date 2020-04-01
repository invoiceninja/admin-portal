import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/payment/refund/payment_refund.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentRefundScreen extends StatelessWidget {
  const PaymentRefundScreen({Key key}) : super(key: key);

  static const String route = '/payment/refund';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentRefundVM>(
      converter: (Store<AppState> store) {
        return PaymentRefundVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return PaymentRefund(
          viewModel: viewModel,
          key: ValueKey(viewModel.payment.id),
        );
      },
    );
  }
}

class PaymentRefundVM {
  PaymentRefundVM({
    @required this.payment,
    @required this.origPayment,
    @required this.onChanged,
    @required this.onRefundPressed,
    @required this.onEmailChanged,
    @required this.prefState,
    @required this.invoiceMap,
    @required this.invoiceList,
    @required this.staticState,
    @required this.onCancelPressed,
    @required this.isSaving,
    @required this.isDirty,
  });

  factory PaymentRefundVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final payment = state.paymentUIState.editing;

    return PaymentRefundVM(
      isSaving: state.isSaving,
      isDirty: payment.isNew,
      origPayment: state.paymentState.map[payment.id],
      payment: payment,
      prefState: state.prefState,
      staticState: state.staticState,
      invoiceMap: state.invoiceState.map,
      invoiceList: state.invoiceState.list,
      onChanged: (PaymentEntity payment) {
        store.dispatch(UpdatePayment(payment));
      },
      onEmailChanged: (value) async {
        if (payment.isOld) {
          return;
        }
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(kSharedPrefEmailPayment, value);
        store.dispatch(UserSettingsChanged(emailPayment: value));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: PaymentEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onRefundPressed: (BuildContext context) {
        final Completer<PaymentEntity> completer = Completer<PaymentEntity>();
        store.dispatch(
            RefundPaymentRequest(completer: completer, payment: payment));
        return completer.future.then((savedPayment) {
          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(PaymentViewScreen.route));
            if (payment.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(PaymentViewScreen.route);
            } else {
              Navigator.of(context).pop(savedPayment);
            }
          } else {
            viewEntity(context: context, entity: savedPayment, force: true);
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final PaymentEntity payment;
  final PaymentEntity origPayment;
  final Function(PaymentEntity) onChanged;
  final Function(BuildContext) onRefundPressed;
  final Function(BuildContext) onCancelPressed;
  final Function(bool) onEmailChanged;
  final BuiltMap<String, InvoiceEntity> invoiceMap;
  final PrefState prefState;
  final BuiltList<String> invoiceList;
  final StaticState staticState;
  final bool isSaving;
  final bool isDirty;
}
