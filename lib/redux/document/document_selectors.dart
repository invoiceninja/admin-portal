import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

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
