import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_header.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management_vm.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

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
          _AccountOverview(viewModel: viewModel),
          ListView(
            children: <Widget>[
              FormCard(
                  // TODO change to kModules.keys
                  children: [
                kModuleInvoices,
                kModuleQuotes,
                kModuleCredits,
              ].map((module) {
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(localization.lookup(kModules[module])),
                  value: company.enabledModules & module != 0,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (value) {
                    int enabledModules = company.enabledModules;
                    if (value) {
                      enabledModules = enabledModules | module;
                    } else {
                      enabledModules = enabledModules ^ module;
                    }
                    viewModel.onCompanyChanged(company
                        .rebuild((b) => b..enabledModules = enabledModules));
                  },
                );
              }).toList()),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccountOverview extends StatelessWidget {
  const _AccountOverview({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final AccountManagementVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);
    final state = viewModel.state;
    final account = state.account;
    final companies = state.companies;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        AppHeader(
          label: localization.plan,
          value: account.plan.isEmpty ? localization.free : account.plan,
          secondLabel: localization.expiresOn,
          secondValue: formatDate(account.planExpires, context),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            label: localization.purchaseLicense.toUpperCase(),
            iconData: Icons.cloud_download,
            onPressed: () async {
              if (await canLaunch(kWhiteLabelUrl)) {
                launch(kWhiteLabelUrl, forceSafariVC: false);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            label: localization.applyLicense.toUpperCase(),
            iconData: Icons.cloud_done,
            onPressed: () {
              fieldCallback(
                  context: context,
                  title: localization.applyLicense,
                  field: localization.license,
                  maxLength: 24,
                  callback: (value) {
                    final state = viewModel.state;
                    final credentials = state.credentials;
                    final url =
                        '${credentials.url}/claim_license?license_key=$value';
                    WebClient()
                        .post(
                      url,
                      credentials.token,
                    )
                        .then((dynamic response) {
                      viewModel.onAppliedLicense();
                    }).catchError((dynamic error) {
                      showErrorDialog(context: context, message: '$error');
                    });
                  });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListDivider(),
        ),
        /*
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  label: localization.purgeData.toUpperCase(),
                  color: Colors.red,
                  iconData: Icons.delete,
                  onPressed: () {
                    confirmCallback(
                        context: context,
                        message: localization.purgeDataMessage,
                        callback: () {
                          passwordCallback(
                              alwaysRequire: true,
                              context: context,
                              callback: (password) {
                                viewModel.onPurgeData(context, password);
                              });
                        });
                  },
                ),
              ),              
               */
        Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            label: localization.manageTokens.toUpperCase(),
            iconData: getEntityIcon(EntityType.token),
            onPressed: () {
              store.dispatch(ViewSettings(
                navigator: Navigator.of(context),
                section: kSettingsTokens,
              ));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            label: localization.manageWebhooks.toUpperCase(),
            iconData: getEntityIcon(EntityType.webhook),
            onPressed: () {
              store.dispatch(ViewSettings(
                navigator: Navigator.of(context),
                section: kSettingsWebhooks,
              ));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListDivider(),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            label: companies.length == 1
                ? localization.cancelAccount.toUpperCase()
                : localization.deleteCompany.toUpperCase(),
            color: Colors.red,
            iconData: Icons.delete,
            onPressed: () {
              String message = companies.length == 1
                  ? localization.cancelAccountMessage
                  : localization.deleteCompanyMessage;

              message =
                  message.replaceFirst(':company', state.company.displayName);

              confirmCallback(
                  context: context,
                  message: message,
                  callback: () {
                    passwordCallback(
                        alwaysRequire: true,
                        context: context,
                        callback: (password) {
                          viewModel.onCompanyDelete(context, password);
                        });
                  });
            },
          ),
        ),
      ],
    );
  }
}
