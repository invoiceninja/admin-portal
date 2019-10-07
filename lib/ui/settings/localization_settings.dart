import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/settings/localization_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
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
        ],
      ),
    );
  }
}
