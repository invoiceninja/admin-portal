import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
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

    return SettingsScaffold(
      title: localization.taxSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        children: <Widget>[
          FormCard(
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}
