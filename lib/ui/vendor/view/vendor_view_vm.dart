// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorViewScreen extends StatelessWidget {
  const VendorViewScreen({
    Key? key,
    this.isFilter = false,
    this.isTopFilter = false,
  }) : super(key: key);
  final bool isFilter;
  final bool isTopFilter;

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
          isFilter: isFilter,
          isTopFilter: isTopFilter,
          tabIndex: vm.state.vendorUIState.tabIndex,
        );
      },
    );
  }
}

class VendorViewVM {
  VendorViewVM({
    required this.state,
    required this.vendor,
    required this.company,
    required this.onAddExpensePressed,
    required this.onEntityAction,
    required this.onEntityPressed,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
    required this.onUploadDocuments,
  });

  factory VendorViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final vendor = state.vendorState.map[state.vendorUIState.selectedId] ??
        VendorEntity(id: state.vendorUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
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
              createEntity(entity: ExpenseEntity(state: state, vendor: vendor));
            } else {
              viewEntitiesByType(
                  entityType: EntityType.expense, filterEntity: vendor);
            }
            break;
        }
      },
      onAddExpensePressed: (context) {
        createEntity(entity: ExpenseEntity(state: state, vendor: vendor));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([vendor], action, autoPop: true),
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFile, bool isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SaveVendorDocumentRequest(
            isPrivate: isPrivate,
            multipartFiles: multipartFile,
            vendor: vendor,
            completer: completer));
        completer.future.then((client) {
          showToast(AppLocalization.of(context)!.uploadedDocument);
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

  final AppState state;
  final VendorEntity vendor;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext) onAddExpensePressed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
  final Function(BuildContext, List<MultipartFile>, bool) onUploadDocuments;
}
