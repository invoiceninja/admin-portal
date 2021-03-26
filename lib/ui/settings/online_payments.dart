import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/settings_model.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/online_payments_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class OnlinePayments extends StatefulWidget {
  const OnlinePayments({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final OnlinePaymentsVM viewModel;

  @override
  _OnlinePaymentsState createState() => _OnlinePaymentsState();
}

class _OnlinePaymentsState extends State<OnlinePayments> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_onlinePayments');
  FocusScopeNode _focusNode;
  final _minimumAmountController = TextEditingController();
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

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

    return EditScaffold(
      title: localization.onlinePayments,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(children: <Widget>[
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
            AppDropdownButton<String>(
                labelText: localization.useAvailableCredits,
                value: settings.useCreditsPayment,
                onChanged: (dynamic value) {
                  viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..useCreditsPayment = value));
                },
                items: [
                  DropdownMenuItem(
                    child: Text(localization.always),
                    value: CompanyEntity.USE_CREDITS_ALWAYS,
                  ),
                  DropdownMenuItem(
                    child: Text(localization.showOption),
                    value: CompanyEntity.USE_CREDITS_OPTION,
                  ),
                  DropdownMenuItem(
                    child: Text(localization.off),
                    value: CompanyEntity.USE_CREDITS_OFF,
                  ),
                ]),
            SizedBox(height: 16),
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
            if (settings.clientPortalAllowUnderPayment == true)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: DecoratedFormField(
                  label: localization.minimumUnderPaymentAmount,
                  controller: _minimumAmountController,
                  isMoney: true,
                ),
              ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
              iconData: Icons.settings,
              label: localization.configureGateways.toUpperCase(),
              onPressed: () => viewModel.onConfigureGatewaysPressed(context),
            ),
          ),
        ],
      ),
    );
  }
}
