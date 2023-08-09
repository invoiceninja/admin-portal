// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/list_scaffold.dart';
import 'package:invoiceninja_flutter/ui/document/document_list_vm.dart';
import 'package:invoiceninja_flutter/ui/document/document_presenter.dart';
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

    return ListScaffold(
      entityType: EntityType.document,
      onHamburgerLongPress: () => store.dispatch(StartDocumentMultiselect()),
      appBarTitle: ListFilter(
        key: ValueKey('__filter_${state.documentListState.filterClearedAt}__'),
        entityType: EntityType.document,
        entityIds: viewModel.documentList,
        filter: state.documentListState.filter,
        onFilterChanged: (value) {
          store.dispatch(FilterDocuments(value));
        },
        onSelectedState: (EntityState state, value) {
          store.dispatch(FilterDocumentsByState(state));
        },
      ),
      onCheckboxPressed: () {
        if (store.state.documentListState.isInMultiselect()) {
          store.dispatch(ClearDocumentMultiselect());
        } else {
          store.dispatch(StartDocumentMultiselect());
        }
      },
      body: DocumentListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.document,
        tableColumns: DocumentPresenter.getAllTableFields(userCompany),
        defaultTableColumns:
            DocumentPresenter.getDefaultTableFields(userCompany),
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
      floatingActionButton: state.prefState.isMenuFloated &&
              userCompany.canCreate(EntityType.document)
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
