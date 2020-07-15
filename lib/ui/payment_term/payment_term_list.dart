import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentTermList extends StatefulWidget {
  const PaymentTermList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PaymentTermListVM viewModel;

  @override
  _PaymentTermListState createState() => _PaymentTermListState();
}

class _PaymentTermListState extends State<PaymentTermList> {
  EntityDataTableSource dataTableSource;

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final listUIState = state.uiState.paymentTermUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    if (!viewModel.state.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (viewModel.paymentTermMap.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.separated(
          separatorBuilder: (context, index) => ListDivider(),
          itemCount: viewModel.paymentTermList.length,
          itemBuilder: (BuildContext context, index) {
            final paymentTermId = viewModel.paymentTermList[index];
            final paymentTerm = viewModel.paymentTermMap[paymentTermId];

            return PaymentTermListItem(
              user: viewModel.state.user,
              filter: viewModel.filter,
              paymentTerm: paymentTerm,
              onEntityAction: (EntityAction action) {
                if (action == EntityAction.more) {
                  showEntityActionsDialog(
                    entities: [paymentTerm],
                    context: context,
                  );
                } else {
                  handlePaymentTermAction(context, [paymentTerm], action);
                }
              },
              onLongPress: () async {
                final longPressIsSelection =
                    state.prefState.longPressSelectionIsDefault ?? true;
                if (longPressIsSelection && !isInMultiselect) {
                  handlePaymentTermAction(
                      context, [paymentTerm], EntityAction.toggleMultiselect);
                } else {
                  showEntityActionsDialog(
                    entities: [paymentTerm],
                    context: context,
                  );
                }
              },
              isChecked:
                  isInMultiselect && listUIState.isSelected(paymentTerm.id),
            );
          }),
    );
  }
}
