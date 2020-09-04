import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
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
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final listUIState = state.uiState.companyGatewayUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final localization = AppLocalization.of(context);
    final settings = viewModel.settings;

    return Column(
      children: <Widget>[
        FormCard(children: [
          BoolDropdownButton(
            label: localization.allowOverPayment,
            value: settings.clientPortalAllowOverPayment,
            helpLabel: localization.allowOverPaymentHelp,
            onChanged: (value) => viewModel.onSettingsChanged(settings
                .rebuild((b) => b..clientPortalAllowOverPayment = value)),
          ),
          BoolDropdownButton(
            label: localization.allowUnderPayment,
            value: settings.clientPortalAllowUnderPayment,
            helpLabel: localization.allowUnderPaymentHelp,
            onChanged: (value) => viewModel.onSettingsChanged(settings
                .rebuild((b) => b..clientPortalAllowUnderPayment = value)),
          ),
        ]),
        Flexible(
          fit: FlexFit.tight,
          child: !viewModel.state.isLoaded &&
                  viewModel.companyGatewayList.isEmpty
              ? LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () => viewModel.onRefreshed(context),
                  child: viewModel.companyGatewayList.isEmpty
                      ? HelpText(AppLocalization.of(context).noRecordsFound)
                      : ReorderableListView(
                          onReorder: (oldIndex, newIndex) {
                            // https://stackoverflow.com/a/54164333/497368
                            // These two lines are workarounds for ReorderableListView problems
                            if (newIndex >
                                viewModel.companyGatewayList.length) {
                              newIndex = viewModel.companyGatewayList.length;
                            }
                            if (oldIndex < newIndex) {
                              newIndex--;
                            }

                            viewModel.onSortChanged(oldIndex, newIndex);
                          },
                          children: viewModel.companyGatewayList
                              .map((companyGatewayId) {
                            final companyGateway =
                                viewModel.companyGatewayMap[companyGatewayId];
                            return CompanyGatewayListItem(
                                key: ValueKey(
                                    '__company_gateway_$companyGatewayId'),
                                user: state.userCompany.user,
                                filter: viewModel.filter,
                                companyGateway: companyGateway,
                                onRemovePressed:
                                    viewModel.state.settingsUIState.isFiltered
                                        ? () => viewModel
                                            .onRemovePressed(companyGatewayId)
                                        : null,
                                isChecked: isInMultiselect &&
                                    listUIState.isSelected(companyGateway.id));
                          }).toList(),
                        ),
                ),
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}
