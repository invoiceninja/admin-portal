// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_state.dart';
import 'package:invoiceninja_flutter/redux/ui/entity_ui_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

EntityUIState documentUIReducer(DocumentUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..listUIState.replace(documentListReducer(state.listUIState, action))
    ..editing.replace(editingReducer(state.editing, action)!)
    ..selectedId = selectedIdReducer(state.selectedId, action)
    ..forceSelected = forceSelectedReducer(state.forceSelected, action));
}

final forceSelectedReducer = combineReducers<bool?>([
  TypedReducer<bool?, ViewDocument>((completer, action) => true),
  TypedReducer<bool?, ViewDocumentList>((completer, action) => false),
  TypedReducer<bool?, FilterDocumentsByState>((completer, action) => false),
  TypedReducer<bool?, FilterDocumentsByStatus>((completer, action) => false),
  TypedReducer<bool?, FilterDocuments>((completer, action) => false),
  TypedReducer<bool?, FilterDocumentsByCustom1>((completer, action) => false),
  TypedReducer<bool?, FilterDocumentsByCustom2>((completer, action) => false),
  TypedReducer<bool?, FilterDocumentsByCustom3>((completer, action) => false),
  TypedReducer<bool?, FilterDocumentsByCustom4>((completer, action) => false),
]);

Reducer<String?> selectedIdReducer = combineReducers([
  TypedReducer<String?, ArchiveDocumentSuccess>((completer, action) => ''),
  TypedReducer<String?, DeleteDocumentSuccess>((completer, action) => ''),
  TypedReducer<String?, PreviewEntity>((selectedId, action) =>
      action.entityType == EntityType.document ? action.entityId : selectedId),
  TypedReducer<String?, ViewDocument>(
      (selectedId, action) => action.documentId),
  //TypedReducer<String, AddDocumentSuccess>((selectedId, action) => action.document.id),
  TypedReducer<String?, SelectCompany>(
      (selectedId, action) => action.clearSelection ? '' : selectedId),
  TypedReducer<String?, ClearEntityFilter>((selectedId, action) => ''),
  TypedReducer<String?, SortDocuments>((selectedId, action) => ''),
  TypedReducer<String?, FilterDocuments>((selectedId, action) => ''),
  TypedReducer<String?, FilterDocumentsByState>((selectedId, action) => ''),
  TypedReducer<String?, FilterDocumentsByStatus>((selectedId, action) => ''),
  TypedReducer<String?, FilterDocumentsByCustom1>((selectedId, action) => ''),
  TypedReducer<String?, FilterDocumentsByCustom2>((selectedId, action) => ''),
  TypedReducer<String?, FilterDocumentsByCustom3>((selectedId, action) => ''),
  TypedReducer<String?, FilterDocumentsByCustom4>((selectedId, action) => ''),
]);

final editingReducer = combineReducers<DocumentEntity?>([
  TypedReducer<DocumentEntity?, SaveDocumentSuccess>(_updateEditing),
  //TypedReducer<DocumentEntity, AddDocumentSuccess>(_updateEditing),
  TypedReducer<DocumentEntity?, RestoreDocumentSuccess>(_updateEditing),
  TypedReducer<DocumentEntity?, ArchiveDocumentSuccess>(_updateEditing),
  //TypedReducer<DocumentEntity, DeleteDocumentSuccess>(_updateEditing),
  TypedReducer<DocumentEntity?, EditDocument>(_updateEditing),
  TypedReducer<DocumentEntity?, UpdateDocument>((document, action) {
    return action.document.rebuild((b) => b..isChanged = true);
  }),
]);

DocumentEntity? _updateEditing(DocumentEntity? document, dynamic action) {
  return action.document;
}

final documentListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortDocuments>(_sortDocuments),
  TypedReducer<ListUIState, FilterDocumentsByState>(_filterDocumentsByState),
  TypedReducer<ListUIState, FilterDocumentsByStatus>(_filterDocumentsByStatus),
  TypedReducer<ListUIState, FilterDocuments>(_filterDocuments),
  TypedReducer<ListUIState, FilterDocumentsByCustom1>(
      _filterDocumentsByCustom1),
  TypedReducer<ListUIState, FilterDocumentsByCustom2>(
      _filterDocumentsByCustom2),
  TypedReducer<ListUIState, StartDocumentMultiselect>(_startListMultiselect),
  TypedReducer<ListUIState, AddToDocumentMultiselect>(_addToListMultiselect),
  TypedReducer<ListUIState, RemoveFromDocumentMultiselect>(
      _removeFromListMultiselect),
  TypedReducer<ListUIState, ClearDocumentMultiselect>(_clearListMultiselect),
  TypedReducer<ListUIState, ViewDocumentList>(_viewDocumentList),
  TypedReducer<ListUIState, FilterByEntity>(
      (state, action) => state.rebuild((b) => b
        ..filter = null
        ..filterClearedAt = DateTime.now().millisecondsSinceEpoch)),
]);

