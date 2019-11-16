import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
    final company = state.company;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.paymentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.paymentList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () =>
          store.dispatch(StartPaymentMultiselect(context: context)),
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
          FlatButton(
            key: key,
            child: Text(
              localization.cancel,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              store.dispatch(ClearPaymentMultiselect(context: context));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            textColor: Colors.white,
            disabledTextColor: Colors.white54,
            child: Text(
              localization.done,
            ),
            onPressed: state.paymentListState.selectedIds.isEmpty
                ? null
                : () async {
                    final payments = viewModel.paymentList
                        .map<PaymentEntity>(
                            (paymentId) => viewModel.paymentMap[paymentId])
                        .toList();

                    await showEntityActionsDialog(
                        entities: payments,
                        context: context,
                        multiselect: true);
                    store.dispatch(ClearPaymentMultiselect(context: context));
                  },
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
                store.dispatch(EditPayment(
                    payment: PaymentEntity(company: company).rebuild((b) => b
                      ..clientId = store.state.paymentListState.filterEntityId),
                    context: context));
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
