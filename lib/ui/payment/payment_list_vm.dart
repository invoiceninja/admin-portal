import 'dart:async';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
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
  PaymentListVM({
    @required this.user,
    @required this.paymentList,
    @required this.paymentMap,
    @required this.clientMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onPaymentTap,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
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
      paymentList: memoizedFilteredPaymentList(
          state.paymentState.map,
          state.paymentState.list,
          state.invoiceState.map,
          state.clientState.map,
          state.paymentListState),
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
        final localization = AppLocalization.of(context);
        switch (action) {
          case EntityAction.edit:
            store.dispatch(
                EditPayment(context: context, payment: payment));
            break;
          case EntityAction.sendEmail:
            store.dispatch(EmailPaymentRequest(
                snackBarCompleter(context, localization.emailedPayment),
                payment));
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
                snackBarCompleter(context, localization.deletedPayment),
                payment.id));
            break;
        }
      },
      onClearEntityFilterPressed: () =>
          store.dispatch(FilterPaymentsByEntity()),
      onViewClientFilterPressed: (BuildContext context) {
        switch (state.paymentListState.filterEntityType) {
          case EntityType.client:
            store.dispatch(ViewClient(
                clientId: state.paymentListState.filterEntityId,
                context: context));
            break;
          case EntityType.invoice:
            store.dispatch(ViewInvoice(
                invoiceId: state.paymentListState.filterEntityId,
                context: context));
            break;
        }
      },
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final UserEntity user;
  final ListUIState listState;
  final List<int> paymentList;
  final BuiltMap<int, PaymentEntity> paymentMap;
  final BuiltMap<int, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, PaymentEntity) onPaymentTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewClientFilterPressed;
  final Function(BuildContext, PaymentEntity, EntityAction) onEntityAction;
}