ListUIState _viewDocumentList(
    ListUIState documentListState, ViewDocumentList action) {
  return documentListState.rebuild((b) => b
    ..selectedIds = null
    ..filter = null
    ..filterClearedAt = DateTime.now().millisecondsSinceEpoch);
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

ListUIState _filterDocumentsByStatus(
    ListUIState documentListState, FilterDocumentsByStatus action) {
  if (documentListState.statusFilters.contains(action.status)) {
    return documentListState
        .rebuild((b) => b..statusFilters.remove(action.status));
  } else {
    return documentListState
        .rebuild((b) => b..statusFilters.add(action.status));
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
    ..sortAscending = b.sortField != action.field || !b.sortAscending!
    ..sortField = action.field);
}

ListUIState _startListMultiselect(
    ListUIState documentListState, StartDocumentMultiselect action) {
  return documentListState.rebuild((b) => b..selectedIds = ListBuilder());
}

ListUIState _addToListMultiselect(
    ListUIState documentListState, AddToDocumentMultiselect action) {
  return documentListState
      .rebuild((b) => b..selectedIds.add(action.entity!.id));
}

ListUIState _removeFromListMultiselect(
    ListUIState documentListState, RemoveFromDocumentMultiselect action) {
  return documentListState
      .rebuild((b) => b..selectedIds.remove(action.entity!.id));
}

ListUIState _clearListMultiselect(
    ListUIState documentListState, ClearDocumentMultiselect action) {
  return documentListState.rebuild((b) => b..selectedIds = null);
}

final documentsReducer = combineReducers<DocumentState>([
  TypedReducer<DocumentState, SaveDocumentSuccess>(_updateDocument),
  TypedReducer<DocumentState, AddDocumentSuccess>(_addDocument),
  TypedReducer<DocumentState, LoadDocumentsSuccess>(_setLoadedDocuments),
  TypedReducer<DocumentState, LoadCompanySuccess>(_setLoadedCompany),
  TypedReducer<DocumentState, LoadDocumentSuccess>(_setLoadedDocument),
  TypedReducer<DocumentState, ArchiveDocumentSuccess>(_archiveDocumentSuccess),
  TypedReducer<DocumentState, DeleteDocumentSuccess>(_deleteDocumentSuccess),
  TypedReducer<DocumentState, RestoreDocumentSuccess>(_restoreDocumentSuccess),
]);

DocumentState _archiveDocumentSuccess(
    DocumentState documentState, ArchiveDocumentSuccess action) {
  return documentState.rebuild((b) {
    for (final document in action.documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _deleteDocumentSuccess(
    DocumentState documentState, DeleteDocumentSuccess action) {
  return documentState.rebuild((b) => b
    ..map.remove(action.documentId)
    ..list.remove(action.documentId));
}

DocumentState _restoreDocumentSuccess(
    DocumentState documentState, RestoreDocumentSuccess action) {
  return documentState.rebuild((b) {
    for (final document in action.documents) {
      b.map[document.id] = document;
    }
  });
}

DocumentState _addDocument(
    DocumentState documentState, AddDocumentSuccess action) {
  final state = documentState.rebuild((b) => b
    ..map.addAll(Map.fromIterable(
      action.documents,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
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
    ..map.addAll(Map.fromIterable(
      action.documents,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}

DocumentState _setLoadedCompany(
    DocumentState documentState, LoadCompanySuccess action) {
  final company = action.userCompany.company;
  final documents = <DocumentEntity>[];
  company.documents.forEach((document) {
    documents.add(document.rebuild((b) => b
      ..parentId = company.id
      ..parentType = EntityType.company));
  });

  company.clients.forEach((client) {
    client.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = client.id
        ..parentType = EntityType.client));
    });
  });

  company.credits.forEach((credit) {
    credit.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = credit.id
        ..parentType = EntityType.credit));
    });
  });

  company.expenses.forEach((expense) {
    expense.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = expense.id
        ..parentType = EntityType.expense));
    });
  });

  company.groups.forEach((group) {
    group.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = group.id
        ..parentType = EntityType.group));
    });
  });

  company.invoices.forEach((invoice) {
    invoice.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = invoice.id
        ..parentType = EntityType.invoice));
    });
  });

  company.products.forEach((product) {
    product.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = product.id
        ..parentType = EntityType.product));
    });
  });

  company.projects.forEach((project) {
    project.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = project.id
        ..parentType = EntityType.project));
    });
  });

  company.purchaseOrders.forEach((purchaseOrder) {
    purchaseOrder.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = purchaseOrder.id
        ..parentType = EntityType.purchaseOrder));
    });
  });

  company.quotes.forEach((quote) {
    quote.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = quote.id
        ..parentType = EntityType.quote));
    });
  });

  company.recurringExpenses.forEach((recurringExpense) {
    recurringExpense.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = recurringExpense.id
        ..parentType = EntityType.recurringExpense));
    });
  });

  company.recurringInvoices.forEach((recurringInvoice) {
    recurringInvoice.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = recurringInvoice.id
        ..parentType = EntityType.recurringInvoice));
    });
  });

  company.tasks.forEach((task) {
    task.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = task.id
        ..parentType = EntityType.task));
    });
  });

  company.vendors.forEach((vendor) {
    vendor.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = vendor.id
        ..parentType = EntityType.vendor));
    });
  });

  company.payments.forEach((payment) {
    payment.documents.forEach((document) {
      documents.add(document.rebuild((b) => b
        ..parentId = payment.id
        ..parentType = EntityType.payment));
    });
  });

  final state = documentState.rebuild((b) => b
    ..map.addAll(Map<String, DocumentEntity>.fromIterable(
      documents,
      key: (dynamic item) => item.id,
      value: (dynamic item) => item,
    )));

  return state.rebuild((b) => b..list.replace(state.map.keys));
}
