import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_item.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_vm.dart';

class CompanyGatewayList extends StatelessWidget {
  const CompanyGatewayList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayListVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final listUIState = state.uiState.companyGatewayUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    return !viewModel.state.isLoaded && viewModel.companyGatewayList.isEmpty
        ? LoadingIndicator()
        : RefreshIndicator(
            onRefresh: () => viewModel.onRefreshed(context),
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                // https://stackoverflow.com/a/54164333/497368
                // These two lines are workarounds for ReorderableListView problems
                if (newIndex > viewModel.companyGatewayList.length) {
                  newIndex = viewModel.companyGatewayList.length;
                }
                if (oldIndex < newIndex) {
                  newIndex--;
                }

                viewModel.onSortChanged(oldIndex, newIndex);
              },
              children: viewModel.companyGatewayList.map((companyGatewayId) {
                final companyGateway =
                    viewModel.companyGatewayMap[companyGatewayId];
                return CompanyGatewayListItem(
                    key: ValueKey('__company_gateway_$companyGatewayId'),
                    user: state.userCompany.user,
                    filter: viewModel.filter,
                    companyGateway: companyGateway,
                    onRemovePressed: viewModel.state.settingsUIState.isFiltered
                        ? () => viewModel.onRemovePressed(companyGatewayId)
                        : null,
                    isChecked: isInMultiselect &&
                        listUIState.isSelected(companyGateway.id));
              }).toList(),
            ),
          );
  }
}
