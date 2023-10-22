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
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceViewScreen extends StatelessWidget {
  const InvoiceViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/invoice/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceViewVM>(
      converter: (Store<AppState> store) {
        return InvoiceViewVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceView(
          viewModel: viewModel,
          isFilter: isFilter,
          tabIndex: viewModel.state!.invoiceUIState.tabIndex,
        );
      },
    );
  }
}

class AbstractInvoiceViewVM {
  AbstractInvoiceViewVM({
    required this.state,
    required this.company,
    required this.invoice,
    required this.client,
    required this.isSaving,
    required this.isDirty,
    required this.onActionSelected,
    required this.onUploadDocuments,
    required this.onEditPressed,
    required this.onPaymentsPressed,
    required this.onRefreshed,
    required this.onViewExpense,
    required this.onViewPdf,
  });

  final AppState? state;
  final CompanyEntity? company;
  final InvoiceEntity? invoice;
  final ClientEntity? client;
  final bool? isSaving;
  final bool? isDirty;
  final Function(BuildContext, EntityAction)? onActionSelected;
  final Function(BuildContext, [int])? onEditPressed;
  final Function(BuildContext)? onPaymentsPressed;
  final Function(BuildContext)? onRefreshed;
  final Function(BuildContext, List<MultipartFile>, bool)? onUploadDocuments;
  final Function(BuildContext, DocumentEntity)? onViewExpense;
  final Function(BuildContext, InvoiceEntity, [String])? onViewPdf;
}

class InvoiceViewVM extends AbstractInvoiceViewVM {
  InvoiceViewVM(
      {AppState? state,
      CompanyEntity? company,
      InvoiceEntity? invoice,
      ClientEntity? client,
      bool? isSaving,
      bool? isDirty,
      Function(BuildContext, EntityAction)? onEntityAction,
      Function(BuildContext, [int])? onEditPressed,
      Function(BuildContext, [bool])? onClientPressed,
      Function(BuildContext, [bool])? onUserPressed,
      Function(BuildContext, PaymentEntity, [bool])? onPaymentPressed,
      Function(BuildContext)? onPaymentsPressed,
      Function(BuildContext)? onRefreshed,
      Function(BuildContext, List<MultipartFile>, bool)? onUploadDocuments,
      Function(BuildContext, DocumentEntity)? onViewExpense,
      Function(BuildContext, InvoiceEntity, [String?])? onViewPdf})
      : super(
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

  factory InvoiceViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoice = state.invoiceState.get(state.invoiceUIState.selectedId!);
    final client = state.clientState.get(invoice.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadInvoice(completer: completer, invoiceId: invoice.id));
      return completer.future;
    }

    return InvoiceViewVM(
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
                AppLocalization.of(context)!.updatedInvoice));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onPaymentsPressed: (BuildContext context) {
        viewEntitiesByType(
            entityType: EntityType.payment, filterEntity: invoice);
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([invoice], action, autoPop: true),
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFile, bool isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SaveInvoiceDocumentRequest(
            isPrivate: isPrivate,
            multipartFiles: multipartFile,
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
      onViewExpense: (BuildContext context, DocumentEntity document) {
        /*
        viewEntityById(
            entityId: document.expenseId,
            entityType: EntityType.expense);
         */
      },
      onViewPdf: (context, invoice, [activityId]) {
        store.dispatch(ShowPdfInvoice(
            context: context, invoice: invoice, activityId: activityId));
      },
    );
  }
}
