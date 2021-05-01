import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_presenter.dart';
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

    return ListScaffold(
      entityType: EntityType.payment,
      onHamburgerLongPress: () => store.dispatch(StartPaymentMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.paymentListState.filterClearedAt}__'),
        entityType: EntityType.payment,
        entityIds: viewModel.paymentList,
        filter: state.paymentListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterPayments(value));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.paymentListState.isInMultiselect()) {
          store.dispatch(ClearPaymentMultiselect());
        } else {
          store.dispatch(StartPaymentMultiselect());
        }
      },
      body: PaymentListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.payment,
        tableColumns: PaymentPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            PaymentPresenter.getDefaultTableFields(userCompany),
        onSelectedSortField: (value) => store.dispatch(SortPayments(value)),
        customValues1: company.getCustomFieldValues(CustomFieldType.payment1,
            excludeBlank: true),
        customValues2: company.getCustomFieldValues(CustomFieldType.payment2,
            excludeBlank: true),
        customValues3: company.getCustomFieldValues(CustomFieldType.payment3,
            excludeBlank: true),
        customValues4: company.getCustomFieldValues(CustomFieldType.payment4,
            excludeBlank: true),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterPaymentsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterPaymentsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterPaymentsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterPaymentsByCustom4(value)),
        sortFields: [
          PaymentFields.number,
          PaymentFields.date,
          PaymentFields.amount,
          EntityFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterPaymentsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.paymentListState.isInMultiselect()) {
            store.dispatch(ClearPaymentMultiselect());
          } else {
            store.dispatch(StartPaymentMultiselect());
          }
        },
      ),
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.payment)
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
