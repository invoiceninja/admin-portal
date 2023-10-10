// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/ui/app/confirm_email_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DashboardScreenBuilder extends StatelessWidget {
  const DashboardScreenBuilder({Key? key}) : super(key: key);
  static const String route = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DashboardVM>(
      //distinct: true,
      //onInit: (Store<AppState> store) => isMobile(context) ? store.dispatch(LoadClients()) : null,
      converter: DashboardVM.fromStore,
      builder: (context, viewModel) {
        final state = viewModel.state;
        final company = state.company;

        if (!state.isUserConfirmed) {
          return ConfirmEmailBuilder();
        }

        return DashboardScreen(
          viewModel: viewModel,
          key: ValueKey(
              '__${company.id}_${company.enabledModules}_${state.prefState.isDesktop}__'),
        );
      },
    );
  }
}

class DashboardVM {
  DashboardVM({
    required this.state,
    required this.dashboardUIState,
    required this.currencyMap,
    required this.isLoading,
    required this.filter,
    required this.filteredList,
    required this.onRefreshed,
    required this.onEntityTypeChanged,
    required this.onSettingsChanged,
    required this.onSelectionChanged,
    required this.onOffsetChanged,
    required this.onCurrencyChanged,
    required this.onTaxesChanged,
    required this.onGroupByChanged,
    required this.onShowSidebar,
  });

  static DashboardVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);

      // TODO just reload activities
      store.dispatch(RefreshData(completer: completer));

      return completer.future;
    }

    final state = store.state;
    final filter = state.uiState.filter;

    return DashboardVM(
      state: state,
      dashboardUIState: state.dashboardUIState,
      currencyMap: state.staticState.currencyMap,
      isLoading: state.isLoading,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityTypeChanged: (entityType) {
        store.dispatch(UpdateDashboardEntityType(entityType: entityType));
      },
      onSettingsChanged: (DashboardSettings settings) =>
          store.dispatch(UpdateDashboardSettings(settings: settings)),
      onTaxesChanged: (value) =>
          store.dispatch(UpdateDashboardSettings(includeTaxes: value)),
      onGroupByChanged: (value) =>
          store.dispatch(UpdateDashboardSettings(groupBy: value)),
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
      onShowSidebar: () =>
          store.dispatch(UpdateDashboardSidebar(showSidebar: true)),
    );
  }

  final AppState state;
  final DashboardUIState dashboardUIState;
  final BuiltMap<String, CurrencyEntity> currencyMap;
  final String? filter;
  final List<BaseEntity> filteredList;
  final bool isLoading;
  final Function(BuildContext) onRefreshed;
  final Function(DashboardSettings) onSettingsChanged;
  final Function(EntityType, List<String>?) onSelectionChanged;
  final Function(EntityType) onEntityTypeChanged;
  final Function(int) onOffsetChanged;
  final Function(String?) onCurrencyChanged;
  final Function(bool?) onTaxesChanged;
  final Function(String?) onGroupByChanged;
  final Function onShowSidebar;
}
