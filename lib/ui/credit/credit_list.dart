import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_list_item.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_list_vm.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/ui/app/tables/entity_datatable.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class CreditList extends StatefulWidget {
  const CreditList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CreditListVM viewModel;

  @override
  _CreditListState createState() => _CreditListState();
}

class _CreditListState extends State<CreditList> {
  EntityDataTableSource dataTableSource;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    dataTableSource = EntityDataTableSource(
        context: context,
        entityType: EntityType.credit,
        editingId: viewModel.state.creditUIState.editing.id,
        tableColumns: viewModel.tableColumns,
        entityList: viewModel.creditList,
        entityMap: viewModel.creditMap,
        entityPresenter: CreditPresenter(),
        onTap: (BaseEntity credit) => viewModel.onCreditTap(context, credit));
  }

  @override
  void didUpdateWidget(CreditList oldWidget) {
    super.didUpdateWidget(oldWidget);

    final viewModel = widget.viewModel;
    dataTableSource.editingId = viewModel.state.creditUIState.editing.id;
    dataTableSource.entityList = viewModel.creditList;
    dataTableSource.entityMap = viewModel.creditMap;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    dataTableSource.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    /*
    final localization = AppLocalization.of(context);
    final listState = viewModel.listState;
    final filteredClientId = listState.filterEntityId;
    final filteredClient =
        filteredClientId != null ? viewModel.clientMap[filteredClientId] : null;
    */
    final store = StoreProvider.of<AppState>(context);
    final listUIState = store.state.uiState.creditUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final creditList = viewModel.creditList;

    if (isNotMobile(context) &&
        creditList.isNotEmpty &&
        !state.uiState.isEditing &&
        !creditList.contains(state.creditUIState.selectedId)) {
      viewEntityById(
          context: context,
          entityType: EntityType.credit,
          entityId: creditList.first);
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: !viewModel.isLoaded
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.creditList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.creditList.length,
                          itemBuilder: (BuildContext context, index) {
                            final creditId = viewModel.creditList[index];
                            final credit = viewModel.creditMap[creditId];
                            final userCompany = viewModel.userCompany;

                            void showDialog() => showEntityActionsDialog(
                                userCompany: userCompany,
                                entity: credit,
                                context: context,
                                onEntityAction: viewModel.onEntityAction);

                            return CreditListItem(
                              user: viewModel.userCompany.user,
                              filter: viewModel.filter,
                              credit: credit,
                              onTap: () =>
                                  viewModel.onCreditTap(context, credit),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  viewModel.onEntityAction(
                                      context, credit, action);
                                }
                              },
                              onLongPress: () => showDialog(),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
