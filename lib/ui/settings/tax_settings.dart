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
    final company = viewModel.company;
    final settings = viewModel.settings;
    final state = viewModel.state;

    return SettingsScaffold(
      title: localization.taxSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              BoolDropdownButton(
                iconData: FontAwesomeIcons.fileInvoice,
                label: localization.invoiceTax,
                value: settings.enableInvoiceTaxes,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..enableInvoiceTaxes = value)),
              ),
              BoolDropdownButton(
                iconData: FontAwesomeIcons.cubes,
                label: localization.lineItemTax,
                value: settings.enableInvoiceItemTaxes,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..enableInvoiceItemTaxes = value)),
              ),
              BoolDropdownButton(
                iconData: FontAwesomeIcons.percent,
                label: localization.inclusiveTaxes,
                value: settings.enableInclusiveTaxes,
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..enableInclusiveTaxes = value)),
              ),
            ],
          ),
          FormCard(
            children: <Widget>[
              AppDropdownButton(
                labelText: localization.numberOfRates,
                // TODO remove this
                showBlank: true,
                value: settings.numberOfRates == null
                    ? ''
                    : '${settings.numberOfRates}',
                onChanged: (value) => viewModel.onSettingsChanged(settings
                    .rebuild((b) => b..numberOfRates = int.parse(value))),
                items: List<int>.generate(3, (i) => i + 1)
                    .map((value) => DropdownMenuItem<String>(
                          child: Text('$value'),
                          value: '$value',
                        ))
                    .toList(),
              ),
              if (settings.enableInvoiceTaxes) ...[
                TaxRateDropdown(
                  taxRates: company.taxRates,
                  onSelected: (taxRate) =>
                      viewModel.onSettingsChanged(settings.rebuild((b) => b
                        ..defaultTaxName1 = taxRate.name
                        ..defaultTaxRate1 = taxRate.rate)),
                  labelText: localization.tax,
                  initialTaxName: settings.defaultTaxName1,
                  initialTaxRate: settings.defaultTaxRate1,
                ),
                // TODO get null value from company
                if ((settings.numberOfRates ?? 0) > 1)
                  TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) =>
                        viewModel.onSettingsChanged(settings.rebuild((b) => b
                          ..defaultTaxName2 = taxRate.name
                          ..defaultTaxRate2 = taxRate.rate)),
                    labelText: localization.tax,
                    initialTaxName: settings.defaultTaxName2,
                    initialTaxRate: settings.defaultTaxRate2,
                  ),
                // TODO get null value from company 
                if ((settings.numberOfRates ?? 0) > 2)
                  TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) =>
                        viewModel.onSettingsChanged(settings.rebuild((b) => b
                          ..defaultTaxName3 = taxRate.name
                          ..defaultTaxRate3 = taxRate.rate)),
                    labelText: localization.tax,
                    initialTaxName: settings.defaultTaxName3,
                    initialTaxRate: settings.defaultTaxRate3,
                  ),
              ],
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
