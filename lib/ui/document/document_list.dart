import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/document/document_list_item.dart';
import 'package:invoiceninja_flutter/ui/document/document_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DocumentList extends StatelessWidget {
  const DocumentList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DocumentListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final userCompany = viewModel.state.userCompany;
    final listUIState = store.state.uiState.documentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    /*
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;
    final filteredClientId = listState.filterEntityId;
    final filteredClient =
        filteredClientId != null ? viewModel.clientMap[filteredClientId] : null;
    */

    return Column(
      children: <Widget>[
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.documentList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.documentList.length,
                          itemBuilder: (BuildContext context, index) {
                            final documentId = viewModel.documentList[index];
                            final document = viewModel.documentMap[documentId];

                            void showDialog() => showEntityActionsDialog(
                                  entities: [document],
                                  context: context,
                                );

                            return DocumentListItem(
                              userCompany: userCompany,
                              filter: viewModel.filter,
                              document: document,
                              onTap: () =>
                                  viewModel.onDocumentTap(context, document),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  viewModel.onEntityAction(
                                      context, [document], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection = store.state.uiState
                                        .longPressSelectionIsDefault ??
                                    true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  viewModel.onEntityAction(context, [document],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                              isChecked: isInMultiselect &&
                                  listUIState.isSelected(document.id),
                            );
                          },
                        ),
                ),
        ),

        /*
        filteredClient != null
            ? Material(
                color: Colors.orangeAccent,
                elevation: 6.0,
                child: InkWell(
                  onTap: () => viewModel.onViewEntityFilterPressed(context),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Text(
                          '${localization.filteredBy} ${filteredClient.listDisplayName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => viewModel.onClearEntityFilterPressed(),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.documentList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.documentList.length,
                          itemBuilder: (BuildContext context, index) {
                            final user = viewModel.user;
                            final documentId = viewModel.documentList[index];
                            final document = viewModel.documentMap[documentId];
                            final client =
                                viewModel.clientMap[document.clientId] ??
                                    ClientEntity();


                              void showDialog() => showEntityActionsDialog(
                                  entity: document,
                                  context: context,
                                  user: user,
                                  onEntityAction: viewModel.onEntityAction);



                            return DocumentListItem(
                                 user: viewModel.user,
                                 filter: viewModel.filter,
                                 document: document,
                                 client:
                                     viewModel.clientMap[document.clientId] ??
                                         ClientEntity(),
                                 onTap: () =>
                                     viewModel.onDocumentTap(context, document),
                                 onEntityAction: (EntityAction action) {
                                   if (action == EntityAction.more) {
                                     showDialog();
                                   } else {
                                     viewModel.onEntityAction(
                                         context, document, action);
                                   }
                                 },
                                 onLongPress: () =>
                                    showDialog(),
                               );
                          },
                        ),
                ),
        ),*/
      ],
    );
  }
}
