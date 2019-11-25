import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/user/edit/user_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_flat_button.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

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
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_userEdit');
  final _debouncer = Debouncer();

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
    _debouncer.run(() {
      final user = widget.viewModel.user.rebuild((b) => b
        ..firstName = _firstNameController.text.trim()
        ..lastName = _lastNameController.text.trim()
        ..email = _emailController.text.trim()
        ..phone = _phoneController.text.trim());
      if (user != widget.viewModel.user) {
        widget.viewModel.onUserChanged(user);
      }
    });
  }

  void _togglePermission(String permission) {
    final user = widget.viewModel.user;
    final userCompany = user.userCompany;

    final permissions = (userCompany.permissions ?? '').split(',');
    if (permissions.contains(permission)) {
      permissions.remove(permission);
    } else {
      permissions.add(permission);
    }
    final permissionsString =
        permissions.where((value) => value.isNotEmpty).join(',');

    widget.viewModel.onUserChanged(
        user.rebuild((b) => b..userCompany.permissions = permissionsString));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final user = viewModel.user;
    final userCompany = user.userCompany;

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
            ActionFlatButton(
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
            FormCard(
              children: <Widget>[
                SwitchListTile(
                  title: Text(localization.administrator),
                  subtitle: Text(localization.administratorHelp),
                  value: userCompany.isAdmin ?? false,
                  onChanged: (value) => viewModel.onUserChanged(
                      user.rebuild((b) => b..userCompany.isAdmin = value)),
                  activeColor: Theme.of(context).accentColor,
                ),
              ],
            ),
            if (!userCompany.isAdmin)
              FormCard(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: SizedBox(),
                      ),
                      DataColumn(
                        label: Text(localization.create),
                      ),
                      DataColumn(
                        label: Text(localization.view),
                      ),
                      DataColumn(
                        label: Text(localization.edit),
                      ),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text(localization.all)),
                        DataCell(
                            _PermissionCheckbox(
                              userCompany: userCompany,
                              permission: kPermissionCreateAll,
                              onChanged: (value) =>
                                  _togglePermission(kPermissionCreateAll),
                            ),
                            onTap: () =>
                                _togglePermission(kPermissionCreateAll)),
                        DataCell(
                            _PermissionCheckbox(
                              userCompany: userCompany,
                              permission: kPermissionViewAll,
                              onChanged: (value) =>
                                  _togglePermission(kPermissionViewAll),
                            ),
                            onTap: () => _togglePermission(kPermissionViewAll)),
                        DataCell(
                            _PermissionCheckbox(
                              userCompany: userCompany,
                              permission: kPermissionEditAll,
                              onChanged: (value) =>
                                  _togglePermission(kPermissionEditAll),
                            ),
                            onTap: () => _togglePermission(kPermissionEditAll)),
                      ]),
                      ...<EntityType>[
                        EntityType.client,
                        EntityType.product,
                        EntityType.invoice,
                        EntityType.payment,
                        EntityType.quote,
                      ].map((EntityType type) {
                        final createPermission =
                            'create_' + toSnakeCase('$type');
                        final editPermission = 'edit_' + toSnakeCase('$type');
                        final viewPermission = 'view_' + toSnakeCase('$type');
                        return DataRow(cells: [
                          DataCell(Text(localization.lookup('$type'))),
                          DataCell(
                              _PermissionCheckbox(
                                userCompany: userCompany,
                                permission: createPermission,
                                onChanged: (value) =>
                                    _togglePermission(createPermission),
                                checkAll: userCompany.permissions
                                    .contains(kPermissionCreateAll),
                              ),
                              onTap: userCompany.permissions
                                      .contains(kPermissionCreateAll)
                                  ? null
                                  : () => _togglePermission(createPermission)),
                          DataCell(
                              _PermissionCheckbox(
                                userCompany: userCompany,
                                permission: viewPermission,
                                onChanged: (value) =>
                                    _togglePermission(viewPermission),
                                checkAll: userCompany.permissions
                                    .contains(kPermissionViewAll),
                              ),
                              onTap: userCompany.permissions
                                      .contains(kPermissionViewAll)
                                  ? null
                                  : () => _togglePermission(viewPermission)),
                          DataCell(
                              _PermissionCheckbox(
                                userCompany: userCompany,
                                permission: editPermission,
                                onChanged: (value) =>
                                    _togglePermission(editPermission),
                                checkAll: userCompany.permissions
                                    .contains(kPermissionEditAll),
                              ),
                              onTap: userCompany.permissions
                                      .contains(kPermissionEditAll)
                                  ? null
                                  : () => _togglePermission(editPermission)),
                        ]);
                      }).toList()
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _PermissionCheckbox extends StatelessWidget {
  const _PermissionCheckbox({
    @required this.userCompany,
    @required this.permission,
    @required this.onChanged,
    this.checkAll = false,
  });

  final UserCompanyEntity userCompany;
  final String permission;
  final Function(bool) onChanged;
  final bool checkAll;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: checkAll
          ? true
          : (userCompany.permissions ?? '').contains(permission),
      onChanged: checkAll ? null : onChanged,
      activeColor: Theme.of(context).accentColor,
    );
  }
}
