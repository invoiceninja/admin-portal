// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'payment_term_screen_vm.dart';

class PaymentTermScreen extends StatelessWidget {
  const PaymentTermScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  static const String route = '/$kSettings/$kSettingsPaymentTerms';

  final PaymentTermScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return ListScaffold(
      entityType: EntityType.paymentTerm,
      onHamburgerLongPress: () => store.dispatch(StartPaymentTermMultiselect()),
      onCancelSettingsSection: kSettingsCompanyDetails,
      onCancelSettingsIndex: 3,
      appBarTitle: ListFilter(
        key: ValueKey(
            '__filter_${state.paymentTermListState.filterClearedAt}__'),
        entityType: EntityType.paymentTerm,
        entityIds: viewModel.paymentTermList,
        filter: state.paymentTermListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterPaymentTerms(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterPaymentTermsByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.paymentTermListState.isInMultiselect()) {
          store.dispatch(ClearPaymentTermMultiselect());
        } else {
          store.dispatch(StartPaymentTermMultiselect());
        }
      },
      body: PaymentTermListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.paymentTerm,
        onSelectedSortField: (value) {
          store.dispatch(SortPaymentTerms(value));
        },
        sortFields: [
          PaymentTermFields.name,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterPaymentTermsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.paymentTermListState.isInMultiselect()) {
            store.dispatch(ClearPaymentTermMultiselect());
          } else {
            store.dispatch(StartPaymentTermMultiselect());
          }
        },
        onSelectedCustom1: (value) =>
            store.dispatch(FilterPaymentTermsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterPaymentTermsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterPaymentTermsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterPaymentTermsByCustom4(value)),
      ),
      floatingActionButton: state.prefState.isMobile &&
              userCompany.canCreate(EntityType.paymentTerm)
          ? FloatingActionButton(
              heroTag: 'payment_term_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.paymentTerm);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization!.newPaymentTerm,
            )
          : null,
    );
  }
}
