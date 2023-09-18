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

class QuotePdfScreen extends StatelessWidget {
  const QuotePdfScreen({Key? key, this.showAppBar = true}) : super(key: key);

  final bool showAppBar;

  static const String route = '/quote/pdf';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuotePdfVM>(
      converter: (Store<AppState> store) {
        return QuotePdfVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoicePdfView(
          key: ValueKey('__quote_pdf_${vm.invoice!.id}__'),
          viewModel: vm,
          showAppBar: showAppBar,
        );
      },
    );
  }
}

class QuotePdfVM extends EntityPdfVM {
  QuotePdfVM({
    AppState? state,
    InvoiceEntity? invoice,
    String? activityId,
  }) : super(
          state: state,
          invoice: invoice,
          activityId: activityId,
        );

  factory QuotePdfVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final quoteUIState = state.uiState.quoteUIState;
    final invoiceId = quoteUIState.selectedId!;
    final invoice = state.quoteState.get(invoiceId);

    return QuotePdfVM(
      state: state,
      invoice: invoice,
      activityId: quoteUIState.historyActivityId,
    );
  }
}
