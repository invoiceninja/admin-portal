import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/document/document_screen.dart';
import 'package:invoiceninja_flutter/ui/document/edit/document_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/document/view/document_view_vm.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/repositories/document_repository.dart';

List<Middleware<AppState>> createStoreDocumentsMiddleware([
  DocumentRepository repository = const DocumentRepository(),
]) {
  final viewDocumentList = _viewDocumentList();
  final viewDocument = _viewDocument();
  final editDocument = _editDocument();
  final loadDocuments = _loadDocuments(repository);
  final loadDocument = _loadDocument(repository);
  final saveDocument = _saveDocument(repository);
  final archiveDocument = _archiveDocument(repository);
  final deleteDocument = _deleteDocument(repository);
  final restoreDocument = _restoreDocument(repository);

  return [
    TypedMiddleware<AppState, ViewDocumentList>(viewDocumentList),
    TypedMiddleware<AppState, ViewDocument>(viewDocument),
    TypedMiddleware<AppState, EditDocument>(editDocument),
    TypedMiddleware<AppState, LoadDocuments>(loadDocuments),
    TypedMiddleware<AppState, LoadDocument>(loadDocument),
    TypedMiddleware<AppState, SaveDocumentRequest>(saveDocument),
    TypedMiddleware<AppState, ArchiveDocumentRequest>(archiveDocument),
    TypedMiddleware<AppState, DeleteDocumentRequest>(deleteDocument),
    TypedMiddleware<AppState, RestoreDocumentRequest>(restoreDocument),
  ];
}

Middleware<AppState> _editDocument() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) {
    final action = dynamicAction as EditDocument;

    next(action);

    store.dispatch(UpdateCurrentRoute(DocumentEditScreen.route));

    if (isMobile(action.context)) {
      action.navigator.pushNamed(DocumentEditScreen.route);
    }
  };
}

Middleware<AppState> _viewDocument() {
  return (Store<AppState> store, dynamic dynamicAction,
      NextDispatcher next) async {
    final action = dynamicAction as ViewDocument;

    next(action);

    store.dispatch(UpdateCurrentRoute(DocumentViewScreen.route));
    action.navigator.pushNamed(DocumentViewScreen.route);
  };
}

Middleware<AppState> _viewDocumentList() {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ViewDocumentList;

    next(action);

    if (store.state.documentState.isStale) {
      store.dispatch(LoadDocuments());
    }

    store.dispatch(UpdateCurrentRoute(DocumentScreen.route));

    action.navigator.pushNamedAndRemoveUntil(
        DocumentScreen.route, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _archiveDocument(DocumentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as ArchiveDocumentRequest;

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
      final documents = action.documentIds
          .map((id) => store.state.documentState.map[id])
          .toList();
      store.dispatch(ArchiveDocumentFailure(documents));
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
        .bulkAction(
            store.state.credentials, action.documentIds, EntityAction.delete)
        .then((List<DocumentEntity> documents) {
      store.dispatch(DeleteDocumentSuccess(documents));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((Object error) {
      print(error);
      final documents = action.documentIds
          .map((id) => store.state.documentState.map[id])
          .toList();
      store.dispatch(DeleteDocumentFailure(documents));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _restoreDocument(DocumentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as RestoreDocumentRequest;

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
      final documents = action.documentIds
          .map((id) => store.state.documentState.map[id])
          .toList();
      store.dispatch(RestoreDocumentFailure(documents));
      if (action.completer != null) {
        action.completer.completeError(error);
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveDocument(DocumentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as SaveDocumentRequest;
    if (store.state.company.isEnterprisePlan) {
      repository
          .saveData(store.state.credentials, action.document)
          .then((DocumentEntity document) {
        if (action.document.isNew) {
          store.dispatch(AddDocumentSuccess(document));
        } else {
          store.dispatch(SaveDocumentSuccess(document));
        }
        action.completer.complete(document);
      }).catchError((Object error) {
        print(error);
        store.dispatch(SaveDocumentFailure(error));
        action.completer.completeError(error);
      });
    } else {
      const error = 'Uploading documents requires an enterprise plan';
      store.dispatch(SaveDocumentFailure(error));
      action.completer.completeError(error);
    }

    next(action);
  };
}

Middleware<AppState> _loadDocument(DocumentRepository repository) {
  return (Store<AppState> store, dynamic dynamicAction, NextDispatcher next) {
    final action = dynamicAction as LoadDocument;
    final AppState state = store.state;

    if (state.isLoading) {
      next(action);
      return;
    }

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
    final AppState state = store.state;

    if (!state.documentState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    final int updatedAt = (state.documentState.lastUpdated / 1000).round();

    store.dispatch(LoadDocumentsRequest());
    repository.loadList(store.state.credentials, updatedAt).then((data) {
      store.dispatch(LoadDocumentsSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
      if (state.dashboardState.isStale) {
        store.dispatch(LoadDashboard());
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
