import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedEntityDocumentMap = memo3((EntityType entityType,
        BuiltMap<String, DocumentEntity> documentMap,
        BuiltMap<String, ExpenseEntity> expenseMap) =>
    entityDocumentMap(entityType, documentMap, expenseMap));

Map<String, bool> entityDocumentMap(
    EntityType entityType,
    BuiltMap<String, DocumentEntity> documentMap,
    BuiltMap<String, ExpenseEntity> expenseMap) {
  final invoiceMap = <String, String>{};
  expenseMap.forEach((int, expense) {
    if (expense.invoiceDocuments && expense.isInvoiced) {
      invoiceMap[expense.id] = expense.invoiceId;
    }
  });

  final Map<String, bool> map = {};
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
    (BuiltMap<String, DocumentEntity> documentMap,
            BuiltList<String> documentList, String clientId) =>
        dropdownDocumentsSelector(documentMap, documentList, clientId));

List<String> dropdownDocumentsSelector(
    BuiltMap<String, DocumentEntity> documentMap,
    BuiltList<String> documentList,
    String clientId) {
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

var memoizedFilteredDocumentList = memo3((BuiltMap<String, DocumentEntity>
            documentMap,
        BuiltList<String> documentList,
        ListUIState documentListState) =>
    filteredDocumentsSelector(documentMap, documentList, documentListState));

List<String> filteredDocumentsSelector(
    BuiltMap<String, DocumentEntity> documentMap,
    BuiltList<String> documentList,
    ListUIState documentListState) {
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
    (BuiltMap<String, DocumentEntity> documentMap,
            BuiltMap<String, ExpenseEntity> expenseMap, InvoiceEntity entity) =>
        invoiceDocumentsSelector(documentMap, expenseMap, entity));

List<String> invoiceDocumentsSelector(
    BuiltMap<String, DocumentEntity> documentMap,
    BuiltMap<String, ExpenseEntity> expenseMap,
    InvoiceEntity entity) {
  final map = <String, List<String>>{};
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
    (BuiltMap<String, DocumentEntity> documentMap, BaseEntity entity) =>
        expenseDocumentsSelector(documentMap, entity));

List<String> expenseDocumentsSelector(
    BuiltMap<String, DocumentEntity> documentMap, ExpenseEntity entity) {
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
