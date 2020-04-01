import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/ui/document/document_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'document_screen_vm.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  static const String route = '/document';

  final DocumentScreenVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);
    final listUIState = state.uiState.documentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return ListScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.documentList.length,
      showCheckbox: isInMultiselect,
      onHamburgerLongPress: () => store.dispatch(StartDocumentMultiselect()),
      onCheckboxChanged: (value) {
        final documents = viewModel.documentList
            .map<DocumentEntity>(
                (documentId) => viewModel.documentMap[documentId])
            .where((document) => value != listUIState.isSelected(document.id))
            .toList();

        handleDocumentAction(
            context, documents, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        title: localization.documents,
        key: ValueKey(state.documentListState.filterClearedAt),
        filter: state.documentListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterDocuments(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            filter: state.documentListState.filter,
            onFilterPressed: (String value) {
              store.dispatch(FilterDocuments(value));
            },
          ),
        if (viewModel.isInMultiselect)
          SaveCancelButtons(
            saveLabel: localization.done,
            onSavePressed: listUIState.selectedIds.isEmpty
                ? null
                : (context) async {
                    final documents = listUIState.selectedIds
                        .map<DocumentEntity>(
                            (documentId) => viewModel.documentMap[documentId])
                        .toList();

                    await showEntityActionsDialog(
                      entities: documents,
                      context: context,
                      multiselect: true,
                      completer: Completer<Null>()
                        ..future.then<dynamic>(
                            (_) => store.dispatch(ClearDocumentMultiselect())),
                    );
                  },
            onCancelPressed: (context) =>
                store.dispatch(ClearDocumentMultiselect()),
          ),
      ],
      body: DocumentListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.document,
        onSelectedSortField: (value) => store.dispatch(SortDocuments(value)),
        onSelectedCustom1: (value) =>
            store.dispatch(FilterDocumentsByCustom1(value)),
        onSelectedCustom2: (value) =>
            store.dispatch(FilterDocumentsByCustom2(value)),
        onSelectedCustom3: (value) =>
            store.dispatch(FilterDocumentsByCustom3(value)),
        onSelectedCustom4: (value) =>
            store.dispatch(FilterDocumentsByCustom4(value)),
        sortFields: [
          DocumentFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterDocumentsByState(state));
        },
        onCheckboxPressed: () {
          if (store.state.documentListState.isInMultiselect()) {
            store.dispatch(ClearDocumentMultiselect());
          } else {
            store.dispatch(StartDocumentMultiselect());
          }
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.document)
          ? FloatingActionButton(
              heroTag: 'document_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                createEntityByType(
                    context: context, entityType: EntityType.document);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              tooltip: localization.newDocument,
            )
          : null,
    );
  }
}
