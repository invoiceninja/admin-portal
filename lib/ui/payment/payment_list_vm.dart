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
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentListBuilder extends StatelessWidget {
  const PaymentListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentListVM>(
      converter: PaymentListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.payment,
            presenter: PaymentPresenter(),
            state: viewModel.state,
            entityList: viewModel.paymentList,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final paymentId = viewModel.paymentList[index];
              final payment = state.paymentState.map[paymentId]!;
              final paymentListState = viewModel.state.paymentListState;

              return PaymentListItem(
                filter: viewModel.filter,
                payment: payment,
                showCheckbox: paymentListState.isInMultiselect(),
                isChecked: paymentListState.isSelected(payment.id),
              );
            });
      },
    );
  }
}

class PaymentListVM {
  PaymentListVM({
    required this.state,
    required this.user,
    required this.paymentList,
    required this.paymentMap,
    required this.clientMap,
    required this.filter,
    required this.isLoading,
    required this.onRefreshed,
    required this.listState,
    required this.tableColumns,
    required this.onSortColumn,
    required this.onClearMultielsect,
  });

  static PaymentListVM fromStore(Store<AppState> store) {
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

    return PaymentListVM(
      state: state,
      user: state.user,
      paymentList: memoizedFilteredPaymentList(
          state.getUISelection(EntityType.payment),
          state.paymentState.map,
          state.paymentState.list,
          state.invoiceState.map,
          state.clientState.map,
          state.userState.map,
          state.staticState.paymentTypeMap,
          state.paymentListState),
      paymentMap: state.paymentState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.paymentUIState.listUIState.filter,
      listState: state.paymentListState,
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.payment) ??
              PaymentPresenter.getDefaultTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortPayments(field)),
      onClearMultielsect: () => store.dispatch(ClearPaymentMultiselect()),
    );
  }

  final AppState state;
  final UserEntity? user;
  final ListUIState listState;
  final List<String> paymentList;
  final BuiltMap<String, PaymentEntity> paymentMap;
  final BuiltMap<String, ClientEntity> clientMap;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
