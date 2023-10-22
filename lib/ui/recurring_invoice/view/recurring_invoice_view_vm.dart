// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class RecurringInvoiceViewScreen extends StatelessWidget {
  const RecurringInvoiceViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  static const String route = '/recurring_invoice/view';
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceViewVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoiceViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoiceView(
          viewModel: vm,
          isFilter: isFilter,
          tabIndex: vm.state!.recurringInvoiceUIState.tabIndex,
        );
      },
    );
  }
}

class RecurringInvoiceViewVM extends AbstractInvoiceViewVM {
  RecurringInvoiceViewVM({
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    ClientEntity? client,
    bool? isSaving,
    bool? isDirty,
    Function(BuildContext, EntityAction)? onEntityAction,
    Function(BuildContext, [int])? onEditPressed,
    Function(BuildContext)? onPaymentsPressed,
    Function(BuildContext, PaymentEntity)? onPaymentPressed,
    Function(BuildContext)? onRefreshed,
    Function(BuildContext, List<MultipartFile>, bool)? onUploadDocuments,
    Function(BuildContext, DocumentEntity)? onViewExpense,
    Function(BuildContext, InvoiceEntity, [String?])? onViewPdf,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          client: client,
          isSaving: isSaving,
          isDirty: isDirty,
          onActionSelected: onEntityAction,
          onEditPressed: onEditPressed,
          onPaymentsPressed: onPaymentsPressed,
          onRefreshed: onRefreshed,
          onUploadDocuments: onUploadDocuments,
          onViewExpense: onViewExpense,
          onViewPdf: onViewPdf,
        );

  factory RecurringInvoiceViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoice = state.recurringInvoiceState
            .map[state.recurringInvoiceUIState.selectedId] ??
        InvoiceEntity(id: state.recurringInvoiceUIState.selectedId);
    final client = store.state.clientState.map[invoice.clientId] ??
        ClientEntity(id: invoice.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadRecurringInvoice(
          completer: completer, recurringInvoiceId: invoice.id));
      return completer.future;
    }

    return RecurringInvoiceViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: invoice.isNew,
      invoice: invoice,
      client: client,
      onEditPressed: (BuildContext context, [int? index]) {
        editEntity(
            entity: invoice,
            subIndex: index,
            completer: snackBarCompleter<InvoiceEntity>(
                AppLocalization.of(context)!.updatedRecurringInvoice));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([invoice], action, autoPop: true),
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFiles, bool isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SaveRecurringInvoiceDocumentRequest(
            isPrivate: isPrivate,
            multipartFiles: multipartFiles,
            invoice: invoice,
            completer: completer));
        completer.future.then((client) {
          showToast(AppLocalization.of(context)!.uploadedDocument);
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
      onViewPdf: (context, invoice, [activityId]) {
        store.dispatch(ShowPdfRecurringInvoice(
            context: context, invoice: invoice, activityId: activityId));
      },
    );
  }
}
