import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:redux/redux.dart';

class PaymentViewScreen extends StatelessWidget {
  const PaymentViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
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
          isFilter: isFilter,
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
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory PaymentViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final payment = state.paymentState.map[state.paymentUIState.selectedId] ??
        PaymentEntity(id: state.paymentUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadPayment(
        completer: completer,
        paymentId: payment.id,
      ));
      return completer.future;
    }

    return PaymentViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: payment.isNew,
      isLoading: state.isLoading,
      payment: payment,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context.getAppContext(), [payment], action,
              autoPop: true),
    );
  }

  final AppState state;
  final PaymentEntity payment;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
