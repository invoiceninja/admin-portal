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
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CreditViewScreen extends StatelessWidget {
  const CreditViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/credit/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditViewVM>(
      //distinct: true,
      converter: (Store<AppState> store) {
        return CreditViewVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceView(
          viewModel: viewModel,
          isFilter: isFilter,
          tabIndex: viewModel.state!.creditUIState.tabIndex,
        );
      },
    );
  }
}

class CreditViewVM extends AbstractInvoiceViewVM {
  CreditViewVM({
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    ClientEntity? client,
    bool? isSaving,
    bool? isDirty,
    Function(BuildContext, EntityAction)? onEntityAction,
    Function(BuildContext, [int])? onEditPressed,
    Function(BuildContext, [bool])? onClientPressed,
    Function(BuildContext, [bool])? onUserPressed,
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

  factory CreditViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final credit = state.creditState.map[state.creditUIState.selectedId] ??
        InvoiceEntity(id: state.creditUIState.selectedId);
    final client = store.state.clientState.map[credit.clientId] ??
        ClientEntity(id: credit.clientId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadCredit(completer: completer, creditId: credit.id));
      return completer.future;
    }

    return CreditViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: credit.isNew,
      invoice: credit,
      client: client,
      onEditPressed: (BuildContext context, [int? index]) {
        editEntity(
            entity: credit,
            subIndex: index,
            completer: snackBarCompleter<InvoiceEntity>(
                AppLocalization.of(context)!.updatedCredit));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([credit], action, autoPop: true),
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFile, bool isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SaveCreditDocumentRequest(
            isPrivate: isPrivate,
            multipartFiles: multipartFile,
            credit: credit,
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
      onViewPdf: (context, credit, [activityId]) {
        store.dispatch(ShowPdfCredit(
            context: context, credit: credit, activityId: activityId));
      },
    );
  }
}
