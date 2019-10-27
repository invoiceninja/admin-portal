import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
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

    return AppScaffold(
      isChecked: isInMultiselect &&
          listUIState.selectedIds.length == viewModel.documentList.length,
      showCheckbox: isInMultiselect,
      onCheckboxChanged: (value) {
        final documents = viewModel.documentList
            .map<DocumentEntity>(
                (documentId) => viewModel.documentMap[documentId])
            .where((document) => value != listUIState.isSelected(document.id))
            .toList();

        viewModel.onEntityAction(
            context, documents, EntityAction.toggleMultiselect);
      },
      appBarTitle: ListFilter(
        key: ValueKey(state.documentListState.filterClearedAt),
        entityType: EntityType.document,
        onFilterChanged: (value) {
          store.dispatch(FilterDocuments(value));
        },
      ),
      appBarActions: [
        if (!viewModel.isInMultiselect)
          ListFilterButton(
            entityType: EntityType.document,
            onFilterPressed: (String value) {
              store.dispatch(FilterDocuments(value));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            child: Text(
              localization.cancel,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              store.dispatch(ClearDocumentMultiselect(context: context));
            },
          ),
        if (viewModel.isInMultiselect)
          FlatButton(
            key: key,
            textColor: Colors.white,
            disabledTextColor: Colors.white54,
            child: Text(
              localization.done,
            ),
            onPressed: state.documentListState.selectedIds.isEmpty
                ? null
                : () async {
                    final documents = viewModel.documentList
                        .map<DocumentEntity>(
                            (documentId) => viewModel.documentMap[documentId])
                        .toList();

                    await showEntityActionsDialog(
                        entities: documents,
                        userCompany: userCompany,
                        context: context,
                        onEntityAction: viewModel.onEntityAction,
                        multiselect: true);
                    store.dispatch(ClearDocumentMultiselect(context: context));
                  },
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
        sortFields: [
          DocumentFields.updatedAt,
        ],
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterDocumentsByState(state));
        },
      ),
      floatingActionButton: userCompany.canCreate(EntityType.document)
          ? FloatingActionButton(
              heroTag: 'document_fab',
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () {
                store.dispatch(
                    EditDocument(document: DocumentEntity(), context: context));
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
