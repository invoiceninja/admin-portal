import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class AccountManagementSettings extends StatefulWidget {
  const AccountManagementSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final AccountManagementVM viewModel;

  @override
  _AccountManagementSettingsState createState() =>
      _AccountManagementSettingsState();
}

class _AccountManagementSettingsState extends State<AccountManagementSettings> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_accountManagement');
  FocusScopeNode _focusNode;

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
    final company = viewModel.company;

    return EditScaffold(
      title: localization.accountManagement,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[

          FormCard(
              // TODO change to kModules.keys
              children: [
            kModuleQuotes,
            kModuleCredits,
            kModuleExpenses,
          ]
                  .map((key) => CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(localization.lookup(kModules[key])),
                        value: company.enabledModules & key != 0,
                        activeColor: Theme.of(context).accentColor,
                        onChanged: (value) {
                          int enabledModules = company.enabledModules;
                          if (value) {
                            enabledModules = enabledModules | key;
                          } else {
                            enabledModules = enabledModules ^ key;
                          }
                          viewModel.onCompanyChanged(company.rebuild(
                              (b) => b..enabledModules = enabledModules));
                        },
                      ))
                  .toList()),
        ],
      ),
    );
  }
}
