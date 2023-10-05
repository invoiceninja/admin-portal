// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/learn_more.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/localization_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class LocalizationSettings extends StatefulWidget {
  const LocalizationSettings({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final LocalizationSettingsVM viewModel;

  @override
  _LocalizationSettingsState createState() => _LocalizationSettingsState();
}

class _LocalizationSettingsState extends State<LocalizationSettings>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_localizationSettings');

  bool autoValidate = false;

  final _firstNameController = TextEditingController();
  TabController? _controller;
  FocusScopeNode? _focusNode;

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    final settingsUIState = widget.viewModel.state.settingsUIState;
    _controller = TabController(
        vsync: this,
        length: 2,
        initialIndex:
            settingsUIState.isFiltered ? 0 : settingsUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller!.index));
  }

  @override
  void dispose() {
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    _focusNode!.dispose();
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

  void _onChanged() {}

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;
    final company = viewModel.company;
    final translations = settings.translations ?? BuiltMap<String, String>();
    final customLabels =
        kCustomLabels.where((key) => !translations.keys.contains(key)).toList();
    customLabels.sort(
        (a, b) => localization.lookup(a).compareTo(localization.lookup(b)));

    return EditScaffold(
      title: localization.localization,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: state.uiState.settingsUIState.isFiltered
          ? null
          : TabBar(
              controller: _controller,
              tabs: [
                Tab(
                  text: localization.settings,
                ),
                Tab(
                  text: localization.customLabels,
                ),
              ],
            ),
      body: AppTabForm(
        formKey: _formKey,
        focusNode: _focusNode,
        tabController: _controller,
        children: <Widget>[
          ScrollableListView(
            primary: true,
            children: [
              FormCard(
                children: <Widget>[
                  EntityDropdown(
                    entityType: EntityType.currency,
                    entityList:
                        memoizedCurrencyList(state.staticState.currencyMap),
                    labelText: localization.currency,
                    entityId: settings.currencyId,
                    onSelected: (SelectableEntity? currency) =>
                        viewModel.onSettingsChanged(settings
                            .rebuild((b) => b..currencyId = currency?.id)),
                  ),
                  BoolDropdownButton(
                    value: settings.showCurrencyCode,
                    label: localization.currencyFormat,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..showCurrencyCode = value)),
                    enabledLabel: '${localization.code}: ' +
                        formatNumber(1000, context,
                            showCurrencyCode: true,
                            currencyId: settings.currencyId)!,
                    disabledLabel: '${localization.symbol}: ' +
                        formatNumber(1000, context,
                            showCurrencyCode: false,
                            currencyId: settings.currencyId)!,
                  ),
                  if (!state.isDemo)
                    LearnMoreUrl(
                      url: kTransifexURL,
                      label: localization.helpTranslate,
                      child: EntityDropdown(
                        entityType: EntityType.language,
                        entityList:
                            memoizedLanguageList(state.staticState.languageMap),
                        labelText: localization.language,
                        entityId: settings.languageId,
                        onSelected: (SelectableEntity? language) =>
                            viewModel.onSettingsChanged(settings
                                .rebuild((b) => b..languageId = language?.id)),
                      ),
                    ),
                  EntityDropdown(
                    entityType: EntityType.timezone,
                    entityList:
                        memoizedTimezoneList(state.staticState.timezoneMap),
                    labelText: localization.timezone,
                    entityId: settings.timezoneId,
                    onSelected: (SelectableEntity? timezone) =>
                        viewModel.onSettingsChanged(settings
                            .rebuild((b) => b..timezoneId = timezone?.id)),
                  ),
                  EntityDropdown(
                    entityType: EntityType.dateFormat,
                    entityList:
                        memoizedDateFormatList(state.staticState.dateFormatMap),
                    labelText: localization.dateFormat,
                    entityId: settings.dateFormatId,
                    onSelected: (SelectableEntity? dateFormat) =>
                        viewModel.onSettingsChanged(settings
                            .rebuild((b) => b..dateFormatId = dateFormat?.id)),
                  ),
                  BoolDropdownButton(
                    iconData: MdiIcons.clock,
                    label: localization.militaryTime,
                    helpLabel: localization.militaryTimeHelp,
                    value: settings.enableMilitaryTime,
                    onChanged: (value) => viewModel.onSettingsChanged(
                        settings.rebuild((b) => b..enableMilitaryTime = value)),
                  ),
                  if (!state.settingsUIState.isFiltered)
                    SwitchListTile(
                      value: company.useCommaAsDecimalPlace,
                      onChanged: (value) {
                        viewModel.onCompanyChanged(company
                            .rebuild((b) => b..useCommaAsDecimalPlace = value));
                      },
                      title: Text(localization.decimalComma),
                      subtitle: Text(localization.useCommaAsDecimalPlace),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      secondary: isDesktop(context)
                          ? Icon(MdiIcons.commaCircle)
                          : null,
                    ),
                ],
              ),
              if (!state.settingsUIState.isFiltered)
                FormCard(
                  isLast: true,
                  children: <Widget>[
                    /*
                AppDropdownButton(
                  labelText: localization.firstDayOfTheWeek,
                  value: company.firstDayOfWeek,
                  onChanged: (dynamic value) => viewModel.onCompanyChanged(
                      company.rebuild((b) => b..firstDayOfWeek = value)),
                  items: kDaysOfTheWeek
                      .map((id, day) =>
                          MapEntry<String, DropdownMenuItem<String>>(
                              id,
                              DropdownMenuItem<String>(
                                child: Text(localization.lookup(day)),
                                value: id,
                              )))
                      .values
                      .toList(),
                ),                
                 */
                    AppDropdownButton(
                        labelText: localization.firstMonthOfTheYear,
                        value: company.firstMonthOfYear,
                        onChanged: (dynamic value) =>
                            viewModel.onCompanyChanged(company
                                .rebuild((b) => b..firstMonthOfYear = value)),
                        items: kMonthsOfTheYear
                            .map((id, month) =>
                                MapEntry<String, DropdownMenuItem<String>>(
                                    id,
                                    DropdownMenuItem<String>(
                                      child: Text(localization.lookup(month)),
                                      value: id,
                                    )))
                            .values
                            .toList()),
                  ],
                ),
            ],
          ),
          ScrollableListView(
            primary: true,
            children: [
              FormCard(
                isLast: true,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: customLabels
                              .map((key) => DropdownMenuItem(
                                    child: Text(localization.lookup(key)),
                                    value: key,
                                  ))
                              .toList(),
                          hint: Text(localization.selectLabel),
                          onChanged: (value) {
                            viewModel.onSettingsChanged(settings
                                .rebuild((b) => b..translations[value] = ''));
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextButton(
                              child: Text(localization.addCustom),
                              onPressed: () {
                                fieldCallback(
                                    context: context,
                                    callback: (value) {
                                      viewModel.onSettingsChanged(
                                          settings.rebuild((b) =>
                                              b..translations[value] = ''));
                                    },
                                    field: localization.label,
                                    title: localization.addCustom,
                                    secondaryActions: [
                                      TextButton(
                                        child: Text(
                                            localization.labels.toUpperCase()),
                                        onPressed: () => launchUrl(
                                            Uri.parse(kGitHubLangUrl)),
                                      )
                                    ]);
                              },
                            ),
                            TextButton(
                              onPressed: () async {
                                final countryId = (await showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return _AddCompanyDialog();
                                    }))!;
                                if (countryId.isNotEmpty) {
                                  final key = 'country_' +
                                      state.staticState.countryMap[countryId]!
                                          .name;
                                  viewModel.onSettingsChanged(settings.rebuild(
                                      (b) => b..translations[key] = ''));
                                }
                              },
                              child: Text(localization.addCountry),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  for (var key in translations.keys)
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          key!.startsWith('country_')
                              ? key.split('_')[1]
                              : localization.lookup(key),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Expanded(
                          child: TextFormField(
                            key: ValueKey('__${key}__'),
                            initialValue: translations[key] ?? '',
                            onChanged: (value) => viewModel.onSettingsChanged(
                                settings.rebuild((b) =>
                                    b..translations[key] = value.trim())),
                          ),
                        ),
                        SizedBox(width: 16),
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            viewModel.onSettingsChanged(settings
                                .rebuild((b) => b..translations.remove(key)));
                          },
                        )
                      ],
                    )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddCompanyDialog extends StatefulWidget {
  const _AddCompanyDialog({Key? key}) : super(key: key);

  @override
  State<_AddCompanyDialog> createState() => _AddCompanyDialogState();
}

class _AddCompanyDialogState extends State<_AddCompanyDialog> {
  String? _countryId;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return AlertDialog(
      title: Text(localization.addCountry),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(localization.cancel.toUpperCase()),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_countryId);
          },
          child: Text(localization.submit.toUpperCase()),
        ),
      ],
      content: EntityDropdown(
        autofocus: true,
        entityType: EntityType.country,
        entityList: memoizedCountryList(state.staticState.countryMap),
        labelText: localization.country,
        onSelected: (SelectableEntity? country) {
          _countryId = country?.id ?? '';
        },
      ),
    );
  }
}
