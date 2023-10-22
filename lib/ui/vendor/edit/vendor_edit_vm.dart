// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/vendor/edit/vendor_edit.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class VendorEditScreen extends StatelessWidget {
  const VendorEditScreen({Key? key}) : super(key: key);
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
          key: ValueKey(viewModel.vendor.updatedAt),
        );
      },
    );
  }
}

class VendorEditVM {
  VendorEditVM({
    required this.state,
    required this.vendor,
    required this.company,
    required this.onChanged,
    required this.isSaving,
    required this.origVendor,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.isLoading,
  });

  factory VendorEditVM.fromStore(Store<AppState> store) {
    final vendor = store.state.vendorUIState.editing!;
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
        createEntity(entity: VendorEntity(), force: true);
        if (state.vendorUIState.cancelCompleter != null) {
          state.vendorUIState.cancelCompleter!.complete();
        } else {
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final vendor = store.state.vendorUIState.editing!;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          if (!vendor.hasNameSet) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(localization!.pleaseEnterAName);
                });
            return null;
          }
          final Completer<VendorEntity> completer =
              new Completer<VendorEntity>();
          store.dispatch(
              SaveVendorRequest(completer: completer, vendor: vendor));
          return completer.future.then((savedVendor) {
            showToast(vendor.isNew
                ? localization!.createdVendor
                : localization!.updatedVendor);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(VendorViewScreen.route));
              if (vendor.isNew && state.vendorUIState.saveCompleter == null) {
                navigator!.pushReplacementNamed(VendorViewScreen.route);
              } else {
                navigator!.pop(savedVendor);
              }
            } else if (state.vendorUIState.saveCompleter == null) {
              if (!state.prefState.isPreviewVisible) {
                store.dispatch(TogglePreviewSidebar());
              }
              viewEntity(entity: savedVendor, force: true);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
    );
  }

  final VendorEntity vendor;
  final CompanyEntity? company;
  final Function(VendorEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final bool isLoading;
  final bool isSaving;
  final VendorEntity? origVendor;
  final AppState state;
}
