import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_vm.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final userCompany = store.state.userCompany;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(store.state.paymentListState.filterClearedAt),
        entityType: EntityType.payment,
        onFilterChanged: (value) {
          store.dispatch(FilterPayments(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.payment,
          onFilterPressed: (String value) {
            store.dispatch(FilterPayments(value));
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
