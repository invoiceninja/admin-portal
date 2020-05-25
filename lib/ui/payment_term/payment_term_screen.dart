import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/payment_term_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

import 'payment_term_screen_vm.dart';

class PaymentTermScreen extends StatelessWidget {
  const PaymentTermScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/payment_term';

  final PaymentTermScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.paymentTermUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.paymentTermList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartPaymentTermMultiselect()),
      onCheckboxChanged: (value) {
        final paymentTerms = viewModel.paymentTermList
            .map<PaymentTermEntity>(
                (paymentTermId) => viewModel.paymentTermMap[paymentTermId])
            .where((paymentTerm) =>
                value != listUIState.isSelected(paymentTerm.id))
            .toList();

        handlePaymentTermAction(
            context, paymentTerms, EntityAction.toggleMultiselect);
      },
      appBarTitle: Text(localization.paymentTerms),
      appBarActions: [
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final paymentTerms = listUIState.selectedIds
                        .map<PaymentTermEntity>((paymentTermId) =>
                            viewModel.paymentTermMap[paymentTermId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: paymentTerms,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>((_) =>
                            store.dispatch(ClearPaymentTermMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearPaymentTermMultiselect()),
          ),
      ],
      body: PaymentTermListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.paymentTerm,
        onRefreshPressed: () => store.dispatch(LoadPaymentTerms(force: true)),
        onSelectedSortField: (value) {
          store.dispatch(SortPaymentTerms(value));
        },
        sortFields: [
          PaymentTermFields.name,
          PaymentTermFields.numDays,
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
      floatingActionButton:
          isMobile(context) && userCompany.canCreate(EntityType.paymentTerm)
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
                  tooltip: localization.newPaymentTerm,
                )
              : null,
    );
  }
}
