import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
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

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    //final user = widget.viewModel.user;
    // STARTER: read value - do not remove comment

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
      // STARTER: set value - do not remove comment
    );
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
                  isVisible: !user.isDeleted,
                  isDirty: user.isNew || user != viewModel.origUser,
                  isSaving: viewModel.isSaving,
                  onPressed: () {
                    if (! _formKey.currentState.validate()) {
                      return;
                    }
                    viewModel.onSavePressed(context);
                  },
                ),
          ],
        ),
        body: Form(
            key: _formKey,
            child: Builder(builder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  FormCard(
                    children: <Widget>[
                      // STARTER: widgets - do not remove comment
                    ],
                  ),
                ],
              );
            })
        ),
      ),
    );
  }
}
