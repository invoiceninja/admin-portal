// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/notification_settings.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/user/edit/user_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final UserEditVM viewModel;

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_userEdit');
  final _debouncer = Debouncer();
  final FocusScopeNode _focusNode = FocusScopeNode();
  TabController? _controller;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  //final _passwordController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _firstNameController,
      _lastNameController,
      _emailController,
      _phoneController,
      //_passwordController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final user = widget.viewModel.user;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    //_passwordController.text = user.password;
    _custom1Controller.text = user.customValue1;
    _custom2Controller.text = user.customValue2;
    _custom3Controller.text = user.customValue3;
    _custom4Controller.text = user.customValue4;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller!.dispose();
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
      ..phone = _phoneController.text.trim()
      //..password = _passwordController.text.trim()
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim());
    if (user != widget.viewModel.user) {
      _debouncer.run(() {
        widget.viewModel.onUserChanged(user);
      });
    }
  }

  void _togglePermission(String permission) {
    final user = widget.viewModel.user;
    final userCompany = user.userCompany!;

    final permissions = userCompany.permissions.split(',');
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

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final localization = AppLocalization.of(context)!;
    final user = viewModel.user;
    final userCompany = user.userCompany!;

    return EditScaffold(
      entity: user,
      title:
          viewModel.user.isNew ? localization.newUser : localization.editUser,
      appBarBottom: TabBar(
        controller: _controller,
        isScrollable: isMobile(context),
        tabs: [
          Tab(
            text: localization.details,
          ),
          Tab(
            text: localization.notifications,
          ),
          Tab(
            text: localization.permissions,
          ),
        ],
      ),
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: _onSavePressed,
      body: AppTabForm(
        focusNode: _focusNode,
        formKey: _formKey,
        tabController: _controller,
        children: <Widget>[
          ScrollableListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  DecoratedFormField(
                    autofocus: true,
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
                  /*
                  PasswordFormField(
                    controller: _passwordController,
                    autoValidate: autoValidate,
                    onSavePressed: _onSavePressed,
                  ),
                  */
                  CustomField(
                    controller: _custom1Controller,
                    field: CustomFieldType.user1,
                    value: user.customValue1,
                    onSavePressed: _onSavePressed,
                  ),
                  CustomField(
                    controller: _custom2Controller,
                    field: CustomFieldType.user2,
                    value: user.customValue2,
                    onSavePressed: _onSavePressed,
                  ),
                  CustomField(
                    controller: _custom3Controller,
                    field: CustomFieldType.user3,
                    value: user.customValue3,
                    onSavePressed: _onSavePressed,
                  ),
                  CustomField(
                    controller: _custom4Controller,
                    field: CustomFieldType.user4,
                    value: user.customValue4,
                    onSavePressed: _onSavePressed,
                  ),
                ],
              ),
            ],
          ),
          ScrollableListView(
            children: <Widget>[
              NotificationSettings(
                user: user,
                onChanged: (channel, options) {
                  viewModel.onUserChanged(user.rebuild((b) => b
                    ..userCompany.notifications[channel] = BuiltList(options)));
                },
              ),
            ],
          ),
          ScrollableListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  SwitchListTile(
                    title: Text(localization.administrator),
                    subtitle: Text(localization.administratorHelp),
                    value: userCompany.isAdmin,
                    onChanged: (value) => viewModel.onUserChanged(
                        user.rebuild((b) => b..userCompany.isAdmin = value)),
                    activeColor: Theme.of(context).colorScheme.secondary,
                  ),
                  SwitchListTile(
                    title: Text(localization.dashboard),
                    subtitle: Text(localization.viewDashboardPermission),
                    value: userCompany.isAdmin
                        ? true
                        : userCompany.permissions
                            .contains(kPermissionViewDashboard),
                    onChanged: userCompany.isAdmin
                        ? null
                        : (value) {
                            final permissions = userCompany.permissions
                                .split(',')
                                .where((element) => element.isNotEmpty)
                                .toList();
                            if (value) {
                              if (!permissions
                                  .contains(kPermissionViewDashboard)) {
                                permissions.add(kPermissionViewDashboard);
                              }
                            } else {
                              if (!value) {
                                if (permissions
                                    .contains(kPermissionViewDashboard)) {
                                  permissions.remove(kPermissionViewDashboard);
                                }
                              }
                            }

                            viewModel.onUserChanged(user.rebuild((b) => b
                              ..userCompany.permissions =
                                  permissions.join(',')));
                          },
                    activeColor: Theme.of(context).colorScheme.secondary,
                  ),
                  SwitchListTile(
                    title: Text(localization.reports),
                    subtitle: Text(localization.viewReportPermission),
                    value: userCompany.isAdmin
                        ? true
                        : userCompany.permissions
                            .contains(kPermissionViewReports),
                    onChanged: userCompany.isAdmin
                        ? null
                        : (value) {
                            final permissions = userCompany.permissions
                                .split(',')
                                .where((element) => element.isNotEmpty)
                                .toList();
                            if (value) {
                              if (!permissions
                                  .contains(kPermissionViewReports)) {
                                permissions.add(kPermissionViewReports);
                              }
                            } else {
                              if (!value) {
                                if (permissions
                                    .contains(kPermissionViewReports)) {
                                  permissions.remove(kPermissionViewReports);
                                }
                              }
                            }

                            viewModel.onUserChanged(user.rebuild((b) => b
                              ..userCompany.permissions =
                                  permissions.join(',')));
                          },
                    activeColor: Theme.of(context).colorScheme.secondary,
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
                          label: Text(localization.viewAll),
                        ),
                        DataColumn(
                          label: Text(localization.editAll),
                        ),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(localization.all), onTap: () {
                            _togglePermission(kPermissionCreateAll);
                            WidgetsBinding.instance
                                .addPostFrameCallback((duration) {
                              _togglePermission(kPermissionViewAll);
                              WidgetsBinding.instance
                                  .addPostFrameCallback((duration) {
                                _togglePermission(kPermissionEditAll);
                              });
                            });
                          }),
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
                              onTap: () =>
                                  _togglePermission(kPermissionViewAll)),
                          DataCell(
                              _PermissionCheckbox(
                                userCompany: userCompany,
                                permission: kPermissionEditAll,
                                onChanged: (value) =>
                                    _togglePermission(kPermissionEditAll),
                              ),
                              onTap: () =>
                                  _togglePermission(kPermissionEditAll)),
                        ]),
                        ...<EntityType>[
                          EntityType.client,
                          EntityType.product,
                          EntityType.invoice,
                          EntityType.recurringInvoice,
                          EntityType.payment,
                          EntityType.quote,
                          EntityType.credit,
                          EntityType.project,
                          EntityType.task,
                          EntityType.vendor,
                          EntityType.purchaseOrder,
                          EntityType.expense,
                          EntityType.recurringExpense,
                          EntityType.transaction,
                        ]
                            .where((entityType) =>
                                state.company.isModuleEnabled(entityType))
                            .map((EntityType type) {
                          final createPermission = 'create_' + type.apiValue;
                          final editPermission = 'edit_' + type.apiValue;
                          final viewPermission = 'view_' + type.apiValue;
                          return DataRow(cells: [
                            DataCell(Text(localization.lookup('$type')),
                                onTap: () {
                              _togglePermission(createPermission);
                              WidgetsBinding.instance
                                  .addPostFrameCallback((duration) {
                                _togglePermission(viewPermission);
                                WidgetsBinding.instance
                                    .addPostFrameCallback((duration) {
                                  _togglePermission(editPermission);
                                });
                              });
                            }),
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
                                    : () =>
                                        _togglePermission(createPermission)),
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
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PermissionCheckbox extends StatelessWidget {
  const _PermissionCheckbox({
    required this.userCompany,
    required this.permission,
    required this.onChanged,
    this.checkAll = false,
  });

  final UserCompanyEntity userCompany;
  final String permission;
  final Function(bool?) onChanged;
  final bool checkAll;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: checkAll ? true : userCompany.permissions.contains(permission),
      onChanged: checkAll ? null : onChanged,
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
