import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/document/document_list.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class DocumentListBuilder extends StatelessWidget {
  const DocumentListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DocumentListVM>(
      converter: DocumentListVM.fromStore,
      builder: (context, viewModel) {
        return DocumentList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class DocumentListVM {
  DocumentListVM({
    @required this.state,
    @required this.documentList,
    @required this.documentMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onDocumentTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
  });

  static DocumentListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadDocuments(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return DocumentListVM(
      state: state,
      listState: state.documentListState,
      documentList: memoizedFilteredDocumentList(state.documentState.map,
          state.documentState.list, state.documentListState),
      documentMap: state.documentState.map,
      isLoading: state.isLoading,
      isLoaded: state.documentState.isLoaded,
      filter: state.documentUIState.listUIState.filter,
      onClearEntityFilterPressed: () =>
          store.dispatch(FilterDocumentsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => store.dispatch(
          ViewClient(
              clientId: state.documentListState.filterEntityId,
              context: context)),
      onDocumentTap: (context, document) {
        store.dispatch(ViewDocument(documentId: document.id, context: context));
      },
      onEntityAction: (BuildContext context, List<BaseEntity> documents,
              EntityAction action) =>
          handleDocumentAction(context, documents[0], action),
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final AppState state;
  final List<String> documentList;
  final BuiltMap<String, DocumentEntity> documentMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, DocumentEntity) onDocumentTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<DocumentEntity>, EntityAction)
      onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
}
