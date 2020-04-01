import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewDocumentList extends AbstractNavigatorAction implements PersistUI {
  ViewDocumentList({@required NavigatorState navigator, this.force = false})
      : super(navigator: navigator);

  final bool force;
}

class ViewDocument extends AbstractNavigatorAction implements PersistUI {
  ViewDocument(
      {@required NavigatorState navigator, this.documentId, this.force})
      : super(navigator: navigator);

  final String documentId;
  final bool force;
}

class EditDocument extends AbstractNavigatorAction implements PersistUI {
  EditDocument({
    @required NavigatorState navigator,
    this.document,
    this.completer,
  }) : super(navigator: navigator);

  final DocumentEntity document;
  final Completer completer;
}

class UpdateDocument implements PersistUI {
  UpdateDocument(this.document);

  final DocumentEntity document;
}

class LoadDocument {
  LoadDocument({this.completer, this.documentId});

  final Completer completer;
  final String documentId;
}

class LoadDocumentActivity {
  LoadDocumentActivity({this.completer, this.documentId});

  final Completer completer;
  final String documentId;
}

class LoadDocuments {
  LoadDocuments({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadDocumentRequest implements StartLoading {}

class LoadDocumentFailure implements StopLoading {
  LoadDocumentFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadDocumentFailure{error: $error}';
  }
}

class LoadDocumentSuccess implements StopLoading, PersistData {
  LoadDocumentSuccess(this.document);

  final DocumentEntity document;

  @override
  String toString() {
    return 'LoadDocumentSuccess{document: $document}';
  }
}

class LoadDocumentsRequest implements StartLoading {}

class LoadDocumentsFailure implements StopLoading {
  LoadDocumentsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadDocumentsFailure{error: $error}';
  }
}

class LoadDocumentsSuccess implements StopLoading, PersistData {
  LoadDocumentsSuccess(this.documents);

  final BuiltList<DocumentEntity> documents;

  @override
  String toString() {
    return 'LoadDocumentsSuccess{documents: $documents}';
  }
}

class SaveDocumentRequest implements StartSaving {
  SaveDocumentRequest({this.completer, this.document});

  final Completer completer;
  final DocumentEntity document;
}

class SaveDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveDocumentSuccess(this.document);

  final DocumentEntity document;
}

class AddDocumentSuccess implements StopSaving, PersistData, PersistUI {
  AddDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveDocumentFailure implements StopSaving {
  SaveDocumentFailure(this.error);

  final Object error;
}

class ArchiveDocumentRequest implements StartSaving {
  ArchiveDocumentRequest(this.completer, this.documentIds);

  final Completer completer;
  final List<String> documentIds;
}

class ArchiveDocumentSuccess implements StopSaving, PersistData {
  ArchiveDocumentSuccess(this.documents);

  final List<DocumentEntity> documents;
}

class ArchiveDocumentFailure implements StopSaving {
  ArchiveDocumentFailure(this.documents);

  final List<DocumentEntity> documents;
}

class DeleteDocumentRequest implements StartSaving {
  DeleteDocumentRequest(this.completer, this.documentIds);

  final Completer completer;
  final List<String> documentIds;
}

class DeleteDocumentSuccess implements StopSaving, PersistData {
  DeleteDocumentSuccess(this.documents);

  final List<DocumentEntity> documents;
}

class DeleteDocumentFailure implements StopSaving {
  DeleteDocumentFailure(this.documents);

  final List<DocumentEntity> documents;
}

class RestoreDocumentRequest implements StartSaving {
  RestoreDocumentRequest(this.completer, this.documentIds);

  final Completer completer;
  final List<String> documentIds;
}

class RestoreDocumentSuccess implements StopSaving, PersistData {
  RestoreDocumentSuccess(this.documents);

  final List<DocumentEntity> documents;
}

class RestoreDocumentFailure implements StopSaving {
  RestoreDocumentFailure(this.documents);

  final List<DocumentEntity> documents;
}

class FilterDocuments implements PersistUI {
  FilterDocuments(this.filter);

  final String filter;
}

class SortDocuments implements PersistUI {
  SortDocuments(this.field);

  final String field;
}

class FilterDocumentsByState implements PersistUI {
  FilterDocumentsByState(this.state);

  final EntityState state;
}

class FilterDocumentsByCustom1 implements PersistUI {
  FilterDocumentsByCustom1(this.value);

  final String value;
}

class FilterDocumentsByCustom2 implements PersistUI {
  FilterDocumentsByCustom2(this.value);

  final String value;
}

class FilterDocumentsByCustom3 implements PersistUI {
  FilterDocumentsByCustom3(this.value);

  final String value;
}

class FilterDocumentsByCustom4 implements PersistUI {
  FilterDocumentsByCustom4(this.value);

  final String value;
}

class FilterDocumentsByEntity implements PersistUI {
  FilterDocumentsByEntity({this.entityId, this.entityType});

  final String entityId;
  final EntityType entityType;
}

void handleDocumentAction(
    BuildContext context, List<BaseEntity> documents, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          documents.length == 1,
      'Cannot perform this action on more than one document');

  if (documents.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final localization = AppLocalization.of(context);
  final document = documents.first;
  final documentIds = documents.map((document) => document.id).toList();

  switch (action) {
    case EntityAction.edit:
      editEntity(context: context, entity: document);
      break;
    case EntityAction.restore:
      store.dispatch(RestoreDocumentRequest(
          snackBarCompleter<Null>(context, localization.restoredDocument),
          documentIds));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveDocumentRequest(
          snackBarCompleter<Null>(context, localization.archivedDocument),
          documentIds));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteDocumentRequest(
          snackBarCompleter<Null>(context, localization.deletedDocument),
          documentIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.documentListState.isInMultiselect()) {
        store.dispatch(StartDocumentMultiselect());
      }

      if (documents.isEmpty) {
        break;
      }

      for (final document in documents) {
        if (!store.state.documentListState.isSelected(document.id)) {
          store.dispatch(AddToDocumentMultiselect(entity: document));
        } else {
          store.dispatch(RemoveFromDocumentMultiselect(entity: document));
        }
      }
      break;
  }
}

class StartDocumentMultiselect {}

class AddToDocumentMultiselect {
  AddToDocumentMultiselect({@required this.entity});

  final BaseEntity entity;
}

class RemoveFromDocumentMultiselect {
  RemoveFromDocumentMultiselect({@required this.entity});

  final BaseEntity entity;
}

class ClearDocumentMultiselect {}
