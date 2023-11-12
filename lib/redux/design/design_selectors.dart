// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

var memoizedDropdownDesignList = memo3(
    (BuiltMap<String, DesignEntity> designMap, BuiltList<String> designList,
            String clientId) =>
        dropdownDesignsSelector(designMap, designList, clientId));

List<String> dropdownDesignsSelector(BuiltMap<String, DesignEntity> designMap,
    BuiltList<String> designList, String clientId) {
  final list = designList.where((designId) {
    final design = designMap[designId]!;
    /*
    if (clientId != null && clientId > 0 && design.clientId != clientId) {
      return false;
    }
    */
    return design.isActive;
  }).toList();

  list.sort((designAId, designBId) {
    final designA = designMap[designAId]!;
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
    final design = designMap[designId]!;

    if (!design.isCustom) {
      return false;
    }

    if (!design.matchesStates(designListState.stateFilters)) {
      return false;
    }
    return design.matchesFilter(designListState.filter);
  }).toList();

  list.sort((designAId, designBId) {
    final designA = designMap[designAId]!;
    final designB = designMap[designBId];
    return designA.compareTo(
        designB, designListState.sortField, designListState.sortAscending);
  });

  return list;
}

String? getDesignIdForClientByEntity(
    {required AppState state,
    required String clientId,
    EntityType? entityType}) {
  final client = state.clientState.get(clientId);
  final settings = getClientSettings(state, client);
  switch (entityType) {
    case EntityType.invoice:
      return settings.defaultInvoiceDesignId;
    case EntityType.quote:
      return settings.defaultQuoteDesignId;
    case EntityType.credit:
      return settings.defaultCreditDesignId;
    default:
      print('## ERROR: undefined entity type $entityType in design_selectors');
      return settings.defaultInvoiceDesignId;
  }
}

String? getDesignIdForVendorByEntity(
    {required AppState state,
    required String vendorId,
    EntityType? entityType}) {
  final vendor = state.vendorState.get(vendorId);

  final settings = getVendorSettings(state, vendor);
  switch (entityType) {
    case EntityType.purchaseOrder:
      return settings.defaultPurchaseOrderDesignId;
    default:
      print('## ERROR: undefined entity type $entityType in design_selectors');
      return settings.defaultInvoiceDesignId;
  }
}

bool hasDesignTemplatesForEntityType(
    BuiltMap<String, DesignEntity> designMap, EntityType entityType) {
  if (!kReleaseMode) {
    return true;
  }

  var hasMatch = false;

  designMap.forEach((designId, design) {
    if (design.supportsEntityType(entityType)) {
      hasMatch = true;
    }
  });

  return hasMatch;
}
