import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:redux/redux.dart';

class CreditViewScreen extends StatelessWidget {
  const CreditViewScreen({
    Key key,
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
          tabIndex: viewModel.state.creditUIState.tabIndex,
        );
      },
    );
  }
}

class CreditViewVM extends EntityViewVM {
  CreditViewVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    ClientEntity client,
    bool isSaving,
    bool isDirty,
    Function(BuildContext, EntityAction) onEntityAction,
    Function(BuildContext, [int]) onEditPressed,
    Function(BuildContext, [bool]) onClientPressed,
    Function(BuildContext, [bool]) onUserPressed,
    Function(BuildContext) onPaymentsPressed,
    Function(BuildContext, PaymentEntity) onPaymentPressed,
    Function(BuildContext) onRefreshed,
    Function(BuildContext, MultipartFile) onUploadDocument,
    Function(BuildContext, DocumentEntity, String, String) onDeleteDocument,
    Function(BuildContext, DocumentEntity) onViewExpense,
    Function(BuildContext, InvoiceEntity, [String]) onViewPdf,
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
          onUploadDocument: onUploadDocument,
          onDeleteDocument: onDeleteDocument,
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
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
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
      onEditPressed: (BuildContext context, [int index]) {
        editEntity(
            context: context,
            entity: credit,
            subIndex: index,
            completer: snackBarCompleter<ClientEntity>(
                context, AppLocalization.of(context).updatedCredit));
      },
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context.getAppContext(), [credit], action,
              autoPop: true),
      onUploadDocument: (BuildContext context, MultipartFile multipartFile) {
        final Completer<DocumentEntity> completer = Completer<DocumentEntity>();
        store.dispatch(SaveCreditDocumentRequest(
            multipartFile: multipartFile,
            credit: credit,
            completer: completer));
        completer.future.then((client) {
          showToast(AppLocalization.of(context).uploadedDocument);
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
      onDeleteDocument: (BuildContext context, DocumentEntity document,
          String password, String idToken) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).deletedDocument);
        completer.future.then<Null>(
            (value) => store.dispatch(LoadCredit(creditId: credit.id)));
        store.dispatch(DeleteDocumentRequest(
          completer: completer,
          documentIds: [document.id],
          password: password,
          idToken: idToken,
        ));
      },
      onViewPdf: (context, credit, [activityId]) {
        store.dispatch(ShowPdfCredit(
            context: context, credit: credit, activityId: activityId));
      },
    );
  }
}
