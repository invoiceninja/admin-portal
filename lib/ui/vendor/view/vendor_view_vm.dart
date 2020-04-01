import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class VendorViewScreen extends StatelessWidget {
  const VendorViewScreen({Key key}) : super(key: key);
  static const String route = '/vendor/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VendorViewVM>(
      converter: (Store<AppState> store) {
        return VendorViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return VendorView(
          viewModel: vm,
        );
      },
    );
  }
}

class VendorViewVM {
  VendorViewVM({
    @required this.state,
    @required this.vendor,
    @required this.company,
    @required this.onAddExpensePressed,
    @required this.onEntityAction,
    @required this.onEntityPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory VendorViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final vendor = state.vendorState.map[state.vendorUIState.selectedId] ??
        VendorEntity(id: state.vendorUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadVendor(completer: completer, vendorId: vendor.id));
      return completer.future;
    }

    return VendorViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: vendor.isNew,
      vendor: vendor,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityPressed: (BuildContext context, EntityType entityType,
          [longPress = false]) {
        switch (entityType) {
          case EntityType.expense:
            if (longPress && vendor.isActive) {
              createEntity(
                  context: context,
                  entity: ExpenseEntity(state: state, vendor: vendor));
            } else {
              viewEntitiesByType(
                  context: context,
                  entityType: EntityType.expense,
                  filterEntity: vendor);
            }
            break;
        }
      },
      onAddExpensePressed: (context) {
        createEntity(
            context: context,
            entity: ExpenseEntity(state: state, vendor: vendor));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleVendorAction(context, [vendor], action),
    );
  }

  final AppState state;
  final VendorEntity vendor;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext) onAddExpensePressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
