// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'vendor_screen.dart';

class VendorScreenBuilder extends StatelessWidget {
  const VendorScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VendorScreenVM>(
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
    required this.isInMultiselect,
    required this.vendorList,
    required this.userCompany,
    required this.vendorMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> vendorList;
  final BuiltMap<String, VendorEntity> vendorMap;

  static VendorScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return VendorScreenVM(
      vendorMap: state.vendorState.map,
      vendorList: memoizedFilteredVendorList(
          state.getUISelection(EntityType.vendor),
          state.vendorState.map,
          state.vendorState.list,
          state.vendorListState,
          state.userState.map,
          state.staticState),
      userCompany: state.userCompany,
      isInMultiselect: state.vendorListState.isInMultiselect(),
    );
  }
}
