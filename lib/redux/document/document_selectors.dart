import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedEntityDocumentMap = memo3((EntityType entityType,
        BuiltMap<int, DocumentEntity> documentMap,
        BuiltMap<int, ExpenseEntity> expenseMap) =>
    entityDocumentMap(entityType, documentMap, expenseMap));

Map<int, bool> entityDocumentMap(
    EntityType entityType,
    BuiltMap<int, DocumentEntity> documentMap,
    BuiltMap<int, ExpenseEntity> expenseMap) {
  final invoiceMap = <int, int>{};
  expenseMap.forEach((int, expense) {
    if (expense.invoiceDocuments && expense.isInvoiced) {
      invoiceMap[expense.id] = expense.invoiceId;
    }
  });

  final Map<int, bool> map = {};
  documentMap.forEach((documentId, document) {
    if (entityType == EntityType.invoice) {
      map[document.invoiceId] = true;
    } else if (entityType == EntityType.expense) {
      map[document.expenseId] = true;
    }

    if (entityType == EntityType.invoice) {
      if (invoiceMap.containsKey(document.expenseId)) {
        map[invoiceMap[document.expenseId]] = true;
      }
    }
  });

  return map;
}

var memoizedDropdownDocumentList = memo3(
    (BuiltMap<int, DocumentEntity> documentMap, BuiltList<int> documentList,
            int clientId) =>
        dropdownDocumentsSelector(documentMap, documentList, clientId));

List<int> dropdownDocumentsSelector(BuiltMap<int, DocumentEntity> documentMap,
    BuiltList<int> documentList, int clientId) {
  final list = documentList.where((documentId) {
    final document = documentMap[documentId];
    /*
    if (clientId != null && clientId > 0 && document.clientId != clientId) {
      return false;
    }
    */
    return document.isActive;
  }).toList();

  list.sort((documentAId, documentBId) {
    final documentA = documentMap[documentAId];
    final documentB = documentMap[documentBId];
    return documentA.compareTo(documentB, DocumentFields.name, true);
  });

  return list;
}

var memoizedFilteredDocumentList = memo3((BuiltMap<int, DocumentEntity>
            documentMap,
        BuiltList<int> documentList,
        ListUIState documentListState) =>
    filteredDocumentsSelector(documentMap, documentList, documentListState));

List<int> filteredDocumentsSelector(BuiltMap<int, DocumentEntity> documentMap,
    BuiltList<int> documentList, ListUIState documentListState) {
  final list = documentList.where((documentId) {
    final document = documentMap[documentId];
    /*
    if (documentListState.filterEntityId != null &&
        document.id != documentListState.filterEntityId) {
      return false;
    } else {}
    */

    if (!document.matchesStates(documentListState.stateFilters)) {
      return false;
    }
    return document.matchesFilter(documentListState.filter);
  }).toList();

  list.sort((documentAId, documentBId) {
    final documentA = documentMap[documentAId];
    final documentB = documentMap[documentBId];
    return documentA.compareTo(documentB, documentListState.sortField,
        documentListState.sortAscending);
  });

  return list;
}

var memoizedInvoiceDocumentsSelector = memo3(
    (BuiltMap<int, DocumentEntity> documentMap,
            BuiltMap<int, ExpenseEntity> expenseMap, InvoiceEntity entity) =>
        invoiceDocumentsSelector(documentMap, expenseMap, entity));

List<int> invoiceDocumentsSelector(BuiltMap<int, DocumentEntity> documentMap,
    BuiltMap<int, ExpenseEntity> expenseMap, InvoiceEntity entity) {
  final map = <int, List<int>>{};
  expenseMap.forEach((int, expense) {
    if (expense.invoiceDocuments) {
      if (map.containsKey(expense.invoiceId)) {
        map[expense.invoiceId].add(expense.id);
      } else {
        map[expense.invoiceId] = [expense.id];
      }
    }
  });

  final list = documentMap.keys.where((documentId) {
    final document = documentMap[documentId];

    if (!document.isActive) {
      return false;
    }

    if (document.invoiceId == entity.id) {
      return true;
    } else if (map.containsKey(entity.id) &&
        map[entity.id].contains(document.expenseId)) {
      return true;
    }

    return false;
  }).toList();

  list.sort((documentAId, documentBId) {
    final documentA = documentMap[documentAId];
    final documentB = documentMap[documentBId];
    return documentA.compareTo(documentB, DocumentFields.id, true);
  });

  return list.toList();
}

var memoizedExpenseDocumentsSelector = memo2(
    (BuiltMap<int, DocumentEntity> documentMap, BaseEntity entity) =>
        expenseDocumentsSelector(documentMap, entity));

List<int> expenseDocumentsSelector(
    BuiltMap<int, DocumentEntity> documentMap, ExpenseEntity entity) {
  final list = documentMap.keys.where((documentId) {
    final document = documentMap[documentId];

    if (!document.isActive) {
      return false;
    }

    if (document.expenseId == entity.id) {
      return true;
    }

    return false;
  }).toList();

  list.sort((documentAId, documentBId) {
    final documentA = documentMap[documentAId];
    final documentB = documentMap[documentBId];
    return documentA.compareTo(documentB, DocumentFields.id, true);
  });

  return list.toList();
}
