// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';

class RecurringInvoicePdfScreen extends StatelessWidget {
  const RecurringInvoicePdfScreen({Key? key, this.showAppBar = true})
      : super(key: key);

  final bool showAppBar;

  static const String route = '/recurring_invoice/pdf';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoicePdfVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoicePdfVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoicePdfView(
          key: ValueKey('__recurring_invoice_pdf_${vm.invoice!.id}__'),
          viewModel: vm,
          showAppBar: showAppBar,
        );
      },
    );
  }
}

class RecurringInvoicePdfVM extends EntityPdfVM {
  RecurringInvoicePdfVM({
    AppState? state,
    InvoiceEntity? invoice,
    String? activityId,
  }) : super(
          state: state,
          invoice: invoice,
          activityId: activityId,
        );

  factory RecurringInvoicePdfVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final recurringInvoiceUIState = state.uiState.recurringInvoiceUIState;
    final invoiceId = recurringInvoiceUIState.selectedId!;
    final invoice = state.recurringInvoiceState.get(invoiceId);

    return RecurringInvoicePdfVM(
      state: state,
      invoice: invoice,
      activityId: recurringInvoiceUIState.historyActivityId,
    );
  }
}
