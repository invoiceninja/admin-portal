import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/app/app_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/document/document_list_vm.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class DocumentScreen extends StatelessWidget {
  static const String route = '/document';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final userCompany = state.userCompany;
    final localization = AppLocalization.of(context);

    return AppScaffold(
      appBarTitle: ListFilter(
        key: ValueKey(state.documentListState.filterClearedAt),
        entityType: EntityType.document,
        onFilterChanged: (value) {
          store.dispatch(FilterDocuments(value));
        },
      ),
      appBarActions: [
        ListFilterButton(
          entityType: EntityType.document,
          onFilterPressed: (String value) {
            store.dispatch(FilterDocuments(value));
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
