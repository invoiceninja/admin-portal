import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownDesignList = memo3(
    (BuiltMap<String, DesignEntity> designMap, BuiltList<String> designList,
            String clientId) =>
        dropdownDesignsSelector(designMap, designList, clientId));

List<String> dropdownDesignsSelector(BuiltMap<String, DesignEntity> designMap,
    BuiltList<String> designList, String clientId) {
  final list = designList.where((designId) {
    final design = designMap[designId];
    /*
    if (clientId != null && clientId > 0 && design.clientId != clientId) {
      return false;
    }
    */
    return design.isActive;
  }).toList();

  list.sort((designAId, designBId) {
    final designA = designMap[designAId];
    final designB = designMap[designBId];
    return designA.compareTo(designB, DesignFields.name, true);
  });

  return list;
}

var memoizedFilteredDesignList = memo3(
    (BuiltMap<String, DesignEntity> designMap, BuiltList<String> designList,
            ListUIState designListState) =>
        filteredDesignsSelector(designMap, designList, designListState));

List<String> filteredDesignsSelector(BuiltMap<String, DesignEntity> designMap,
    BuiltList<String> designList, ListUIState designListState) {
  final list = designList.where((designId) {
    final design = designMap[designId];

    if (!design.isCustom) {
      return false;
    }

    if (!design.matchesStates(designListState.stateFilters)) {
      return false;
    }
    return design.matchesFilter(designListState.filter);
  }).toList();

  list.sort((designAId, designBId) {
    final designA = designMap[designAId];
    final designB = designMap[designBId];
    return designA.compareTo(
        designB, designListState.sortField, designListState.sortAscending);
  });

  return list;
}

bool hasDesignChanges(
        DesignEntity design, BuiltMap<String, DesignEntity> designMap) =>
    design.isNew ? design.isChanged : design != designMap[design.id];
