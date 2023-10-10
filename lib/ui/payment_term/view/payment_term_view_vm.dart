// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_screen.dart';
import 'package:invoiceninja_flutter/ui/payment_term/view/payment_term_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentTermViewScreen extends StatelessWidget {
  const PaymentTermViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/$kSettings/$kSettingsPaymentTermView';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentTermViewVM>(
      converter: (Store<AppState> store) {
        return PaymentTermViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return PaymentTermView(
          viewModel: vm,
        );
      },
    );
  }
}

class PaymentTermViewVM {
  PaymentTermViewVM({
    required this.state,
    required this.paymentTerm,
    required this.company,
    required this.onEntityAction,
    required this.onBackPressed,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
  });

  factory PaymentTermViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final paymentTerm =
        state.paymentTermState.map[state.paymentTermUIState.selectedId] ??
            PaymentTermEntity(id: state.paymentTermUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(
          LoadPaymentTerm(completer: completer, paymentTermId: paymentTerm.id));
      return completer.future;
    }

    return PaymentTermViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: paymentTerm.isNew,
      paymentTerm: paymentTerm,
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(PaymentTermScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([paymentTerm], action, autoPop: true),
    );
  }

  final AppState state;
  final PaymentTermEntity paymentTerm;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
