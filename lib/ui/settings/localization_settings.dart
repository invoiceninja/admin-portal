import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
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

    return SettingsScaffold(
      title: localization.localization,
      onSavePressed: viewModel.onSavePressed,
      onCancelPressed: viewModel.onCancelPressed,
      body: AppForm(
        formKey: _formKey,
        children: <Widget>[
          EntityDropdown(
            key: ValueKey('__currency_${settings.currencyId}'),
            entityType: EntityType.currency,
            entityMap: state.staticState.currencyMap,
            entityList: memoizedCurrencyList(state.staticState.currencyMap),
            labelText: localization.currency,
            initialValue:
                state.staticState.currencyMap[settings.currencyId]?.name,
            onSelected: (SelectableEntity currency) => viewModel.onChanged(
                settings.rebuild((b) => b..currencyId = currency.id)),
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Radio(
                value: false,
                groupValue: settings.showCurrencyCode,
                activeColor: Theme.of(context).accentColor,
                onChanged: (bool value) => viewModel.onChanged(
                    settings.rebuild((b) => b..showCurrencyCode = false)),
              ),
              GestureDetector(
                child: Text('${localization.symbol}: ' +
                    formatNumber(1000, context,
                        showCurrencyCode: false,
                        currencyId: settings.currencyId)),
                onTap: () => viewModel.onChanged(
                    settings.rebuild((b) => b..showCurrencyCode = false)),
              ),
              SizedBox(width: 10),
              Radio(
                value: true,
                groupValue: settings.showCurrencyCode,
                activeColor: Theme.of(context).accentColor,
                onChanged: (bool value) => viewModel.onChanged(
                    settings.rebuild((b) => b..showCurrencyCode = true)),
              ),
              GestureDetector(
                child: Text('${localization.code}: ' +
                    formatNumber(1000, context,
                        showCurrencyCode: true,
                        currencyId: settings.currencyId)),
                onTap: () => viewModel.onChanged(
                    settings.rebuild((b) => b..showCurrencyCode = true)),
              ),
            ],
          ),
          SizedBox(height: 20),
          EntityDropdown(
            key: ValueKey('__language_${settings.languageId}'),
            entityType: EntityType.language,
            entityMap: state.staticState.languageMap,
            entityList: memoizedLanguageList(state.staticState.languageMap),
            labelText: localization.language,
            initialValue:
                state.staticState.languageMap[settings.languageId]?.name,
            onSelected: (SelectableEntity language) => viewModel.onChanged(
                settings.rebuild((b) => b..languageId = language.id)),
          ),
          EntityDropdown(
            key: ValueKey('__timezone_${settings.timezoneId}'),
            entityType: EntityType.timezone,
            entityMap: state.staticState.timezoneMap,
            entityList: memoizedTimezoneList(state.staticState.timezoneMap),
            labelText: localization.timezone,
            initialValue:
            state.staticState.timezoneMap[settings.timezoneId]?.name,
            onSelected: (SelectableEntity timezone) => viewModel.onChanged(
                settings.rebuild((b) => b..timezoneId = timezone.id)),
          ),
          EntityDropdown(
            key: ValueKey('__date_format_${settings.dateFormatId}'),
            entityType: EntityType.dateFormat,
            entityMap: state.staticState.dateFormatMap,
            entityList: memoizedDateFormatList(state.staticState.dateFormatMap),
            labelText: localization.dateFormat,
            initialValue:
            state.staticState.dateFormatMap[settings.dateFormatId]?.preview,
            onSelected: (SelectableEntity dateFormat) => viewModel.onChanged(
                settings.rebuild((b) => b..dateFormatId = dateFormat.id)),
          ),
        ],
      ),
    );
  }
}
