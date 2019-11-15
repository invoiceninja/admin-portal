import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/vendor/vendor_list.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class VendorListBuilder extends StatelessWidget {
  const VendorListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VendorListVM>(
      converter: VendorListVM.fromStore,
      builder: (context, viewModel) {
        return VendorList(
          viewModel: viewModel,
        );
      },
    );
  }
}

class VendorListVM {
  VendorListVM({
    @required this.state,
    @required this.vendorList,
    @required this.vendorMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onVendorTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
  });

  static VendorListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadVendors(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return VendorListVM(
      state: state,
      listState: state.vendorListState,
      vendorList: memoizedFilteredVendorList(
          state.vendorState.map, state.vendorState.list, state.vendorListState),
      vendorMap: state.vendorState.map,
      isLoading: state.isLoading,
      isLoaded: state.vendorState.isLoaded,
      filter: state.vendorUIState.listUIState.filter,
      onClearEntityFilterPressed: () => store.dispatch(FilterVendorsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.vendorListState.filterEntityId,
          entityType: state.vendorListState.filterEntityType),
      onVendorTap: (context, vendor) {
        store.dispatch(ViewVendor(vendorId: vendor.id, context: context));
      },
      onRefreshed: (context) => _handleRefresh(context),
    );
  }

  final AppState state;
  final List<String> vendorList;
  final BuiltMap<String, VendorEntity> vendorMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, VendorEntity) onVendorTap;
  final Function(BuildContext) onRefreshed;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
}
