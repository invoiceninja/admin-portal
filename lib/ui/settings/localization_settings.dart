import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/settings/localization_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class LocalizationSettings extends StatefulWidget {
  const LocalizationSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final LocalizationSettingsVM viewModel;

  @override
  _LocalizationSettingsState createState() => _LocalizationSettingsState();
}

class _LocalizationSettingsState extends State<LocalizationSettings> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  final _firstNameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [_firstNameController];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    /*
    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
      */

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;
    final company = viewModel.company;

    return SettingsScaffold(
      title: localization.localization,
      onSavePressed: viewModel.onSavePressed,
      onCancelPressed: viewModel.onCancelPressed,
      body: AppForm(
        formKey: _formKey,
        children: <Widget>[
          EntityDropdown(
            allowClearing: state.settingsUIState.isFiltered,
            key: ValueKey('__currency_${settings.currencyId}'),
            entityType: EntityType.currency,
            entityMap: state.staticState.currencyMap,
            entityList: memoizedCurrencyList(state.staticState.currencyMap),
            labelText: localization.currency,
            initialValue:
                state.staticState.currencyMap[settings.currencyId]?.name,
            onSelected: (SelectableEntity currency) =>
                viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..currencyId = currency?.id)),
          ),
          BoolDropdownButton(
            value: settings.showCurrencyCode,
            label: localization.currencyFormat,
            onChanged: (value) => viewModel.onSettingsChanged(settings
                .rebuild((b) => b..showCurrencyCode = value)),
            showBlank: state.settingsUIState.isFiltered,
            enabledLabel: '${localization.code}: ' +
                formatNumber(1000, context,
                    showCurrencyCode: true,
                    currencyId: settings.currencyId),
            disabledLabel: '${localization.symbol}: ' +
                formatNumber(1000, context,
                    showCurrencyCode: false,
                    currencyId: settings.currencyId),
          ),
          EntityDropdown(
            allowClearing: state.settingsUIState.isFiltered,
            key: ValueKey('__language_${settings.languageId}'),
            entityType: EntityType.language,
            entityMap: state.staticState.languageMap,
            entityList: memoizedLanguageList(state.staticState.languageMap),
            labelText: localization.language,
            initialValue:
                state.staticState.languageMap[settings.languageId]?.name,
            onSelected: (SelectableEntity language) =>
                viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..languageId = language?.id)),
          ),
          EntityDropdown(
            allowClearing: state.settingsUIState.isFiltered,
            key: ValueKey('__timezone_${settings.timezoneId}'),
            entityType: EntityType.timezone,
            entityMap: state.staticState.timezoneMap,
            entityList: memoizedTimezoneList(state.staticState.timezoneMap),
            labelText: localization.timezone,
            initialValue:
                state.staticState.timezoneMap[settings.timezoneId]?.name,
            onSelected: (SelectableEntity timezone) =>
                viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..timezoneId = timezone?.id)),
          ),
          EntityDropdown(
            allowClearing: state.settingsUIState.isFiltered,
            key: ValueKey('__date_format_${settings.dateFormatId}'),
            entityType: EntityType.dateFormat,
            entityMap: state.staticState.dateFormatMap,
            entityList: memoizedDateFormatList(state.staticState.dateFormatMap),
            labelText: localization.dateFormat,
            initialValue:
                state.staticState.dateFormatMap[settings.dateFormatId]?.preview,
            onSelected: (SelectableEntity dateFormat) =>
                viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..dateFormatId = dateFormat?.id)),
          ),
          BoolDropdownButton(
            label: localization.militaryTime,
            showBlank: state.settingsUIState.isFiltered,
            value: settings.enableMilitaryTime,
            onChanged: (value) => viewModel.onSettingsChanged(
                settings.rebuild((b) => b..enableMilitaryTime = value)),
          ),
          if (!state.settingsUIState.isFiltered)
            InputDecorator(
              decoration: InputDecoration(
                labelText: localization.firstDayOfTheWeek,
              ),
              isEmpty: company.startOfWeek == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                    value: company.startOfWeek,
                    isExpanded: true,
                    isDense: true,
                    onChanged: (value) => viewModel.onCompanyChanged(
                        company.rebuild((b) => b..startOfWeek = value)),
                    items: kDaysOfTheWeek
                        .map((id, day) => MapEntry<int, DropdownMenuItem<int>>(
                            id,
                            DropdownMenuItem<int>(
                              child: Text(localization.lookup(day)),
                              value: id,
                            )))
                        .values
                        .toList()),
              ),
            ),
          if (!state.settingsUIState.isFiltered)
            InputDecorator(
              decoration: InputDecoration(
                labelText: localization.firstMonthOfTheYear,
              ),
              isEmpty: company.financialYearStart == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                    value: company.financialYearStart,
                    isExpanded: true,
                    isDense: true,
                    onChanged: (value) => viewModel.onCompanyChanged(
                        company.rebuild((b) => b..financialYearStart = value)),
                    items: kMonthsOfTheYear
                        .map(
                            (id, month) => MapEntry<int, DropdownMenuItem<int>>(
                                id,
                                DropdownMenuItem<int>(
                                  child: Text(localization.lookup(month)),
                                  value: id,
                                )))
                        .values
                        .toList()),
              ),
            ),
        ],
      ),
    );
  }
}
