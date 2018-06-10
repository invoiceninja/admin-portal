import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:redux/redux.dart';

class ClientEditBuilder extends StatelessWidget {
  ClientEditBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientEditVM>(
      converter: (Store<AppState> store) {
        return ClientEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return ClientEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class ClientEditVM {
  final ClientEntity client;

  ClientEditVM({
    @required this.client,
  });

  factory ClientEditVM.fromStore(Store<AppState> store) {
    final client = store.state.clientState().editing;

    return ClientEditVM(
        client: client,
    );
  }
}
