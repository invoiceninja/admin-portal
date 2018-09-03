import 'dart:async';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';

class PaymentListBuilder extends StatelessWidget {
  const PaymentListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentListVM>(
      converter: PaymentListVM.fromStore,
      builder: (context, viewModel) {
        return PaymentList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class PaymentListVM {
  final UserEntity user;
  final ListUIState listState;
  final List<int> paymentList;
  final BuiltMap<int, PaymentEntity> paymentMap;
  final BuiltMap<int, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, PaymentEntity) onPaymentTap;
  final Function(BuildContext, PaymentEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;
  final Function onClearClientFilterPressed;
  final Function(BuildContext) onViewClientFilterPressed;
  final Function(BuildContext, PaymentEntity, EntityAction) onEntityAction;

  PaymentListVM({
    @required this.user,
    @required this.paymentList,
    @required this.paymentMap,
    @required this.clientMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onPaymentTap,
    @required this.onDismissed,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearClientFilterPressed,
    @required this.onViewClientFilterPressed,
    @required this.listState,
  });

  static PaymentListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadPayments(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return PaymentListVM(
        user: state.user,
        paymentList: memoizedFilteredPaymentList(state.paymentState.map,
            state.paymentState.list, state.paymentListState),
        paymentMap: state.paymentState.map,
        clientMap: state.clientState.map,
        isLoading: state.isLoading,
        isLoaded: state.paymentState.isLoaded,
        filter: state.paymentUIState.listUIState.filter,
        listState: state.paymentListState,
        onPaymentTap: (context, payment) {
          store.dispatch(ViewPayment(paymentId: payment.id, context: context));
        },
        onEntityAction: (context, payment, action) {
          switch (action) {
            case EntityAction.restore:
              store.dispatch(RestorePaymentRequest(
                  popCompleter(
                      context, AppLocalization.of(context).restoredPayment),
                  payment.id));
              break;
            case EntityAction.archive:
              store.dispatch(ArchivePaymentRequest(
                  popCompleter(
                      context, AppLocalization.of(context).archivedPayment),
                  payment.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeletePaymentRequest(
                  popCompleter(
                      context, AppLocalization.of(context).deletedPayment),
                  payment.id));
              break;
          }
        },
        onClearClientFilterPressed: () =>
            store.dispatch(FilterPaymentsByClient()),
        onViewClientFilterPressed: (BuildContext context) => store.dispatch(
            ViewClient(
                clientId: state.paymentListState.filterClientId,
                context: context)),
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, PaymentEntity payment,
            DismissDirection direction) {
          final localization = AppLocalization.of(context);
          if (direction == DismissDirection.endToStart) {
            if (payment.isDeleted || payment.isArchived) {
              store.dispatch(RestorePaymentRequest(
                  snackBarCompleter(context, localization.restoredPayment),
                  payment.id));
            } else {
              store.dispatch(ArchivePaymentRequest(
                  snackBarCompleter(context, localization.archivedPayment),
                  payment.id));
            }
          } else if (direction == DismissDirection.startToEnd) {
            if (payment.isDeleted) {
              store.dispatch(RestorePaymentRequest(
                  snackBarCompleter(context, localization.restoredPayment),
                  payment.id));
            } else {
              store.dispatch(DeletePaymentRequest(
                  snackBarCompleter(context, localization.deletedPayment),
                  payment.id));
            }
          }
        });
  }
}
