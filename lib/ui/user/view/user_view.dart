import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';

class UserView extends StatefulWidget {
  const UserView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final UserViewVM viewModel;

  @override
  _UserViewState createState() => new _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final userCompany = viewModel.state.userCompany;
    final user = viewModel.user;

    return Scaffold(
      appBar: AppBar(
        title: EntityStateTitle(entity: user),
        actions: [
          userCompany.canEditEntity(user)
              ? EditIconButton(
                  isVisible: user.isActive,
                  onPressed: () => viewModel.onEditPressed(context),
                )
              : Container(),
          ActionMenuButton(
            entityActions: user.getActions(userCompany: userCompany),
            isSaving: viewModel.isSaving,
            entity: user,
            onSelected: viewModel.onEntityAction,
          )
        ],
      ),
      body: FormCard(children: [
        // STARTER: widgets - do not remove comment
      ]),
    );
  }
}
