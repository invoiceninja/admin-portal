// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/settings/import_export.dart';

class ImportExportScreen extends StatelessWidget {
  const ImportExportScreen({Key? key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsImportExport';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ImportExportVM>(
      converter: ImportExportVM.fromStore,
      builder: (context, viewModel) {
        return ImportExport(viewModel: viewModel);
      },
    );
  }
}

class ImportExportVM {
  ImportExportVM({
    required this.state,
  });

  static ImportExportVM fromStore(Store<AppState> store) {
    final state = store.state;

    return ImportExportVM(
      state: state,
    );
  }

  final AppState state;
}
