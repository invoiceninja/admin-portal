// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';

DashboardUIState dashboardUIReducer(DashboardUIState state, dynamic action) {
  return state.rebuild((b) => b
    ..settings.replace(dashboardSettingsReducer(state.settings, action))
    ..selectedEntities
        .replace(selectedEntitiesReducer(state.selectedEntities, action))
    ..selectedEntityType =
        selectedEntityTypeReducer(state.selectedEntityType, action)
    ..showSidebar = showSidebarReducer(state.showSidebar, action));
}

Reducer<BuiltMap<EntityType?, BuiltList<String>>> selectedEntitiesReducer =
    combineReducers([
  TypedReducer<BuiltMap<EntityType?, BuiltList<String>>,
      UpdateDashboardSelection>((state, action) {
    return state.rebuild((b) =>
        b..[action.entityType] = BuiltList(action.entityIds ?? <String>[]));
  }),
  TypedReducer<BuiltMap<EntityType?, BuiltList<String>>, SelectCompany>(
      (state, action) {
    return state.rebuild((b) => b..clear());
  }),
]);

Reducer<EntityType?> selectedEntityTypeReducer = combineReducers([
  TypedReducer<EntityType?, UpdateDashboardEntityType>((state, action) {
    return action.entityType;
  }),
]);

Reducer<bool?> showSidebarReducer = combineReducers([
  TypedReducer<bool?, UpdateDashboardSidebar>((state, action) {
    return action.showSidebar;
  }),
]);

DashboardUISettings dashboardSettingsReducer(
    DashboardUISettings state, dynamic action) {
  if (action is UpdateDashboardSettings) {
    final settings = action.settings;
    if (settings != null) {
      return state.rebuild((b) => b
        ..dateRange = settings.dateRange
        ..customStartDate = settings.startDate
        ..customEndDate = settings.endDate
        ..enableComparison = settings.enableComparison
        ..compareDateRange = settings.compareDateRange
        ..compareCustomStartDate = settings.compareStartDate
        ..compareCustomStartDate = settings.compareEndDate
        ..offset = 0);
    } else if (action.includeTaxes != null) {
      return state.rebuild((b) => b..includeTaxes = action.includeTaxes);
    } else if (action.offset != null) {
      return state.rebuild((b) => b..offset = state.offset + action.offset!);
    } else if (action.currencyId != null) {
      return state.rebuild((b) => b..currencyId = action.currencyId);
    } else if (action.groupBy != null) {
      return state.rebuild((b) => b..groupBy = action.groupBy);
    }
  } else if (action is SelectCompany) {
    //return state.rebuild((b) => b..currencyId = action.company.currencyId);
    // TODO re-enable
    return state;
  }

  return state;
}
