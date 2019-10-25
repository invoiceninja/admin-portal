import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:redux/redux.dart';

import 'vendor_screen.dart';

class VendorScreenBuilder extends StatelessWidget {
  const VendorScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VendorScreenVM>(
      //rebuildOnChange: true,
      converter: VendorScreenVM.fromStore,
      builder: (context, vm) {
        return VendorScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class VendorScreenVM {
  VendorScreenVM({
    @required this.isInMultiselect,
    @required this.vendorList,
    @required this.userCompany,
    @required this.onEntityAction,
    @required this.vendorMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity userCompany;
  final List<String> vendorList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, VendorEntity> vendorMap;

  static VendorScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return VendorScreenVM(
      vendorMap: state.vendorState.map,
      vendorList: memoizedFilteredVendorList(
          state.vendorState.map, state.vendorState.list, state.vendorListState),
      userCompany: state.userCompany,
      isInMultiselect: state.vendorListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> vendors,
              EntityAction action) =>
          handleVendorAction(context, vendors, action),
    );
  }
}
