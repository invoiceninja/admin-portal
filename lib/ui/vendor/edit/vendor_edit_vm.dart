import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/vendor_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';

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
    @required this.onCancelPressed,
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
      company: state.company,
      onChanged: (VendorEntity vendor) {
        store.dispatch(UpdateVendor(vendor));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(context: context, entity: VendorEntity(), force: true);
        if (state.vendorUIState.cancelCompleter != null) {
          state.vendorUIState.cancelCompleter.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onSavePressed: (BuildContext context) {
        if (!vendor.hasNameSet) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                    AppLocalization.of(context).pleaseEnterAName);
              });
          return null;
        }
        final localization = AppLocalization.of(context);
        final Completer<VendorEntity> completer = new Completer<VendorEntity>();
        store.dispatch(SaveVendorRequest(completer: completer, vendor: vendor));
        return completer.future.then((savedVendor) {
          showToast(vendor.isNew
              ? localization.createdVendor
              : localization.updatedVendor);

          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(VendorViewScreen.route));
            if (vendor.isNew && state.vendorUIState.saveCompleter == null) {
              Navigator.of(context)
                  .pushReplacementNamed(VendorViewScreen.route);
            } else {
              Navigator.of(context).pop(savedVendor);
            }
          } else {
            viewEntity(context: context, entity: savedVendor, force: true);
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final VendorEntity vendor;
  final CompanyEntity company;
  final Function(VendorEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final VendorEntity origVendor;
  final AppState state;
}
