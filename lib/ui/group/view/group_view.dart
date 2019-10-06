import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';

class GroupView extends StatefulWidget {
  const GroupView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final GroupViewVM viewModel;

  @override
  _GroupViewState createState() => new _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final group = viewModel.group;

    return Scaffold(
      appBar: AppBar(
        title: EntityStateTitle(entity: group),
        actions: group.isNew
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    viewModel.onEditPressed(context);
                  },
                ),
                ActionMenuButton(
                  isSaving: viewModel.isSaving,
                  entity: group,
                  onSelected: viewModel.onEntityAction,
                ),
              ],
      ),
      body: FormCard(children: [
        // STARTER: widgets - do not remove comment
      ]),
    );
  }
}
