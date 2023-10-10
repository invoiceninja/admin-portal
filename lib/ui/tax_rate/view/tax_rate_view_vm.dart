// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/tax_rate_screen.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/view/tax_rate_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaxRateViewScreen extends StatelessWidget {
  const TaxRateViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);

  final bool isFilter;
  static const String route = '/$kSettings/$kSettingsTaxRatesView';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaxRateViewVM>(
      converter: (Store<AppState> store) {
        return TaxRateViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return TaxRateView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class TaxRateViewVM {
  TaxRateViewVM({
    required this.state,
    required this.taxRate,
    required this.company,
    required this.onEntityAction,
    required this.onBackPressed,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
  });

  factory TaxRateViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final taxRate = state.taxRateState.map[state.taxRateUIState.selectedId] ??
        TaxRateEntity(id: state.taxRateUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadTaxRate(completer: completer, taxRateId: taxRate.id));
      return completer.future;
    }

    return TaxRateViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: taxRate.isNew,
      taxRate: taxRate,
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(TaxRateSettingsScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([taxRate], action, autoPop: true),
    );
  }

  final AppState state;
  final TaxRateEntity taxRate;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
