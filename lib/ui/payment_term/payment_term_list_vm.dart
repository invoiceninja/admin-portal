// Dart imports:
import 'dart:async';

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
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_list_item.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentTermListBuilder extends StatelessWidget {
  const PaymentTermListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentTermListVM>(
      converter: PaymentTermListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.paymentTerm,
            state: viewModel.state,
            entityList: viewModel.paymentTermList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final paymentTermId = viewModel.paymentTermList[index];
              final paymentTerm = viewModel.paymentTermMap[paymentTermId]!;
              final listState = state.getListState(EntityType.paymentTerm);
              final isInMultiselect = listState.isInMultiselect();

              return PaymentTermListItem(
                user: viewModel.state.user,
                filter: viewModel.filter,
                paymentTerm: paymentTerm,
                isChecked:
                    isInMultiselect && listState.isSelected(paymentTerm.id),
              );
            });
      },
    );
  }
}

class PaymentTermListVM {
  PaymentTermListVM({
    required this.state,
    required this.userCompany,
    required this.paymentTermList,
    required this.paymentTermMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.onSortColumn,
    required this.onClearMultielsect,
    this.tableColumns,
  });

  static PaymentTermListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return PaymentTermListVM(
      state: state,
      userCompany: state.userCompany,
      listState: state.paymentTermListState,
      paymentTermList: memoizedFilteredPaymentTermList(
          state.getUISelection(EntityType.paymentTerm),
          state.paymentTermState.map,
          state.paymentTermState.list,
          state.paymentTermListState),
      paymentTermMap: state.paymentTermState.map,
      isLoading: state.isLoading,
      filter: state.paymentTermUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> paymentTerms,
              EntityAction action) =>
          handlePaymentTermAction(context, paymentTerms, action),
      onRefreshed: (context) => _handleRefresh(context),
      onSortColumn: (field) => store.dispatch(SortPaymentTerms(field)),
      onClearMultielsect: () => store.dispatch(ClearPaymentTermMultiselect()),
    );
  }

  final AppState state;
  final UserCompanyEntity? userCompany;
  final List<String> paymentTermList;
  final BuiltMap<String, PaymentTermEntity> paymentTermMap;
  final ListUIState listState;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final List<String>? tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
