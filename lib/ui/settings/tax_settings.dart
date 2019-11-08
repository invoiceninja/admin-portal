import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/tax_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaxSettings extends StatefulWidget {
  const TaxSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaxSettingsVM viewModel;

  @override
  _TaxSettingsState createState() => _TaxSettingsState();
}

class _TaxSettingsState extends State<TaxSettings> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;
    final state = viewModel.state;

    return SettingsScaffold(
      title: localization.taxSettings,
      onSavePressed: viewModel.onSavePressed,
      onCancelPressed: viewModel.onCancelPressed,
      body: AppForm(
        formKey: _formKey,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              NumberOfRatesSelector(
                label: localization.invoiceTaxRates,
                numberOfRates: settings.numberOfInvoiceTaxRates,
                onChanged: (value) => viewModel.onSettingsChanged(settings
                    .rebuild((b) => b..numberOfInvoiceTaxRates = value)),
              ),
              NumberOfRatesSelector(
                label: localization.itemTaxRates,
                numberOfRates: settings.numberOfItemTaxRates,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..numberOfItemTaxRates = value)),
              ),
              SizedBox(height: 15),
              BoolDropdownButton(
                iconData: FontAwesomeIcons.percent,
                label: localization.inclusiveTaxes,
                value: settings.enableInclusiveTaxes,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..enableInclusiveTaxes = value)),
              ),
            ],
          ),
          if (settings.enableFirstInvoiceTaxRate &&
              state.taxRateState.list.isNotEmpty)
            FormCard(
              children: <Widget>[
                TaxRateDropdown(
                  onSelected: (taxRate) =>
                      viewModel.onSettingsChanged(settings.rebuild((b) => b
                        ..defaultTaxName1 = taxRate.name
                        ..defaultTaxRate1 = taxRate.rate)),
                  labelText: localization.defaultTaxRate,
                  initialTaxName: settings.defaultTaxName1,
                  initialTaxRate: settings.defaultTaxRate1,
                ),
                if (settings.enableSecondInvoiceTaxRate)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onSettingsChanged(settings.rebuild((b) => b
                          ..defaultTaxName2 = taxRate.name
                          ..defaultTaxRate2 = taxRate.rate)),
                    labelText: localization.defaultTaxRate,
                    initialTaxName: settings.defaultTaxName2,
                    initialTaxRate: settings.defaultTaxRate2,
                  ),
                if (settings.enableThirdInvoiceTaxRate)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onSettingsChanged(settings.rebuild((b) => b
                          ..defaultTaxName3 = taxRate.name
                          ..defaultTaxRate3 = taxRate.rate)),
                    labelText: localization.defaultTaxRate,
                    initialTaxName: settings.defaultTaxName3,
                    initialTaxRate: settings.defaultTaxRate3,
                  ),
              ],
            ),
          if (!state.uiState.settingsUIState.isFiltered)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                label: localization.configureRates.toUpperCase(),
                onPressed: () => viewModel.onConfigureRatesPressed(context),
              ),
            ),
        ],
      ),
    );
  }
}

class NumberOfRatesSelector extends StatelessWidget {
  const NumberOfRatesSelector({
    @required this.label,
    @required this.numberOfRates,
    @required this.onChanged,
  });

  final String label;
  final int numberOfRates;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AppDropdownButton(
      labelText: label,
      value: numberOfRates == null ? '' : '$numberOfRates',
      onChanged: (value) =>
          onChanged(value == null || value.isEmpty ? null : int.parse(value)),
      items: [
        DropdownMenuItem(
          child: Text(localization.disabled),
          value: '0',
        ),
        DropdownMenuItem(
          child: Text(localization.oneTaxRate),
          value: '1',
        ),
        DropdownMenuItem(
          child: Text(localization.twoTaxRates),
          value: '2',
        ),
        DropdownMenuItem(
          child: Text(localization.threeTaxRates),
          value: '3',
        ),
      ],
    );
  }
}
