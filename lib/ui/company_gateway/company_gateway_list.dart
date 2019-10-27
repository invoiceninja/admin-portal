import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_item.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyGatewayList extends StatelessWidget {
  const CompanyGatewayList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayListVM viewModel;

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
    final listUIState = store.state.uiState.companyGatewayUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return Column(
      children: <Widget>[
        Expanded(
          child: !viewModel.isLoaded
              ? (viewModel.isLoading ? LoadingIndicator() : SizedBox())
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.companyGatewayList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.companyGatewayList.length,
                          itemBuilder: (BuildContext context, index) {
                            final companyGatewayId =
                                viewModel.companyGatewayList[index];
                            final companyGateway =
                                viewModel.companyGatewayMap[companyGatewayId];
                            final userCompany = viewModel.userCompany;

                            void showDialog() => showEntityActionsDialog(
                                userCompany: userCompany,
                                entities: [companyGateway],
                                context: context,
                                onEntityAction: viewModel.onEntityAction);

                            return CompanyGatewayListItem(
                              user: viewModel.userCompany.user,
                              filter: viewModel.filter,
                              companyGateway: companyGateway,
                              onTap: () => viewModel.onCompanyGatewayTap(
                                  context, companyGateway),
                              onEntityAction: (EntityAction action) {
                                if (action == EntityAction.more) {
                                  showDialog();
                                } else {
                                  viewModel.onEntityAction(
                                      context, [companyGateway], action);
                                }
                              },
                              onLongPress: () async {
                                final longPressIsSelection = store.state.uiState
                                        .longPressSelectionIsDefault ??
                                    true;
                                if (longPressIsSelection && !isInMultiselect) {
                                  viewModel.onEntityAction(
                                      context,
                                      [companyGateway],
                                      EntityAction.toggleMultiselect);
                                } else {
                                  showDialog();
                                }
                              },
                              isChecked: isInMultiselect &&
                                  listUIState.isSelected(companyGateway.id),
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
                  child: viewModel.companyGatewayList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => ListDivider(),
                          itemCount: viewModel.companyGatewayList.length,
                          itemBuilder: (BuildContext context, index) {
                            final user = viewModel.user;
                            final companyGatewayId = viewModel.companyGatewayList[index];
                            final companyGateway = viewModel.companyGatewayMap[companyGatewayId];
                            final client =
                                viewModel.clientMap[companyGateway.clientId] ??
                                    ClientEntity();


                              void showDialog() => showEntityActionsDialog(
                                  entity: companyGateway,
                                  context: context,
                                  user: user,
                                  onEntityAction: viewModel.onEntityAction);



                            return CompanyGatewayListItem(
                                 user: viewModel.user,
                                 filter: viewModel.filter,
                                 companyGateway: companyGateway,
                                 client:
                                     viewModel.clientMap[companyGateway.clientId] ??
                                         ClientEntity(),
                                 onTap: () =>
                                     viewModel.onCompanyGatewayTap(context, companyGateway),
                                 onEntityAction: (EntityAction action) {
                                   if (action == EntityAction.more) {
                                     showDialog();
                                   } else {
                                     viewModel.onEntityAction(
                                         context, companyGateway, action);
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
