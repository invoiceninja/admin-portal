import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_selectors.dart';
import 'package:redux/redux.dart';

import 'company_gateway_screen.dart';

class CompanyGatewayScreenBuilder extends StatelessWidget {
  const CompanyGatewayScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompanyGatewayScreenVM>(
      //rebuildOnChange: true,
      converter: CompanyGatewayScreenVM.fromStore,
      builder: (context, vm) {
        return CompanyGatewayScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class CompanyGatewayScreenVM {
  CompanyGatewayScreenVM({
    @required this.isInMultiselect,
    @required this.companyGatewayList,
    @required this.userCompany,
    @required this.onEntityAction,
    @required this.companyGatewayMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity userCompany;
  final List<String> companyGatewayList;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;
  final BuiltMap<String, CompanyGatewayEntity> companyGatewayMap;

  static CompanyGatewayScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return CompanyGatewayScreenVM(
      companyGatewayMap: state.companyGatewayState.map,
      companyGatewayList: memoizedFilteredCompanyGatewayList(
          state.companyGatewayState.map,
          state.companyGatewayState.list,
          state.companyGatewayListState),
      userCompany: state.userCompany,
      isInMultiselect: state.companyGatewayListState.isInMultiselect(),
      onEntityAction: (BuildContext context, List<BaseEntity> companyGateways,
              EntityAction action) =>
          handleCompanyGatewayAction(context, companyGateways, action),
    );
  }
}
