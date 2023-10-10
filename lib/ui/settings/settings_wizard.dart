// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class SettingsWizard extends StatefulWidget {
  const SettingsWizard({
    required this.user,
    required this.company,
  });

  final UserEntity? user;
  final CompanyEntity? company;

  @override
  _SettingsWizardState createState() => _SettingsWizardState();
}

class _SettingsWizardState extends State<SettingsWizard> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_settingsWizard');
  final FocusScopeNode _focusNode = FocusScopeNode();
  final _debouncer = Debouncer(milliseconds: kMillisecondsToDebounceSave);

  bool _isSaving = false;
  bool _showLogo = false;
  bool _isSubdomainUnique = false;
  bool _isCheckingSubdomain = false;
  bool _hasCheckedSubdomain = false;
  String _currencyId = kCurrencyUSDollar;
  String _languageId = kLanguageEnglish;
  final _nameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _subdomainController = TextEditingController();
  final _webClient = WebClient();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();

    _controllers = [
      _nameController,
      _firstNameController,
      _lastNameController,
      _subdomainController,
    ];

    _firstNameController.text = widget.user!.firstName;
    _lastNameController.text = widget.user!.lastName;
    _subdomainController.text = widget.company!.subdomain;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controllers.forEach((dynamic controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void _validateSubdomain() {
    _debouncer.run(() {
      if (_isCheckingSubdomain) {
        return;
      }

      final subdomain = _subdomainController.text.trim();
      final store = StoreProvider.of<AppState>(context);
      final state = store.state;
      final credentials = state.credentials;
      final url = '${credentials.url}/check_subdomain';

      if (subdomain.isEmpty) {
        setState(() => _isSubdomainUnique = false);
        return;
      }

      setState(() {
        _isCheckingSubdomain = true;
        _hasCheckedSubdomain = true;
      });

      _webClient
          .post(url, credentials.token,
              data: jsonEncode(
                {'subdomain': subdomain},
              ))
          .then((dynamic data) {
        setState(() {
          _isSubdomainUnique = true;
          _isCheckingSubdomain = false;
        });
      }).catchError((Object error) {
        setState(() {
          _isSubdomainUnique = false;
          _isCheckingSubdomain = false;
        });
      });
    });
  }

  void _onSavePressed() {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid || _isCheckingSubdomain) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    passwordCallback(
        context: context,
        callback: (password, idToken) {
          final localization = AppLocalization.of(context);
          final completer = Completer<Null>();
          completer.future.then<Null>((_) {
            final toastCompleter =
                snackBarCompleter<Null>(localization!.savedSettings);
            toastCompleter.future.then<Null>((_) {
              setState(() {
                _isSaving = false;
                _showLogo = true;
              });
            }).catchError((Object error) {
              setState(() {
                _isSaving = false;
              });
            });
            store.dispatch(
              SaveCompanyRequest(
                completer: toastCompleter,
                company: state.company.rebuild(
                  (b) => b
                    ..subdomain = _subdomainController.text.trim()
                    ..settings.name = _nameController.text.trim()
                    ..settings.currencyId = _currencyId
                    ..settings.languageId = _languageId,
                ),
              ),
            );
          }).catchError((Object error) {
            setState(() => _isSaving = false);
          });

          setState(() => _isSaving = true);

          if (state.companies.length > 1) {
            completer.complete();
          } else {
            store.dispatch(
              SaveAuthUserRequest(
                completer: completer,
                user: state.user.rebuild((b) => b
                  ..firstName = _firstNameController.text.trim()
                  ..lastName = _lastNameController.text.trim()),
                password: password,
                idToken: idToken,
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final companyName = DecoratedFormField(
      autofocus: true,
      label: localization.companyName,
      controller: _nameController,
      validator: (value) =>
          value.isEmpty ? localization.pleaseEnterAValue : null,
      keyboardType: TextInputType.text,
    );

    final firstName = DecoratedFormField(
      label: localization.firstName,
      controller: _firstNameController,
      keyboardType: TextInputType.name,
      autofillHints: [AutofillHints.givenName],
      validator: (value) =>
          value.isEmpty ? localization.pleaseEnterAValue : null,
    );

    final lastName = DecoratedFormField(
      label: localization.lastName,
      controller: _lastNameController,
      keyboardType: TextInputType.name,
      autofillHints: [AutofillHints.familyName],
      validator: (value) =>
          value.isEmpty ? localization.pleaseEnterAValue : null,
    );

    final currency = EntityDropdown(
      entityType: EntityType.currency,
      entityList: memoizedCurrencyList(state.staticState.currencyMap),
      labelText: localization.currency,
      entityId: _currencyId,
      onSelected: (SelectableEntity? currency) =>
          setState(() => _currencyId = currency?.id ?? ''),
      validator: (dynamic value) =>
          value.isEmpty ? localization.pleaseEnterAValue : null,
    );

    final language = EntityDropdown(
      entityType: EntityType.language,
      entityList: memoizedLanguageList(state.staticState.languageMap),
      labelText: localization.language,
      entityId: _languageId,
      onSelected: (SelectableEntity? language) {
        setState(() => _languageId = language?.id ?? '');
        store.dispatch(UpdateCompanyLanguage(languageId: language?.id));
        AppBuilder.of(context)!.rebuild();
      },
      validator: (dynamic value) =>
          value.isEmpty ? localization.pleaseEnterAValue : null,
    );

    final darkMode = LayoutBuilder(builder: (context, constraints) {
      return ToggleButtons(
        children: [
          Text(localization.system),
          Text(localization.light),
          Text(localization.dark),
        ],
        constraints: BoxConstraints.expand(
            width: (constraints.maxWidth / 3) - 2, height: 40),
        isSelected: [
          state.prefState.darkModeType == kBrightnessSytem,
          state.prefState.darkModeType == kBrightnessLight,
          state.prefState.darkModeType == kBrightnessDark,
        ],
        onPressed: (index) {
          store.dispatch(
            UpdateUserPreferences(
              darkModeType: index == 0
                  ? kBrightnessSytem
                  : index == 1
                      ? kBrightnessLight
                      : kBrightnessDark,
            ),
          );
          AppBuilder.of(context)!.rebuild();
        },
      );
    });

    final subdomain = DecoratedFormField(
      label: localization.subdomain,
      controller: _subdomainController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) {
          return localization.pleaseEnterAValue;
        } else if (_hasCheckedSubdomain &&
            !_isCheckingSubdomain &&
            !_isSubdomainUnique) {
          return localization.subdomainIsNotAvailable;
        }

        return null;
      },
      suffixIcon: Icon(_isCheckingSubdomain
          ? Icons.pending_outlined
          : _isSubdomainUnique
              ? Icons.check_circle_outline
              : Icons.error_outline),
      onChanged: (value) => _validateSubdomain(),
      hint: localization.subdomainHelp,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9\-]')),
      ],
    );

    var showNameFields = true;
    if (state.companies.length > 1 && kReleaseMode) {
      showNameFields = false;
    }
    if (state.user.isConnectedToApple && state.user.fullName.isEmpty) {
      showNameFields = false;
    }

    return AlertDialog(
      content: AppForm(
        focusNode: _focusNode,
        formKey: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            child: _isSaving
                ? LoadingIndicator(
                    height: 200,
                  )
                : _showLogo
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Text(
                            localization.setupWizardLogo,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: isMobile(context)
                            ? [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    localization.welcomeToInvoiceNinja,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                companyName,
                                if (state.isHosted) subdomain,
                                if (showNameFields) ...[
                                  firstName,
                                  lastName,
                                ],
                                language,
                                currency,
                                SizedBox(height: 16),
                                darkMode,
                                if (state.isHosted)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 32),
                                    child: Text(localization.subdomainGuide),
                                  )
                              ]
                            : [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      localization.welcomeToInvoiceNinja,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    )),
                                    if (state.isHosted) ...[
                                      SizedBox(width: kTableColumnGap),
                                      Flexible(child: darkMode),
                                    ]
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(child: companyName),
                                    SizedBox(width: kTableColumnGap),
                                    Expanded(
                                        child: state.isHosted
                                            ? subdomain
                                            : darkMode),
                                  ],
                                ),
                                if (showNameFields)
                                  Row(
                                    children: [
                                      Expanded(child: firstName),
                                      SizedBox(width: kTableColumnGap),
                                      Expanded(child: lastName),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    Expanded(child: language),
                                    SizedBox(width: kTableColumnGap),
                                    Expanded(child: currency),
                                  ],
                                ),
                                if (state.isHosted)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 32),
                                    child: Text(localization.subdomainGuide),
                                  ),
                              ],
                      ),
          ),
        ),
      ),
      actions: [
        if (!_isSaving) ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(localization.close.toUpperCase()),
          ),
          if (_showLogo)
            TextButton(
                onPressed: () {
                  store.dispatch(ViewSettings(
                    section: kSettingsCompanyDetails,
                    tabIndex: 2,
                  ));
                  Navigator.of(context).pop();
                },
                child: Text(localization.upload.toUpperCase()))
          else
            TextButton(
              onPressed: _onSavePressed,
              child: Text(localization.save.toUpperCase()),
            ),
        ]
      ],
    );
  }
}
