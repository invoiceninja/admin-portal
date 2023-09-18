// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/client/client_pdf.dart';

class ClientPdfScreen extends StatelessWidget {
  const ClientPdfScreen({Key? key, this.showAppBar = true}) : super(key: key);

  final bool showAppBar;

  static const String route = '/client/pdf';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClientPdfVM>(
      converter: (Store<AppState> store) {
        return ClientPdfVM.fromStore(store);
      },
      builder: (context, vm) {
        return ClientPdfView(
          key: ValueKey('__client_pdf_${vm.client!.id}__'),
          viewModel: vm,
          showAppBar: showAppBar,
        );
      },
    );
  }
}

class ClientPdfVM {
  ClientPdfVM({
    required this.state,
    required this.client,
  });

  factory ClientPdfVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final clientUIState = state.uiState.clientUIState;
    final clientId = clientUIState.selectedId!;
    final client = state.clientState.get(clientId);

    return ClientPdfVM(
      state: state,
      client: client,
    );
  }

  final AppState state;
  final ClientEntity? client;
}
