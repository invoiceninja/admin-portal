// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/payment/refund/payment_refund.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class PaymentRefundScreen extends StatelessWidget {
  const PaymentRefundScreen({Key? key}) : super(key: key);

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
    required this.state,
    required this.payment,
    required this.origPayment,
    required this.onChanged,
    required this.onRefundPressed,
    required this.prefState,
    required this.invoiceMap,
    required this.invoiceList,
    required this.staticState,
    required this.onCancelPressed,
    required this.isSaving,
    required this.isDirty,
  });

  factory PaymentRefundVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final payment = state.paymentUIState.editing!;

    return PaymentRefundVM(
      state: state,
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
      onCancelPressed: (BuildContext context) {
        createEntity(entity: PaymentEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onRefundPressed:
          (BuildContext context, Completer<PaymentEntity> completer) {
        store.dispatch(
            RefundPaymentRequest(completer: completer, payment: payment));
        return completer.future.then((savedPayment) {
          showToast(AppLocalization.of(context)!.refundedPayment);
          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(PaymentViewScreen.route));
            if (payment.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(PaymentViewScreen.route);
            } else {
              Navigator.of(context).pop(savedPayment);
            }
          } else {
            viewEntity(entity: savedPayment, force: true);
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

  final AppState state;
  final PaymentEntity payment;
  final PaymentEntity? origPayment;
  final Function(PaymentEntity) onChanged;
  final Function(BuildContext, Completer<PaymentEntity>) onRefundPressed;
  final Function(BuildContext) onCancelPressed;
  final BuiltMap<String, InvoiceEntity> invoiceMap;
  final PrefState prefState;
  final BuiltList<String> invoiceList;
  final StaticState staticState;
  final bool isSaving;
  final bool isDirty;
}
