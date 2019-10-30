import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/user/edit/user_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final UserEditVM viewModel;

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _firstNameController,
      _lastNameController,
      _emailController,
      _phoneController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final user = widget.viewModel.user;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;
    _phoneController.text = user.phone;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final user = widget.viewModel.user.rebuild((b) => b
      ..firstName = _firstNameController.text.trim()
      ..lastName = _lastNameController.text.trim()
      ..email = _emailController.text.trim()
      ..firstName = _firstNameController.text.trim());
    if (user != widget.viewModel.user) {
      widget.viewModel.onChanged(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final user = viewModel.user;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: isMobile(context),
          title: Text(viewModel.user.isNew
              ? localization.newUser
              : localization.editUser),
          actions: <Widget>[
            if (!isMobile(context))
              FlatButton(
                child: Text(
                  localization.cancel,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => viewModel.onCancelPressed(context),
              ),
            ActionIconButton(
              icon: Icons.cloud_upload,
              tooltip: localization.save,
              isVisible: user.isActive,
              isDirty: user.isNew || user != viewModel.origUser,
              isSaving: viewModel.isSaving,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                viewModel.onSavePressed(context);
              },
            ),
          ],
        ),
        body: AppForm(
          formKey: _formKey,
          children: <Widget>[
            FormCard(
              children: <Widget>[
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
