// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/payment/edit/payment_edit.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class PaymentEditScreen extends StatelessWidget {
  const PaymentEditScreen({Key? key}) : super(key: key);

  static const String route = '/payment/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentEditVM>(
      converter: (Store<AppState> store) {
        return PaymentEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return PaymentEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.payment.updatedAt),
        );
      },
    );
  }
}

class PaymentEditVM {
  PaymentEditVM({
    required this.state,
    required this.payment,
    required this.origPayment,
    required this.onChanged,
    required this.onSavePressed,
    required this.prefState,
    required this.staticState,
    required this.onCancelPressed,
    required this.isSaving,
    required this.isDirty,
  });

  factory PaymentEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final payment = state.paymentUIState.editing!;

    return PaymentEditVM(
      state: state,
      isSaving: state.isSaving,
      isDirty: payment.isNew,
      origPayment: state.paymentState.map[payment.id],
      payment: payment,
      prefState: state.prefState,
      staticState: state.staticState,
      onChanged: (PaymentEntity payment) {
        store.dispatch(UpdatePayment(payment));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(entity: PaymentEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final payment = store.state.paymentUIState.editing!;
          final localization = navigatorKey.localization!;
          final navigator = navigatorKey.currentState;
          double amount = 0;
          payment.invoices.forEach((invoice) => amount += invoice.amount);
          payment.credits.forEach((credit) => amount -= credit.amount);
          if (amount < 0) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(localization.creditPaymentError);
                });
            return null;
          } else if (!state.company.enableApplyingPayments &&
              payment.invoices.isEmpty &&
              payment.credits.isEmpty &&
              payment.isNew) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(
                      localization.pleaseSelectAnInvoiceOrCredit);
                });
            return null;
          }

          final Completer<PaymentEntity> completer = Completer<PaymentEntity>();
          store.dispatch(
              SavePaymentRequest(completer: completer, payment: payment));
          return completer.future.then((savedPayment) {
            showToast(payment.isNew
                ? localization.createdPayment
                : localization.updatedPayment);
            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(PaymentViewScreen.route));
              if (payment.isNew) {
                navigator!.pushReplacementNamed(PaymentViewScreen.route);
              } else {
                navigator!.pop(savedPayment);
              }
            } else {
              if (payment.isApplying == true) {
                navigator!.pop();
              } else {
                viewEntity(entity: savedPayment);
              }
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final AppState state;
  final PaymentEntity payment;
  final PaymentEntity? origPayment;
  final Function(PaymentEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final PrefState prefState;
  final StaticState staticState;
  final bool isSaving;
  final bool isDirty;
}
