import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/color_picker.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/forms/notification_settings.dart';
import 'package:invoiceninja_flutter/ui/app/forms/password_field.dart';
import 'package:invoiceninja_flutter/ui/settings/user_details_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    Key key,
    @required this.viewModel,
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
  TabController _controller;
  bool autoValidate = false;

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
    _controller.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller.index));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.removeListener(_onTabChanged);
    _controller.dispose();
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
    _debouncer.run(() {
      final user = widget.viewModel.user.rebuild((b) => b
        ..firstName = _firstNameController.text.trim()
        ..lastName = _lastNameController.text.trim()
        ..email = _emailController.text.trim()
        ..firstName = _firstNameController.text.trim()
        ..password = _passwordController.text.trim());
      if (user != widget.viewModel.user) {
        widget.viewModel.onChanged(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final user = viewModel.user;

    return EditScaffold(
      title: localization.userDetails,
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        setState(() {
          autoValidate = !isValid ?? false;
        });

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
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
          ListView(
            children: <Widget>[
              FormCard(children: <Widget>[
                DecoratedFormField(
                  label: localization.firstName,
                  controller: _firstNameController,
                  validator: (val) => val.isEmpty || val.trim().isEmpty
                      ? localization.pleaseEnterAFirstName
                      : null,
                  autovalidate: autoValidate,
                ),
                DecoratedFormField(
                  label: localization.lastName,
                  controller: _lastNameController,
                  validator: (val) => val.isEmpty || val.trim().isEmpty
                      ? localization.pleaseEnterALastName
                      : null,
                  autovalidate: autoValidate,
                ),
                DecoratedFormField(
                  label: localization.email,
                  controller: _emailController,
                  validator: (val) => val.isEmpty || val.trim().isEmpty
                      ? localization.pleaseEnterYourEmail
                      : null,
                  autovalidate: autoValidate,
                ),
                DecoratedFormField(
                  label: localization.phone,
                  controller: _phoneController,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  autoValidate: autoValidate,
                ),
              ]),
              FormCard(
                children: <Widget>[
                  FormColorPicker(
                    labelText: localization.accentColor,
                    initialValue:
                        viewModel.state.userCompany.settings.accentColor,
                    onSelected: (value) {
                      widget.viewModel.onChanged(user.rebuild(
                          (b) => b..userCompany.settings.accentColor = value));
                    },
                  ),
                ],
              ),
            ],
          ),
          ListView(
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
