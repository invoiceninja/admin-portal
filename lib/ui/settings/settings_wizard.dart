import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SettingsWizard extends StatefulWidget {
  @override
  _SettingsWizardState createState() => _SettingsWizardState();
}

class _SettingsWizardState extends State<SettingsWizard> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_settingsWizard');
  final FocusScopeNode _focusNode = FocusScopeNode();
  bool autoValidate = false;
  final _nameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String _currencyId = kCurrencyUSDollar;
  String _languageId = kLanguageEnglish;

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();

    _controllers = [
      _nameController,
      _firstNameController,
      _lastNameController,
    ];
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onSettingsChanged);
      controller.dispose();
    });
    super.dispose();
  }

  void _onSettingsChanged() {}

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;

    return AlertDialog(
      title: Text(localization.settings),
      content: AppForm(
        focusNode: _focusNode,
        formKey: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedFormField(
                autofocus: true,
                label: localization.companyName,
                controller: _nameController,
              ),
              DecoratedFormField(
                label: localization.firstName,
                controller: _firstNameController,
              ),
              DecoratedFormField(
                label: localization.lastName,
                controller: _lastNameController,
              ),
              EntityDropdown(
                key: ValueKey('__currency_${_currencyId}__'),
                allowClearing: true,
                entityType: EntityType.currency,
                entityList: memoizedCurrencyList(state.staticState.currencyMap),
                labelText: localization.currency,
                entityId: _currencyId,
                onSelected: (SelectableEntity currency) =>
                    setState(() => _currencyId = currency?.id),
              ),
              EntityDropdown(
                key: ValueKey('__language_${_languageId}__'),
                allowClearing: true,
                entityType: EntityType.language,
                entityList: memoizedLanguageList(state.staticState.languageMap),
                labelText: localization.language,
                entityId: _languageId,
                onSelected: (SelectableEntity language) =>
                    setState(() => _languageId = language?.id),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              //
            },
            child: Text(localization.save.toUpperCase()))
      ],
    );
  }
}
