import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/document/document_list.dart';
import 'package:invoiceninja_flutter/ui/document/document_list_item.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class DocumentListBuilder extends StatelessWidget {
  const DocumentListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DocumentListVM>(
      converter: DocumentListVM.fromStore,
      builder: (context, viewModel) {
        return EntityList(
            isLoaded: viewModel.isLoaded,
            entityType: EntityType.document,
            state: viewModel.state,
            entityList: viewModel.documentList,
            onEntityTap: viewModel.onDocumentTap,
            //presenter: DocumentPresenter(),
            //tableColumns: viewModel.tableColumns,
            onRefreshed: viewModel.onRefreshed,
            onClearEntityFilterPressed: viewModel.onClearEntityFilterPressed,
            onViewEntityFilterPressed: viewModel.onViewEntityFilterPressed,
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final documentId = viewModel.documentList[index];
              final document = viewModel.documentMap[documentId];
              final listState = state.getListState(EntityType.document);
              final isInMultiselect = listState.isInMultiselect();

              void showDialog() => showEntityActionsDialog(
                    entities: [document],
                    context: context,
                  );

              return DocumentListItem(
                userCompany: state.userCompany,
                filter: viewModel.filter,
                document: document,
                onTap: () => viewModel.onDocumentTap(context, document),
                onEntityAction: (EntityAction action) {
                  if (action == EntityAction.more) {
                    showDialog();
                  } else {
                    viewModel.onEntityAction(context, [document], action);
                  }
                },
                onLongPress: () async {
                  final longPressIsSelection =
                      state.prefState.longPressSelectionIsDefault ?? true;
                  if (longPressIsSelection && !isInMultiselect) {
                    viewModel.onEntityAction(
                        context, [document], EntityAction.toggleMultiselect);
                  } else {
                    showDialog();
                  }
                },
                isChecked: isInMultiselect && listState.isSelected(document.id),
              );
            });
      },
    );
  }
}

class DocumentListVM {
  DocumentListVM({
    @required this.state,
    @required this.documentList,
    @required this.documentMap,
    @required this.filter,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onDocumentTap,
    @required this.listState,
    @required this.onRefreshed,
    @required this.onEntityAction,
    @required this.onClearEntityFilterPressed,
    @required this.onViewEntityFilterPressed,
    @required this.onSortColumn,
  });

  static DocumentListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      if (store.state.isLoading) {
        return Future<Null>(null);
      }
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadDocuments(completer: completer, force: true));
      return completer.future;
    }

    final state = store.state;

    return DocumentListVM(
      state: state,
      listState: state.documentListState,
      documentList: memoizedFilteredDocumentList(state.documentState.map,
          state.documentState.list, state.documentListState),
      documentMap: state.documentState.map,
      isLoading: state.isLoading,
      isLoaded: state.documentState.isLoaded,
      filter: state.documentUIState.listUIState.filter,
      onClearEntityFilterPressed: () =>
          store.dispatch(FilterDocumentsByEntity()),
      onViewEntityFilterPressed: (BuildContext context) => viewEntityById(
          context: context,
          entityId: state.documentListState.filterEntityId,
          entityType: state.documentListState.filterEntityType),
      onDocumentTap: (context, document) => viewEntityById(
          context: context,
          entityId: document.id,
          entityType: EntityType.document),
      onEntityAction: (BuildContext context, List<BaseEntity> documents,
              EntityAction action) =>
          handleDocumentAction(context, documents, action),
      onRefreshed: (context) => _handleRefresh(context),
      onSortColumn: (field) => store.dispatch(SortDocuments(field)),
    );
  }

  final AppState state;
  final List<String> documentList;
  final BuiltMap<String, DocumentEntity> documentMap;
  final ListUIState listState;
  final String filter;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, DocumentEntity) onDocumentTap;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, List<DocumentEntity>, EntityAction)
      onEntityAction;
  final Function onClearEntityFilterPressed;
  final Function(BuildContext) onViewEntityFilterPressed;
  final Function(String) onSortColumn;
}
