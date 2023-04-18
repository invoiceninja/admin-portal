// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
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
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_taxSettings');
  FocusScopeNode _focusNode;
  final Map<String, bool> _showDetails = {
    kTaxRegionUnitedStates: false,
    kTaxRegionEurope: false,
    kTaxRegionAustralia: false,
  };

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;
    final company = viewModel.company;
    final state = viewModel.state;
    final taxData = company.taxData;

    final countryMap = memoizedCountryIso2Map(state.staticState.countryMap);
    List<String> subregions = [];
    String region = kTaxRegionEurope;
    if (company.settings.countryId == kCountryUnitedStates) {
      region = kTaxRegionUnitedStates;
    } else if (company.settings.countryId == kCountryAustralia) {
      region = kTaxRegionAustralia;
    }
    subregions = taxData.regions[region].subregions.keys.toList();

    return EditScaffold(
      title: localization.taxSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          if (!state.settingsUIState.isFiltered)
            FormCard(
              children: <Widget>[
                NumberOfRatesSelector(
                  label: localization.invoiceTaxRates,
                  numberOfRates: company.numberOfInvoiceTaxRates,
                  onChanged: (value) => viewModel.onCompanyChanged(company
                      .rebuild((b) => b..numberOfInvoiceTaxRates = value)),
                ),
                NumberOfRatesSelector(
                  label: localization.invoiceItemTaxRates,
                  numberOfRates: company.numberOfItemTaxRates,
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..numberOfItemTaxRates = value)),
                ),
                NumberOfRatesSelector(
                  label: localization.expenseTaxRates,
                  numberOfRates: company.numberOfExpenseTaxRates,
                  onChanged: (value) => viewModel.onCompanyChanged(company
                      .rebuild((b) => b..numberOfExpenseTaxRates = value)),
                ),
                SizedBox(height: 16),
                BoolDropdownButton(
                  iconData: MdiIcons.percent,
                  label: localization.inclusiveTaxes,
                  value: settings.enableInclusiveTaxes,
                  onChanged: (value) => viewModel.onSettingsChanged(
                      settings.rebuild((b) => b..enableInclusiveTaxes = value)),
                  helpLabel:
                      '\n${localization.exclusive}: 100 + 10% = 100 + 10\n${localization.inclusive}: 100 + 10% = 90.91 + 9.09',
                ),
              ],
            ),
          if (state.taxRateState.list.isNotEmpty)
            FormCard(
              children: <Widget>[
                if (company.enableFirstInvoiceTaxRate)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onSettingsChanged(settings.rebuild((b) => b
                          ..defaultTaxName1 = taxRate.name
                          ..defaultTaxRate1 = taxRate.rate)),
                    labelText: localization.defaultTaxRate,
                    initialTaxName: settings.defaultTaxName1,
                    initialTaxRate: settings.defaultTaxRate1,
                  ),
                if (company.enableSecondInvoiceTaxRate)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onSettingsChanged(settings.rebuild((b) => b
                          ..defaultTaxName2 = taxRate.name
                          ..defaultTaxRate2 = taxRate.rate)),
                    labelText: localization.defaultTaxRate,
                    initialTaxName: settings.defaultTaxName2,
                    initialTaxRate: settings.defaultTaxRate2,
                  ),
                if (company.enableThirdInvoiceTaxRate)
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppButton(
              iconData: Icons.settings,
              label: localization.configureRates.toUpperCase(),
              onPressed: () => viewModel.onConfigureRatesPressed(context),
            ),
          ),
          if (supportsLatestFeatures())
            FormCard(
              isLast: true,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoolDropdownButton(
                  iconData: MdiIcons.calculator,
                  label: localization.calculateTaxes,
                  value: company.calculateTaxes,
                  onChanged: (value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..calculateTaxes = value)),
                  helpLabel: localization.calculateTaxesHelp,
                ),
                if (company.calculateTaxes) ...[
                  /*
                DecoratedFormField(
                  keyboardType: TextInputType.text,
                  enabled: false,
                  label: localization.version,
                  initialValue: taxData.version,
                ),
                */
                  SizedBox(height: 16),
                  AppDropdownButton<String>(
                      labelText: localization.sellerSubregion,
                      value: taxData.sellerSubregion,
                      onChanged: (dynamic value) {
                        viewModel.onCompanyChanged(company.rebuild(
                            (b) => b..taxData.sellerSubregion = value));
                      },
                      items: subregions
                          .map((code) => DropdownMenuItem(
                              child: Text(region == kTaxRegionUnitedStates
                                  ? code
                                  : (countryMap[code]?.name ?? code)),
                              value: code))
                          .toList()),
                  SizedBox(height: 12),
                  ...taxData.regions.keys.map((region) {
                    final taxDataRegion = taxData.regions[region];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  child:
                                      Text(countryMap[region]?.name ?? region)),
                              Flexible(
                                child: AppDropdownButton<bool>(
                                    value: taxDataRegion.taxAll,
                                    onChanged: (dynamic value) {
                                      viewModel.onCompanyChanged(
                                          company.rebuild((b) => b
                                            ..taxData.regions[region] =
                                                taxDataRegion.rebuild(
                                                    (b) => b..taxAll = value)));
                                    },
                                    items: [
                                      DropdownMenuItem<bool>(
                                        child: ListTile(
                                          title: Text(localization.taxAll),
                                        ),
                                        value: true,
                                      ),
                                      DropdownMenuItem<bool>(
                                        child: ListTile(
                                          title: Text(localization.taxSelected),
                                          subtitle: Text(
                                              '${taxDataRegion.subregions.keys.where((element) => taxDataRegion.subregions[element].applyTax).length} ${localization.selected}'),
                                        ),
                                        value: false,
                                      ),
                                    ]),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(minWidth: 120),
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _showDetails[region] =
                                            !_showDetails[region];
                                      });
                                    },
                                    child: Text(_showDetails[region]
                                        ? localization.hideDetails
                                        : localization.showDetails)),
                              )
                            ],
                          ),
                        ),
                        if (_showDetails[region])
                          ...taxDataRegion.subregions.keys
                              .map((subregion) => Row(
                                    children: [
                                      Text(region == kTaxRegionUnitedStates
                                          ? subregion
                                          : (countryMap[subregion]?.name ??
                                              subregion)),
                                    ],
                                  ))
                              .toList(),
                      ],
                    );
                  }).toList(),
                ]
              ],
            )
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
      onChanged: (dynamic value) =>
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
