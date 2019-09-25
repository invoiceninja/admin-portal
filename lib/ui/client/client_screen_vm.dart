import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
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
  });

  final bool isInMultiselect;

  static ClientScreenVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadClients(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return ClientScreenVM(
        isInMultiselect: state.clientListState.isInMultiselect());
  }
}
