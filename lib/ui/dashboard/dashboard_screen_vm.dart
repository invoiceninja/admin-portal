import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';

class DashboardScreenBuilder extends StatelessWidget {
  const DashboardScreenBuilder({Key key}) : super(key: key);
  static const String route = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DashboardVM>(
      //distinct: true,
      //onInit: (Store<AppState> store) => isMobile(context) ? store.dispatch(LoadClients()) : null,
      converter: DashboardVM.fromStore,
      builder: (context, viewModel) {
        return DashboardScreen(viewModel: viewModel);
      },
    );
  }
}

class DashboardVM {
  DashboardVM({
    @required this.state,
    @required this.dashboardUIState,
    @required this.currencyMap,
    @required this.isLoading,
    @required this.isNextEnabled,
    @required this.filter,
    @required this.filteredList,
    @required this.onRefreshed,
    @required this.onSettingsChanged,
    @required this.onSelectionChanged,
    @required this.onOffsetChanged,
    @required this.onCurrencyChanged,
  });

  static DashboardVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);

      // TODO just reload activities
      store.dispatch(RefreshData(completer: completer));

      return completer.future;
    }

    final state = store.state;
    final filter = state.uiState.filter;
    final settings = state.dashboardUIState.settings;

    return DashboardVM(
      state: state,
      dashboardUIState: state.dashboardUIState,
      currencyMap: state.staticState.currencyMap,
      isLoading: state.isLoading,
      isNextEnabled:
          DateTime.parse(settings.endDate(state.company))
              .isBefore(DateTime.now()),
      onRefreshed: (context) => _handleRefresh(context),
      onSettingsChanged: (DashboardSettings settings) =>
          store.dispatch(UpdateDashboardSettings(settings: settings)),
      onSelectionChanged: (entityType, entityIds) {
        store.dispatch(UpdateDashboardSelection(
          entityType: entityType,
          entityIds: entityIds,
        ));
      },
      onOffsetChanged: (offset) =>
          store.dispatch(UpdateDashboardSettings(offset: offset)),
      onCurrencyChanged: (currencyId) =>
          store.dispatch(UpdateDashboardSettings(currencyId: currencyId)),
      filter: filter,
      filteredList: memoizedFilteredSelector(filter, state.userCompanyState),
    );
  }

  final AppState state;
  final DashboardUIState dashboardUIState;
  final BuiltMap<String, CurrencyEntity> currencyMap;
  final String filter;
  final List<BaseEntity> filteredList;
  final bool isLoading;
  final bool isNextEnabled;
  final Function(BuildContext) onRefreshed;
  final Function(DashboardSettings) onSettingsChanged;
  final Function(EntityType, List<String>) onSelectionChanged;
  final Function(int) onOffsetChanged;
  final Function(String) onCurrencyChanged;

/*
  @override
  bool operator ==(dynamic other) =>
      dashboardUIState == other.dashboardUIState &&
      currencyMap == other.currencyMap &&
      isLoading == other.isLoading &&
      filter == other.filter &&
      filteredList == other.filteredList;

  @override
  int get hashCode =>
      dashboardUIState.hashCode ^
      currencyMap.hashCode ^
      isLoading.hashCode ^
      filter.hashCode ^
      filteredList.hashCode;
   */
}
