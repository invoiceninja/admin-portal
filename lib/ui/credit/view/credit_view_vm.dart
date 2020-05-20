import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
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
    Function(BuildContext) onPaymentsPressed,
    Function(BuildContext, PaymentEntity) onPaymentPressed,
    Function(BuildContext) onRefreshed,
    Function(BuildContext, String) onUploadDocument,
    Function(BuildContext, DocumentEntity) onDeleteDocument,
    Function(BuildContext, DocumentEntity) onViewExpense,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          client: client,
          isSaving: isSaving,
          isDirty: isDirty,
          onActionSelected: onEntityAction,
          onEditPressed: onEditPressed,
          onClientPressed: onClientPressed,
          onPaymentsPressed: onPaymentsPressed,
          onPaymentPressed: onPaymentPressed,
          onRefreshed: onRefreshed,
          onUploadDocument: onUploadDocument,
          onDeleteDocument: onDeleteDocument,
          onViewExpense: onViewExpense,
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
      onClientPressed: (BuildContext context, [bool longPress = false]) {
        if (longPress) {
          showEntityActionsDialog(
            context: context,
            entities: [client],
          );
        } else if (isMobile(context)) {
          viewEntity(context: context, entity: client);
        } else {
          store.dispatch(FilterCreditsByEntity(
              entityType: EntityType.client, entityId: client.id));
        }
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleCreditAction(context, [credit], action),
      onUploadDocument: (BuildContext context, String path) {
        final Completer<DocumentEntity> completer = Completer<DocumentEntity>();
        final document = DocumentEntity().rebuild((b) => b
          ..invoiceId = credit.id
          ..path = path);
        store.dispatch(
            SaveDocumentRequest(document: document, completer: completer));
        completer.future.then((client) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).uploadedDocument,
          )));
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
      onDeleteDocument: (BuildContext context, DocumentEntity document) {
        store.dispatch(DeleteDocumentRequest(
            snackBarCompleter<Null>(
                context, AppLocalization.of(context).deletedDocument),
            [document.id]));
      },
    );
  }
}
