import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:redux/redux.dart';

import 'payment_screen.dart';

class PaymentScreenBuilder extends StatelessWidget {
  const PaymentScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentScreenVM>(
      converter: PaymentScreenVM.fromStore,
      builder: (context, vm) {
        return PaymentScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class PaymentScreenVM {
  PaymentScreenVM({
    @required this.isInMultiselect,
    @required this.paymentList,
    @required this.userCompany,
    @required this.paymentMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity userCompany;
  final List<String> paymentList;
  final BuiltMap<String, PaymentEntity> paymentMap;

  static PaymentScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return PaymentScreenVM(
      paymentMap: state.paymentState.map,
      paymentList: memoizedFilteredPaymentList(
          state.paymentState.map,
          state.paymentState.list,
          state.invoiceState.map,
          state.clientState.map,
          state.paymentListState),
      userCompany: state.userCompany,
      isInMultiselect: state.paymentListState.isInMultiselect(),
    );
  }
}
