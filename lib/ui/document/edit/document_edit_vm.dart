import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/document/document_screen.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/document/view/document_view_vm.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/data/models/document_model.dart';
import 'package:invoiceninja_flutter/ui/document/edit/document_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class DocumentEditScreen extends StatelessWidget {
  const DocumentEditScreen({Key key}) : super(key: key);
  static const String route = '/document/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DocumentEditVM>(
      converter: (Store<AppState> store) {
        return DocumentEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return DocumentEdit(
          viewModel: viewModel,
        );
      },
    );
  }
}

class DocumentEditVM {
  DocumentEditVM({
    @required this.state,
    @required this.document,
    @required this.company,
    @required this.onChanged,
    @required this.isSaving,
    @required this.origDocument,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.isLoading,
  });

  factory DocumentEditVM.fromStore(Store<AppState> store) {
    final document = store.state.documentUIState.editing;
    final state = store.state;

    return DocumentEditVM(
      state: state,
      isLoading: state.isLoading,
      isSaving: state.isSaving,
      origDocument: state.documentState.map[document.id],
      document: document,
      company: state.selectedCompany,
      onChanged: (DocumentEntity document) {
        store.dispatch(UpdateDocument(document));
      },
      onBackPressed: () {
        if (state.uiState.currentRoute.contains(DocumentScreen.route)) {
          store.dispatch(UpdateCurrentRoute(document.isNew
              ? DocumentScreen.route
              : DocumentViewScreen.route));
        }
      },
      onSavePressed: (BuildContext context) {
        final Completer<DocumentEntity> completer =
            new Completer<DocumentEntity>();
        store.dispatch(
            SaveDocumentRequest(completer: completer, document: document));
        return completer.future.then((savedDocument) {
          if (isMobile(context)) {
            store.dispatch(UpdateCurrentRoute(DocumentViewScreen.route));
            if (document.isNew) {
              Navigator.of(context)
                  .pushReplacementNamed(DocumentViewScreen.route);
            } else {
              Navigator.of(context).pop(savedDocument);
            }
          } else {
            store.dispatch(ViewDocument(context: context, documentId: savedDocument.id, force: true));
          }
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }

  final DocumentEntity document;
  final CompanyEntity company;
  final Function(DocumentEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final bool isLoading;
  final bool isSaving;
  final DocumentEntity origDocument;
  final AppState state;
}
