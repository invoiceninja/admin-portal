import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_screen.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class VendorEditScreen extends StatelessWidget {
  const VendorEditScreen({Key key}) : super(key: key);
  static const String route = '/vendor/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VendorEditVM>(
      converter: (Store<AppState> store) {
        return VendorEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return VendorEdit(
          viewModel: viewModel,
        );
      },
    );
  }
}

class VendorEditVM {
  VendorEditVM({
    @required this.state,
    @required this.vendor,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origVendor,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.isLoading,
  });

  factory VendorEditVM.fromStore(Store<AppState> store) {
    final vendor = store.state.vendorUIState.editing;
    final state = store.state;

    return VendorEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origVendor: state.vendorState.map[vendor.id],
      vendor: vendor,
      company: state.selectedCompany,
      onChanged: (VendorEntity vendor) {
        store.dispatch(UpdateVendor(vendor));
      },
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(VendorScreen.route)) {
          store.dispatch(UpdateCurrentRoute(
              vendor.isNew ? VendorScreen.route : VendorViewScreen.route));
        }
      },
      onSavePressed: (BuildContext context) {
        final Completer<VendorEntity> completer = new Completer<VendorEntity>();
        store.dispatch(SaveVendorRequest(completer: completer, vendor: vendor));
        return completer.future.then((_) {
          return completer.future.then((savedVendor) {
            if (state.uiState.currentRoute.contains(VendorScreen.route)) {
              store.dispatch(UpdateCurrentRoute(VendorViewScreen.route));
            }
            if (vendor.isNew) {
              if ([
                ExpenseEditScreen.route,
              ].contains(store.state.uiState.currentRoute)) {
                Navigator.of(context).pop(savedVendor);
              } else {
                Navigator.of(context)
                    .pushReplacementNamed(VendorViewScreen.route);
              }
            } else {
              Navigator.of(context).pop(savedVendor);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final VendorEntity vendor;
  final CompanyEntity company;
  final Function(VendorEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final bool isLoading;
  final bool isSaving;
  final VendorEntity origVendor;
  final AppState state;
}
