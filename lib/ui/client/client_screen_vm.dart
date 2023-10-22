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
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'client_screen.dart';

class ClientScreenBuilder extends StatelessWidget {
  const ClientScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientScreenVM>(
      converter: ClientScreenVM.fromStore,
      builder: (context, vm) {
        return ClientScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class ClientScreenVM {
  ClientScreenVM({
    required this.isInMultiselect,
    required this.clientList,
    required this.userCompany,
    required this.clientMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> clientList;
  final BuiltMap<String, ClientEntity> clientMap;

  static ClientScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ClientScreenVM(
      clientMap: state.clientState.map,
      clientList: memoizedFilteredClientList(
          state.getUISelection(EntityType.client),
          state.clientState.map,
          state.clientState.list,
          state.groupState.map,
          state.clientListState,
          state.userState.map,
          state.staticState),
      userCompany: state.userCompany,
      isInMultiselect: state.clientListState.isInMultiselect(),
    );
  }
}
