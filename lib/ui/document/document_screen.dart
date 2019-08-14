import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/document/document_list_vm.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';

class DocumentScreen extends StatelessWidget {
  static const String route = '/document';

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.selectedCompany;
    final user = company.user;
    final localization = AppLocalization.of(context);

    return WillPopScope(
      onWillPop: () async {
        store.dispatch(ViewDashboard(context: context));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListFilter(
            key: ValueKey(state.documentListState.filterClearedAt),
            entityType: EntityType.document,
            onFilterChanged: (value) {
              store.dispatch(FilterDocuments(value));
            },
          ),
          actions: [
            ListFilterButton(
              entityType: EntityType.document,
              onFilterPressed: (String value) {
                store.dispatch(FilterDocuments(value));
              },
            ),
          ],
        ),
        drawer: AppDrawerBuilder(),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: user.canCreate(EntityType.document)
            ? FloatingActionButton(
                //key: Key(DocumentKeys.documentScreenFABKeyString),
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () {
                  store.dispatch(EditDocument(
                      document: DocumentEntity(), context: context));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: localization.newDocument,
              )
            : null,
      ),
    );
  }
}
