import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:redux/redux.dart';

EntityUIState documentUIReducer(DocumentUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(documentListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action))
    ..selectedId = selectedIdReducer(state.selectedId, action));
}

Reducer<String> selectedIdReducer = combineReducers([
  TypedReducer<String, ViewDocument>((selectedId, action) => action.documentId),
  TypedReducer<String, AddDocumentSuccess>(
      (selectedId, action) => action.document.id),
  TypedReducer<String, SelectCompany>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<DocumentEntity>([
  TypedReducer<DocumentEntity, SaveDocumentSuccess>(_updateEditing),
  TypedReducer<DocumentEntity, AddDocumentSuccess>(_updateEditing),
  TypedReducer<DocumentEntity, RestoreDocumentSuccess>(_updateEditing),
  TypedReducer<DocumentEntity, ArchiveDocumentSuccess>(_updateEditing),
  TypedReducer<DocumentEntity, DeleteDocumentSuccess>(_updateEditing),
  TypedReducer<DocumentEntity, EditDocument>(_updateEditing),
  TypedReducer<DocumentEntity, UpdateDocument>((document, action) {
    return action.document.rebuild((b) => b..isChanged = true);
  }),
  TypedReducer<DocumentEntity, SelectCompany>(_clearEditing),
]);

DocumentEntity _clearEditing(DocumentEntity document, dynamic action) {
  return DocumentEntity();
}

DocumentEntity _updateEditing(DocumentEntity document, dynamic action) {
  return action.document;
}

final documentListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortDocuments>(_sortDocuments),
  TypedReducer<ListUIState, FilterDocumentsByState>(_filterDocumentsByState),
  TypedReducer<ListUIState, FilterDocuments>(_filterDocuments),
  TypedReducer<ListUIState, FilterDocumentsByCustom1>(
      _filterDocumentsByCustom1),
  TypedReducer<ListUIState, FilterDocumentsByCustom2>(
      _filterDocumentsByCustom2),
  TypedReducer<ListUIState, FilterDocumentsByEntity>(_filterDocumentsByClient),
  TypedReducer<ListUIState, StartDocumentMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToDocumentMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromDocumentMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearDocumentMultiselect>(_clearListMultiselect),
]);

ListUIState _filterDocumentsByClient(
    ListUIState documentListState, FilterDocumentsByEntity action) {
  return documentListState.rebuild((b) => b
    ..filterEntityId = action.entityId
    ..filterEntityType = action.entityType);
}

ListUIState _filterDocumentsByCustom1(
    ListUIState documentListState, FilterDocumentsByCustom1 action) {
  if (documentListState.custom1Filters.contains(action.value)) {
    return documentListState
        .rebuild((b) => b..custom1Filters.remove(action.value));
  } else {
    return documentListState
        .rebuild((b) => b..custom1Filters.add(action.value));
  }
}

ListUIState _filterDocumentsByCustom2(
    ListUIState documentListState, FilterDocumentsByCustom2 action) {
  if (documentListState.custom2Filters.contains(action.value)) {
    return documentListState
        .rebuild((b) => b..custom2Filters.remove(action.value));
  } else {
    return documentListState
        .rebuild((b) => b..custom2Filters.add(action.value));
  }
}

ListUIState _filterDocumentsByState(
    ListUIState documentListState, FilterDocumentsByState action) {
  if (documentListState.stateFilters.contains(action.state)) {
    return documentListState
        .rebuild((b) => b..stateFilters.remove(action.state));
  } else {
    return documentListState.rebuild((b) => b..stateFilters.add(action.state));
  }
}

ListUIState _filterDocuments(
    ListUIState documentListState, FilterDocuments action) {
  return documentListState.rebuild((b) => b
    ..filter = action.filter
    ..filterClearedAt = action.filter == null
        ? DateTime.now().millisecondsSinceEpoch
        : documentListState.filterClearedAt);
}

