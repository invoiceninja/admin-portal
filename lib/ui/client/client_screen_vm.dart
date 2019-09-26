import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:redux/redux.dart';

import 'client_screen.dart';

class ClientScreenBuilder extends StatelessWidget {
  const ClientScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientScreenVM>(
      //rebuildOnChange: true,
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
    @required this.isInMultiselect,
    @required this.userCompany,
    @required this.onEntityAction,
  });

  final bool isInMultiselect;
  final UserCompanyEntity userCompany;
  final Function(BuildContext, ClientEntity, EntityAction) onEntityAction;

  static ClientScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ClientScreenVM(
      userCompany: state.userCompany,
      isInMultiselect: state.clientListState.isInMultiselect(),
      onEntityAction:
          (BuildContext context, BaseEntity client, EntityAction action) =>
              handleClientAction(context, client, action),
    );
  }
}
