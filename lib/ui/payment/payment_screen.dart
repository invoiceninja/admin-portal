import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_vm.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class PaymentScreen extends StatelessWidget {
  static const String route = '/payment';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final company = store.state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return WillPopScope(
      onWillPop: () async {
        store.dispatch(ViewDashboard(context));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListFilter(
            entityType: EntityType.payment,
            onFilterChanged: (value) {
              store.dispatch(FilterPayments(value));
            },
          ),
          actions: [
            ListFilterButton(
              entityType: EntityType.payment,
              onFilterPressed: (String value) {
                store.dispatch(FilterPayments(value));
              },
            ),
          ],
        ),
        drawer: AppDrawerBuilder(),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: user.canCreate(EntityType.payment)
            ? FloatingActionButton(
                //key: Key(PaymentKeys.paymentScreenFABKeyString),
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () {
                  store.dispatch(EditPayment(
                      payment: PaymentEntity(company: company).rebuild((b) => b
                        ..clientId =
                            store.state.paymentListState.filterEntityId ?? 0),
                      context: context));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: localization.enterPayment,
              )
            : null,
      ),
    );
  }
}
