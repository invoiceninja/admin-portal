// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment_term/payment_term_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentTermList extends StatefulWidget {
  const PaymentTermList({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final PaymentTermListVM viewModel;

  @override
  _PaymentTermListState createState() => _PaymentTermListState();
}

class _PaymentTermListState extends State<PaymentTermList> {
  EntityDataTableSource? dataTableSource;

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final listUIState = state.uiState.paymentTermUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    if (!viewModel.state.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (viewModel.paymentTermMap.isEmpty) {
      return HelpText(AppLocalization.of(context)!.noRecordsFound);
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ScrollableListViewBuilder(
          separatorBuilder: (context, index) => ListDivider(),
          itemCount: viewModel.paymentTermList.length,
          itemBuilder: (BuildContext context, index) {
            final paymentTermId = viewModel.paymentTermList[index];
            final paymentTerm = viewModel.paymentTermMap[paymentTermId]!;

            return PaymentTermListItem(
              user: viewModel.state.user,
              filter: viewModel.filter,
              paymentTerm: paymentTerm,
              isChecked:
                  isInMultiselect && listUIState.isSelected(paymentTerm.id),
            );
          }),
    );
  }
}
