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
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class QuoteViewScreen extends StatelessWidget {
  const QuoteViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/quote/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteViewVM>(
      //distinct: true,
      converter: (Store<AppState> store) {
        return QuoteViewVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceView(
          viewModel: viewModel,
          isFilter: isFilter,
          tabIndex: viewModel.state!.quoteUIState.tabIndex,
        );
      },
    );
  }
}

class QuoteViewVM extends AbstractInvoiceViewVM {
  QuoteViewVM({
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

  factory QuoteViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final quote = state.quoteState.map[state.quoteUIState.selectedId] ??
        InvoiceEntity(id: state.quoteUIState.selectedId);
    final client = store.state.clientState.map[quote.clientId] ??
        ClientEntity(id: quote.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadQuote(completer: completer, quoteId: quote.id));
      return completer.future;
    }

    return QuoteViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: quote.isNew,
      invoice: quote,
      client: client,
      onEditPressed: (BuildContext context, [int? index]) {
        editEntity(
            entity: quote,
            subIndex: index,
            completer: snackBarCompleter<InvoiceEntity>(
                AppLocalization.of(context)!.updatedQuote));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([quote], action, autoPop: true),
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFiles, bool isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SaveQuoteDocumentRequest(
            isPrivate: isPrivate,
            multipartFile: multipartFiles,
            quote: quote,
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
      onViewPdf: (context, quote, [activityId]) {
        store.dispatch(ShowPdfQuote(
            context: context, quote: quote, activityId: activityId));
      },
    );
  }
}
