import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';
import 'package:redux/redux.dart';

class ClientViewScreen extends StatelessWidget {
  const ClientViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;

  static const String route = '/client/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientViewVM>(
      //distinct: true,
      converter: (Store<AppState> store) {
        return ClientViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ClientView(
          viewModel: vm,
          isFilter: isFilter,
          tabIndex: vm.state.clientUIState.tabIndex,
        );
      },
    );
  }
}

class ClientViewVM {
  ClientViewVM({
    @required this.state,
    @required this.client,
    @required this.company,
    @required this.onEntityAction,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onRefreshed,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
  });

  factory ClientViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final client = state.clientState.map[state.clientUIState.selectedId] ??
        ClientEntity(id: state.clientUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadClient(
        completer: completer,
        clientId: client.id,
      ));
      return completer.future;
    }

    return ClientViewVM(
      state: state,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: client.isNew,
      client: client,
      company: state.company,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context.getAppContext(), [client], action,
              autoPop: true),
      onUploadDocument: (BuildContext context, MultipartFile multipartFile) {
        final Completer<DocumentEntity> completer = Completer<DocumentEntity>();
        store.dispatch(SaveClientDocumentRequest(
            multipartFile: multipartFile,
            client: client,
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
            (value) => store.dispatch(LoadClient(clientId: client.id)));
        store.dispatch(DeleteDocumentRequest(
          completer: completer,
          documentIds: [document.id],
          password: password,
          idToken: idToken,
        ));
      },
    );
  }

  final AppState state;
  final ClientEntity client;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, MultipartFile) onUploadDocument;
  final Function(BuildContext, DocumentEntity, String, String) onDeleteDocument;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
