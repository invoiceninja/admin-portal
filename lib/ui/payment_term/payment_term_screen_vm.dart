// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_selectors.dart';
import 'payment_term_screen.dart';

class PaymentTermScreenBuilder extends StatelessWidget {
  const PaymentTermScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentTermScreenVM>(
      converter: PaymentTermScreenVM.fromStore,
      builder: (context, vm) {
        return PaymentTermScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class PaymentTermScreenVM {
  PaymentTermScreenVM({
    required this.isInMultiselect,
    required this.paymentTermList,
    required this.userCompany,
    required this.onEntityAction,
    required this.paymentTermMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> paymentTermList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, PaymentTermEntity> paymentTermMap;

  static PaymentTermScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return PaymentTermScreenVM(
      paymentTermMap: state.paymentTermState.map,
      paymentTermList: memoizedFilteredPaymentTermList(
          state.getUISelection(EntityType.paymentTerm),
          state.paymentTermState.map,
          state.paymentTermState.list,
          state.paymentTermListState),
      userCompany: state.userCompany,
      isInMultiselect: state.paymentTermListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> paymentTerms,
              EntityAction action) =>
          handlePaymentTermAction(context, paymentTerms, action),
    );
  }
}
