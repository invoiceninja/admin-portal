import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_presenter.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';

class PaymentListBuilder extends StatelessWidget {
  const PaymentListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentListVM>(
      converter: PaymentListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            entityType: EntityType.payment,
            presenter: PaymentPresenter(),
            state: viewModel.state,
            entityList: viewModel.paymentList,
            onEntityTap: viewModel.onPaymentTap,
            tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final paymentId = viewModel.paymentList[index];
              final state = viewModel.state;
              final payment = state.paymentState.map[paymentId];
              final client = state.clientState.map[payment.clientId] ??
                  ClientEntity(id: payment.clientId);
              final listState = state.getListState(EntityType.client);
              final isInMultiselect = listState.isInMultiselect();

              void showDialog() => showEntityActionsDialog(
                    entities: [payment],
                    context: context,
                    client: client,
                  );

              return PaymentListItem(
                user: viewModel.user,
                filter: viewModel.filter,
                payment: payment,
                onTap: () => viewModel.onPaymentTap(context, payment),
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    handlePaymentAction(context, [payment], action);
                  }
                },
                onLongPress: () async {
                  final longPressIsSelection =
                      state.prefState.longPressSelectionIsDefault ?? true;
                  if (longPressIsSelection && !isInMultiselect) {
                    handlePaymentAction(
                        context, [payment], EntityAction.toggleMultiselect);
                  } else {
                    showDialog();
                  }
                },
                isChecked: isInMultiselect && listState.isSelected(payment.id),
              );
            });
      },
    );
  }
}

class PaymentListVM {
  PaymentListVM({
    @required this.state,
    @required this.user,
    @required this.paymentList,
    @required this.paymentMap,
    @required this.clientMap,
    @required this.filter,
    @required this.isLoading,
    @required this.onPaymentTap,
    @required this.onRefreshed,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.listState,
    @required this.tableColumns,
    @required this.onSortColumn,
  });

  static PaymentListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(RefreshData(completer: completer));
      return completer.future;
    }

    final state = store.state;

    return PaymentListVM(
      state: state,
      user: state.user,
      paymentList: memoizedFilteredPaymentList(
          state.paymentState.map,
          state.paymentState.list,
          state.invoiceState.map,
          state.clientState.map,
          state.userState.map,
          state.paymentListState),
      paymentMap: state.paymentState.map,
      clientMap: state.clientState.map,
      isLoading: state.isLoading,
      filter: state.paymentUIState.listUIState.filter,
      listState: state.paymentListState,
      onPaymentTap: (context, payment) {
        if (store.state.paymentListState.isInMultiselect()) {
          handlePaymentAction(
              context, [payment], EntityAction.toggleMultiselect);
        } else if (isDesktop(context) && state.uiState.isEditing) {
          viewEntity(context: context, entity: payment);
        } else if (isDesktop(context) &&
            state.paymentUIState.selectedId == payment.id) {
          editEntity(context: context, entity: payment);
        } else {
          viewEntity(context: context, entity: payment);
        }
      },
      onClearEntityFilterPressed: () => store.dispatch(FilterByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.paymentListState.filterEntityId,
          entityType: state.paymentListState.filterEntityType),
      onRefreshed: (context) => _handleRefresh(context),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.payment) ??
              PaymentPresenter.getAllTableFields(state.userCompany),
      onSortColumn: (field) => store.dispatch(SortPayments(field)),
    );
  }

  final AppState state;
  final UserEntity user;
  final ListUIState listState;
  final List<String> paymentList;
  final BuiltMap<String, PaymentEntity> paymentMap;
  final BuiltMap<String, ClientEntity> clientMap;
  final String filter;
  final bool isLoading;
  final Function(BuildContext, BaseEntity) onPaymentTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final List<String> tableColumns;
  final Function(String) onSortColumn;
}
