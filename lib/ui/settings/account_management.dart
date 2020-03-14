import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final AccountManagementVM viewModel;

  @override
  _AccountManagementState createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_accountManagement');
  FocusScopeNode _focusNode;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;
    final companies = state.companies;

    return EditScaffold(
      title: localization.accountManagement,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: localization.enableModules,
          ),
        ],
      ),
      body: AppTabForm(
        formKey: _formKey,
        focusNode: _focusNode,
        tabController: _controller,
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(height: 14),
              //if (isSelfHosted(context))
              if (false)
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        label: localization.purchaseLicense,
                        iconData: Icons.cloud_download,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: ElevatedButton(
                        label: localization.applyLicense,
                        iconData: Icons.cloud_done,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  label: companies.length == 1
                      ? localization.cancelAccount.toUpperCase()
                      : localization.deleteCompany.toUpperCase(),
                  color: Colors.red,
                  onPressed: () {
                    confirmCallback(
                        context: context,
                        message: companies.length == 1
                            ? localization.cancelAccountMessage
                            : localization.deleteCompanyMessage,
                        callback: () {
                          passwordCallback(
                              context: context,
                              callback: (password) {
                                viewModel.onCompanyDelete(context, password);
                              });
                        });
                  },
                ),
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              FormCard(
                  // TODO change to kModules.keys
                  children: kModules.keys.map((module) {
                final implementedModules = <String>[
                  //kModuleQuotes,
                  //kModuleCredits,
                ];
                final isImplemented = implementedModules.contains(module);
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(localization.lookup(kModules[module])),
                  value: company.enabledModules & module != 0,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: isImplemented
                      ? (value) {
                          int enabledModules = company.enabledModules;
                          if (value) {
                            enabledModules = enabledModules | module;
                          } else {
                            enabledModules = enabledModules ^ module;
                          }
                          viewModel.onCompanyChanged(company.rebuild(
                              (b) => b..enabledModules = enabledModules));
                        }
                      : null,
                );
              }).toList()),
            ],
          ),
        ],
      ),
    );
  }
}
