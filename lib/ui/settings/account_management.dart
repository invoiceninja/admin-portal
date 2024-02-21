// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_header.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/learn_more.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AccountManagementVM viewModel;

  @override
  _AccountManagementState createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_accountManagement');
  FocusScopeNode? _focusNode;
  TabController? _controller;

  final _debouncer = Debouncer();
  final _trackingIdController = TextEditingController();
  final _matomoUrl = TextEditingController();
  final _matomoId = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();

    final settingsUIState = widget.viewModel.state.settingsUIState;
    _controller = TabController(
        vsync: this, length: 4, initialIndex: settingsUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller!.index));
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _trackingIdController,
      _matomoId,
      _matomoUrl,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final viewModel = widget.viewModel;
    final company = viewModel.company;

    _trackingIdController.text = company.googleAnalyticsKey;
    _matomoId.text = company.matomoId;
    _matomoUrl.text = company.matomoUrl;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final company = widget.viewModel.company.rebuild((b) => b
      ..googleAnalyticsKey = _trackingIdController.text.trim()
      ..matomoId = _matomoId.text.trim()
      ..matomoUrl = _matomoUrl.text.trim());
    if (company != widget.viewModel.company) {
      _debouncer.run(() {
        widget.viewModel.onCompanyChanged(company);
      });
    }
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    _focusNode!.dispose();
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = viewModel.company;

    final durations = [
      if (!kReleaseMode)
        DropdownMenuItem<int>(
          child: Text('2 minutes'),
          value: 1000 * 60 * 2,
        ),
      DropdownMenuItem<int>(
        child: Text(localization.countMinutes.replaceFirst(':count', '30')),
        value: 1000 * 60 * 30,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countHours.replaceFirst(':count', '2')),
        value: 1000 * 60 * 60 * 2,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countHours.replaceFirst(':count', '8')),
        value: 1000 * 60 * 60 * 8,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countDay),
        value: 1000 * 60 * 60 * 24,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countDays.replaceFirst(':count', '7')),
        value: 1000 * 60 * 60 * 24 * 7,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.countDays.replaceFirst(':count', '30')),
        value: 1000 * 60 * 60 * 24 * 30,
      ),
      DropdownMenuItem<int>(
        child: Text(localization.never),
        value: 0,
      ),
    ];

    return EditScaffold(
      title: localization.accountManagement,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: localization.enabledModules,
          ),
          Tab(
            text: localization.integrations,
          ),
          Tab(
            text: localization.securitySettings,
          ),
        ],
      ),
      body: AppTabForm(
        formKey: _formKey,
        focusNode: _focusNode,
        tabController: _controller,
        children: <Widget>[
          _AccountOverview(viewModel: viewModel),
          ScrollableListView(
            primary: true,
            children: <Widget>[
              FormCard(
                  children: kModules.keys.map((module) {
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(localization.lookup(kModules[module])),
                  value: company.enabledModules & module != 0,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) {
                    int enabledModules = company.enabledModules;
                    if (value!) {
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
          ScrollableListView(primary: true, children: [
            FormCard(
              children: [
                LearnMoreUrl(
                  url: kGoogleAnalyticsUrl,
                  child: DecoratedFormField(
                    label: localization.googleAnalyticsTrackingId,
                    controller: _trackingIdController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            FormCard(
              isLast: true,
              children: [
                DecoratedFormField(
                  label: localization.matomoId,
                  controller: _matomoId,
                  keyboardType: TextInputType.text,
                ),
                DecoratedFormField(
                  label: localization.matomoUrl,
                  controller: _matomoUrl,
                  keyboardType: TextInputType.url,
                ),
              ],
            ),
          ]),
          ScrollableListView(
            primary: true,
            children: [
              FormCard(
                children: [
                  AppDropdownButton<int>(
                    labelText: localization.passwordTimeout,
                    value: company.passwordTimeout,
                    onChanged: (dynamic value) => viewModel.onCompanyChanged(
                        company.rebuild((b) => b..passwordTimeout = value)),
                    items: durations,
                  ),
                  AppDropdownButton<int>(
                    labelText: localization.webSessionTimeout,
                    value: company.sessionTimeout,
                    onChanged: (dynamic value) => viewModel.onCompanyChanged(
                        company.rebuild((b) => b..sessionTimeout = value)),
                    items: durations,
                  ),
                  BoolDropdownButton(
                      label: localization.requirePasswordWithSocialLogin,
                      value: company.oauthPasswordRequired,
                      onChanged: (value) {
                        viewModel.onCompanyChanged(company
                            .rebuild((b) => b.oauthPasswordRequired = value));
                      }),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _AccountOverview extends StatelessWidget {
  const _AccountOverview({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AccountManagementVM viewModel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context)!;
    final state = viewModel.state;
    final account = state.account;
    final company = viewModel.company;
    final companies = state.companies;

    String _getDataStats() {
      String stats = '\n';
      final localization = AppLocalization.of(context);
      final state = viewModel.state;

      if (state.clientState.list.isNotEmpty) {
        final count = state.clientState.list.length;
        stats += '\n- $count ' +
            (count == 1 ? localization!.client : localization!.clients);
      }

      if (state.productState.list.isNotEmpty) {
        final count = state.productState.list.length;
        stats += '\n- $count ' +
            (count == 1 ? localization!.product : localization!.products);
      }

      if (state.invoiceState.list.isNotEmpty && !state.company.isLarge) {
        final count = state.invoiceState.list.length;
        stats += '\n- $count ' +
            (count == 1 ? localization!.invoice : localization!.invoices);
      }

      return stats;
    }

    String? secondValue;
    String? secondLabel;

    if (state.isHosted && (account.plan.isEmpty || account.isTrial)) {
      final clientLimit = account.hostedClientCount;
      secondLabel = localization.clients;
      secondValue = '${viewModel.state.clientState.list.length} / $clientLimit';
    } else if (account.planExpires.isNotEmpty) {
      secondLabel = localization.expiresOn;
      secondValue = formatDate(account.planExpires, context);
    }

    return ScrollableListView(
      primary: true,
      children: <Widget>[
        AppHeader(
          label: localization.plan,
          value: account.isTrial
              ? '${localization.pro} • ${localization.freeTrial}'
              : account.plan.isEmpty
                  ? localization.free
                  : localization.lookup(account.plan),
          secondLabel: secondLabel,
          secondValue: secondValue,
        ),
        if (state.company.id != state.account.defaultCompanyId)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: AppButton(
              iconData: Icons.business,
              label: localization.setDefaultCompany.toUpperCase(),
              onPressed: () => viewModel.onSetPrimaryCompany(context),
            ),
          ),
        if (state.isHosted) ...[
          if (state.isProPlan && account.hasIapPlan)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                localization.useMobileToManagePlan,
                textAlign: TextAlign.center,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: OutlinedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconText(
                    icon: MdiIcons.openInNew,
                    text:
                        (account.isEligibleForTrial && !supportsInAppPurchase()
                                ? localization.startFreeTrial
                                : localization.changePlan)
                            .toUpperCase(),
                  ),
                ),
                onPressed: () => initiatePurchase(),
              ),
            ),
        ],
        FormCard(children: [
          SwitchListTile(
            value: !company.isDisabled,
            onChanged: (value) {
              viewModel.onCompanyChanged(
                  company.rebuild((b) => b..isDisabled = !value));
            },
            title: Text(localization.activateCompany),
            subtitle: Text(localization.activateCompanyHelp),
            activeColor: Theme.of(context).colorScheme.secondary,
          ),
          SwitchListTile(
            value: company.markdownEnabled,
            onChanged: (value) {
              viewModel.onCompanyChanged(
                  company.rebuild((b) => b..markdownEnabled = value));
            },
            title: Text(localization.enablePdfMarkdown),
            subtitle: Text(localization.enableMarkdownHelp),
            activeColor: Theme.of(context).colorScheme.secondary,
          ),
          SwitchListTile(
            value: company.markdownEmailEnabled,
            onChanged: (value) {
              viewModel.onCompanyChanged(
                  company.rebuild((b) => b..markdownEmailEnabled = value));
            },
            title: Text(localization.enableEmailMarkdown),
            subtitle: Text(localization.enableEmailMarkdownHelp),
            activeColor: Theme.of(context).colorScheme.secondary,
          ),
        ]),
        FormCard(
          children: [
            SwitchListTile(
              value: company.reportIncludeDrafts,
              onChanged: (value) {
                viewModel.onCompanyChanged(
                    company.rebuild((b) => b..reportIncludeDrafts = value));
              },
              title: Text(localization.includeDrafts),
              subtitle: Text(localization.includeDraftsHelp),
              activeColor: Theme.of(context).colorScheme.secondary,
            ),
            SwitchListTile(
              value: company.reportIncludeDeleted,
              onChanged: (value) {
                viewModel.onCompanyChanged(
                    company.rebuild((b) => b..reportIncludeDeleted = value));
              },
              title: Text(localization.includeDeleted),
              subtitle: Text(localization.includeDeletedHelp),
              activeColor: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
        if (state.isSelfHosted) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: localization.purchaseLicense.toUpperCase(),
                    iconData: isMobile(context) ? null : Icons.cloud_download,
                    onPressed: () async {
                      launchUrl(Uri.parse(kWhiteLabelUrl));
                    },
                  ),
                ),
                SizedBox(width: kGutterWidth),
                Expanded(
                  child: AppButton(
                    label: localization.applyLicense.toUpperCase(),
                    iconData: isMobile(context) ? null : Icons.cloud_done,
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

                            showDialog<AlertDialog>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) => SimpleDialog(
                                      children: <Widget>[LoadingDialog()],
                                    ));

                            WebClient()
                                .post(
                              url,
                              credentials.token,
                            )
                                .then((dynamic response) {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context).pop();
                              }
                              viewModel.onAppliedLicense();
                            }).catchError((dynamic error) {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context).pop();
                              }
                              showErrorDialog(message: '$error');
                            });
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: ListDivider(),
          ),
        ],
        if (state.isProPlan)
          Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(
                  child: AppButton(
                    label: localization.apiTokens.toUpperCase(),
                    iconData: isMobile(context)
                        ? null
                        : getEntityIcon(EntityType.token),
                    onPressed: () {
                      store.dispatch(ViewSettings(
                        section: kSettingsTokens,
                      ));
                    },
                  ),
                ),
                SizedBox(width: kGutterWidth),
                Expanded(
                  child: AppButton(
                    label: localization.apiWebhooks.toUpperCase(),
                    iconData: isMobile(context)
                        ? null
                        : getEntityIcon(EntityType.webhook),
                    onPressed: () {
                      store.dispatch(ViewSettings(
                        section: kSettingsWebhooks,
                      ));
                    },
                  ),
                ),
              ])),
        Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Expanded(
                child: AppButton(
                  label: localization.apiDocs.toUpperCase(),
                  iconData: isMobile(context) ? null : MdiIcons.bookshelf,
                  onPressed: () => launchUrl(Uri.parse(kApiDocsUrl)),
                ),
              ),
              SizedBox(width: kGutterWidth),
              Expanded(
                child: AppButton(
                  label: 'Zapier',
                  iconData: isMobile(context) ? null : MdiIcons.cloud,
                  onPressed: () => launchUrl(Uri.parse(kZapierUrl)),
                ),
              ),
            ])),
        if (state.userCompany.isOwner && !state.isDemo) ...[
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: ListDivider(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: localization.purgeData.toUpperCase(),
                    color: Colors.red,
                    iconData: isMobile(context) ? null : Icons.delete,
                    onPressed: () {
                      confirmCallback(
                          context: context,
                          message:
                              localization.purgeDataMessage + _getDataStats(),
                          typeToConfirm: localization.purge.toLowerCase(),
                          callback: (_) {
                            passwordCallback(
                                alwaysRequire: true,
                                context: context,
                                callback: (password, idToken) {
                                  viewModel.onPurgeData(
                                      context, password ?? '', idToken ?? '');
                                });
                          });
                    },
                  ),
                ),
                SizedBox(width: kGutterWidth),
                Expanded(
                  child: AppButton(
                    label: companies.length == 1
                        ? localization.cancelAccount.toUpperCase()
                        : localization.deleteCompany.toUpperCase(),
                    color: Colors.red,
                    iconData: isMobile(context) ? null : Icons.delete,
                    onPressed: () {
                      String message = companies.length == 1
                          ? localization.cancelAccountMessage
                          : localization.deleteCompanyMessage;

                      message = message.replaceFirst(
                          ':company',
                          company.displayName.isEmpty
                              ? localization.newCompany
                              : company.displayName);
                      message += _getDataStats();

                      confirmCallback(
                          context: context,
                          message: message,
                          typeToConfirm: localization.delete.toLowerCase(),
                          askForReason: true,
                          callback: (String? reason) async {
                            if (state.user.isConnectedToApple &&
                                !state.user.hasPassword) {
                              final credentials =
                                  await SignInWithApple.getAppleIDCredential(
                                scopes: [
                                  AppleIDAuthorizationScopes.email,
                                  AppleIDAuthorizationScopes.fullName,
                                ],
                                webAuthenticationOptions:
                                    WebAuthenticationOptions(
                                  clientId: kAppleOAuthClientId,
                                  redirectUri:
                                      Uri.parse(kAppleOAuthRedirectUrl),
                                ),
                              );

                              viewModel.onCompanyDelete(
                                navigatorKey.currentContext!,
                                '',
                                credentials.identityToken ?? '',
                                reason ?? '',
                              );
                            } else {
                              passwordCallback(
                                  alwaysRequire: true,
                                  context: context,
                                  callback: (password, idToken) {
                                    viewModel.onCompanyDelete(
                                      context,
                                      password ?? '',
                                      idToken ?? '',
                                      reason ?? '',
                                    );
                                  });
                            }
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