ListUIState _sortDocuments(
    ListUIState documentListState, SortDocuments action) {
  return documentListState.rebuild((b) => b
    ..sortAscending = b.sortField != action.field || !b.sortAscending
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState documentListState, StartDocumentMultiselect action) {
  return documentListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState documentListState, AddToDocumentMultiselect action) {
  return documentListState.rebuild((b) => b..selectedIds.add(action.entity.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState documentListState, RemoveFromDocumentMultiselect action) {
  return documentListState
      .rebuild((b) => b..selectedIds.remove(action.entity.id));
}

ListUIState _clearListMultiselect(
    ListUIState documentListState, ClearDocumentMultiselect action) {
  return documentListState.rebuild((b) => b..selectedIds = null);
}

final documentsReducer = combineReducers<DocumentState>([
  TypedReducer<DocumentState, SaveDocumentSuccess>(_updateDocument),
  TypedReducer<DocumentState, AddDocumentSuccess>(_addDocument),
  TypedReducer<DocumentState, LoadDocumentsSuccess>(_setLoadedDocuments),
  TypedReducer<DocumentState, LoadDocumentSuccess>(_setLoadedDocument),
  TypedReducer<DocumentState, ArchiveDocumentRequest>(_archiveDocumentRequest),
  TypedReducer<DocumentState, ArchiveDocumentSuccess>(_archiveDocumentSuccess),
  TypedReducer<DocumentState, ArchiveDocumentFailure>(_archiveDocumentFailure),
  TypedReducer<DocumentState, DeleteDocumentRequest>(_deleteDocumentRequest),
  TypedReducer<DocumentState, DeleteDocumentSuccess>(_deleteDocumentSuccess),
  TypedReducer<DocumentState, DeleteDocumentFailure>(_deleteDocumentFailure),
  TypedReducer<DocumentState, RestoreDocumentRequest>(_restoreDocumentRequest),
  TypedReducer<DocumentState, RestoreDocumentSuccess>(_restoreDocumentSuccess),
  TypedReducer<DocumentState, RestoreDocumentFailure>(_restoreDocumentFailure),
]);

DocumentState _archiveDocumentRequest(
    DocumentState documentState, ArchiveDocumentRequest action) {
  final documents =
      action.documentIds.map((id) => documentState.map[id]).toList();

  for (int i = 0; i < documents.length; i++) {
    documents[i] = documents[i]
        .rebuild((b) => b..archivedAt = DateTime.now().millisecondsSinceEpoch);
  }
  return documentState.rebuild((b) {
    for (final document in documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _archiveDocumentSuccess(
    DocumentState documentState, ArchiveDocumentSuccess action) {
  return documentState.rebuild((b) {
    for (final document in action.documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _archiveDocumentFailure(
    DocumentState documentState, ArchiveDocumentFailure action) {
  return documentState.rebuild((b) {
    for (final document in action.documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _deleteDocumentRequest(
    DocumentState documentState, DeleteDocumentRequest action) {
  final documents =
      action.documentIds.map((id) => documentState.map[id]).toList();

  for (int i = 0; i < documents.length; i++) {
    documents[i] = documents[i].rebuild((b) => b
      ..archivedAt = DateTime.now().millisecondsSinceEpoch
      ..isDeleted = true);
  }
  return documentState.rebuild((b) {
    for (final document in documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _deleteDocumentSuccess(
    DocumentState documentState, DeleteDocumentSuccess action) {
  return documentState.rebuild((b) {
    for (final document in action.documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _deleteDocumentFailure(
    DocumentState documentState, DeleteDocumentFailure action) {
  return documentState.rebuild((b) {
    for (final document in action.documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _restoreDocumentRequest(
    DocumentState documentState, RestoreDocumentRequest action) {
  final documents =
      action.documentIds.map((id) => documentState.map[id]).toList();

  for (int i = 0; i < documents.length; i++) {
    documents[i] = documents[i].rebuild((b) => b
      ..archivedAt = null
      ..isDeleted = false);
  }
  return documentState.rebuild((b) {
    for (final document in documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _restoreDocumentSuccess(
    DocumentState documentState, RestoreDocumentSuccess action) {
  return documentState.rebuild((b) {
    for (final document in action.documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _restoreDocumentFailure(
    DocumentState documentState, RestoreDocumentFailure action) {
  return documentState.rebuild((b) {
    for (final document in action.documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _addDocument(
    DocumentState documentState, AddDocumentSuccess action) {
  return documentState.rebuild((b) => b
    ..map[action.document.id] = action.document
    ..list.add(action.document.id));
}

DocumentState _updateDocument(
    DocumentState documentState, SaveDocumentSuccess action) {
  return documentState
      .rebuild((b) => b..map[action.document.id] = action.document);
}

DocumentState _setLoadedDocument(
    DocumentState documentState, LoadDocumentSuccess action) {
  return documentState
      .rebuild((b) => b..map[action.document.id] = action.document);
}

DocumentState _setLoadedDocuments(
    DocumentState documentState, LoadDocumentsSuccess action) {
  final state = documentState.rebuild((b) => b
    ..lastUpdated = DateTime.now().millisecondsSinceEpoch
    ..map.addAll(Map.fromIterable(
      action.documents,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
