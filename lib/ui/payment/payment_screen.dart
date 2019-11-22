import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_vm.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.paymentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.paymentList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartPaymentMultiselect()),
      onCheckboxChanged: (value) {
        final payments = viewModel.paymentList
            .map<PaymentEntity>((paymentId) => viewModel.paymentMap[paymentId])
            .where((payment) => value != listUIState.isSelected(payment.id))
            .toList();

        handlePaymentAction(context, payments, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.payments,
        key: ValueKey(store.state.paymentListState.filterClearedAt),
        filter: state.paymentListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterPayments(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.paymentListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterPayments(value));
            },
          ),
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: state.paymentListState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final payments = viewModel.paymentList
                        .map<PaymentEntity>(
                            (paymentId) => viewModel.paymentMap[paymentId])
                        .toList();

                    await showEntityActionsDialog(
                        entities: payments,
                        context: context,
                        multiselect: true);

                    store.dispatch(ClearPaymentMultiselect());
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearPaymentMultiselect()),
          ),
      ],
      body: PaymentListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.payment,
        onSelectedSortField: (value) => store.dispatch(SortPayments(value)),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterPaymentsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterPaymentsByCustom2(value)),
        sortFields: [
          PaymentFields.paymentDate,
          PaymentFields.amount,
          PaymentFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterPaymentsByState(state));
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.payment)
          ? FloatingActionButton(
              heroTag: 'payment_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.payment);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.enterPayment,
            )
          : null,
    );
  }

  static const String route = '/payment';
}
