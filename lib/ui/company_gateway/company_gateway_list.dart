import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_item.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _OnlinePaymentForm(
          viewModel: viewModel,
          key: ValueKey('__settings_${state.settingsUIState.updatedAt}__'),
        ),
        !viewModel.state.isLoaded && viewModel.companyGatewayList.isEmpty
            ? LoadingIndicator()
            : RefreshIndicator(
                onRefresh: () => viewModel.onRefreshed(context),
                child: viewModel.companyGatewayList.isEmpty
                    ? HelpText(AppLocalization.of(context).noRecordsFound)
                    : SizedBox(
                        height:
                            (viewModel.companyGatewayList.length * 80.0) + 100,
                        child: ReorderableListView(
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
      ],
    );
  }
}

class _OnlinePaymentForm extends StatefulWidget {
  const _OnlinePaymentForm({Key key, @required this.viewModel})
      : super(key: key);

  final CompanyGatewayListVM viewModel;

  @override
  __OnlinePaymentFormState createState() => __OnlinePaymentFormState();
}

class __OnlinePaymentFormState extends State<_OnlinePaymentForm> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_companyGatewayList');
  final FocusScopeNode _focusNode = FocusScopeNode();
  bool _autoValidate = false;

  final _minimumAmountController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _minimumAmountController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _minimumAmountController.text = formatNumber(
        widget.viewModel.settings.clientPortalUnderPaymentMinimum, context,
        formatNumberType: FormatNumberType.inputMoney);

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    _focusNode.dispose();

    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final settings = viewModel.settings.rebuild((b) => b
      ..clientPortalUnderPaymentMinimum =
          parseDouble(_minimumAmountController.text));
    if (settings != viewModel.settings) {
      viewModel.onSettingsChanged(settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;

    return AppForm(
      formKey: _formKey,
      focusNode: _focusNode,
      child: FormCard(children: [
        AppDropdownButton<String>(
          labelText: localization.autoBillOn,
          value: settings.autoBillDate,
          onChanged: (dynamic value) => viewModel.onSettingsChanged(
              settings.rebuild((b) => b..autoBillDate = value)),
          items: [
            DropdownMenuItem(
              child: Text(localization.sendDate),
              value: SettingsEntity.AUTO_BILL_ON_SEND_DATE,
            ),
            DropdownMenuItem(
              child: Text(localization.dueDate),
              value: SettingsEntity.AUTO_BILL_ON_DUE_DATE,
            ),
          ],
        ),
        SizedBox(height: 16),
        BoolDropdownButton(
          label: localization.allowOverPayment,
          value: settings.clientPortalAllowOverPayment,
          helpLabel: localization.allowOverPaymentHelp,
          onChanged: (value) => viewModel.onSettingsChanged(
              settings.rebuild((b) => b..clientPortalAllowOverPayment = value)),
        ),
        BoolDropdownButton(
          label: localization.allowUnderPayment,
          value: settings.clientPortalAllowUnderPayment,
          helpLabel: localization.allowUnderPaymentHelp,
          onChanged: (value) => viewModel.onSettingsChanged(settings
              .rebuild((b) => b..clientPortalAllowUnderPayment = value)),
        ),
        if (settings.clientPortalAllowUnderPayment == true)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: DecoratedFormField(
              label: localization.minimumUnderPaymentAmount,
              controller: _minimumAmountController,
            ),
          ),
      ]),
    );
  }
}
