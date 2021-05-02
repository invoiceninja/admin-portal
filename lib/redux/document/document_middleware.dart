import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/document/document_screen.dart';
import 'package:invoiceninja_flutter/ui/document/edit/document_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/document/view/document_view_vm.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/document_repository.dart';

import 'package:invoiceninja_flutter/main_app.dart';

List<Middleware<AppState>> createStoreDocumentsMiddleware([
  DocumentRepository repository = const DocumentRepository(),
]) {
  final viewDocumentList = _viewDocumentList();
  final viewDocument = _viewDocument();
  final editDocument = _editDocument();
  final loadDocuments = _loadDocuments(repository);
  final loadDocument = _loadDocument(repository);
  final archiveDocument = _archiveDocument(repository);
  final deleteDocument = _deleteDocument(repository);
  final restoreDocument = _restoreDocument(repository);

  return [
    TypedMiddleware<AppState, ViewDocumentList>(viewDocumentList),
    TypedMiddleware<AppState, ViewDocument>(viewDocument),
    TypedMiddleware<AppState, EditDocument>(editDocument),
    TypedMiddleware<AppState, LoadDocuments>(loadDocuments),
    TypedMiddleware<AppState, LoadDocument>(loadDocument),
    TypedMiddleware<AppState, ArchiveDocumentRequest>(archiveDocument),
    TypedMiddleware<AppState, DeleteDocumentRequest>(deleteDocument),
    TypedMiddleware<AppState, RestoreDocumentRequest>(restoreDocument),
  ];
}

Middleware<AppState> _editDocument() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as EditDocument;

    next(action);

    store.dispatch(UpdateCurrentRoute(DocumentEditScreen.route));

    if (store.state.prefState.isMobile) {
      navigatorKey.currentState.pushNamed(DocumentEditScreen.route);
    }
  };
}

Middleware<AppState> _viewDocument() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewDocument;

    next(action);

    store.dispatch(UpdateCurrentRoute(DocumentViewScreen.route));
    navigatorKey.currentState.pushNamed(DocumentViewScreen.route);
  };
}

Middleware<AppState> _viewDocumentList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewDocumentList;

    next(action);

    if (store.state.isStale) {
      store.dispatch(RefreshData());
    }

    store.dispatch(UpdateCurrentRoute(DocumentScreen.route));

    navigatorKey.currentState.pushNamedAndRemoveUntil(
        DocumentScreen.route, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _archiveDocument(DocumentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveDocumentRequest;
    final prevDocuments = action.documentIds
        .map((id) => store.state.documentState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.documentIds, EntityAction.archive)
        .then((List<DocumentEntity> documents) {
      store.dispatch(ArchiveDocumentSuccess(documents));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(ArchiveDocumentFailure(prevDocuments));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _deleteDocument(DocumentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as DeleteDocumentRequest;

    repository
        .delete(store.state.credentials, action.documentIds.first,
            action.password, action.idToken)
        .then((value) {
      store.dispatch(DeleteDocumentSuccess());
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteDocumentFailure());
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    /*
    final prevDocuments = action.documentIds
        .map((id) => store.state.documentState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.documentIds, EntityAction.delete)
        .then((List<DocumentEntity> documents) {
      store.dispatch(DeleteDocumentSuccess(documents));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(DeleteDocumentFailure(prevDocuments));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });
     */

    next(action);
  };
}

Middleware<AppState> _restoreDocument(DocumentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreDocumentRequest;
    final prevDocuments = action.documentIds
        .map((id) => store.state.documentState.map[id])
        .toList();

    repository
        .bulkAction(
            store.state.credentials, action.documentIds, EntityAction.restore)
        .then((List<DocumentEntity> documents) {
      store.dispatch(RestoreDocumentSuccess(documents));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(RestoreDocumentFailure(prevDocuments));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadDocument(DocumentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadDocument;

    store.dispatch(LoadDocumentRequest());
    repository
        .loadItem(store.state.credentials, action.documentId)
        .then((document) {
      store.dispatch(LoadDocumentSuccess(document));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadDocumentFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _loadDocuments(DocumentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadDocuments;

    store.dispatch(LoadDocumentsRequest());
    repository.loadList(store.state.credentials).then((data) {
      store.dispatch(LoadDocumentsSuccess(data));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      store.dispatch(LoadDocumentsFailure(error));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}
