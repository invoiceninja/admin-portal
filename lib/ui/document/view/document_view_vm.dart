// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/document/view/document_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DocumentViewScreen extends StatelessWidget {
  const DocumentViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;

  static const String route = '/document/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DocumentViewVM>(
      converter: (Store<AppState> store) {
        return DocumentViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return DocumentView(
          isFilter: isFilter,
          viewModel: vm,
        );
      },
    );
  }
}

class DocumentViewVM {
  DocumentViewVM({
    required this.state,
    required this.document,
    required this.company,
    required this.onEntityAction,
    required this.onRefreshed,
    required this.isSaving,
    required this.isLoading,
    required this.isDirty,
  });

  factory DocumentViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final document =
        state.documentState.map[state.documentUIState.selectedId] ??
            DocumentEntity(id: state.documentUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(
          LoadDocument(completer: completer, documentId: document.id));
      return completer.future;
    }

    return DocumentViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: document.isNew,
      document: document,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([document], action, autoPop: true),
    );
  }

  final AppState state;
  final DocumentEntity document;
  final CompanyEntity? company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
