import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_screen.dart';
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
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
  });

  factory VendorViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final company = state.selectedCompany;
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
      company: state.selectedCompany,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: vendor.isNew,
      vendor: vendor,
      onEditPressed: (BuildContext context) {
        final Completer<VendorEntity> completer = Completer<VendorEntity>();
        store.dispatch(
            EditVendor(vendor: vendor, context: context, completer: completer));
        completer.future.then((client) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).updatedVendor,
          )));
        });
      },
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(VendorScreen.route)) {
          store.dispatch(UpdateCurrentRoute(VendorScreen.route));
        }
      },
      onEntityPressed: (BuildContext context, EntityType entityType,
          [longPress = false]) {
        switch (entityType) {
          case EntityType.expense:
            if (longPress && vendor.isActive) {
              store.dispatch(EditExpense(
                  context: context,
                  expense: ExpenseEntity(
                      company: state.selectedCompany, vendor: vendor)));
            } else {
              store.dispatch(FilterExpensesByEntity(
                  entityId: vendor.id, entityType: EntityType.vendor));
              store.dispatch(ViewExpenseList(context: context));
            }
            break;
        }
      },
      onAddExpensePressed: (context) => store.dispatch(EditExpense(
          expense: ExpenseEntity(company: company, vendor: vendor),
          context: context)),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleVendorAction(context, [vendor], action),
    );
  }

  final AppState state;
  final VendorEntity vendor;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onEditPressed;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext) onAddExpensePressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
