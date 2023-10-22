// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf.dart';

class InvoicePdfScreen extends StatelessWidget {
  const InvoicePdfScreen({Key? key, this.showAppBar = true}) : super(key: key);

  final bool showAppBar;

  static const String route = '/invoice/pdf';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoicePdfVM>(
      converter: (Store<AppState> store) {
        return InvoicePdfVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoicePdfView(
          key: ValueKey('__invoice_pdf_${vm.invoice!.id}__'),
          viewModel: vm,
          showAppBar: showAppBar,
        );
      },
    );
  }
}

abstract class EntityPdfVM {
  EntityPdfVM({
    required this.state,
    required this.invoice,
    required this.activityId,
  });

  final AppState? state;
  final InvoiceEntity? invoice;
  final String? activityId;
}

class InvoicePdfVM extends EntityPdfVM {
  InvoicePdfVM({
    AppState? state,
    InvoiceEntity? invoice,
    String? activityId,
  }) : super(
          state: state,
          invoice: invoice,
          activityId: activityId,
        );

  factory InvoicePdfVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoiceUIState = state.uiState.invoiceUIState;
    final invoiceId = invoiceUIState.selectedId!;
    final invoice = state.invoiceState.get(invoiceId);

    return InvoicePdfVM(
      state: state,
      invoice: invoice,
      activityId: invoiceUIState.historyActivityId,
    );
  }
}
