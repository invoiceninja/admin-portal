// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';

class ClientViewDocuments extends StatelessWidget {
  const ClientViewDocuments({Key? key, required this.viewModel})
      : super(key: key);

  final ClientViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final client = viewModel.client;

    return DocumentGrid(
      documents: client.documents.toList(),
      onUploadDocument: (path, isPrivate) =>
          viewModel.onUploadDocuments(context, path, isPrivate),
      onRenamedDocument: () => store.dispatch(LoadClient(clientId: client.id)),
    );
  }
}
