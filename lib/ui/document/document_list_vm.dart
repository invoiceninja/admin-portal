// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/document/document_presenter.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_list.dart';
import 'package:invoiceninja_flutter/ui/document/document_list_item.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DocumentListBuilder extends StatelessWidget {
  const DocumentListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DocumentListVM>(
      converter: DocumentListVM.fromStore,
      builder: (context, viewModel) {
        final localization = AppLocalization.of(context);

        // TODO remove this widget
        if (viewModel.state.documentState.list.isEmpty) {
          return Center(
            child: OutlinedButton(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(localization!.refreshData),
              ),
              onPressed: () => viewModel.onRefreshed(context, true),
            ),
          );
        }

        return EntityList(
            onClearMultiselect: viewModel.onClearMultielsect,
            entityType: EntityType.document,
            state: viewModel.state,
            entityList: viewModel.documentList,
            presenter: DocumentPresenter(),
            tableColumns: viewModel.tableColumns,
            onRefreshed: (context) => viewModel.onRefreshed(context, false),
            onSortColumn: viewModel.onSortColumn,
            itemBuilder: (BuildContext context, index) {
              final state = viewModel.state;
              final documentId = viewModel.documentList[index];
              final document = viewModel.documentMap[documentId]!;
              final listState = state.getListState(EntityType.document);
              final isInMultiselect = listState.isInMultiselect();

              return DocumentListItem(
                userCompany: state.userCompany,
                filter: viewModel.filter,
                document: document,
                isChecked: isInMultiselect && listState.isSelected(document.id),
              );
            });
      },
    );
  }
}

class DocumentListVM {
  DocumentListVM({
    required this.state,
    required this.documentList,
    required this.documentMap,
    required this.filter,
    required this.isLoading,
    required this.listState,
    required this.onRefreshed,
    required this.onEntityAction,
    required this.onSortColumn,
    required this.onClearMultielsect,
    required this.tableColumns,
  });

  static DocumentListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context, bool clearData) {
      if (store.state.isLoading) {
        return Future<Null>.value();
      }
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(RefreshData(completer: completer, clearData: clearData));
      return completer.future;
    }

    final state = store.state;

    return DocumentListVM(
      state: state,
      listState: state.documentListState,
      documentList: memoizedFilteredDocumentList(
        state.getUISelection(EntityType.document),
        state.documentState.map,
        state.documentState.list,
        state.documentListState,
      ),
      documentMap: state.documentState.map,
      isLoading: state.isLoading,
      filter: state.documentUIState.listUIState.filter,
      onEntityAction: (BuildContext context, List<BaseEntity> documents,
              EntityAction action) =>
          handleDocumentAction(context, documents, action),
      onRefreshed: (context, clearData) => _handleRefresh(context, clearData),
      onSortColumn: (field) => store.dispatch(SortDocuments(field)),
      onClearMultielsect: () => store.dispatch(ClearDocumentMultiselect()),
      tableColumns:
          state.userCompany.settings.getTableColumns(EntityType.document) ??
              DocumentPresenter.getDefaultTableFields(state.userCompany),
    );
  }

  final AppState state;
  final List<String> documentList;
  final BuiltMap<String, DocumentEntity> documentMap;
  final ListUIState listState;
  final List<String> tableColumns;
  final String? filter;
  final bool isLoading;
  final Function(BuildContext, bool) onRefreshed;
  final Function(BuildContext, List<DocumentEntity>, EntityAction)
      onEntityAction;
  final Function(String) onSortColumn;
  final Function onClearMultielsect;
}
