import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:redux/redux.dart';

import 'credit_screen.dart';

class CreditScreenBuilder extends StatelessWidget {
  const CreditScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditScreenVM>(
      converter: CreditScreenVM.fromStore,
      builder: (context, vm) {
        return CreditScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class CreditScreenVM {
  CreditScreenVM({
    @required this.isInMultiselect,
    @required this.creditList,
    @required this.userCompany,
    @required this.onEntityAction,
    @required this.creditMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity userCompany;
  final List<String> creditList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, InvoiceEntity> creditMap;

  static CreditScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return CreditScreenVM(
      creditMap: state.creditState.map,
      creditList: memoizedFilteredCreditList(state.creditState.map,
          state.creditState.list, state.clientState.map, state.creditListState),
      userCompany: state.userCompany,
      isInMultiselect: state.creditListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> credits,
              EntityAction action) =>
          handleCreditAction(context, credits, action),
    );
  }
}
