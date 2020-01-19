import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/payment_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentListVM viewModel;

  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.payment,
        editingId: viewModel.state.paymentUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.paymentList,
        entityMap: viewModel.paymentMap,
        entityPresenter: PaymentPresenter(),
        onTap: (BaseEntity payment) =>
            viewModel.onPaymentTap(context, payment));
  }

  @override
  void didUpdateWidget(PaymentList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.paymentUIState.editing.id;
    dataTableSource.entityList = viewModel.paymentList;
    dataTableSource.entityMap = viewModel.paymentMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final viewModel = widget.viewModel;
    final listState = viewModel.listState;
    final state = viewModel.state;
    final listUIState = state.uiState.paymentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final isList = state.prefState.moduleLayout == ModuleLayout.list;
    final paymentList = viewModel.paymentList;

    if (!viewModel.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (viewModel.paymentMap.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    if (state.shouldSelectEntity(EntityType.payment)) {
      viewEntityById(
          context: context,
          entityType: EntityType.payment,
          entityId: paymentList.isEmpty ? null : paymentList.first);
    }

    final listOrTable = () {
      if (isList) {
        return Column(children: <Widget>[
          if (listState.filterEntityId != null)
            ListFilterMessage(
              filterEntityId: listState.filterEntityId,
              filterEntityType: listState.filterEntityType,
              onPressed: viewModel.onViewEntityFilterPressed,
              onClearPressed: viewModel.onClearEntityFilterPressed,
            ),
          Expanded(
              child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: viewModel.paymentList.length,
            itemBuilder: (BuildContext context, index) {
              final paymentId = viewModel.paymentList[index];
              final payment = state.paymentState.map[paymentId];
              final client = state.clientState.map[payment.clientId] ??
                  ClientEntity(id: payment.clientId);

              void showDialog() => showEntityActionsDialog(
                    entities: [payment],
                    context: context,
                    client: client,
                  );

              ClientEntity(id: payment.clientId);

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
                isChecked:
                    isInMultiselect && listUIState.isSelected(payment.id),
              );
            },
          )),
        ]);
      } else {
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: PaginatedDataTable(
            onSelectAll: (value) {
              final payments = viewModel.paymentList
                  .map<PaymentEntity>(
                      (paymentId) => viewModel.paymentMap[paymentId])
                  .where(
                      (payment) => value != listUIState.isSelected(payment.id))
                  .toList();
              handlePaymentAction(
                  context, payments, EntityAction.toggleMultiselect);
            },
            columns: [
              if (!listUIState.isInMultiselect()) DataColumn(label: SizedBox()),
              ...viewModel.tableColumns.map((field) => DataColumn(
                  label: Text(AppLocalization.of(context).lookup(field)),
                  numeric: EntityPresenter.isFieldNumeric(field),
                  onSort: (int columnIndex, bool ascending) =>
                      store.dispatch(SortPayments(field)))),
            ],
            source: dataTableSource,
            header: DatatableHeader(
              entityType: EntityType.payment,
              onClearPressed: widget.viewModel.onClearEntityFilterPressed,
            ),
          ),
        ));
      }
    };

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: listOrTable(),
    );
  }
}
