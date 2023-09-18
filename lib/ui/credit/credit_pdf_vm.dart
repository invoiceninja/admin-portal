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

class CreditPdfScreen extends StatelessWidget {
  const CreditPdfScreen({Key? key, this.showAppBar = true}) : super(key: key);

  final bool showAppBar;

  static const String route = '/credit/pdf';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditPdfVM>(
      converter: (Store<AppState> store) {
        return CreditPdfVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoicePdfView(
          key: ValueKey('__credit_pdf_${vm.invoice!.id}__'),
          viewModel: vm,
          showAppBar: showAppBar,
        );
      },
    );
  }
}

class CreditPdfVM extends EntityPdfVM {
  CreditPdfVM({
    AppState? state,
    InvoiceEntity? invoice,
    String? activityId,
  }) : super(
          state: state,
          invoice: invoice,
          activityId: activityId,
        );

  factory CreditPdfVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final creditUIState = state.uiState.creditUIState;
    final invoiceId = creditUIState.selectedId!;
    final invoice = state.creditState.get(invoiceId);

    return CreditPdfVM(
      state: state,
      invoice: invoice,
      activityId: creditUIState.historyActivityId,
    );
  }
}
