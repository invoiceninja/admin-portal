// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/static/static_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/sms_verification.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/notification_settings.dart';
import 'package:invoiceninja_flutter/ui/app/forms/password_field.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/user_details_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final UserDetailsVM viewModel;

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_userDetails');
  final FocusScopeNode _focusNode = FocusScopeNode();
  TabController? _controller;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();

    final settingsUIState = widget.viewModel.state.settingsUIState;
    _controller = TabController(
        vsync: this, length: 2, initialIndex: settingsUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller!.index));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _firstNameController,
      _lastNameController,
      _emailController,
      _phoneController,
      _passwordController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final user = widget.viewModel.state.user;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _passwordController.text = user.password;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final user = widget.viewModel.user.rebuild((b) => b
      ..firstName = _firstNameController.text.trim()
      ..lastName = _lastNameController.text.trim()
      ..email = _emailController.text.trim()
      ..phone = _phoneController.text.trim()
      ..password = _passwordController.text.trim());
    if (user != widget.viewModel.user) {
      _debouncer.run(() {
        widget.viewModel.onChanged(user);
      });
    }
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final user = viewModel.user;

    final googleButton = Expanded(
      child: OutlinedButton(
        child: Text(
          (state.user.isConnectedToGoogle
                  ? localization.disconnectGoogle
                  : localization.connectGoogle)
              .toUpperCase(),
          textAlign: TextAlign.center,
        ),
        onPressed: state.user.isConnectedToEmail ||
                state.user.isConnectedToApple ||
                state.user.isConnectedToMicrosoft
            ? null
            : () {
                if (state.settingsUIState.isChanged) {
                  showMessageDialog(message: localization.errorUnsavedChanges);
                  return;
                }

                if (state.user.isConnectedToGoogle) {
                  viewModel.onDisconnectGooglePressed(context);
                } else {
                  viewModel.onConnectGooglePressed(context);
                }
              },
      ),
    );

    final gmailButton = Expanded(
      child: OutlinedButton(
        child: Text(
          (state.user.isConnectedToEmail
                  ? localization.disconnectGmail
                  : localization.connectGmail)
              .toUpperCase(),
          textAlign: TextAlign.center,
        ),
        onPressed: !state.user.isConnectedToGoogle
            ? null
            : () async {
                if (state.settingsUIState.isChanged) {
                  showMessageDialog(message: localization.errorUnsavedChanges);
                  return;
                }

                if (state.user.isConnectedToEmail) {
                  viewModel.onDisconnectGmailPressed(context);
                } else {
                  launchUrl(Uri.parse('$kAppProductionUrl/auth/google'));
                }
              },
      ),
    );

    final microsoftButton = Expanded(
      child: OutlinedButton(
        child: Text(
          (state.user.isConnectedToMicrosoft
                  ? localization.disconnectMicrosoft
                  : localization.connectMicrosoft)
              .toUpperCase(),
          textAlign: TextAlign.center,
        ),
        onPressed: state.user.isConnectedToEmail ||
                state.user.isConnectedToGoogle ||
                state.user.isConnectedToApple
            ? null
            : () {
                if (state.settingsUIState.isChanged) {
                  showMessageDialog(message: localization.errorUnsavedChanges);
                  return;
                }

                if (state.user.isConnectedToMicrosoft) {
                  viewModel.onDisconnectMicrosoftPressed(context);
                } else {
                  viewModel.onConnectMicrosoftPressed(context);
                }
              },
      ),
    );

    final office365Button = Expanded(
      child: OutlinedButton(
        child: Text(
          (state.user.isConnectedToEmail
                  ? localization.disconnectEmail
                  : localization.connectEmail)
              .toUpperCase(),
          textAlign: TextAlign.center,
        ),
        onPressed: !state.user.isConnectedToMicrosoft
            ? null
            : () async {
                if (state.settingsUIState.isChanged) {
                  showMessageDialog(message: localization.errorUnsavedChanges);
                  return;
                }

                if (state.user.isConnectedToEmail) {
                  viewModel.onDisconnectMicrosoftEmailPressed(context);
                } else {
                  launchUrl(
                      Uri.parse('${state.account.defaultUrl}/auth/microsoft'));
                }
              },
      ),
    );

    final appleButton = Expanded(
      child: OutlinedButton(
        child: Text(
          (state.user.isConnectedToApple
                  ? localization.disconnectApple
                  : localization.connectApple)
              .toUpperCase(),
          textAlign: TextAlign.center,
        ),
        onPressed: state.user.isConnectedToGoogle ||
                state.user.isConnectedToMicrosoft
            ? null
            : () {
                if (state.settingsUIState.isChanged) {
                  showMessageDialog(message: localization.errorUnsavedChanges);
                  return;
                }

                if (state.user.isConnectedToApple) {
                  viewModel.onDisconnectApplePressed(context);
                } else {
                  // do nothing
                }
              },
      ),
    );

    return EditScaffold(
      title: localization.userDetails,
      onSavePressed: _onSavePressed,
      appBarBottom: TabBar(
        controller: _controller,
        tabs: [
          Tab(
            text: localization.details,
          ),
          Tab(
            text: localization.notifications,
          ),
        ],
      ),
      body: AppTabForm(
        focusNode: _focusNode,
        formKey: _formKey,
        tabController: _controller,
        children: <Widget>[
          ScrollableListView(
            primary: true,
            children: <Widget>[
              FormCard(children: <Widget>[
                DecoratedFormField(
                  label: localization.firstName,
                  controller: _firstNameController,
                  validator: (val) => val.isEmpty || val.trim().isEmpty
                      ? localization.pleaseEnterAFirstName
                      : null,
                  onSavePressed: _onSavePressed,
                  keyboardType: TextInputType.name,
                ),
                DecoratedFormField(
                  label: localization.lastName,
                  controller: _lastNameController,
                  validator: (val) => val.isEmpty || val.trim().isEmpty
                      ? localization.pleaseEnterALastName
                      : null,
                  onSavePressed: _onSavePressed,
                  keyboardType: TextInputType.name,
                ),
                DecoratedFormField(
                  label: localization.email,
                  controller: _emailController,
                  validator: (val) => val.isEmpty || val.trim().isEmpty
                      ? localization.pleaseEnterYourEmail
                      : null,
                  onSavePressed: _onSavePressed,
                  keyboardType: TextInputType.emailAddress,
                ),
                DecoratedFormField(
                  label: localization.phone,
                  controller: _phoneController,
                  onSavePressed: _onSavePressed,
                  keyboardType: TextInputType.phone,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  onSavePressed: _onSavePressed,
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18, top: 20, right: 18, bottom: 10),
                child: Row(
                  children: [
                    if (state.isHosted &&
                        (!kReleaseMode || !isDesktopOS())) ...[
                      if (user.isConnectedToGoogle) ...[
                        googleButton,
                        SizedBox(width: kTableColumnGap),
                        gmailButton,
                        SizedBox(width: kTableColumnGap),
                      ] else if (user.isConnectedToMicrosoft) ...[
                        microsoftButton,
                        SizedBox(width: kTableColumnGap),
                        office365Button,
                        SizedBox(width: kTableColumnGap),
                      ] else if (user.isConnectedToApple) ...[
                        appleButton,
                        SizedBox(width: kTableColumnGap),
                      ] else ...[
                        googleButton,
                        SizedBox(width: kTableColumnGap),
                        if (kIsWeb) microsoftButton else gmailButton,
                        SizedBox(width: kTableColumnGap),
                      ]
                    ],
                    Expanded(
                      child: OutlinedButton(
                        child: Text(
                          (state.user.isTwoFactorEnabled
                                  ? localization.disableTwoFactor
                                  : localization.enableTwoFactor)
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () async {
                          if (state.settingsUIState.isChanged) {
                            showMessageDialog(
                                message: localization.errorUnsavedChanges);
                            return;
                          }

                          if (state.user.isTwoFactorEnabled) {
                            viewModel.onDisableTwoFactorPressed(context);
                          } else {
                            if (state.user.phone.isEmpty ||
                                user.phone.isEmpty) {
                              showMessageDialog(
                                  message:
                                      localization.enterPhoneToEnableTwoFactor);
                              return;
                            }

                            if (state.isHosted && !state.user.phoneVerified) {
                              final bool? phoneVerified =
                                  await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) =>
                                    UserSmsVerification(),
                              );

                              if (phoneVerified == true) {
                                showDialog<void>(
                                  context: navigatorKey.currentContext!,
                                  builder: (BuildContext context) =>
                                      _EnableTwoFactor(state: viewModel.state),
                                );
                              }
                            } else {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) =>
                                    _EnableTwoFactor(state: viewModel.state),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              FormCard(
                isLast: true,
                children: <Widget>[
                  FormColorPicker(
                    labelText: localization.accentColor,
                    initialValue: user.userCompany!.settings.accentColor,
                    onSelected: (value) {
                      widget.viewModel.onChanged(user.rebuild((b) => b
                        ..userCompany.settings.accentColor =
                            value ?? '#ffffff'));
                    },
                  ),
                  EntityDropdown(
                    entityType: EntityType.language,
                    entityList:
                        memoizedLanguageList(state.staticState.languageMap),
                    labelText: localization.language +
                        (user.languageId.isNotEmpty
                            ? ''
                            : ' - ' +
                                state
                                    .staticState
                                    .languageMap[state.company.languageId]!
                                    .name),
                    entityId: user.languageId,
                    onSelected: (SelectableEntity? language) =>
                        viewModel.onChanged(user.rebuild(
                            (b) => b..languageId = language?.id ?? '')),
                  ),
                  if (state.company.isLarge || !kReleaseMode) ...[
                    AppDropdownButton<int>(
                      blankValue: null,
                      labelText: localization.yearsDataShown,
                      value: user.userCompany!.settings.numberYearsActive,
                      onChanged: (dynamic value) {
                        widget.viewModel.onChanged(user.rebuild((b) =>
                            b..userCompany.settings.numberYearsActive = value));
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text(localization.all),
                          value: 0,
                        ),
                        ...List<int>.generate(10, (i) => i + 1)
                            .map((value) => DropdownMenuItem(
                                  child: Text('$value'),
                                  value: value,
                                ))
                            .toList()
                      ],
                    ),
                    SizedBox(height: 8),
                    BoolDropdownButton(
                      label: localization.includeDeletedClients,
                      helpLabel: localization.includeDeletedClientsHelp,
                      value: user.userCompany!.settings.includeDeletedClients,
                      onChanged: (value) {
                        widget.viewModel.onChanged(user.rebuild((b) => b
                          ..userCompany.settings.includeDeletedClients =
                              value));
                      },
                    )
                  ],
                  BoolDropdownButton(
                    label: localization.userLoggedInNotification,
                    helpLabel: localization.userLoggedInNotificationHelp,
                    value: user.userLoggedInNotification,
                    onChanged: (value) {
                      widget.viewModel.onChanged(user
                          .rebuild((b) => b..userLoggedInNotification = value));
                    },
                  )
                ],
              ),
            ],
          ),
          ScrollableListView(
            primary: true,
            children: <Widget>[
              NotificationSettings(
                user: user,
                onChanged: (channel, options) {
                  viewModel.onChanged(user.rebuild((b) => b
                    ..userCompany.notifications[channel] = BuiltList(options)));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _EnableTwoFactor extends StatefulWidget {
  const _EnableTwoFactor({required this.state});

  final AppState state;

  @override
  _EnableTwoFactorState createState() => _EnableTwoFactorState();
}

class _EnableTwoFactorState extends State<_EnableTwoFactor> {
  String? _secret;
  late String _qrCode;
  String? _oneTimePassword;
  //String _smsCode;
  bool autoValidate = false;
  bool _isLoading = true;
  final _webClient = WebClient();

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_twoFactor');
  final FocusScopeNode _focusNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();

    final credentials = widget.state.credentials;
    final url = '${credentials.url}/settings/enable_two_factor';

    _webClient.get(url, credentials.token).then((dynamic data) {
      final response =
          serializers.deserializeWith(UserTwoFactorResponse.serializer, data);
      setState(() {
        _isLoading = false;
        _qrCode = response!.data.qrCode;
        _secret = response.data.secret;
      });
    }).catchError((dynamic error) {
      Navigator.of(context).pop();
      showErrorDialog(message: error);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onSavePressed() {
    final bool isValid = _formKey.currentState!.validate();

    setState(() {
      autoValidate = !isValid;
    });

    if (!isValid) {
      return;
    }

    final credentials = widget.state.credentials;
    final url = '${credentials.url}/settings/enable_two_factor';

    setState(() => _isLoading = true);

    _webClient
        .post(url, credentials.token,
            data: json.encode({
              'secret': _secret,
              'one_time_password': _oneTimePassword,
            }))
        .then((dynamic data) {
      setState(() => _isLoading = false);
      showToast(AppLocalization.of(context)!.enabledTwoFactor);
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(RefreshData());
      Navigator.of(context).pop();
    }).catchError((Object error) {
      setState(() => _isLoading = false);
      showErrorDialog(message: '$error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final localzation = AppLocalization.of(context)!;

    return AlertDialog(
      title: Text(localzation.enableTwoFactor),
      content: _isLoading
          ? LoadingIndicator(height: 100)
          : AppForm(
              focusNode: _focusNode,
              formKey: _formKey,
              child: SizedBox(
                width: 280,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_secret == null)
                      LoadingIndicator()
                    else ...[
                      QrImageView(
                        data: _qrCode,
                        version: QrVersions.auto,
                        size: 180,
                        backgroundColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: SelectableText(_secret!),
                      ),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: DecoratedFormField(
                            autofocus: true,
                            label: localzation.oneTimePassword,
                            onChanged: (value) {
                              _oneTimePassword = value;
                            },
                            validator: (value) => value.isEmpty
                                ? AppLocalization.of(context)!.pleaseEnterAValue
                                : null,
                            keyboardType: TextInputType.number,
                            onSavePressed: (context) => _onSavePressed(),
                          ),
                        ),
                        SizedBox(width: kTableColumnGap),
                        SizedBox(
                          width: 100,
                          child: TextButton(
                            onPressed: () {
                              launchUrl(Uri.parse(
                                  'https://github.com/antonioribeiro/google2fa#google-authenticator-apps'));
                            },
                            child: Text(localzation.learnMore),
                          ),
                        ),
                      ],
                    ),
                    /*
                    Row(
                      children: [
                        Expanded(
                          child: DecoratedFormField(
                            label: localzation.smsCode,
                            onChanged: (value) {
                              _smsCode = value;
                            },
                          ),
                        ),
                        SizedBox(width: kTableColumnGap),
                        SizedBox(
                          width: 100,
                          child: TextButton(
                            onPressed: () {
                              //
                            },
                            child: Text(localzation.sendSms),
                          ),
                        ),
                      ],
                    ),
                    */
                  ],
                ),
              ),
            ),
      actions: [
        if (_secret != null) ...[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              localzation.cancel.toUpperCase(),
            ),
          ),
          TextButton(
            onPressed: () => _onSavePressed(),
            child: Text(
              localzation.save.toUpperCase(),
            ),
          ),
        ]
      ],
    );
  }
}
